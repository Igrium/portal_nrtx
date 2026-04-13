"""
audit_modelsrc.py

Audits a modelsrc folder for:
  1. QC files that share a duplicate $modelname
  2. Orphaned .smd/.dmx files not referenced by any QC

Usage:
    python audit_modelsrc.py <src_dir>
"""

import re
import argparse
import subprocess
from collections import defaultdict
from pathlib import Path, PurePosixPath


MODELNAME_RE = re.compile(r'^\s*\$modelname\s+"([^"]+)"', re.IGNORECASE | re.MULTILINE)
ASSET_REF_RE = re.compile(r'"([^"]*\.(?:smd|dmx))"', re.IGNORECASE)


def parse_qc(qc_path: Path) -> tuple[str | None, set[Path]]:
    """
    Return (normalised_modelname, {absolute_paths_of_referenced_assets}).
    References are resolved relative to the .qc file's directory.
    """
    text = qc_path.read_text(encoding="utf-8", errors="replace")

    m = MODELNAME_RE.search(text)
    modelname = PurePosixPath(m.group(1).replace("\\", "/")).as_posix().lower() if m else None

    refs: set[Path] = set()
    for raw in ASSET_REF_RE.findall(text):
        rel = Path(raw.replace("\\", "/"))
        candidate = (qc_path.parent / rel).resolve()
        if candidate.exists():
            refs.add(candidate)
        else:
            # Case-insensitive fallback within the qc's directory
            target_name = rel.name.lower()
            target_dir  = (qc_path.parent / rel.parent).resolve()
            if target_dir.is_dir():
                for f in target_dir.iterdir():
                    if f.name.lower() == target_name:
                        refs.add(f.resolve())
                        break

    return modelname, refs


def audit(src_dir: Path) -> None:
    qc_files = sorted(src_dir.rglob("*.qc"))
    if not qc_files:
        print(f"No .qc files found under {src_dir}")
        return

    print(f"Scanning {len(qc_files)} .qc file(s) under {src_dir}…\n")

    # ── 1. Duplicate modelnames ───────────────────────────────────────────────
    modelname_map: dict[str, list[Path]] = defaultdict(list)
    all_referenced: set[Path] = set()

    for qc in qc_files:
        modelname, refs = parse_qc(qc)
        all_referenced.update(refs)
        if modelname:
            modelname_map[modelname].append(qc)

    duplicates = {name: paths for name, paths in modelname_map.items() if len(paths) > 1}

    if duplicates:
        print(f"{'─'*60}")
        print(f"  DUPLICATE MODELNAMES ({len(duplicates)} conflict(s))")
        print(f"{'─'*60}")
        for name, paths in sorted(duplicates.items()):
            print(f"\n  {name}")
            for p in paths:
                print(f"    {p.relative_to(src_dir)}")
    else:
        print("  No duplicate modelnames found.")

    # ── 2. Orphaned assets ────────────────────────────────────────────────────
    all_assets = [
        p for p in src_dir.rglob("*")
        if p.is_file() and p.suffix.lower() in {".smd", ".dmx"}
    ]
    orphans = sorted(p for p in all_assets if p.resolve() not in all_referenced)

    print(f"\n{'─'*60}")
    if not orphans:
        print("  No orphaned .smd/.dmx files found.")
        print(f"{'─'*60}\n")
        return

    print(f"  ORPHANED ASSETS ({len(orphans)} file(s))")
    print(f"{'─'*60}")
    for p in orphans:
        print(f"  {p.relative_to(src_dir)}")

    print()
    answer = input("Delete all orphaned files? [y/N] ").strip().lower()
    if answer == "y":
        removed, failed = 0, 0
        for p in orphans:
            try:
                if not _git_rm(p):
                    p.unlink()
                removed += 1
            except OSError as e:
                print(f"  [error] could not delete {p}: {e}")
                failed += 1
        print(f"\n  Deleted {removed} file(s)." + (f" {failed} failed." if failed else ""))
    else:
        print("  No files deleted.")


def _git_rm(path: Path) -> bool:
    """Try `git rm path`. Returns True on success, False otherwise."""
    return subprocess.run(["git", "rm", str(path)], capture_output=True).returncode == 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Audit a modelsrc folder for duplicate modelnames and orphaned assets."
    )
    parser.add_argument("src", type=Path, help="modelsrc root to scan")
    args = parser.parse_args()

    src = args.src.resolve()
    if not src.is_dir():
        parser.error(f"{src} is not a directory")

    audit(src)
