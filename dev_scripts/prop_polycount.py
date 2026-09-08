#!/usr/bin/env python3

"""
prop_polycount.py

Scans a VMF for static props and ranks the referenced models by poly count.

Triangle counts are read straight out of each model's LOD0 .vtx file, so the
numbers match what the renderer actually submits. Models are looked up through
the same search paths the engine uses: the mod folder, then whatever gameinfo.txt
mounts (Portal 1 / Portal 2 / P2CE), loose files first and then VPKs.

Each model is also sized from its .mdl bounding box (scaled by whatever
uniformscale the VMF places it at) to give a triangle *density* — triangles per
1,000 square units of surface. A small prop with a high density is carrying more
geometry than its on-screen footprint justifies, so that is the default ranking;
--sort total ranks by raw map cost instead, and --no-dims skips sizing entirely.

Usage:
    python prop_polycount.py <file.vmf> [-g <game_dir>] [-b <bin_dir>] [options]

Examples:
    python prop_polycount.py mapsrc/testchmb_a_00.vmf
    python prop_polycount.py mapsrc/escape_00.vmf --sort total --top 25
    python prop_polycount.py mapsrc/escape_00.vmf --csv props.csv
"""

import argparse
import csv
import re
import struct
import subprocess
import sys
from collections import Counter
from pathlib import Path, PurePosixPath

DEFAULT_BIN = Path(
    "/home/igrium/.steam/debian-installation/steamapps/common"
    "/Portal 2 Community Edition/bin/linux64"
)

# Static props in a VMF are plain entities; prop_detail/prop_static_scalable
# behave the same way for our purposes.
DEFAULT_CLASSNAMES = ("prop_static",)

# Order matters: the first one that exists wins, matching engine preference.
VTX_SUFFIXES = (".dx90.vtx", ".dx80.vtx", ".vtx", ".sw.vtx")

VPK_SIGNATURE = 0x55AA1234


# ── KeyValues ─────────────────────────────────────────────────────────────────

# KeyValues has no string escapes, so a quoted token runs to the next quote.
_KV_TOKEN_RE = re.compile(r'"([^"]*)"|([{}])|//[^\n]*|\S+')


def parse_kv(text: str) -> list[tuple[str, "str | list"]]:
    """
    Parse KeyValues (VMF, gameinfo.txt, .acf, …) into a flat list of
    (key, value) pairs, where value is either a string or a nested list of
    pairs. Duplicate keys are preserved, which VMFs rely on heavily.
    """
    tokens: list[str] = []
    for m in _KV_TOKEN_RE.finditer(text):
        if m.group(1) is not None:
            tokens.append(m.group(1))
        elif m.group(2) is not None:
            tokens.append(m.group(2))
        elif not m.group(0).startswith("//"):
            tokens.append(m.group(0))

    pos = 0

    def block(depth: int) -> list[tuple[str, str | list]]:
        nonlocal pos
        out: list[tuple[str, str | list]] = []
        while pos < len(tokens):
            tok = tokens[pos]
            if tok == "}":
                pos += 1
                if depth == 0:
                    continue  # stray brace; ignore rather than bail
                return out
            pos += 1
            if pos < len(tokens) and tokens[pos] == "{":
                pos += 1
                out.append((tok, block(depth + 1)))
            elif pos < len(tokens):
                out.append((tok, tokens[pos]))
                pos += 1
        return out

    return block(0)


def kv_get(pairs, key: str) -> "str | list | None":
    """Last value for `key` (case-insensitive) in a pair list, or None."""
    key = key.lower()
    for k, v in reversed(pairs):
        if k.lower() == key:
            return v
    return None


# ── VPK archives ──────────────────────────────────────────────────────────────


