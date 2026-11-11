#!/usr/bin/env python3
"""Replace exact generated fixed-color trend labels with shared readable labels.

Only _StatCard's change/isPositive text with the known size-eleven bold style
qualifies. Other labels, styles, constructors and conditions require review.
Dry run by default; --offset/--limit select deterministic library batches.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)
LABEL = re.compile(r'(?<![\w.])Text\s*\(\s*change\s*,\s*style\s*:\s*TextStyle\s*\(\s*color\s*:\s*isPositive\s*\?\s*const\s+Color\(0xFF047857\)\s*:\s*Colors\.amber\.shade700\s*,\s*fontSize\s*:\s*11\s*,\s*fontWeight\s*:\s*FontWeight\.bold\s*,?\s*\)\s*,?\s*\)')


def migrate(source):
    if '0xFF047857' not in source:
        return source, 0
    code = t.boundary.executable_code(source)
    if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\b', code):
        return source, 0
    for package in ('flutter/material.dart', 'primecare_ui/primecare_ui.dart'):
        pattern = r"\bimport\s+(['\"])package:" + re.escape(package) + r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern, source)):
            return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Color|Colors|Text|TextStyle|PrimeTrendLabel|FontWeight)\b', code):
        return source, 0
    if re.search(r'\b(?:Color|Colors|Text|TextStyle|PrimeTrendLabel|FontWeight)\s*=', code):
        return source, 0
    frames = t.frames(code)
    by_open = {f[0]: f for f in frames}
    edits = []
    for method in re.finditer(r'\bWidget\s+build\s*\(BuildContext\s+context\)\s*{', code):
        body = by_open.get(method.end()-1)
        if not body or not body[3] or body[3][3] is not None:
            continue
        owner = body[3]
        if not re.search(r'\bclass\s+_StatCard\s+extends\s+StatelessWidget\s*$', code[max(0, owner[0]-120):owner[0]]):
            continue
        declarations = code[owner[0]+1:body[0]]
        if not all(re.search(r'\bfinal\s+'+kind+r'\s+'+name+r'\s*;', declarations) for kind, name in [('String', 'change'), ('bool', 'isPositive')]):
            continue
        body_code = code[body[0]+1:body[1]]
        if re.search(r'\b(?:change|isPositive)\s*=|\b(?:var|final|dynamic)\s+(?:change|isPositive)\b', body_code):
            continue
        for match in LABEL.finditer(code, body[0]+1, body[1]):
            if code[:match.start()].rstrip().endswith('.'):
                continue
            containers = [f for f in frames if f[2] == 'Container' and f[0] < match.start() < f[1]]
            if not containers:
                continue
            badge = max(containers, key=lambda f: f[0])
            tint = r'\bcolor\s*:\s*isPositive\s*\?\s*theme\.colors\.success\.withOpacity\(0\.1\)\s*:\s*theme\.colors\.warning\.withOpacity\(0\.1\)\s*(?:,|$)'
            if not any(f[2] == 'BoxDecoration' and f[3] is badge and re.search(tint, code[f[0]+1:f[1]]) for f in frames):
                continue
            if '/*' in source[match.start():match.end()] or '//' in source[match.start():match.end()]:
                continue
            edits.append((match.start(), match.end(), 'PrimeTrendLabel(change, isPositive: isPositive)'))
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
    files, labels = [], 0
    for path in sorted((root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))[args.offset:args.offset+args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            labels += count
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'labels': labels, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
