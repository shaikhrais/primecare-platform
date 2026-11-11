#!/usr/bin/env python3
"""Repair three exact invalid generated strings and apply established palette roles."""
import argparse
import hashlib
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('palette', Path(__file__).with_name('migrate-generated-theme.py'))
palette = importlib.util.module_from_spec(spec)
spec.loader.exec_module(palette)
MANIFEST = json.loads(Path(__file__).with_name('generated-possessive-manifest.json').read_text())
HASHES = {row['sha256'] for row in MANIFEST}
OLD = "'Summary card of the client's medical/care profile.'"
NEW = "'Summary card of the client\\'s medical/care profile.'"
HEADING = re.compile(r"(Text\(\n                        'Target Role: [^'\n$]+',\n                        style: )const (TextStyle\(fontWeight: FontWeight.bold, color: )Color\(0xFF881337\)(, fontSize: 14\),\n                      \))")


def migrate(source):
    if hashlib.sha256(source.encode()).hexdigest() not in HASHES or source.count(OLD) != 1:
        return source, 0
    fixed = source.replace(OLD, NEW)
    updated, count = palette.migrate(fixed)
    updated, headings = HEADING.subn(r'\1\2theme.colors.onSurface\3', updated)
    if count != 72 or headings != 1 or not palette.frames(palette.boundary.executable_code(updated)):
        return source, 0
    return updated, count + headings


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
    files, edits = [], 0
    for row in MANIFEST[args.offset:args.offset + args.limit]:
        path = root / row['path']
        if path.is_symlink() or not path.resolve().is_relative_to(root) or not path.is_file():
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            files.append(row['path'])
            edits += count
    print(json.dumps({'applied': args.apply, 'themeEdits': edits, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