class VPK:
    """Minimal reader for VPK v1/v2 directory archives."""

    def __init__(self, dir_path: Path):
        self.path = dir_path
        self.entries: dict[str, tuple[int, int, int, bytes]] = {}
        self._read_tree()

    def _read_tree(self) -> None:
        data = self.path.read_bytes()
        sig, version, tree_size = struct.unpack_from("<III", data, 0)
        if sig != VPK_SIGNATURE:
            raise ValueError(f"{self.path} is not a VPK")
        off = 12 if version == 1 else 28
        self.data_start = off + tree_size

        end = off + tree_size

        def read_str() -> str:
            nonlocal off
            nul = data.index(b"\0", off)
            s = data[off:nul].decode("utf-8", "replace")
            off = nul + 1
            return s

        while off < end:
            ext = read_str()
            if not ext:
                break
            while True:
                folder = read_str()
                if not folder:
                    break
                while True:
                    name = read_str()
                    if not name:
                        break
                    (_crc, preload, archive, entry_off, entry_len) = struct.unpack_from(
                        "<IHHII", data, off
                    )
                    off += 18  # 16 bytes of fields + the 0xFFFF terminator
                    preload_data = data[off : off + preload]
                    off += preload
                    prefix = "" if folder in ("", " ") else folder + "/"
                    suffix = "" if ext in ("", " ") else "." + ext
                    key = f"{prefix}{name}{suffix}".lower()
                    self.entries[key] = (archive, entry_off, entry_len, preload_data)

    def __contains__(self, rel: str) -> bool:
        return rel.lower() in self.entries

    def read(self, rel: str) -> bytes:
        archive, entry_off, entry_len, preload = self.entries[rel.lower()]
        if entry_len == 0:
            return preload
        if archive == 0x7FFF:
            with self.path.open("rb") as f:
                f.seek(self.data_start + entry_off)
                return preload + f.read(entry_len)
        base = self.path.name.removesuffix("_dir.vpk")
        part = self.path.with_name(f"{base}_{archive:03d}.vpk")
        with part.open("rb") as f:
            f.seek(entry_off)
            return preload + f.read(entry_len)


# ── Search paths ──────────────────────────────────────────────────────────────


class SearchPaths:
    """Loose directories plus VPKs, searched in engine priority order."""

    def __init__(self):
        self.dirs: list[Path] = []
        self.vpks: list[VPK] = []
        self._listings: dict[Path, dict[str, str]] = {}

    def add_dir(self, path: Path, vpks: "list[str] | None" = None) -> None:
        """Add a content root. `vpks` names bare VPK stems (e.g. "pak01")."""
        path = path.resolve()
        if not path.is_dir():
            return
        if path not in self.dirs:
            self.dirs.append(path)
        for stem in vpks or []:
            candidate = path / f"{stem}_dir.vpk"
            if not candidate.is_file():
                candidate = path / f"{stem}.vpk"
            if candidate.is_file():
                try:
                    self.vpks.append(VPK(candidate))
                except (ValueError, OSError, struct.error) as e:
                    print(f"  warning: could not read {candidate}: {e}", file=sys.stderr)

    def _resolve_ci(self, root: Path, rel: str) -> "Path | None":
        """Resolve `rel` under `root`, falling back to a case-insensitive walk."""
        direct = root / rel
        if direct.is_file():
            return direct
        current = root
        for part in PurePosixPath(rel).parts:
            listing = self._listings.get(current)
            if listing is None:
                try:
                    listing = {p.name.lower(): p.name for p in current.iterdir()}
                except OSError:
                    return None
                self._listings[current] = listing
            actual = listing.get(part.lower())
            if actual is None:
                return None
            current = current / actual
        return current if current.is_file() else None

    def read(self, rel: str) -> "bytes | None":
        for root in self.dirs:
            found = self._resolve_ci(root, rel)
            if found is not None:
                return found.read_bytes()
        for vpk in self.vpks:
            if rel in vpk:
                return vpk.read(rel)
        return None


def steam_libraries(steamapps: Path) -> list[Path]:
    """Every steamapps folder reachable from this one, per libraryfolders.vdf."""
    libs = [steamapps]
    vdf = steamapps / "libraryfolders.vdf"
    if not vdf.is_file():
        return libs
    root = parse_kv(vdf.read_text(encoding="utf-8", errors="replace"))
    folders = kv_get(root, "libraryfolders")
    if not isinstance(folders, list):
        return libs
    for _, entry in folders:
        if isinstance(entry, list):
            path = kv_get(entry, "path")
            if isinstance(path, str):
                candidate = Path(path) / "steamapps"
                if candidate.is_dir() and candidate not in libs:
                    libs.append(candidate)
    return libs


