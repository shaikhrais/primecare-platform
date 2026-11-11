#!/usr/bin/env python3
"""Route reviewed core Text/Icon constructors through the cycle-free shared library."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path


def module(name):
    spec = importlib.util.spec_from_file_location(name, Path(__file__).with_name('migrate-shared-'+name+'.py'))
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


text = module('text')
icons = module('icons')
MANIFEST = json.loads(Path(__file__).with_name('core-shared-primitives-manifest.json').read_text())
BY_HASH = {row['sha256']: row for row in MANIFEST}
UI_IMPORT = "import 'package:primecare_ui/primecare_ui.dart' show "
FOUNDATION_IMPORT = "import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show "


def migrate(source):
    row = BY_HASH.get(hashlib.sha256(source.encode()).hexdigest())
    if row is None:
        return source, 0
    updated, labels = text.migrate(source, add_import=True)
    updated, symbols = icons.migrate(updated, add_import=True)
    if (labels, symbols) != (row['text'], row['icons']):
        return source, 0
    updated = updated.replace(UI_IMPORT+'PrimeText;', FOUNDATION_IMPORT+'PrimeText;')
    updated = updated.replace(UI_IMPORT+'PrimeIcon;', FOUNDATION_IMPORT+'PrimeIcon;')
    return updated, labels + symbols


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
    base = root/'packages/flutter_core'
    pubspec = base/'pubspec.yaml'
    if not pubspec.is_file() or 'path: ../primecare_ui_foundation' not in pubspec.read_text():
        parser.error('the declared shared foundation dependency is required')
    calls, files = 0, []
    for row in MANIFEST[args.offset:args.offset + args.limit]:
        path = root/row['path']
        if path.is_symlink() or not path.resolve().is_relative_to(base.resolve()) or not path.resolve().is_relative_to(root) or not path.is_file():
            continue
        updated, count = migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            calls += count
            files.append(row['path'])
    print(json.dumps({'applied': args.apply, 'calls': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
