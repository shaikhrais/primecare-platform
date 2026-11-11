#!/usr/bin/env python3
"""Remove unused names from generated shared status imports; dry run by default.

Only exact, unaliased status show-lists qualify. Part libraries and commented
directives require analyzer review. Executable interpolation counts as usage.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('boundary', Path(__file__).with_name('check-shared-ui-boundary.py'))
boundary = importlib.util.module_from_spec(spec)
spec.loader.exec_module(boundary)
NAMES = ('PrimeStatusIcon', 'PrimeStatusText', 'PrimeStatusTone')
IMPORT = re.compile(r"\bimport\s+(['\"])package:primecare_ui/(?:primecare_ui.dart|src/components/prime_status.dart)\1\s+show\s+(PrimeStatus\w+(?:\s*,\s*PrimeStatus\w+)*)\s*;")


def clean(source):
    code = boundary.executable_code(source)
    if re.search(r'\bpart\b', code):
        return source, 0
    matches = [m for m in IMPORT.finditer(source)
               if code[m.start():].startswith('import')
               and set(re.split(r'\s*,\s*', m[2])) <= set(NAMES)]
    # Ignore every matched import while looking for real uses.
    usage = list(code)
    for m in matches:
        usage[m.start():m.end()] = ' ' * (m.end() - m.start())
    usage = ''.join(usage)
    edits, removed = [], 0
    for m in matches:
        names = re.split(r'\s*,\s*', m[2])
        used = [name for name in names if re.search(r'\b' + name + r'\b', usage)]
        if len(used) == len(names):
            continue
        removed += len(names) - len(used)
        replacement = source[m.start():m.start(2)] + ', '.join(used) + source[m.end(2):m.end()] if used else ''
        edits.append((m.start(), m.end(), replacement))
    for begin, end, replacement in reversed(edits):
        source = source[:begin] + replacement + source[end:]
    return source, removed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    root = args.root.resolve()
    files, names = [], 0
    for base in ('apps', 'packages/primecare_ui'):
        for path in sorted((root / base).rglob('*.dart')):
            if 'lib' not in path.relative_to(root).parts or path.is_symlink() or not path.resolve().is_relative_to(root):
                continue
            updated, count = clean(path.read_text())
            if count:
                if args.apply:
                    path.write_text(updated)
                names += count
                files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'unused_names_removed': names, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