def find_app_dir(appid: str, libraries: list[Path]) -> "Path | None":
    """Locate an installed app's content directory by its Steam AppID."""
    for lib in libraries:
        manifest = lib / f"appmanifest_{appid}.acf"
        if not manifest.is_file():
            continue
        state = parse_kv(manifest.read_text(encoding="utf-8", errors="replace"))
        app = kv_get(state, "AppState")
        installdir = kv_get(app, "installdir") if isinstance(app, list) else None
        if isinstance(installdir, str):
            candidate = lib / "common" / installdir
            if candidate.is_dir():
                return candidate
    return None


def build_search_paths(game_dir: Path, extra: list[Path], quiet: bool) -> SearchPaths:
    """The mod folder, then everything gameinfo.txt mounts, then --search dirs."""
    paths = SearchPaths()
    paths.add_dir(game_dir)

    gameinfo = game_dir / "gameinfo.txt"
    if gameinfo.is_file():
        root = parse_kv(gameinfo.read_text(encoding="utf-8", errors="replace"))
        info = kv_get(root, "GameInfo")
        mounts = kv_get(info, "mount") if isinstance(info, list) else None

        # steamapps/sourcemods/<mod> → steamapps
        steamapps = game_dir.resolve().parent.parent
        libraries = steam_libraries(steamapps) if steamapps.is_dir() else []

        for appid, folders in mounts or []:
            if not isinstance(folders, list):
                continue
            app_dir = find_app_dir(appid, libraries)
            if app_dir is None:
                if not quiet:
                    print(f"  note: AppID {appid} is mounted but not installed", file=sys.stderr)
                continue
            for subdir, contents in folders:
                if not isinstance(contents, list):
                    continue
                stems = [v for k, v in contents if k.lower() == "vpk" and isinstance(v, str)]
                paths.add_dir(app_dir / subdir, stems)

    for path in extra:
        paths.add_dir(path, ["pak01"])
    return paths


# ── Model parsing ─────────────────────────────────────────────────────────────


def vtx_lod0_triangles(data: bytes) -> "tuple[int, int] | None":
    """
    Sum LOD0 triangles and vertices across every body part of a .vtx file.
    Returns (triangles, vertices), or None if the file doesn't parse.
    """
    try:
        version, num_bodyparts, bodypart_off = struct.unpack_from("<i24xii", data, 0)
        if version != 7:
            return None

        tris = verts = 0
        for b in range(num_bodyparts):
            bp = bodypart_off + b * 8
            num_models, model_off = struct.unpack_from("<ii", data, bp)
            for m in range(num_models):
                md = bp + model_off + m * 8
                num_lods, lod_off = struct.unpack_from("<ii", data, md)
                if num_lods < 1:
                    continue
                lod = md + lod_off  # LOD0 only
                num_meshes, mesh_off = struct.unpack_from("<ii", data, lod)
                for i in range(num_meshes):
                    mesh = lod + mesh_off + i * 9  # MeshHeader_t is packed to 9 bytes
                    num_groups, group_off = struct.unpack_from("<ii", data, mesh)
                    for _, n_verts, n_indices in strip_groups(
                        data, mesh + group_off, num_groups
                    ):
                        tris += n_indices // 3
                        verts += n_verts
        return tris, verts
    except (struct.error, IndexError):
        return None


def strip_groups(data: bytes, base: int, count: int):
    """
    Yield (index, numVerts, numIndices) for a mesh's strip groups.

    StripGroupHeader_t grew two topology fields in later Source branches, so the
    stride is either 25 or 33 bytes. Pick whichever gives sane headers for every
    group; with a single group the choice can't matter.
    """
    if count <= 0:
        return

    def read(stride: int):
        out = []
        for s in range(count):
            off = base + s * stride
            n_verts, vert_off, n_indices, index_off = struct.unpack_from("<iiii", data, off)
            if n_verts < 0 or n_indices < 0 or n_indices % 3:
                return None
            if not (0 < vert_off < len(data)) or not (0 < index_off < len(data)):
                return None
            out.append((s, n_verts, n_indices))
        return out

    groups = read(25) or read(33)
    if groups is None:
        raise struct.error("no plausible strip group stride")
    yield from groups


def vvd_lod0_vertices(data: bytes) -> "int | None":
    """LOD0 vertex count from a .vvd header, used when no .vtx is available."""
    try:
        num_lods = struct.unpack_from("<i", data, 12)[0]
        if num_lods < 1:
            return None
        return struct.unpack_from("<i", data, 16)[0]
    except struct.error:
        return None


