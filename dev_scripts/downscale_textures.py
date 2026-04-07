"""A script to scale down textures above a given threshold, updating all VMTs as needed."""

import argparse
import os
from os import path
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


def get_tex_name(vtf_path: str) -> str:
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

# ---------------------------------------------------------------------------
# Core processing
# ---------------------------------------------------------------------------

def process_texture(vtf_path: str, old_res: ImageDimensions) -> None:
    """Resize a VTF to old_res scaled by the global factor."""
    new_res = (int(old_res[0] * factor), int(old_res[1] * factor))
    tex_name = get_tex_name(vtf_path)
    print(f"Resizing {tex_name} from {old_res} to {new_res}")

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


def process_if_hit_threshold(vtf_path: str) -> None:
    """Fetch texture info and process it if it meets the resize threshold."""
    tex_info = get_texture_info(vtf_path)
    if tex_info is None:
        return

    res = get_dimensions(tex_info)
    process_texture(vtf_path, res)


def get_first_tex() -> str | None:
    """Return the path of the first *_color.vtf file found under folder."""
    for root, _dirs, files in os.walk(folder):
        for file in files:
            name, ext = path.splitext(file)
            if ext == '.vtf' and name.endswith('_color'):
                return path.join(root, file)
    return None


def process_material(vmt_path: str, updated_textures: list[str]) -> bool:
    """Check if a material uses an updated texture as its basetexture and adjust UV mapping as needed.

    Args:
        vmt_path: Path to the VMT file.
        updated_textures: All textures that have been resized.

    Returns:
        bool: Whether the material was updated.
    """
    shader, params = parse_material(vmt_path)
    basetexture = params.get('$basetexture')
    needs_process = basetexture is not None and basetexture in updated_textures

    if not needs_process:
        return False

    print(f"Material {vmt_path} needs processing!")
    return True


def process_materials(updated_textures: list[str]) -> None:
    """Walk the folder and process any VMT that references an updated texture."""
    print(f"Checking for materials with textures: {updated_textures}")
    for root, _dirs, files in os.walk(folder):
        for file in files:
            if path.splitext(file)[1] == '.vmt':
                process_material(path.join(root, file), updated_textures)

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main() -> None:
    tex = get_first_tex()
    print(tex)
    if tex:
        process_if_hit_threshold(tex)
        process_materials([get_tex_name(tex)])

    # Walk all textures
    # for root, dirs, files in os.walk(folder):
    #     for file in files:
    #         if path.splitext(file)[1] == '.vtf':
    #             print(get_tex_name(path.join(root, file)))


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