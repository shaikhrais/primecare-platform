#!/usr/bin/env python3
"""Migrate exact premium telemetry progress tracks to shared theme defaults.

Only _TelemetryPanel's known grey200 track and exact value/valueColor/minHeight
signature qualify. Other colors/options/owners remain unresolved. Dry-run default.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
b = importlib.util.module_from_spec(spec)
spec.loader.exec_module(b)
spec2 = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
theme = importlib.util.module_from_spec(spec2)
spec2.loader.exec_module(theme)


def migrate(source):
    code = b.text.boundary.executable_code(source)
    if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\b', code):
        return source, 0
    for pattern in (b.SHARED, b.text.MATERIAL):
        if not any(code[m.start():].startswith('import') for m in pattern.finditer(source)):
            return source, 0
    names = r'(?:LinearProgressIndicator|PrimeLinearProgressIndicator|Colors)'
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+' + names + r'\b|\b' + names + r'\s*=', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+' + names + r'\s*\(', code):
        return source, 0
    if any(not re.match(r'\s*\(', code[m.end():]) for m in re.finditer(r'\bLinearProgressIndicator\b', code)):
        return source, 0
    owner = re.search(r'\bclass\s+_TelemetryPanel\s+extends\s+StatelessWidget\s*{', code)
    if not owner:
        return source, 0
    frame = next((f for f in theme.frames(code) if f[0] == owner.end() - 1), None)
    if not frame:
        return source, 0
    edits, count = [], 0
    for call in re.finditer(r'(?<![\w.])LinearProgressIndicator\s*\(', code):
        if not frame[0] < call.start() < frame[1] or code[:call.start()].rstrip().endswith('.'):
            continue
        parsed = b.arguments(code, call.end())
        if not parsed:
            continue
        parts, end = parsed
        fields = {}
        for start, stop in parts:
            if not code[start:stop].strip():
                continue
            match = re.match(r'\s*(\w+)\s*:', code[start:stop])
            if not match or match[1] in fields:
                break
            fields[match[1]] = (start, stop, start + match.end())
        else:
            if not {'value', 'valueColor', 'minHeight', 'backgroundColor'} <= fields.keys() <= {'key', 'value', 'valueColor', 'minHeight', 'backgroundColor'}:
                continue
            start, stop, value_start = fields['backgroundColor']
            if re.sub(r'\s+', '', code[value_start:stop]) != 'Colors.grey.shade200':
                continue
            if '/*' in source[start:stop] or '//' in source[start:stop]:
                continue
            if code[stop] == ',':
                remove = (start, stop + 1, '')
            elif code[start - 1] == ',':
                remove = (start - 1, stop, '')
            else:
                continue
            edits.extend([(call.start(), call.start() + len('LinearProgressIndicator'), 'PrimeLinearProgressIndicator'), remove])
            count += 1
    for begin, end, replacement in sorted(edits, reverse=True):
        source = source[:begin] + replacement + source[end:]
    return source, count


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
    paths = sorted((root / 'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))
    files, count = [], 0
    for path in paths[args.offset:args.offset + args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated, changes = migrate(path.read_text())
        if changes:
            if args.apply:
                path.write_text(updated)
            count += changes
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'tracks': count, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