def mdl_bone_count(data: bytes) -> "int | None":
    """Bone count from an .mdl header — a cheap static-prop sanity signal."""
    try:
        return struct.unpack_from("<i", data, 156)[0]
    except struct.error:
        return None


def mdl_bbox(data: bytes) -> "tuple[float, float, float] | None":
    """
    Model dimensions in Hammer units, from the .mdl header's collision hull.
    Falls back to the render bbox when the hull is absent or degenerate.
    """
    try:
        for offset in (104, 128):  # hull_min/hull_max, then view_bbmin/view_bbmax
            mins = struct.unpack_from("<3f", data, offset)
            maxs = struct.unpack_from("<3f", data, offset + 12)
            size = tuple(hi - lo for lo, hi in zip(mins, maxs))
            if max(size) > 0 and all(0 <= d < 1e6 for d in size):
                return size
    except struct.error:
        pass
    return None


class ModelStats:
    __slots__ = ("model", "tris", "verts", "bones", "count", "source", "error",
                 "size", "scale", "area", "density")

    def __init__(self, model: str):
        self.model = model
        self.tris: int | None = None
        self.verts: int | None = None
        self.bones: int | None = None
        self.count = 0
        self.source = ""
        self.error = ""
        self.size: tuple[float, float, float] | None = None
        self.scale = 1.0
        self.area: float | None = None
        self.density: float | None = None


def apply_dimensions(stats: ModelStats, scale: float) -> None:
    """Scale the bbox to the size the prop is actually placed at, then derive
    triangles per 1,000 square units of bounding-box surface."""
    if stats.size is None:
        return
    stats.scale = scale
    stats.size = tuple(d * scale for d in stats.size)
    w, h, d = stats.size
    # Both faces of a flat model count, so a plane still gets a sane area.
    stats.area = 2 * (w * h + h * d + w * d)
    if stats.area > 0 and stats.tris:
        stats.density = stats.tris / (stats.area / 1000.0)


def measure(model: str, paths: SearchPaths, mdlinfo: "MdlInfo | None",
            dims: bool = True) -> ModelStats:
    stats = ModelStats(model)
    stem = model.removesuffix(".mdl")
    resolved: Path | None = None

    def read(suffix: str) -> "bytes | None":
        """Companion file for this model, from the search paths or next to it."""
        data = paths.read(stem + suffix)
        if data is None and resolved is not None:
            sibling = resolved.with_name(resolved.stem + suffix)
            if sibling.is_file():
                return sibling.read_bytes()
        return data

    mdl = paths.read(model)
    if mdl is None and mdlinfo is not None:
        resolved = mdlinfo.resolve(model)
        if resolved is not None:
            mdl = resolved.read_bytes()
            stats.source = str(resolved)
    if mdl is None:
        stats.error = "model not found"
        return stats
    stats.bones = mdl_bone_count(mdl)
    if dims:
        stats.size = mdl_bbox(mdl)

    for suffix in VTX_SUFFIXES:
        vtx = read(suffix)
        if vtx is None:
            continue
        result = vtx_lod0_triangles(vtx)
        if result is not None:
            stats.tris, stats.verts = result
            stats.source = stats.source or suffix
            return stats

    vvd = read(".vvd")
    if vvd is not None:
        stats.verts = vvd_lod0_vertices(vvd)
        stats.source = ".vvd"
        stats.error = "no .vtx; vertex count only"
    else:
        stats.error = "no .vtx or .vvd alongside model"
    return stats


class MdlInfo:
    """Fallback model resolution via the SDK's mdlinfo tool."""

    def __init__(self, bin_dir: Path, game_dir: Path):
        self.exe = bin_dir / "mdlinfo"
        self.game_dir = game_dir
        self.available = self.exe.is_file()

    def resolve(self, model: str) -> "Path | None":
        if not self.available:
            return None
        try:
            out = subprocess.run(
                [str(self.exe), "-game", str(self.game_dir), model],
                capture_output=True, text=True, timeout=30, cwd=self.exe.parent,
            ).stdout
        except (OSError, subprocess.SubprocessError):
            return None
        m = re.search(r'"filename"\s+"([^"]+)"', out)
        if not m:
            return None
        path = Path(m.group(1))
        return path if path.is_file() else None


# ── VMF scanning ──────────────────────────────────────────────────────────────


