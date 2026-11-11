#!/usr/bin/env python3
"""Migrate only plain Scaffold(appBar: AppBar(title: ...), body: ...) shells.

No scaffold/app-bar keys, options, type references or part files qualify.
Bodies, title widgets, const parents and callback expressions remain unchanged.
Dry-run by default; --path scopes writes, --add-imports permits narrow imports.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
b = importlib.util.module_from_spec(spec)
spec.loader.exec_module(b)
IMPORT = "import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;\n"


def named_arguments(code, parts):
    result = {}
    for start, end in parts:
        if not code[start:end].strip():
            continue
        match = re.match(r'\s*(\w+)\s*:', code[start:end])
        if not match or match[1] in result:
            return None
        result[match[1]] = (start + match.end(), end, start, start + match.start(1), start + match.end(1))
    return result


def migrate(source, add_import=False):
    code = b.text.boundary.executable_code(source)
    material = [m for m in b.text.MATERIAL.finditer(source) if code[m.start():].startswith('import')]
    shared = any(code[m.start():].startswith('import') for m in b.SHARED.finditer(source))
    if not material or not (shared or add_import):
        return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Scaffold|AppBar|PrimePageScaffold)\b', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:Scaffold|AppBar|PrimePageScaffold)\s*\(|\b(?:Scaffold|AppBar|PrimePageScaffold)\s*=', code):
        return source, 0
    for symbol in ('Scaffold', 'AppBar'):
        if any(not re.match(r'\s*\(', code[m.end():]) for m in re.finditer(r'\b' + symbol + r'\b', code)):
            return source, 0
    if not shared and re.search(r'\bPrimePageScaffold\b', code):
        return source, 0
    edits, count = [], 0
    for call in re.finditer(r'(?<![\w.])Scaffold\s*\(', code):
        if code[:call.start()].rstrip().endswith('.'):
            continue
        parsed = b.arguments(code, call.end())
        if not parsed:
            continue
        parts, end = parsed
        fields = named_arguments(code, parts)
        if not fields or set(fields) != {'appBar', 'body'}:
            continue
        value_start, value_end, _, name_start, name_end = fields['appBar']
        appbar = re.match(r'\s*AppBar\s*\(', code[value_start:value_end])
        if not appbar:
            continue
        inner = b.arguments(code, value_start + appbar.end())
        if not inner:
            continue
        inner_parts, inner_end = inner
        title = named_arguments(code, inner_parts)
        if not title or set(title) != {'title'} or code[inner_end + 1:value_end].strip():
            continue
        # Retain uncommon commented header expressions for explicit review.
        fragment = source[value_start:value_end]
        if '/*' in fragment or '//' in fragment:
            continue
        begin, finish, *_ = title['title']
        # Nested shells inside this replaced title need resolved review.
        if re.search(r'\bScaffold\s*\(', code[begin:finish]):
            continue
        edits.extend([(call.start(), call.start() + len('Scaffold'), 'PrimePageScaffold'),
                      (name_start, name_end, 'title'),
                      (value_start, value_end, ' ' + source[begin:finish].strip())])
        count += 1
    for begin, end, replacement in sorted(edits, reverse=True):
        source = source[:begin] + replacement + source[end:]
    if count and not shared:
        position = material[0].start()
        source = source[:position] + IMPORT + source[position:]
    return source, count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--path', action='append')
    parser.add_argument('--add-imports', action='store_true')
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
        updated, count = migrate(path.read_text(), add_import=args.add_imports)
        if count:
            if args.apply:
                path.write_text(updated)
            calls += count
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'pages': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
