#!/usr/bin/env python3
"""Migrate exact generated themed workspace shells; dry run by default.

Accept only the known background/surface tokens, zero header elevation and a
literal local scaffold Key. Title/body/actions remain unchanged. Other options,
GlobalKeys, ambiguous symbols, type references and part files require review.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('pages', Path(__file__).with_name('migrate-shared-pages.py'))
p = importlib.util.module_from_spec(spec)
spec.loader.exec_module(p)
b = p.b


def migrate(source):
    code = b.text.boundary.executable_code(source)
    for pattern in (b.SHARED, b.text.MATERIAL):
        if not any(code[m.start():].startswith('import') for m in pattern.finditer(source)):
            return source, 0
    names = r'(?:Scaffold|AppBar|PrimeWorkspaceScaffold)'
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+' + names + r'\b', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+' + names + r'\s*\(|\b' + names + r'\s*=', code):
        return source, 0
    for symbol in ('Scaffold', 'AppBar'):
        if any(not re.match(r'\s*\(', code[m.end():]) for m in re.finditer(r'\b' + symbol + r'\b', code)):
            return source, 0
    edits, count = [], 0
    for call in re.finditer(r'(?<![\w.])Scaffold\s*\(', code):
        if code[:call.start()].rstrip().endswith('.'):
            continue
        parsed = b.arguments(code, call.end())
        if not parsed:
            continue
        parts, end = parsed
        fields = p.named_arguments(code, parts)
        if not fields or set(fields) != {'key', 'backgroundColor', 'appBar', 'body'}:
            continue
        def text(field, original=False):
            start, end, *_ = field
            return (source if original else code)[start:end].strip()
        if not re.fullmatch(r"const\s+Key\(\s*(?:'[^'\n$]*'|\"[^\"\n$]*\")\s*\)", text(fields['key'], True)):
            continue
        if re.sub(r'\s+', '', text(fields['backgroundColor'])) != 'theme.colors.background':
            continue
        begin, finish, *_ = fields['appBar']
        appbar = re.match(r'\s*AppBar\s*\(', code[begin:finish])
        if not appbar:
            continue
        inner = b.arguments(code, begin + appbar.end())
        if not inner:
            continue
        inner_parts, inner_end = inner
        header = p.named_arguments(code, inner_parts)
        if not header or set(header) != {'backgroundColor', 'elevation', 'title', 'actions'}:
            continue
        if code[inner_end + 1:finish].strip():
            continue
        if re.sub(r'\s+', '', text(header['backgroundColor'])) != 'theme.colors.surface' or text(header['elevation']) != '0':
            continue
        # Removing only the known header structure must not discard comments.
        fragment = source[call.start():finish]
        if '/*' in fragment or '//' in fragment or re.search(r'\bScaffold\s*\(', text(header['title']) + text(header['actions'])):
            continue
        key_start, key_end, _, name_start, name_end = fields['key']
        app_start, app_end, _, app_name_start, app_name_end = fields['appBar']
        edits.extend([(call.start(), call.start() + len('Scaffold'), 'PrimeWorkspaceScaffold'),
                      (name_start, name_end, 'scaffoldKey'),
                      (app_name_start, app_name_end, 'title'),
                      (app_start, app_end, ' ' + text(header['title'], True) + ',\n          headerColor: ' + text(header['backgroundColor'], True) + ',\n          actions: ' + text(header['actions'], True))])
        count += 1
    for begin, end, replacement in sorted(edits, reverse=True):
        source = source[:begin] + replacement + source[end:]
    return source, count


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
    print(json.dumps({'applied': args.apply, 'pages': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
