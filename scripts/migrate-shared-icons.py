#!/usr/bin/env python3
"""Route compatible app Icon calls through PrimeIcon. Dry run by default.

Only unrestricted Material/shared imports qualify. Concrete Icon type references,
constructor tear-offs, part files, aliases and unsupported parameters need review.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
b = importlib.util.module_from_spec(spec)
spec.loader.exec_module(b)
PARAMETERS = {'key', 'color', 'size', 'semanticLabel', 'textDirection'}
CALL = re.compile(r'(?<![\w.])Icon\s*\(')


def migrate(source):
    code = b.text.boundary.executable_code(source)
    for pattern in (b.SHARED, b.text.MATERIAL):
        if not any(code[m.start():].startswith('import') for m in pattern.finditer(source)):
            return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Icon|PrimeIcon)\b', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:Icon|PrimeIcon)\s*\(|\b(?:Icon|PrimeIcon)\s*=', code):
        return source, 0
    if any(not re.match(r'\s*\(', code[m.end():]) for m in re.finditer(r'\bIcon\b', code)):
        return source, 0
    edits = []
    for call in CALL.finditer(code):
        if code[:call.start()].rstrip().endswith('.'):
            continue
        parsed = b.arguments(code, call.end())
        if parsed is None:
            continue
        parts, end = parsed
        if not parts or re.match(r'\s*\w+\s*:', code[slice(*parts[0])]):
            continue
        seen = set()
        for begin, finish in parts[1:]:
            if not code[begin:finish].strip():
                continue
            named = re.match(r'\s*(\w+)\s*:', code[begin:finish])
            if not named or named[1] not in PARAMETERS or named[1] in seen:
                break
            seen.add(named[1])
        else:
            edits.append(call.start())
    for offset in reversed(edits):
        source = source[:offset] + 'PrimeIcon' + source[offset + 4:]
    return source, len(edits)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--path', action='append')
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    root = args.root.resolve()
    paths = set()
    for relative in args.path or ['apps']:
        path = root / relative
        if path.is_symlink() or not path.resolve().is_relative_to(root / 'apps'):
            parser.error('paths must stay inside apps without symlink escapes')
        paths.update([path] if path.is_file() else path.rglob('*.dart'))
    files, calls = [], 0
    for path in sorted(paths):
        if path.suffix != '.dart' or 'lib' not in path.relative_to(root).parts or path.is_symlink() or not path.resolve().is_relative_to(root / 'apps'):
            continue
        pubspec = root / Path(*path.relative_to(root).parts[:2]) / 'pubspec.yaml'
        if not pubspec.is_file() or not b.text.shared_dependency(pubspec.read_text()):
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            calls += count
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'calls': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
