#!/usr/bin/env python3
"""
compile_models.py - Recursively compile all Source Engine models in a modelsrc folder.

Usage:
    python compile_models.py -game <gamedir> [options]
    python compile_models.py --help
"""

import argparse
import subprocess
import sys
import os
import time
import logging
from pathlib import Path
from dataclasses import dataclass, field
from typing import Optional


# ---------------------------------------------------------------------------
# Result container
# ---------------------------------------------------------------------------

@dataclass
class CompileResult:
    qc_path: Path
    success: bool
    returncode: int
    stdout: str
    stderr: str
    duration: float
    skipped: bool = False
    skip_reason: str = ""


@dataclass
class CompileSummary:
    total: int = 0
    succeeded: int = 0
    failed: int = 0
    skipped: int = 0
    results: list = field(default_factory=list)


# ---------------------------------------------------------------------------
# Logging setup
# ---------------------------------------------------------------------------

def setup_logging(log_level: str, log_file: Optional[str]) -> logging.Logger:
    logger = logging.getLogger("compile_models")
    logger.setLevel(getattr(logging, log_level.upper(), logging.INFO))

    fmt = logging.Formatter("[%(levelname)s] %(message)s")

    ch = logging.StreamHandler(sys.stdout)
    ch.setFormatter(fmt)
    logger.addHandler(ch)

    if log_file:
        fh = logging.FileHandler(log_file, encoding="utf-8")
        fh.setFormatter(logging.Formatter("%(asctime)s [%(levelname)s] %(message)s"))
        logger.addHandler(fh)

    return logger


# ---------------------------------------------------------------------------
# QC discovery
# ---------------------------------------------------------------------------

def find_qc_files(modelsrc: Path, recursive: bool = True) -> list[Path]:
    """Return all .qc files under modelsrc."""
    if recursive:
        return sorted(modelsrc.rglob("*.qc"))
    return sorted(modelsrc.glob("*.qc"))


# ---------------------------------------------------------------------------
# Compiler invocation
# ---------------------------------------------------------------------------

def is_wine_required(studiomdl: Path) -> bool:
    """Return True if studiomdl is a Windows .exe that needs Wine to run."""
    return studiomdl.suffix.lower() == ".exe"


def build_command(studiomdl: Path, game_dir: Optional[str], qc: Path,
                  extra_flags: list[str], use_wine: bool = False) -> list[str]:
    # When running under Wine, pass the full absolute path to the exe.
    # Otherwise use ./name so the OS resolves it relative to cwd (studiomdl's
    # own directory), which lets the dynamic linker find sibling .so files.
    if use_wine:
        cmd = ["wine", str(studiomdl)]
    else:
        cmd = [f"./{studiomdl.name}"]
    if game_dir:
        # Wine needs Windows-style paths; convert with winepath if available.
        resolved_game = str(Path(game_dir).resolve())
        if use_wine:
            result = subprocess.run(
                ["winepath", "-w", resolved_game],
                capture_output=True, text=True,
            )
            if result.returncode == 0:
                resolved_game = result.stdout.strip()
        cmd += ["-game", resolved_game]
    cmd += extra_flags
    qc_path = str(qc.resolve())
    if use_wine:
        result = subprocess.run(
            ["winepath", "-w", qc_path],
            capture_output=True, text=True,
        )
        if result.returncode == 0:
            qc_path = result.stdout.strip()
    cmd.append(qc_path)
    return cmd


