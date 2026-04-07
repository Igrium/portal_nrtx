"""A script to scale down textures above a given threshold, updating all VMTs as needed."""

import argparse
import os
from os import path
import re
import subprocess
import sys

import vdf

# ---------------------------------------------------------------------------
# Type aliases
# ---------------------------------------------------------------------------

DepMap = dict[str, list[str]]
ImageDimensions = tuple[int, int]

# ---------------------------------------------------------------------------
# Global config
# ---------------------------------------------------------------------------

folder: str
factor: float
threshold: int

# ---------------------------------------------------------------------------
# Low-level helpers
# ---------------------------------------------------------------------------

def parse_material(vmt_path: str) -> tuple[str, dict]:
    """Load a VMT file and parse its keyvalues.

    Returns:
        tuple[str, dict]: The shader name and its parameter dict.
    """
    with open(vmt_path, 'r') as f:
        data = vdf.load(f)

    if len(data) == 0:
        print(f"No material data found in {vmt_path}")
        return ('', {})

    shader = next(iter(data.keys()))
    return (shader, data[shader])


def save_material(vmt_path: str, shader: str, params: dict):
    with open(vmt_path, 'w') as f:
        vdf.dump({shader: params}, f, pretty=True)


def tex_name(vtf_path: str) -> str:
    """Return the texture name as it appears in a VMT (relative, forward-slashed, no extension)."""
    return path.splitext(path.relpath(vtf_path, folder))[0].replace('\\', '/')


def get_texture_info(vtf_path: str) -> dict | None:
    """Run maretf to retrieve metadata for a VTF file. Returns None on failure."""
    result = subprocess.run(
        ['maretf', 'info', '--verbose', '--info-output-mode', 'kv1', path.abspath(vtf_path)],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"Warning: maretf failed for {vtf_path}: {result.stderr.strip()}", file=sys.stderr)
        return None

    return vdf.loads(result.stdout)


def get_dimensions(tex_info: dict) -> ImageDimensions:
    """Extract (width, height) from a maretf texture-info dict."""
    dims = tex_info['image']['dimensions']
    return (int(dims['width']), int(dims['height']))


def modify_transform(transform: str, factor: float) -> str:
    """Modify a $basetexturetransform string, adjusting its scale by a given amount."""
    return re.sub(
        r'(?<=scale )([\d.]+) ([\d.]+)',
        lambda m: f"{float(m.group(1)) * factor} {float(m.group(2)) * factor}",
        transform
    )

# ---------------------------------------------------------------------------
# Core processing
# ---------------------------------------------------------------------------

def build_dependency_map() -> DepMap:
    """Figure out which materials depend on which textures. $basetexture only."""
    print(f"Walking {folder}")
    deps: DepMap = {}

    for root, _dirs, files in os.walk(folder):
        for file in files:
            if path.splitext(file)[1] == '.vmt':
                params = parse_material(path.join(root, file))[1]
                base_texture = params.get('$basetexture')
                if base_texture is not None:
                    deps.setdefault(base_texture, []).append(path.join(root, file))

    return deps


def resize_texture(vtf_path: str, old_res: ImageDimensions) -> None:
    """Resize a VTF to old_res scaled by the global factor."""
    new_res = (int(old_res[0] * factor), int(old_res[1] * factor))
    print(f"Resizing {tex_name(vtf_path)} from {old_res} to {new_res}")

    result = subprocess.run(
        [
            'maretf', 'edit',
            '--set-width', str(new_res[0]),
            '--set-height', str(new_res[1]),
            '--recompute-mips', '-y',
            path.abspath(vtf_path),
        ],
        capture_output=True,
    )

    if result.returncode != 0:
        print(f"Warning: maretf failed for {vtf_path}: {result.stderr.strip()}", file=sys.stderr)


def process_texture(vtf_path: str, dep_map: DepMap | None) -> bool:
    """Fetch texture info and process it if it meets the resize threshold."""
    tex_info = get_texture_info(vtf_path)
    if tex_info is None:
        return False

    res = get_dimensions(tex_info)

    if res[0] >= threshold or res[1] >= threshold:
        resize_texture(vtf_path, res)

        if not dep_map:
            return True

        dependants = dep_map.get(tex_name(vtf_path))
        if dependants:
            for vmt_path in dependants:
                process_material(vmt_path)
        else:
            print("No dependant materials")

        return True
    return False


def get_first_tex() -> str | None:
    """Return the path of the first *_color.vtf file found under folder."""
    for root, _dirs, files in os.walk(folder):
        for file in files:
            name, ext = path.splitext(file)
            if ext == '.vtf' and name.endswith('_color'):
                return path.join(root, file)
    return None


def process_material(vmt_path: str):
    shader, params = parse_material(vmt_path)
    transform = params.get('$basetexturetransform')
    if not transform:
        print(f"Material {path.basename(vmt_path)} does not have a basetexturetransform. Skipping...")
        return

    params['$basetexturetransform'] = modify_transform(transform, factor)
    save_material(vmt_path, shader, params)
    print(f"Modified $basetexturetransform for {path.basename(vmt_path)}.")

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main() -> None:
    deps = build_dependency_map()

    for root, _dirs, files in os.walk(folder):
        for file in files:
            if path.splitext(file)[1] == '.vtf':
                process_texture(path.join(root, file), deps)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        prog='downscale_textures',
        description=(
            'Automatically adjust textures to a maximum resolution, '
            'updating VMTs to keep Hammer mapping intact.'
        ),
    )
    parser.add_argument('folder', help="The materials folder of your mod")
    parser.add_argument(
        '-t', '--threshold', type=int, default=4096,
        help="Textures with any dimension >= this value are processed.",
    )
    parser.add_argument(
        '-f', '--factor', type=float, default=0.5,
        help="Resize each qualifying texture by this factor.",
    )

    args = parser.parse_args()
    folder = args.folder
    threshold = args.threshold
    factor = args.factor

    main()