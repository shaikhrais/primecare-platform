#!/usr/bin/env python3
"""Bound exact generated telemetry text in finite row widths. Dry-run default."""
import argparse
import hashlib
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
b = importlib.util.module_from_spec(spec)
spec.loader.exec_module(b)
BEFORE_HASH = '8f818e018a3e01b9129450f7cd5c4e2b28f87b8e9b862f7338277dfe12b5e892'


def wrap_call(source, start, wrapper):
    opening = source.index('(', start)
    parsed = b.arguments(b.text.boundary.executable_code(source), opening + 1)
    if not parsed:
        raise ValueError('Unbalanced template call')
    end = parsed[1] + 1
    return source[:start] + wrapper + '(child: ' + source[start:end] + ')' + source[end:]


def migrate(source):
    if 'class PremiumFeature' not in source or 'extends GovernedConsumerWidget' not in source:
        return source, 0
    code = b.text.boundary.executable_code(source)
    for package in ('flutter/material.dart', 'primecare_ui/primecare_ui.dart'):
        pattern = r"\bimport\s+(['\"])package:" + re.escape(package) + r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern, source)):
            return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Expanded|Flexible|SizedBox)\b|\b(?:Expanded|Flexible|SizedBox)\s*=', code):
        return source, 0
    begin = code.find('class _TelemetryPanel ')
    middle = source.find('\nclass _AuditPanel', begin)
    row = source.find('class _TelemetryRow ')
    end = source.find('\nclass _StatusBadge', row)
    if min(begin, middle, row, end) < 0:
        return source, 0
    panel, line = source[begin:middle].strip(), source[row:end].strip()
    canonical = panel + '\n\n' + line
    if hashlib.sha256(canonical.encode()).hexdigest() != BEFORE_HASH:
        return source, 0
    # Preserve labels, typography, status roles, progress and data expressions.
    panel = wrap_call(panel, panel.index('Column(', panel.index('const SizedBox(width: 14)')), 'Expanded')
    first = panel.index("const Text('API Response Health'")
    panel = wrap_call(panel, first, 'Expanded')
    status = panel.index("Text(data.isEmpty ? 'Offline'")
    panel = wrap_call(panel, status, 'Flexible')
    panel = panel[:status] + 'const SizedBox(width: 12),\n                      ' + panel[status:]
    line = wrap_call(line, line.index('Text(\n          label,'), 'Expanded')
    line = line.replace('const Spacer(),', 'const SizedBox(width: 12),')
    line = wrap_call(line, line.index('Text(\n          value,'), 'Flexible')
    updated = source[:row] + line + source[end:]
    updated = updated[:begin] + panel + updated[middle:]
    return updated, 1


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    p.add_argument('--offset', type=int, default=0)
    p.add_argument('--limit', type=int, default=100)
    p.add_argument('--apply', action='store_true')
    a = p.parse_args()
    if a.offset < 0 or a.limit < 1:
        p.error('offset must be nonnegative and limit positive')
    root = a.root.resolve()
    files = []
    for path in sorted((root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))[a.offset:a.offset+a.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        result, count = migrate(path.read_text())
        if count:
            if a.apply:
                path.write_text(result)
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': a.apply, 'panels': len(files), 'files': files}))


if __name__ == '__main__':
    main()
