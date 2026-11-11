#!/usr/bin/env python3
"""Route exact generated compliance badges through the shared semantic badge; dry run by default."""
import argparse
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)
OLD = "_StatusBadge(label: 'HIPAA Compliant', color: const Color(0xFF10B981))"
HELPER = 'class _StatusBadge extends StatelessWidget {\n  final String label;\n  final Color color;\n\n  const _StatusBadge({\n    required this.label,\n    required this.color,\n  });\n\n  @override\n  Widget build(BuildContext context) {\n    return Container(\n      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),\n      decoration: BoxDecoration(\n        color: color.withOpacity(0.08),\n        borderRadius: BorderRadius.circular(12),\n        border: Border.all(color: color.withOpacity(0.15)),\n      ),\n      child: Text(\n        label,\n        style: TextStyle(\n          color: color,\n          fontSize: 10.5,\n          fontWeight: FontWeight.bold,\n        ),\n      ),\n    );\n  }\n}\n'
NEW = "PrimeStatusBadge('HIPAA Compliant', tone: PrimeStatusTone.success)"


def migrate(source):
    code = t.boundary.executable_code(source)
    if source.count(HELPER) != 1 or not code[source.index(HELPER):].startswith('class _StatusBadge extends'):
        return source, 0
    if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\b', code):
        return source, 0
    for package in ('flutter/material.dart', 'primecare_ui/primecare_ui.dart'):
        pattern = r"\bimport\s+(['\"])package:" + re.escape(package) + r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern, source)):
            return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Color|Colors|PrimeStatusBadge|PrimeStatusTone)\b', code):
        return source, 0
    if re.search(r'\b(?:Color|Colors|PrimeStatusBadge|PrimeStatusTone)\s*=', code):
        return source, 0
    frames = t.frames(code)
    edits = []
    for frame in frames:
        if frame[3] is not None or not re.search(r'\bclass\s+_AuditPanel\s+extends\s+StatelessWidget\s*$', code[max(0, frame[0]-120):frame[0]]):
            continue
        body = source[frame[0]+1:frame[1]]
        executable = code[frame[0]+1:frame[1]]
        if len(re.findall(r'\btheme\s*=', executable)) != 1 or not re.search(r'Widget\s+build\(BuildContext context\)\s*{\s*final theme = context\.theme;\s*return Card\(', executable):
            continue
        if body.count(OLD) != 1:
            continue
        offset = frame[0]+1+body.index(OLD)
        if not code[offset:].lstrip().startswith('_StatusBadge('):
            continue
        edits.append(offset)
    for offset in reversed(edits):
        source = source[:offset] + NEW + source[offset+len(OLD):]
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
    files = []
    for path in sorted((root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))[args.offset:args.offset+args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'badges': len(files), 'files': files}, indent=2))


if __name__ == '__main__':
    main()
