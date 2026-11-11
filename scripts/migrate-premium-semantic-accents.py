#!/usr/bin/env python3
"""Bind nine exact premium-template consumers to established semantic tokens.

The match is based on complete generated call signatures and labels, not color
proximity. Dry run is the default; offset/limit provide deterministic parts.
"""
import argparse
import hashlib
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location(
    'theme', Path(__file__).with_name('migrate-generated-theme.py'))
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)

RULES = [
    ("""_StatCard(
              title: 'API Request Latency', // .tr() LocaleKeys.
              value: '14.2 ms', // .tr() LocaleKeys.
              change: '-2.4 ms', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.speed,
              color: Color(0xFF0EA5E9),
            )""", 'Color(0xFF0EA5E9)', 'primary'),
    ("""_StatCard(
              title: 'Data Ingestion Rate', // .tr() LocaleKeys.
              value: '4,821 rps', // .tr() LocaleKeys.
              change: '+18.4%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.cloud_download,
              color: Color(0xFF10B981),
            )""", 'Color(0xFF10B981)', 'success'),
    ("""_StatCard(
              title: 'Governance Violations', // .tr() LocaleKeys.
              value: '0 entries', // .tr() LocaleKeys.
              change: '0.00%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.gavel,
              color: Color(0xFFF59E0B),
            )""", 'Color(0xFFF59E0B)', 'warning'),
    ("""const _AuditPanel(
                    modelName: '{MODEL}',
                    themeColor: Colors.amber,
                  )""", 'Colors.amber', 'warning'),
    ("""QuickActionItem(
                  label: 'Trigger Audit', // .tr() LocaleKeys.
                  icon: Icons.shield,
                  color: const Color(0xFF0EA5E9),
                  onTap: () {},
                )""", 'const Color(0xFF0EA5E9)', 'primary'),
    ("""QuickActionItem(
                  label: 'Sync Schema', // .tr() LocaleKeys.
                  icon: Icons.sync,
                  color: const Color(0xFF10B981),
                  onTap: () {},
                )""", 'const Color(0xFF10B981)', 'success'),
    ("""QuickActionItem(
                  label: 'Export Logs', // .tr() LocaleKeys.
                  icon: Icons.download,
                  color: const Color(0xFFF59E0B),
                  onTap: () {},
                )""", 'const Color(0xFFF59E0B)', 'warning'),
    ("""PortalActivityItem(
                  title: 'Prisma Client Hydration', // .tr() LocaleKeys.
                  description: 'Synchronized telemetry mapping against database node.', // .tr() LocaleKeys.
                  time: '2m ago', // .tr() LocaleKeys.
                  icon: Icons.cloud_done,
                  color: Color(0xFF10B981),
                )""", 'Color(0xFF10B981)', 'success'),
    ("""PortalActivityItem(
                  title: 'Telemetry Session Start', // .tr() LocaleKeys.
                  description: 'Established active stream listener on /v1/premium/{SLUG}.', // .tr() LocaleKeys.
                  time: '3h ago', // .tr() LocaleKeys.
                  icon: Icons.play_arrow,
                  color: Color(0xFF0EA5E9),
                )""", 'Color(0xFF0EA5E9)', 'primary'),
]

HELPER_HASHES = {
    '_StatCard': 'a19f390a63b728a5e274f574d58cb5cde2166a53eeb86dfc1913ac4f784db8bd',
    '_AuditPanel': 'ee2b95869294318e61b0b71d90ff3e663a1c566196b535d269ed35913f101143',
}


def _pattern(template):
    result = re.escape(template)
    result = result.replace(re.escape('{MODEL}'), r"(?:\\[^$'\r\n]|[^'\\$\r\n])+")
    result = result.replace(re.escape('{SLUG}'), r'[a-z0-9_]+')
    return re.compile(result)


PATTERNS = [_pattern(template) for template, _, _ in RULES]


def _replacement(value, old_color, role):
    value = value.replace(old_color, 'theme.colors.' + role)
    return value.replace('const _AuditPanel(', '_AuditPanel(')


MIGRATED_PATTERNS = [
    _pattern(_replacement(template, old_color, role))
    for template, old_color, role in RULES
]


def planned_edits(source):
    code = t.boundary.executable_code(source)
    if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\b', code):
        return [], 0
    for package in ('flutter/material.dart', 'primecare_ui/primecare_ui.dart'):
        pattern = r"\bimport\s+(['\"])package:" + re.escape(package) + r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern, source)):
            return [], 0
    names = ('Color', 'Colors', 'QuickActionItem', 'PortalActivityItem', '_StatCard', '_AuditPanel')
    joined = '|'.join(map(re.escape, names))
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Color|Colors|QuickActionItem|PortalActivityItem)\b', code):
        return [], 0
    if re.search(r'\b(?:' + joined + r')\s*=', code):
        return [], 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:QuickActionItem|PortalActivityItem|_StatCard|_AuditPanel)\s*\(', code):
        return [], 0
    for name, next_name in (('_StatCard', '_TelemetryPanel'), ('_AuditPanel', None)):
        begin = source.find('class ' + name + ' ')
        end = source.find('class ' + next_name + ' ', begin) if next_name else len(source)
        if begin < 0 or end < 0 or not code[begin:].startswith('class ' + name + ' '):
            return [], 0
        if hashlib.sha256(source[begin:end].strip().encode()).hexdigest() != HELPER_HASHES[name]:
            return [], 0
    frames = t.frames(code)
    by_open = {frame[0]: frame for frame in frames}
    for method in re.finditer(r'\bWidget\s+buildScreen\(BuildContext context, WidgetRef ref\)\s*{', code):
        body = by_open.get(method.end() - 1)
        if not body or not body[3] or body[3][3] is not None:
            continue
        owner = body[3]
        owner_prefix = code[max(0, owner[0] - 180):owner[0]]
        if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\s*$', owner_prefix):
            continue
        body_code = code[body[0] + 1:body[1]]
        if not re.match(r'\s*final theme = context\.theme;', body_code):
            continue
        if len(re.findall(r'\btheme\s*=', body_code)) != 1:
            continue
        if re.search(r'\b(?:const|var|final)\s+\w+\s+theme\b|[(,]\s*theme\s*[,)]|\btheme\s*=>', body_code):
            continue
        matches = []
        for pattern, (template, _, _) in zip(PATTERNS, RULES):
            found = list(pattern.finditer(source, body[0] + 1, body[1]))
            if len(found) != 1:
                return [], 0
            match = found[0]
            first_token = 'const _AuditPanel' if template.startswith('const _AuditPanel') else template.split('(', 1)[0]
            if not code[match.start():].startswith(first_token):
                return [], 0
            if code[:match.start()].rstrip().endswith('.'):
                return [], 0
            matches.append(match)
        edits = []
        for match, (_, old_color, role) in zip(matches, RULES):
            edits.append((match.start(), match.end(), _replacement(match[0], old_color, role)))
        return sorted(edits), len(edits)
    return [], 0


def migrate(source):
    edits, count = planned_edits(source)
    for begin, end, value in reversed(edits):
        source = source[:begin] + value + source[end:]
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
    files, colors = [], 0
    paths = sorted((root / 'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))
    for path in paths[args.offset:args.offset + args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            files.append(path.relative_to(root).as_posix())
            colors += count
    print(json.dumps({'applied': args.apply, 'colors': colors, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
