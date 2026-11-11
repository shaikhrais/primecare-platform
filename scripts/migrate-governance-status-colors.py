#!/usr/bin/env python3
"""Move exact generated Active/Clear metric card colors to the success theme role.

Only the known title/value/trend/progress/icon/color signatures qualify, inside a
buildScreen with an existing context.theme binding. Other metrics remain visible
in the strict gate. Dry run by default; --offset/--limit select library batches.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)
# Exact known generated status cards; never infer status from a nearby color.
CARDS = (
    ('Operational Status', 'Active', 'Optimal', '0.92', 'activity', '0D9488'),
    ('Security Sync', 'Clear', 'Secured', '1.0', 'shieldCheck', '16A34A'),
)
PATTERNS = []
for title, value, trend, progress, icon, color in CARDS:
    PATTERNS.append(re.compile(r"(?<![\w.])GovMetricCard\s*\(\s*title\s*:\s*'"+re.escape(title)+r"'\s*,\s*value\s*:\s*'"+value+r"'\s*,\s*trendLabel\s*:\s*'"+trend+r"'\s*,\s*progress\s*:\s*"+re.escape(progress)+r'\s*,\s*icon\s*:\s*LucideIcons\.'+icon+r'\s*,\s*brandColor\s*:\s*(?P<color>(?:const\s+)?Color\(0xFF'+color+r'\))\s*,?\s*\)'))


def migrate(source):
    if not any(title in source for title, *_ in CARDS):
        return source, 0
    code = t.boundary.executable_code(source)
    for package in ('flutter/material.dart', 'primecare_ui/primecare_ui.dart'):
        pattern = r"\bimport\s+(['\"])package:" + re.escape(package) + r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern, source)):
            return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Color|LucideIcons|GovMetricCard)\b', code):
        return source, 0
    if re.search(r'\b(?:Color|LucideIcons|GovMetricCard)\s*=', code):
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
        prefix = body_code.split('return', 1)[0]
        if not re.search(r'\bfinal\s+theme\s*=\s*context\.theme\s*;', prefix):
            continue
        if len(re.findall(r'\btheme\s*=', body_code)) != 1 or re.search(r'\bconst\s+\w+(?:\s+\w+)?\s*=', body_code):
            continue
        for pattern in PATTERNS:
            for match in pattern.finditer(source, body[0]+1, body[1]):
                if not code[match.start():].startswith('GovMetricCard') or code[:match.start()].rstrip().endswith('.'):
                    continue
                start, end = match.span('color')
                edits.append((start, end, 'theme.colors.success'))
                for begin, finish, frame in consts:
                    if frame and body[0] < begin <= start and frame[1] >= end-1:
                        removed.add((begin, finish, ''))
    for start, end, replacement in sorted(edits+list(removed), reverse=True):
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
    paths = []
    for base in ('apps', 'packages/primecare_ui'):
        paths.extend(p for p in (root/base).rglob('*.dart') if 'lib' in p.relative_to(root).parts)
    files, colors = [], 0
    for path in sorted(paths)[args.offset:args.offset+args.limit]:
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
