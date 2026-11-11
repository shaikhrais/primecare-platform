#!/usr/bin/env python3
"""Resolve exact generated API health label colors from success/warning tokens.

Only the known Offline/Nominal telemetry label in _TelemetryPanel qualifies.
Dry run by default; --offset/--limit split deterministic library batches.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)
PAIR = re.compile(r'\bcolor\s*:\s*data\.isEmpty\s*\?\s*(?P<warning>Colors\.amber)\s*:\s*(?P<success>const\s+Color\(0xFF10B981\))\s*(?=,)')


def migrate(source):
    code = t.boundary.executable_code(source)
    if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\b', code):
        return source, 0
    for package in ('flutter/material.dart', 'primecare_ui/primecare_ui.dart'):
        pattern = r"\bimport\s+(['\"])package:" + re.escape(package) + r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern, source)):
            return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Color|Colors|Text|TextStyle)\b', code):
        return source, 0
    if re.search(r'\b(?:Color|Colors|Text|TextStyle)\s*=', code):
        return source, 0
    frames = t.frames(code)
    by_open = {f[0]: f for f in frames}
    edits = []
    for method in re.finditer(r'\bWidget\s+build\s*\(BuildContext\s+context\)\s*{', code):
        body = by_open.get(method.end()-1)
        if not body or not body[3] or body[3][3] is not None:
            continue
        owner = body[3]
        if not re.search(r'\bclass\s+_TelemetryPanel\s+extends\s+StatelessWidget\s*$', code[max(0, owner[0]-120):owner[0]]):
            continue
        if not re.search(r'\bfinal\s+Map<String,\s*dynamic>\s+data\s*;', code[owner[0]+1:body[0]]):
            continue
        body_code = code[body[0]+1:body[1]]
        if not re.match(r'\s*final\s+theme\s*=\s*context\.theme\s*;', body_code):
            continue
        if len(re.findall(r'\btheme\s*=', body_code)) != 1 or re.search(r'\bdata\s*=|\b(?:var|final|dynamic)\s+data\b|\bconst\s+\w+(?:\s+\w+)?\s*=', body_code):
            continue
        for match in PAIR.finditer(code, body[0]+1, body[1]):
            parents = [f for f in frames if f[0] < match.start() < f[1]]
            parent = max(parents, key=lambda f: f[0]) if parents else None
            text = parent[3] if parent and parent[2] == 'TextStyle' else None
            if not text or text[2] != 'Text':
                continue
            label = source[text[0]:parent[0]]
            if not re.fullmatch(r"\(\s*data\.isEmpty\s*\?\s*'Offline'\s*:\s*'Nominal'\s*,\s*style\s*:\s*TextStyle\s*", label):
                continue
            if '/*' in source[match.start():match.end()] or '//' in source[match.start():match.end()]:
                continue
            edits.extend([(match.start('warning'), match.end('warning'), 'theme.colors.warning'),
                          (match.start('success'), match.end('success'), 'theme.colors.success')])
    for start, end, replacement in sorted(edits, reverse=True):
        source = source[:start] + replacement + source[end:]
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
    files, colors = [], 0
    for path in sorted((root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))[args.offset:args.offset+args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            colors += count
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'colors': colors, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
