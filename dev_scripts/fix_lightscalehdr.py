#!/usr/bin/env python3
"""Set _lightscaleHDR to 1 on every entity in a VMF that defines it.

Usage:
    fix_lightscalehdr.py <file.vmf> [-o OUTPUT] [--dry-run]

Prints one line per replaced value: entity id, classname, targetname and the
old value. Without -o the file is edited in place.
"""

import argparse
import re
import sys

KEY = "_lightscaleHDR"
NEW_VALUE = "1"

KEY_RE = re.compile(r'^(\s*)"([^"]+)"\s+"([^"]*)"\s*$')
BLOCK_NAME_RE = re.compile(r'^\s*([A-Za-z_][A-Za-z0-9_]*)\s*$')


def entity_ranges(lines):
    """Yield (start, end) line indices (inclusive of the closing brace) of
    every `entity { ... }` block, however deeply nested."""
    stack = []  # (block name, start index)
    pending = None  # name of a block whose `{` has not been seen yet
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped == "{":
            stack.append((pending, i))
            pending = None
        elif stripped == "}":
            if stack:
                name, start = stack.pop()
                if name == "entity":
                    yield start, i
        else:
            m = BLOCK_NAME_RE.match(line)
            pending = m.group(1) if m else None


def process(lines):
    """Rewrite lines in place; return a list of (id, classname, targetname, old)."""
    replaced = []
    for start, end in entity_ranges(lines):
        body = range(start, end + 1)
        props = {}
        hits = []
        for i in body:
            m = KEY_RE.match(lines[i])
            if not m:
                continue
            _, key, value = m.groups()
            props.setdefault(key, value)
            if key == KEY:
                hits.append((i, value))
        for i, old in hits:
            if old == NEW_VALUE:
                continue
            indent = KEY_RE.match(lines[i]).group(1)
            lines[i] = f'{indent}"{KEY}" "{NEW_VALUE}"\n'
            replaced.append((
                props.get("id", "?"),
                props.get("classname", "?"),
                props.get("targetname", ""),
                old,
            ))
    return replaced


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("vmf", help="VMF file to process")
    parser.add_argument("-o", "--output", help="write here instead of in place")
    parser.add_argument("--dry-run", action="store_true",
                        help="only list what would change")
    args = parser.parse_args()

    with open(args.vmf, "r", encoding="utf-8", errors="surrogateescape") as f:
        lines = f.readlines()

    replaced = process(lines)

    for ent_id, classname, targetname, old in replaced:
        name = f" ({targetname})" if targetname else ""
        print(f'id {ent_id}\t{classname}{name}\t{old} -> {NEW_VALUE}')
    print(f"{len(replaced)} value(s) replaced", file=sys.stderr)

    if args.dry_run:
        return
    out = args.output or args.vmf
    with open(out, "w", encoding="utf-8", errors="surrogateescape", newline="") as f:
        f.writelines(lines)


if __name__ == "__main__":
    main()
