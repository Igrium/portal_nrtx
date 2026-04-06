"""A script to scale down textures above a given threshold, updating all VMTs as needed."""

import os
from os import path
import argparse
import sys
import vdf
import subprocess

DepMap = dict[str, list[str]]

def build_dependency_map(folder: str):
    """Figure out which materials depend on which textures. Base texture only."""
    ...
    print(f"Walking {folder}")

    deps: DepMap = {}

    for root, dirs, files in os.walk(folder):
        for file in files:
            ext = os.path.splitext(file)[1]

            if ext == '.vmt':
                base_texture = find_base_texture(path.join(root, file))
                if base_texture != None:

                    dep_list = deps.setdefault(base_texture, [])
                    dep_list.append(path.join(root, file))
    
    return deps


def find_base_texture(vmt_path: str) -> str | None:
    with open(vmt_path, 'r') as f:
        data = vdf.load(f)
    
    # Get the material object out
    mat = next(iter(data.values()))

    return mat.get('$basetexture')

def get_texture_info(vtf_path: str):
    result = subprocess.run(
        ['maretf', 'info', '--verbose', '--info-output-mode', 'kv1', path.abspath(vtf_path)],
        capture_output=True,
        text=True)

    if result.returncode != 0:
        print(f"Warning: maretf failed for {vtf_path}: {result.stderr.strip()}", file=sys.stderr)
        return None

    return vdf.loads(result.stdout)

def main():
    parser = argparse.ArgumentParser(
        prog='downscale_textures',
        description='Automatically adjust textures to a maximum resolution, updating vmts to keep hammer mapping intact.'
    )

    parser.add_argument('folder', help="The materials folder of your mod")

    args = parser.parse_args()

    build_dependency_map(args.folder)
    print(get_texture_info(args.folder))

if __name__ == '__main__':
    main()
