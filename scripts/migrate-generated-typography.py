#!/usr/bin/env python3
"""Repair literal legacy TextStyle italic flags; dry-run unless --apply."""
import argparse
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
theme = importlib.util.module_from_spec(spec)
spec.loader.exec_module(theme)


def migrate(source):
    code = theme.boundary.executable_code(source)
    if '// Generated directly from SQLite Database' not in source:
        return source, 0
    if re.search(r'\b(?:class|typedef|mixin|enum)\s+(?:TextStyle|FontStyle)\b|\b(?:TextStyle|FontStyle)\s*=', code):
        return source, 0
    frames = theme.frames(code)
    edits = []
    for match in re.finditer(r'\bitalic\s*:\s*(true|false)\b', code):
        parents = [frame for frame in frames if frame[0] < match.start() < frame[1]]
        parent = max(parents, key=lambda frame: frame[0]) if parents else None
        if not parent or parent[2] != 'TextStyle' or re.search(r'\bfontStyle\s*:', code[parent[0]:parent[1]]):
            continue
        if any(mark in source[match.start():match.end()] for mark in ('//', '/*')):
            continue
        edits.append((match.start(), match.end(), 'fontStyle: FontStyle.' + ('italic' if match[1] == 'true' else 'normal')))
    for begin, end, replacement in reversed(edits):
        source = source[:begin] + replacement + source[end:]
    return source, len(edits)


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
    files, calls = [], 0
    paths = sorted((root / 'packages/primecare_ui/lib/src/features/generated_screens').glob('*.dart'))
    for path in paths[args.offset:args.offset + args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            files.append(path.relative_to(root).as_posix())
            calls += count
    print(json.dumps({'applied': args.apply, 'repairs': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