def compile_qc(
    qc: Path,
    studiomdl: Path,
    game_dir: Optional[str],
    extra_flags: list[str],
    timeout: Optional[int],
    logger: logging.Logger,
) -> CompileResult:
    # Resolve studiomdl to an absolute path before deriving its parent dir.
    studiomdl = studiomdl.resolve()
    use_wine = is_wine_required(studiomdl)
    if use_wine:
        logger.debug("Wine mode: detected .exe extension on studiomdl")
    cmd = build_command(studiomdl, game_dir, qc, extra_flags, use_wine=use_wine)
    # Run from studiomdl's own directory so the dynamic linker finds sibling
    # shared libraries (.so on Linux, .dll via Wine). Wine also searches the
    # cwd for DLLs, so this matters in both cases.
    cwd = studiomdl.parent
    logger.debug("cwd: %s", cwd)
    logger.debug("Running: %s", " ".join(cmd))

    start = time.monotonic()
    try:
        proc = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=timeout,
            cwd=cwd,
        )
        duration = time.monotonic() - start
        success = proc.returncode == 0
        return CompileResult(
            qc_path=qc,
            success=success,
            returncode=proc.returncode,
            stdout=proc.stdout,
            stderr=proc.stderr,
            duration=duration,
        )
    except subprocess.TimeoutExpired:
        duration = time.monotonic() - start
        logger.error("  TIMEOUT after %ds: %s", timeout, qc)
        return CompileResult(
            qc_path=qc,
            success=False,
            returncode=-1,
            stdout="",
            stderr=f"Process timed out after {timeout}s",
            duration=duration,
        )
    except FileNotFoundError:
        duration = time.monotonic() - start
        logger.error("  studiomdl not found at: %s", studiomdl)
        return CompileResult(
            qc_path=qc,
            success=False,
            returncode=-2,
            stdout="",
            stderr=f"studiomdl executable not found: {studiomdl}",
            duration=duration,
        )


# ---------------------------------------------------------------------------
# Output path helpers
# ---------------------------------------------------------------------------

def derive_output_dir(qc: Path, modelsrc: Path, models_dir: Path) -> Path:
    """
    Mirror the relative path of the QC's parent from modelsrc into models_dir.

    Example:
        modelsrc  = /game/modelsrc
        models_dir = /game/models
        qc        = /game/modelsrc/props/crate/crate.qc
        → output  = /game/models/props/crate/
    """
    try:
        rel = qc.parent.relative_to(modelsrc)
    except ValueError:
        rel = Path()
    return models_dir / rel


# ---------------------------------------------------------------------------
# Main compile loop
# ---------------------------------------------------------------------------

def run_compile(args: argparse.Namespace, logger: logging.Logger) -> CompileSummary:
    # Resolve to absolute paths immediately so cwd changes never matter.
    studiomdl = Path(args.studiomdl).resolve()
    modelsrc = Path(args.modelsrc).resolve()
    models_dir = Path(args.models_dir).resolve() if args.models_dir else None

    # Validate paths
    if not studiomdl.is_file():
        logger.error("studiomdl not found: %s", studiomdl)
        sys.exit(1)

    if not modelsrc.is_dir():
        logger.error("modelsrc directory not found: %s", modelsrc)
        sys.exit(1)

    if models_dir and args.create_models_dir:
        models_dir.mkdir(parents=True, exist_ok=True)
    elif models_dir and not models_dir.is_dir():
        logger.error("models output directory not found: %s", models_dir)
        sys.exit(1)

    # Build extra flags list
    extra_flags: list[str] = []
    if args.nop4:
        extra_flags.append("-nop4")
    if args.quiet:
        extra_flags.append("-quiet")
    if args.fastbuild:
        extra_flags.append("-fastbuild")
    if args.preview:
        extra_flags.append("-preview")
    if args.nowarnings:
        extra_flags.append("-nowarnings")
    if args.verify:
        extra_flags.append("-verify")
    if args.extra_flags:
        extra_flags.extend(args.extra_flags)

    qc_files = find_qc_files(modelsrc, recursive=not args.no_recursive)

    if not qc_files:
        logger.warning("No .qc files found in: %s", modelsrc)
        return CompileSummary()

    logger.info("Found %d QC file(s) in %s", len(qc_files), modelsrc)
    if args.dry_run:
        logger.info("DRY RUN — no compilation will occur.")

    summary = CompileSummary(total=len(qc_files))

    for i, qc in enumerate(qc_files, 1):
        rel_qc = qc.relative_to(modelsrc) if qc.is_relative_to(modelsrc) else qc
        logger.info("[%d/%d] %s", i, len(qc_files), rel_qc)

        # --- skip patterns ---
        if args.skip_pattern:
            import fnmatch
            if any(fnmatch.fnmatch(str(rel_qc), pat) for pat in args.skip_pattern):
                logger.info("  SKIPPED (matched skip pattern)")
                summary.skipped += 1
                summary.results.append(CompileResult(
                    qc_path=qc, success=True, returncode=0,
                    stdout="", stderr="", duration=0,
                    skipped=True, skip_reason="matched skip pattern",
                ))
                continue

        if args.dry_run:
            cmd = build_command(studiomdl, args.game, qc, extra_flags)
            logger.info("  Would run: %s", " ".join(cmd))
            summary.skipped += 1
            summary.results.append(CompileResult(
                qc_path=qc, success=True, returncode=0,
                stdout="", stderr="", duration=0,
                skipped=True, skip_reason="dry run",
            ))
            continue

        result = compile_qc(
            qc=qc,
            studiomdl=studiomdl,
            game_dir=args.game,
            extra_flags=extra_flags,
            timeout=args.timeout,
            logger=logger,
        )

        summary.results.append(result)

        if result.success:
            summary.succeeded += 1
            logger.info("  OK  (%.1fs)", result.duration)
        else:
            summary.failed += 1
            logger.error("  FAILED (rc=%d, %.1fs)", result.returncode, result.duration)

        # Print studiomdl output if verbose or on failure
        if args.verbose or (not result.success and not args.suppress_output_on_error):
            if result.stdout.strip():
                for line in result.stdout.splitlines():
                    logger.debug("    [stdout] %s", line)
            if result.stderr.strip():
                for line in result.stderr.splitlines():
                    logger.warning("    [stderr] %s", line)
        elif not result.success and not args.quiet:
            # Show tail of output on failure even in normal mode
            tail = (result.stdout + result.stderr).strip().splitlines()
            for line in tail[-20:]:
                logger.error("    %s", line)

        # Abort on first failure
        if not result.success and args.fail_fast:
            logger.error("--fail-fast set; aborting after first failure.")
            break

    return summary