def prop_scale(entity: list) -> float:
    """The prop's uniform scale, defaulting to 1 for anything unparseable."""
    raw = kv_get(entity, "uniformscale")
    if not isinstance(raw, str):
        raw = kv_get(entity, "modelscale")
    try:
        scale = float(raw) if isinstance(raw, str) else 1.0
    except ValueError:
        return 1.0
    return scale if scale > 0 else 1.0


def collect_props(vmf: Path, classnames: set[str]) -> "tuple[Counter, dict[str, float]]":
    """
    Map each referenced model path to how many times the VMF places it, plus
    the mean scale it is placed at (props of the same model can differ).
    """
    root = parse_kv(vmf.read_text(encoding="utf-8", errors="replace"))
    counts: Counter = Counter()
    scales: dict[str, list[float]] = {}
    for key, value in root:
        if key.lower() != "entity" or not isinstance(value, list):
            continue
        classname = kv_get(value, "classname")
        if not isinstance(classname, str) or classname.lower() not in classnames:
            continue
        model = kv_get(value, "model")
        if isinstance(model, str) and model.strip():
            key = model.strip().replace("\\", "/").lower()
            counts[key] += 1
            scales.setdefault(key, []).append(prop_scale(value))
    return counts, {k: sum(v) / len(v) for k, v in scales.items()}


# ── Reporting ─────────────────────────────────────────────────────────────────


def size_str(stats: ModelStats) -> str:
    """The prop's placed dimensions, as W×D×H in Hammer units."""
    if stats.size is None:
        return "—"
    return "×".join(f"{d:,.0f}" for d in stats.size)


def print_report(rows: list[ModelStats], top: "int | None", sort_key: str,
                 dims: bool) -> None:
    total_tris = sum(r.tris * r.count for r in rows if r.tris)
    total_props = sum(r.count for r in rows)

    shown = rows if top is None else rows[:top]
    width = max((len(r.model) for r in shown), default=20)

    if dims:
        header = (f"{'#':>4}  {'TRIS':>9}  {'SIZE':>16}  {'TRIS/kU²':>9}  "
                  f"{'N':>5}  {'TOTAL':>10}  MODEL")
    else:
        header = f"{'#':>4}  {'TRIS':>9}  {'VERTS':>9}  {'N':>5}  {'TOTAL':>10}  MODEL"
    print(header)
    print("─" * (len(header) + width - 5))
    for i, r in enumerate(shown, 1):
        tris = f"{r.tris:,}" if r.tris is not None else "—"
        total = f"{r.tris * r.count:,}" if r.tris is not None else "—"
        notes = [r.error] if r.error else []
        if dims and abs(r.scale - 1.0) > 0.01:
            notes.append(f"scaled ×{r.scale:.2f}")
        note = f"  ({'; '.join(notes)})" if notes else ""
        if dims:
            density = f"{r.density:,.1f}" if r.density is not None else "—"
            print(f"{i:>4}  {tris:>9}  {size_str(r):>16}  {density:>9}  "
                  f"{r.count:>5}  {total:>10}  {r.model}{note}")
        else:
            verts = f"{r.verts:,}" if r.verts is not None else "—"
            print(f"{i:>4}  {tris:>9}  {verts:>9}  {r.count:>5}  {total:>10}  "
                  f"{r.model}{note}")

    if top is not None and len(rows) > top:
        print(f"      … {len(rows) - top} more")
    print()
    print(
        f"{len(rows)} unique model(s), {total_props} prop(s), "
        f"{total_tris:,} triangles total (sorted by {sort_key})"
    )
    if dims:
        measured = [r.density for r in rows if r.density is not None]
        print("SIZE is the placed bounding box (W×D×H, Hammer units); TRIS/kU² is "
              "triangles per 1,000 units² of that box's surface.")
        if measured:
            measured.sort()
            median = measured[len(measured) // 2]
            print(f"Median density here is {median:,.1f} — anything well above that "
                  f"is dense for its size.")

    missing = [r for r in rows if r.tris is None]
    if missing:
        print(f"{len(missing)} model(s) could not be measured:", file=sys.stderr)
        for r in missing:
            print(f"  {r.model}: {r.error}", file=sys.stderr)


def write_csv(rows: list[ModelStats], out: Path) -> None:
    with out.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["model", "triangles", "vertices", "bones", "instances",
                    "total_triangles", "width", "depth", "height", "scale",
                    "surface_area", "tris_per_1k_area", "source", "note"])
        for r in rows:
            size = r.size or ("", "", "")
            w.writerow([
                r.model, r.tris or "", r.verts or "", r.bones or "", r.count,
                (r.tris * r.count) if r.tris else "",
                *(f"{d:.2f}" if isinstance(d, float) else d for d in size),
                f"{r.scale:.3f}",
                f"{r.area:.2f}" if r.area is not None else "",
                f"{r.density:.2f}" if r.density is not None else "",
                r.source, r.error,
            ])


