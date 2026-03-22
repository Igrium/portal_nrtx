"""A script to increase lightmap resolution in vmfs to modern standards"""

import argparse
import re
import sys


COMPLETED_FLAG = '"lightmap_upscaled" "1"'

def check_already_processed(content: str) -> bool:
    # Only look inside the world block's own keys, not nested solids
    world_match = re.search(r'^world\s*\{', content, re.MULTILINE)
    if not world_match:
        return False
    # Scan lines from world open brace until the first nested block
    world_section = content[world_match.end():]
    for line in world_section.splitlines():
        stripped = line.strip()
        if stripped == '{':  # entering a nested block (solid), stop
            break
        if stripped == COMPLETED_FLAG:
            return True
    return False

def inject_flag(content: str) -> str:
    # Insert the flag key after the opening brace of the world block
    return re.sub(
        r'^(world\s*\{\n)',
        r'\1\t' + COMPLETED_FLAG + '\n',
        content,
        count=1,
        flags=re.MULTILINE,
    )

def execute(content: str, threshold: int, divisor: int) -> tuple[str, int, int]:
    count = 0
    skipped = 0

    def replacer(m: re.Match) -> str:
        nonlocal count
        nonlocal skipped
        value = int(m.group(1))
        if value >= threshold:
            count += 1
            return f'"lightmapscale" "{value // divisor}"'
        else:
            skipped += 1
        return m.group(0)
    
    result = re.sub(r'"lightmapscale" "(\d+)"', replacer, content)
    return result, count, skipped

def confirm_proceed(path: str) -> bool:
    answer = input(
        f"Warning: '{path}' appears to have already been processed. "
        "Proceed anyway? [y/N] "
    ).strip().lower()
    return answer == 'y'

def main():
    parser = argparse.ArgumentParser(
        prog='upscale_lightmaps',
        description="Increase the resolution of lightmaps in a VMF file."
    )

    parser.add_argument('input', help="Path to the input VMF file")
    parser.add_argument('-o', '--output', help="Output VMF path (defaults to overwriting the input file)")
    parser.add_argument('-f', '--force', action='store_true', help="Skip the already-processed warning")

    parser.add_argument('-t', '--threshold', type=int, default=16,
                        help="Lightmap scales at or over this value get reduced. Defaults to 16.")
    parser.add_argument('-d', '--divisor', type=int, default=2,
                        help="Divide all eligible lightmap scales by this amount. Defaults to 2.")
    
    args = parser.parse_args()

    input_path = args.input
    output_path = args.output or input_path

    try:
        with open(input_path, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        sys.exit(f"Error: file not found: {input_path}")
    except OSError as e:
        sys.exit(f"Error reading file: {e}")
    

    already_processed = check_already_processed(content)
    if already_processed and not (args.force or confirm_proceed(input_path)):
        sys.exit("Aborted.")

    content, count, skipped = execute(content, args.threshold, args.divisor)

    if not already_processed:
        content = inject_flag(content)
    
    print(f"Divided the lightmapscale of {count} faces by {args.divisor}. Skipped {skipped} faces.")

    if count > 0:
        try:
            with open(output_path, 'w') as f:
                f.write(content)
        except OSError as e:
            sys.exit(f"Error writing file: {e}")
    
        if input_path == output_path:
            print(f"Overwrote {output_path}")
        else:
            print(f"Wrote to {output_path}")
    else:
        print("Nothing changed in the file.")

if __name__ == '__main__':
    main()