# ---------------------------------------------------------------------------
# Summary report
# ---------------------------------------------------------------------------

def print_summary(summary: CompileSummary, logger: logging.Logger) -> None:
    logger.info("")
    logger.info("=" * 60)
    logger.info("COMPILE SUMMARY")
    logger.info("  Total   : %d", summary.total)
    logger.info("  OK      : %d", summary.succeeded)
    logger.info("  Failed  : %d", summary.failed)
    logger.info("  Skipped : %d", summary.skipped)
    logger.info("=" * 60)

    if summary.failed:
        logger.error("Failed QC files:")
        for r in summary.results:
            if not r.success and not r.skipped:
                logger.error("  %s", r.qc_path)


# ---------------------------------------------------------------------------
# Argument parser
# ---------------------------------------------------------------------------

def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="compile_models",
        description="Recursively compile all Source Engine models in a modelsrc folder.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Basic usage — compile everything, infer game dir
  python compile_models.py \\
      --studiomdl "C:/Steam/steamapps/common/Team Fortress 2/bin/studiomdl.exe" \\
      --modelsrc  "C:/TF2Mod/modelsrc" \\
      --game      "C:/TF2Mod"

  # Fast build, skip LOD variants, abort on first error
  python compile_models.py --studiomdl ... --modelsrc ... --game ... \\
      --fastbuild --fail-fast

  # Dry run — show what would be compiled without doing anything
  python compile_models.py --studiomdl ... --modelsrc ... --game ... --dry-run

  # Skip specific QC files by glob pattern
  python compile_models.py ... --skip-pattern "npc/*" "test_*"

  # Pass arbitrary extra flags directly to studiomdl
  python compile_models.py ... --extra-flags -nop4 -nowarnings
