#!/usr/bin/env python3
"""Bind reviewed generated heading foregrounds to their existing onSurface role.

Whole-file input hashes deliberately reject edited files. Dry run by default.
"""
import argparse
import hashlib
import json
from pathlib import Path

MANIFEST = json.loads(Path(__file__).with_name('target-role-heading-manifest.json').read_text())
for row in MANIFEST:
    row['old'] = ("Text(\n                        'Target Role: " + row['role'] +
        "',\n                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF" +
        row['color'] + "), fontSize: 14),\n                      )")
    row['new'] = row['old'].replace('style: const TextStyle', 'style: TextStyle').replace(
        'Color(0xFF' + row['color'] + ')', 'theme.colors.onSurface')
BY_HASH = {row['sha256']: row for row in MANIFEST}


def migrate(source):
    row = BY_HASH.get(hashlib.sha256(source.encode()).hexdigest())
    if row is None or source.count(row['old']) != 1:
        return source, 0
    return source.replace(row['old'], row['new'], 1), 1


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--offset', type=int, default=0)
    parser.add_argument('--limit', type=int, default=100)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    if args.offset < 0 or args.limit < 1:
        parser.error('offset must be nonnegative and limit positive')
    root = args.root.resolve()
    files = []
    for row in MANIFEST[args.offset:args.offset + args.limit]:
        path = root / row['path']
        if path.is_symlink() or not path.resolve().is_relative_to(root) or not path.is_file():
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            files.append(row['path'])
    print(json.dumps({'applied': args.apply, 'colors': len(files), 'files': files}, indent=2))


if __name__ == '__main__':
    main()
