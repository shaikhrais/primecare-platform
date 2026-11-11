#!/usr/bin/env python3
"""Resolve exact generated API-error panel borders from the active error token.

Dry run by default. No decorative reds, modified colors, unlabelled panels,
constant declarations or scopes without an existing context.theme qualify.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)


def migrate(source):
    if 'api-error' not in source or 'Colors.red' not in source:
        return source, 0
    code = t.boundary.executable_code(source)
    for package in ('flutter/material.dart', 'primecare_ui/primecare_ui.dart'):
        pattern = r"\bimport\s+(['\"])package:" + re.escape(package) + r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern, source)):
            return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Color|Colors|Cy|Border|Container|BoxDecoration)\b', code):
        return source, 0
    if re.search(r'\b(?:Color|Colors|Cy|Border|Container|BoxDecoration)\s*=|\bconst\s+\w+(?:\s+\w+)?\s*=', code):
        return source, 0
    frames = t.frames(code)
    by_open = {f[0]: f for f in frames}
    consts = [(m.start(), m.start()+len('const'), by_open.get(m.end()-1)) for m in t.CONST_CALL.finditer(code)]
    edits, removed = [], set()
    for method in re.finditer(r'\bWidget\s+buildScreen\s*\(BuildContext\s+context,\s*WidgetRef\s+ref\)\s*{', code):
        body = by_open.get(method.end()-1)
        if not body or not body[3] or body[3][3] is not None:
            continue
        body_code = code[body[0]+1:body[1]]
        # Bind in this method, before the return, with no reassignments.
        prefix = body_code.split('return', 1)[0]
        if not re.search(r'\bfinal\s+theme\s*=\s*context\.theme\s*;', prefix) or len(re.findall(r'\btheme\s*=', body_code)) != 1:
            continue
        for match in re.finditer(r'(?<![\w.])Colors\.red\b(?!\s*[.\[])', code[body[0]+1:body[1]]):
            start, end = body[0]+1+match.start(), body[0]+1+match.end()
            parents = [f for f in frames if f[0] < start < f[1]]
            parent = max(parents, key=lambda f:f[0]) if parents else None
            if not parent or parent[2] != 'Border.all' or not re.match(r'\s*color\s*:\s*$', code[parent[0]+1:start]):
                continue
            if code[end:parent[1]].strip() not in ('', ','):
                continue
            decoration = parent[3]
            container = decoration[3] if decoration and decoration[2] == 'BoxDecoration' else None
            cy = container[3] if container and container[2] == 'Container' else None
            if not cy or cy[2] != 'Cy' or not re.match(r"^\(\s*id\s*:\s*(['\"])api-error\1\s*,\s*child\s*:\s*Container\s*\(", source[cy[0]:container[0]+1]):
                continue
            if '/*' in source[parent[0]:parent[1]] or '//' in source[parent[0]:parent[1]]:
                continue
            edits.append((start, end, 'theme.colors.error'))
            for begin, finish, frame in consts:
                if frame and body[0] < begin <= start and frame[1] >= end-1:
                    removed.add((begin, finish, ''))
    for start, end, replacement in sorted(edits+list(removed), reverse=True):
        source = source[:start]+replacement+source[end:]
    return source, len(edits)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    root = args.root.resolve()
    files, calls = [], 0
    for base in ('apps', 'packages/primecare_ui'):
        for path in sorted((root/base).rglob('*.dart')):
            if 'lib' not in path.relative_to(root).parts or path.is_symlink() or not path.resolve().is_relative_to(root):
                continue
            updated, count = migrate(path.read_text())
            if count:
                if args.apply:
                    path.write_text(updated)
                calls += count
                files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'colors': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