""",
    )

    # --- Required ---
    req = parser.add_argument_group("required arguments")
    req.add_argument(
        "--studiomdl", "-s",
        required=True,
        metavar="PATH",
        help="Path to studiomdl.exe",
    )
    req.add_argument(
        "--modelsrc", "-m",
        required=True,
        metavar="PATH",
        help="Root modelsrc directory to search for .qc files",
    )

    # --- Game / output ---
    out = parser.add_argument_group("game / output paths")
    out.add_argument(
        "--game", "-g",
        metavar="GAMEDIR",
        default=None,
        help="Game directory passed to studiomdl -game (overrides VProject)",
    )
    out.add_argument(
        "--models-dir",
        metavar="PATH",
        default=None,
        help=(
            "Destination models folder. When set, the script mirrors the "
            "modelsrc subdirectory structure here. "
            "(StudioMDL itself controls actual output placement via $modelname; "
            "this option is informational / used for --create-models-dir.)"
        ),
    )
    out.add_argument(
        "--create-models-dir",
        action="store_true",
        default=False,
        help="Create --models-dir (and parents) if it does not exist",
    )

    # --- StudioMDL flags ---
    flags = parser.add_argument_group("studiomdl flags")
    flags.add_argument(
        "--nop4",
        action="store_true",
        default=True,
        help="Pass -nop4 to studiomdl (disables Perforce; on by default)",
    )
    flags.add_argument(
        "--no-nop4",
        dest="nop4",
        action="store_false",
        help="Do NOT pass -nop4 (enable Perforce integration)",
    )
    flags.add_argument(
        "--quiet", "-q",
        action="store_true",
        default=False,
        help="Pass -quiet to studiomdl (suppress its console output)",
    )
    flags.add_argument(
        "--fastbuild",
        action="store_true",
        default=False,
        help="Pass -fastbuild (skip .sw/.dx80/.360 VTX variants)",
    )
    flags.add_argument(
        "--preview",
        action="store_true",
        default=False,
        help="Pass -preview (skip tristrip building; faster but slower in-engine)",
    )
    flags.add_argument(
        "--nowarnings",
        action="store_true",
        default=False,
        help="Pass -nowarnings to studiomdl",
    )
    flags.add_argument(
        "--verify",
        action="store_true",
        default=False,
        help="Pass -verify (compile but do not write output files)",
    )
    flags.add_argument(
        "--extra-flags",
        nargs="+",
        metavar="FLAG",
        default=[],
        help="Any additional flags to pass verbatim to studiomdl (e.g. -definebones -h)",
    )

    # --- Behaviour ---
    beh = parser.add_argument_group("behaviour")
    beh.add_argument(
        "--no-recursive",
        action="store_true",
        default=False,
        help="Only search the top level of --modelsrc, do not recurse",
    )
    beh.add_argument(
        "--fail-fast",
        action="store_true",
        default=False,
        help="Stop after the first failed compilation",
    )
    beh.add_argument(
        "--dry-run", "-n",
        action="store_true",
        default=False,
        help="Print commands that would be run without executing them",
    )
    beh.add_argument(
        "--timeout",
        type=int,
        default=None,
        metavar="SECONDS",
        help="Per-QC compile timeout in seconds (default: none)",
    )
    beh.add_argument(
        "--skip-pattern",
        nargs="+",
        metavar="GLOB",
        default=[],
        help=(
            "Skip QC files whose path (relative to modelsrc) matches any of "
            "these glob patterns, e.g. 'npc/*' '*.test.qc'"
        ),
    )
    beh.add_argument(
        "--suppress-output-on-error",
        action="store_true",
        default=False,
        help="Do not print studiomdl output even on failure",
    )

    # --- Logging ---
    log = parser.add_argument_group("logging")
    log.add_argument(
        "--verbose", "-v",
        action="store_true",
        default=False,
        help="Show full studiomdl stdout/stderr for every compile",
    )
    log.add_argument(
        "--log-level",
        default="INFO",
        choices=["DEBUG", "INFO", "WARNING", "ERROR"],
        help="Console log level (default: INFO)",
    )
    log.add_argument(
        "--log-file",
        metavar="PATH",
        default=None,
        help="Write log output to this file in addition to stdout",
    )

    return parser


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main() -> None:
    parser = build_parser()
    args = parser.parse_args()

    logger = setup_logging(args.log_level, args.log_file)

    logger.info("compile_models.py — Source Engine batch model compiler")
    logger.info("studiomdl : %s", args.studiomdl)
    logger.info("modelsrc  : %s", args.modelsrc)
    if args.game:
        logger.info("game      : %s", args.game)
    if args.models_dir:
        logger.info("models    : %s", args.models_dir)
    logger.info("")

    summary = run_compile(args, logger)
    print_summary(summary, logger)

    sys.exit(0 if summary.failed == 0 else 1)


if __name__ == "__main__":
    main()