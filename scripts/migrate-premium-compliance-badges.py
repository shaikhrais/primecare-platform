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

EXTRA_OLD_PANEL = "class _AuditPanel extends StatelessWidget {\n  final String modelName;\n  final Color themeColor;\n\n  const _AuditPanel({\n    required this.modelName,\n    required this.themeColor,\n  });\n\n  @override\n  Widget build(BuildContext context) {\n    final theme = context.theme;\n    return Card(\n      elevation: 0,\n      shape: RoundedRectangleBorder(\n        borderRadius: BorderRadius.circular(24),\n        side: BorderSide(color: theme.colors.outline, width: 1.5),\n      ),\n      child: Padding(\n        padding: const EdgeInsets.all(28.0),\n        child: Column(\n          crossAxisAlignment: CrossAxisAlignment.start,\n          children: [\n            Row(\n              children: [\n                Container(\n                  padding: const EdgeInsets.all(10),\n                  decoration: BoxDecoration(\n                    color: theme.colors.warning.withOpacity(0.08),\n                    shape: BoxShape.circle,\n                  ),\n                  child: PrimeIcon(Icons.gavel, color: theme.colors.warning, size: 20),\n                ),\n                const SizedBox(width: 14),\n                Column(\n                  crossAxisAlignment: CrossAxisAlignment.start,\n                  children: [\n                    PrimeText(\n                      'COMPLIANCE & GOVERNANCE', // .tr() LocaleKeys.\n                      style: TextStyle(\n                        fontSize: 10,\n                        fontWeight: FontWeight.bold,\n                        color: theme.colors.warning,\n                        letterSpacing: 1.2,\n                      ),\n                    ),\n                    Text(\n                      '$modelName Audit Ledger', // .tr() LocaleKeys.\n                      style:  TextStyle(\n                        fontSize: 16,\n                        fontWeight: FontWeight.bold,\n                        color: theme.colors.onSurface,\n                      ),\n                    ),\n                  ],\n                ),\n              ],\n            ),\n            const SizedBox(height: 24),\n            const Row(\n              children: [\n                PrimeStatusBadge('HIPAA Compliant', tone: PrimeStatusTone.success), // .tr() LocaleKeys.\n                SizedBox(width: 8),\n                _StatusBadge(label: 'GDPR Verified', color: Colors.blue), // .tr() LocaleKeys.\n                SizedBox(width: 8),\n                _StatusBadge(label: 'TLS 1.3 Active', color: Colors.purple), // .tr() LocaleKeys.\n              ],\n            ),\n            const SizedBox(height: 24),\n            PrimeTelemetryRow(\n              label: 'Prisma Schema Bindings', // .tr() LocaleKeys.\n              value: 'Verified UUID Entity', // .tr() LocaleKeys.\n              icon: Icons.dns,\n              color: theme.colors.primary,\n            ),\n            const Divider(height: 24),\n            PrimeTelemetryRow(\n              label: 'Encryption Standard', // .tr() LocaleKeys.\n              value: 'AES-256 GCM', // .tr() LocaleKeys.\n              icon: Icons.enhanced_encryption,\n              color: theme.colors.secondary,\n            ),\n            const Divider(height: 24),\n            PrimeTelemetryRow(\n              label: 'Audit Trail Signature', // .tr() LocaleKeys.\n              value: 'SHA-256 HMAC', // .tr() LocaleKeys.\n              icon: Icons.fingerprint,\n              color: theme.colors.tertiary,\n            ),\n          ],\n        ),\n      ),\n    );\n  }\n}\n\n"
EXTRA_NEW_PANEL = "class _AuditPanel extends StatelessWidget {\n  final String modelName;\n  final Color themeColor;\n\n  const _AuditPanel({\n    required this.modelName,\n    required this.themeColor,\n  });\n\n  @override\n  Widget build(BuildContext context) {\n    final theme = context.theme;\n    return Card(\n      elevation: 0,\n      shape: RoundedRectangleBorder(\n        borderRadius: BorderRadius.circular(24),\n        side: BorderSide(color: theme.colors.outline, width: 1.5),\n      ),\n      child: Padding(\n        padding: const EdgeInsets.all(28.0),\n        child: Column(\n          crossAxisAlignment: CrossAxisAlignment.start,\n          children: [\n            Row(\n              children: [\n                Container(\n                  padding: const EdgeInsets.all(10),\n                  decoration: BoxDecoration(\n                    color: theme.colors.warning.withOpacity(0.08),\n                    shape: BoxShape.circle,\n                  ),\n                  child: PrimeIcon(Icons.gavel, color: theme.colors.warning, size: 20),\n                ),\n                const SizedBox(width: 14),\n                Expanded(child: Column(\n                  crossAxisAlignment: CrossAxisAlignment.start,\n                  children: [\n                    PrimeText(\n                      'COMPLIANCE & GOVERNANCE', // .tr() LocaleKeys.\n                      style: TextStyle(\n                        fontSize: 10,\n                        fontWeight: FontWeight.bold,\n                        color: theme.colors.warning,\n                        letterSpacing: 1.2,\n                      ),\n                    ),\n                    Text(\n                      '$modelName Audit Ledger', // .tr() LocaleKeys.\n                      style:  TextStyle(\n                        fontSize: 16,\n                        fontWeight: FontWeight.bold,\n                        color: theme.colors.onSurface,\n                      ),\n                    ),\n                  ],\n                )),\n              ],\n            ),\n            const SizedBox(height: 24),\n            const Wrap(\n              spacing: 8,\n              runSpacing: 8,\n              children: [\n                PrimeStatusBadge('HIPAA Compliant', tone: PrimeStatusTone.success), // .tr() LocaleKeys.\n                PrimeStatusBadge('GDPR Verified', tone: PrimeStatusTone.success), // .tr() LocaleKeys.\n                PrimeStatusBadge('TLS 1.3 Active', tone: PrimeStatusTone.success), // .tr() LocaleKeys.\n              ],\n            ),\n            const SizedBox(height: 24),\n            PrimeTelemetryRow(\n              label: 'Prisma Schema Bindings', // .tr() LocaleKeys.\n              value: 'Verified UUID Entity', // .tr() LocaleKeys.\n              icon: Icons.dns,\n              color: theme.colors.primary,\n            ),\n            const Divider(height: 24),\n            PrimeTelemetryRow(\n              label: 'Encryption Standard', // .tr() LocaleKeys.\n              value: 'AES-256 GCM', // .tr() LocaleKeys.\n              icon: Icons.enhanced_encryption,\n              color: theme.colors.secondary,\n            ),\n            const Divider(height: 24),\n            PrimeTelemetryRow(\n              label: 'Audit Trail Signature', // .tr() LocaleKeys.\n              value: 'SHA-256 HMAC', // .tr() LocaleKeys.\n              icon: Icons.fingerprint,\n              color: theme.colors.tertiary,\n            ),\n          ],\n        ),\n      ),\n    );\n  }\n}\n"

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
    # Remaining affirmative badge labels use the same existing success role as
    # HIPAA Compliant. Match the entire known panel, never nearby palette hues.
    if source.count(EXTRA_OLD_PANEL) == 1:
        offset = source.index(EXTRA_OLD_PANEL)
        outside = source.replace(EXTRA_OLD_PANEL, '').replace(HELPER, '')
        if code[offset:].startswith('class _AuditPanel extends') and not re.search(r'\b_StatusBadge\b', t.boundary.executable_code(outside)):
            return source.replace(EXTRA_OLD_PANEL, EXTRA_NEW_PANEL).replace(HELPER, ''), 2
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
    files, badges = [], 0
    for path in sorted((root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))[args.offset:args.offset+args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            files.append(path.relative_to(root).as_posix())
            badges += count
    print(json.dumps({'applied': args.apply, 'badges': badges, 'libraries': len(files), 'files': files}, indent=2))


if __name__ == '__main__':
    main()
