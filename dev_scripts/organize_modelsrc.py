"""
organize_modelsrc.py

Reorganizes a flat modelsrc folder into subdirectories based on the
$modelname declared in each .qc file.

QC files already inside a subdirectory are left untouched.
SMD/DMX references are resolved relative to src_dir and moved to the same
relative position under the destination, so anim subfolders etc. travel
with their QC intact. Unreferenced .smd/.dmx files are deleted afterward.
"""

import re
import argparse
import subprocess
import shutil
from pathlib import Path, PurePosixPath


MODELNAME_RE = re.compile(r'^\s*\$modelname\s+"([^"]+)"', re.IGNORECASE | re.MULTILINE)
ASSET_REF_RE = re.compile(r'"([^"]*\.(?:smd|dmx))"', re.IGNORECASE)


def build_case_map(root: Path) -> dict[str, Path]:
    """Map lowercase relative path → real Path for every file under root."""
    return {
        str(p.relative_to(root)).lower(): p
        for p in root.rglob("*")
        if p.is_file()
    }


def parse_qc(qc_path: Path) -> tuple[str | None, list[str]]:
    """Return (modelname_value, [normalised_relative_asset_paths]) from a .qc."""
    text = qc_path.read_text(encoding="utf-8", errors="replace")

    m = MODELNAME_RE.search(text)
    modelname = m.group(1) if m else None

    refs = []
    for raw in ASSET_REF_RE.findall(text):
        norm = raw.replace("\\", "/")
        if norm:
            refs.append(norm)

    return modelname, refs


def model_subdir(modelname: str) -> Path:
    """'props/combine_ball_catcher.mdl' → Path('props')"""
    p = PurePosixPath(modelname.replace("\\", "/"))
    parent = p.parent
    return Path(str(parent)) if str(parent) != "." else Path("")


def organize(src_dir: Path, dst_dir: Path) -> None:
    # Only touch QCs sitting directly in src_dir — subdirectory QCs are already organised
    qc_files = sorted(src_dir.glob("*.qc"))
    if not qc_files:
        print(f"No .qc files found at the root of {src_dir}")
        return

    print(f"Found {len(qc_files)} root-level .qc file(s) in {src_dir}")
    print(f"Output root: {dst_dir}\n")

    # Build once upfront; updated in-place as files are moved
    case_map = build_case_map(src_dir)
    # Tracks every dst path that was intentionally placed (used for orphan pruning)
    claimed: set[Path] = set()

    for qc in qc_files:
        modelname, refs = parse_qc(qc)

        if not modelname:
            print(f"[SKIP] {qc.name} — no $modelname found")
            continue

        subdir = model_subdir(modelname)
        dest   = dst_dir / subdir
        dest.mkdir(parents=True, exist_ok=True)

        _transfer(qc, dest / qc.name, case_map, src_dir, claimed)
        label = str(dest.relative_to(dst_dir)) + "/" if subdir != Path("") else "(root)"
        print(f"{qc.name}  →  {label}")

        missing = []
        for rel in dict.fromkeys(refs):            # deduplicate, preserve order
            key = rel.lower()
            real_src = case_map.get(key)
            if real_src is None:
                missing.append(rel)
                continue
            real_dst = dest / rel                  # same relative position under dest
            real_dst.parent.mkdir(parents=True, exist_ok=True)
            _transfer(real_src, real_dst, case_map, src_dir, claimed)

        if missing:
            print(f"  [warn] not found: {', '.join(missing)}")

    _prune_orphans(dst_dir, claimed)
    print("\nDone.")


def _prune_orphans(dst_dir: Path, claimed: set[Path]) -> None:
    """Delete any .smd/.dmx under dst_dir that weren't placed by organize()."""
    orphans = [
        p for p in dst_dir.iterdir()
        if p.is_file()
        and p.suffix.lower() in {".smd", ".dmx"}
        and p not in claimed
    ]
    if not orphans:
        return
    print(f"\nRemoving {len(orphans)} unreferenced file(s):")
    for p in sorted(orphans):
        print(f"  {p}")
        _git_rm(p) or p.unlink()


def _git_mv(src: Path, dst: Path) -> bool:
    """Try `git mv src dst`. Returns True on success, False otherwise."""
    return subprocess.run(["git", "mv", str(src), str(dst)], capture_output=True).returncode == 0


def _git_rm(path: Path) -> bool:
    """Try `git rm path`. Returns True on success, False otherwise."""
    return subprocess.run(["git", "rm", str(path)], capture_output=True).returncode == 0


def _transfer(src: Path, dst: Path, case_map: dict[str, Path],
              src_root: Path, claimed: set[Path]) -> None:
    """
    Move src → dst, keeping case_map and claimed consistent.
    Tries `git mv` first; falls back to shutil.move for untracked files.
    """
    if not src.exists():
        return

    if dst == src:
        claimed.add(dst)
        return

    if dst.exists():
        pass  # already placed by a previous QC
    else:
        if not _git_mv(src, dst):
            shutil.move(str(src), dst)

    claimed.add(dst)

    try:
        old_key = str(src.relative_to(src_root)).lower()
        case_map[old_key] = dst
    except ValueError:
        pass


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Reorganize a flat modelsrc folder into subdirectories based on $modelname in each .qc file."
    )
    parser.add_argument("src", type=Path, help="modelsrc root containing .qc and .smd/.dmx files")
    parser.add_argument("dst", nargs="?", type=Path, help="output root (default: src)")
    args = parser.parse_args()

    src = args.src.resolve()
    dst = (args.dst or args.src).resolve()

    if not src.is_dir():
        parser.error(f"{src} is not a directory")

    organize(src, dst)