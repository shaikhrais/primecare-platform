#!/usr/bin/env python3
"""Migrate the reviewed live-dispatch palette to existing semantic theme roles."""
import argparse
import hashlib
import json
from pathlib import Path

SOURCE = 'packages/primecare_ui/lib/src/features/generated_screens/live_dispatch_map.dart'
ORIGINAL_SHA = '990fb053098059a0cbd9312397408f5faa96951e884f452dcd711f1eb23fe344'
UPDATED_SHA = 'a004a5be83a24aa8ee812102b82746cf67789e8cb69f707c9ea4eeb3218e80c6'

RULES = [
    ('''    final controller = ref.read(liveDispatchMapControllerProvider.notifier);
    final theme = context.theme;
''', '''    final controller = ref.read(liveDispatchMapControllerProvider.notifier);
    final theme = context.theme;
    final primary = PrimeActionPalette.of(context, PrimeActionTone.primary);
    final success = PrimeActionPalette.of(context, PrimeActionTone.success);
    final warning = PrimeActionPalette.of(context, PrimeActionTone.warning);
    final error = PrimeActionPalette.of(context, PrimeActionTone.error);
''', 1),
    ('color: isWarning ? Colors.amber.shade300 : theme.colors.border,', 'color: isWarning ? warning.border : theme.colors.border,', 1),
    ('color: Colors.black.withValues(alpha: 0.02),', 'color: Theme.of(context).shadowColor.withValues(alpha: 0.02),', 1),
    ('? Colors.amber.shade50\n                                      : theme.colors.primary.withValues(alpha: 0.1),', '? warning.surface\n                                      : theme.colors.primary.withValues(alpha: 0.1),', 1),
    ('color: isWarning ? Colors.amber.shade900 : theme.colors.primary,', 'color: isWarning ? warning.onSurface : theme.colors.primary,', 1),
    ('const Icon(LucideIcons.navigation, size: 14, color: Colors.blue)', 'PrimeIcon(LucideIcons.navigation, size: 14, color: theme.colors.primary)', 1),
    ('Colors.transparent\n                                    ],', 'theme.colors.surface.withValues(alpha: 0)\n                                    ],', 1),
    ('color: isWarning ? Colors.amber : theme.colors.primary,', 'color: isWarning ? warning.accent : primary.accent,', 1),
    ('border: Border.all(color: Colors.white, width: 2),', 'border: Border.all(color: isWarning ? warning.onAccent : primary.onAccent, width: 2),', 1),
    ('boxShadow: const [\n                                            BoxShadow(color: Colors.black26, blurRadius: 4)\n                                          ],', 'boxShadow: [\n                                            BoxShadow(color: Theme.of(context).shadowColor.withValues(alpha: 0.26), blurRadius: 4)\n                                          ],', 1),
    ('color: Colors.white,\n                                        ),', 'color: isWarning ? warning.onAccent : primary.onAccent,\n                                        ),', 1),
    ('color: Colors.black87,', 'color: theme.colors.inverseSurface,', 2),
    ('style: const TextStyle(color: Colors.white, fontSize: 10),', 'style: TextStyle(color: theme.colors.inverseOnSurface, fontSize: 10),', 1),
    ('decoration: const BoxDecoration(\n                                          color: Colors.green, shape: BoxShape.circle),', 'decoration: BoxDecoration(\n                                          color: success.accent, shape: BoxShape.circle),', 1),
    ("const Text(\n                                      'Telemetry Hub Online',\n                                      style: TextStyle(color: Colors.white, fontSize: 11),", "Text(\n                                      'Telemetry Hub Online',\n                                      style: TextStyle(color: theme.colors.inverseOnSurface, fontSize: 11),", 1),
    ('color: Colors.red.shade50,', 'color: error.surface,', 1),
    ('style: theme.typography.labelBold.copyWith(color: Colors.red),', 'style: theme.typography.labelBold.copyWith(color: error.onSurface),', 1),
    ('color: Colors.black.withValues(alpha: 0.01),', 'color: Theme.of(context).shadowColor.withValues(alpha: 0.01),', 1),
    ('? Colors.green\n                                                      : theme.colors.primary,', '? success.accent\n                                                      : primary.accent,', 1),
    ('foregroundColor: Colors.white,', 'foregroundColor: isSelected ? success.onAccent : primary.onAccent,', 1),
]


def migrate(source):
    if hashlib.sha256(source.encode()).hexdigest() != ORIGINAL_SHA:
        return source, 0
    for old, new, count in RULES:
        if source.count(old) != count:
            return source, 0
        source = source.replace(old, new)
    return source, 20


def reverse_migrate(source):
    if hashlib.sha256(source.encode()).hexdigest() != UPDATED_SHA:
        return source, 0
    for old, new, count in reversed(RULES):
        if source.count(new) != count:
            return source, 0
        source = source.replace(new, old)
    return source, 20


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    root = args.root.resolve(); path = root / SOURCE
    if path.is_symlink() or not path.resolve().is_relative_to(root):
        parser.error('source must remain inside root and may not be a symlink')
    source = path.read_text(); updated, count = migrate(source)
    if args.apply and count: path.write_text(updated)
    print(json.dumps({'applied': args.apply, 'colors': count, 'files': [SOURCE] if count else []}))


if __name__ == '__main__': main()