# ── Entry point ───────────────────────────────────────────────────────────────


def main(argv: "list[str] | None" = None) -> int:
    ap = argparse.ArgumentParser(
        description="Rank the static props in a VMF by poly count.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    ap.add_argument("vmf", type=Path, help="the .vmf file to scan")
    ap.add_argument("-g", "--game", type=Path, default=Path.cwd(),
                    help="mod folder containing gameinfo.txt")
    ap.add_argument("-b", "--bin", type=Path, default=DEFAULT_BIN,
                    help="SDK bin folder, used as a mdlinfo fallback for lookups")
    ap.add_argument("-s", "--search", type=Path, action="append", default=[],
                    metavar="DIR", help="extra content folder to search (repeatable)")
    ap.add_argument("-c", "--classname", action="append", default=[],
                    help=f"entity classname to include (default: {', '.join(DEFAULT_CLASSNAMES)})")
    ap.add_argument("-n", "--top", type=int, default=25,
                    help="how many models to list; 0 for all")
    ap.add_argument("--sort", choices=("tris", "total", "instances", "density"),
                    default=None,
                    help="density = tris per unit of bounding-box surface "
                         "(the default; tris when --no-dims), tris = per model, "
                         "total = tris × instances")
    ap.add_argument("--no-dims", dest="dims", action="store_false",
                    help="skip bounding-box sizing and the density column")
    ap.add_argument("--csv", type=Path, help="also write the full table to this CSV")
    ap.add_argument("-q", "--quiet", action="store_true", help="suppress progress output")
    args = ap.parse_args(argv)

    if not args.vmf.is_file():
        ap.error(f"no such VMF: {args.vmf}")

    game_dir = args.game.resolve()
    if not (game_dir / "gameinfo.txt").is_file() and not args.quiet:
        print(f"warning: no gameinfo.txt in {game_dir}; mounted content will be missed",
              file=sys.stderr)

    if args.sort == "density" and not args.dims:
        ap.error("--sort density needs the dimension pass; drop --no-dims")
    sort = args.sort or ("density" if args.dims else "tris")

    classnames = {c.lower() for c in (args.classname or DEFAULT_CLASSNAMES)}
    props, scales = collect_props(args.vmf, classnames)
    if not props:
        print(f"No {'/'.join(sorted(classnames))} entities found in {args.vmf}")
        return 0

    if not args.quiet:
        print(f"Found {sum(props.values())} prop(s) using {len(props)} unique model(s).")
        print("Building search paths…")

    paths = build_search_paths(game_dir, args.search, args.quiet)
    if not args.quiet:
        print(f"  {len(paths.dirs)} content folder(s), {len(paths.vpks)} VPK(s)")

    mdlinfo = MdlInfo(args.bin, game_dir)
    if not mdlinfo.available and not args.quiet:
        print(f"  note: no mdlinfo in {args.bin}; skipping that fallback", file=sys.stderr)

    rows = []
    for model, count in props.items():
        stats = measure(model, paths, mdlinfo, args.dims)
        stats.count = count
        if args.dims:
            apply_dimensions(stats, scales.get(model, 1.0))
        rows.append(stats)

    keys = {
        "tris": lambda r: (r.tris or -1, r.count),
        "total": lambda r: ((r.tris or -1) * r.count, r.tris or -1),
        "instances": lambda r: (r.count, r.tris or -1),
        "density": lambda r: (r.density or -1.0, float(r.tris or -1)),
    }
    rows.sort(key=keys[sort], reverse=True)

    if not args.quiet:
        print()
    print_report(rows, None if args.top <= 0 else args.top, sort, args.dims)

    if args.csv:
        write_csv(rows, args.csv)
        print(f"Wrote {args.csv}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
