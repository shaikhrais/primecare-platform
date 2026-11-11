#!/usr/bin/env python3
"""Migrate the reviewed Material Scaffold constructors to PrimeScaffold.

Dry-run by default. Complete source hashes, exact constructor counts and symbol
ownership must match. Scaffold.of state access is intentionally unchanged.
"""
import argparse
import hashlib
import importlib.util
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = Path(__file__).with_name('shared-scaffold-constructors-manifest.json')
spec = importlib.util.spec_from_file_location('boundary', Path(__file__).with_name('check-shared-ui-boundary.py'))
boundary = importlib.util.module_from_spec(spec)
spec.loader.exec_module(boundary)
CALL = re.compile(r'(?<![\w.])Scaffold\s*\(')
PRIME_CALL = re.compile(r'(?<![\w.])PrimeScaffold\s*\(')
CORE_IMPORT = "import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeScaffold;\n"
APP_IMPORT = "import 'package:primecare_ui/primecare_ui.dart' show PrimeScaffold;\n"
BROAD_UI_IMPORT = re.compile(r"\bimport\s+['\"]package:primecare_ui/primecare_ui\.dart['\"]\s*;")


def digest(source):
    return hashlib.sha256(source.encode()).hexdigest()


def required_import(path, source):
    if path.startswith('packages/flutter_core/'):
        return CORE_IMPORT
    if BROAD_UI_IMPORT.search(source):
        return ''
    return APP_IMPORT


def replace_scaffolds(source, expected):
    code = boundary.executable_code(source)
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Scaffold|PrimeScaffold)\b', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:Scaffold|PrimeScaffold)\s*(?:\(|=)', code):
        return source, 0
    matches = list(CALL.finditer(code))
    if len(matches) != expected:
        return source, 0
    for match in reversed(matches):
        source = source[:match.start()] + 'PrimeScaffold' + source[match.start() + len('Scaffold'):]
    return source, expected


def migrate_source(path, source, original_sha, expected):
    if digest(source) != original_sha:
        return source, 0
    updated, count = replace_scaffolds(source, expected)
    if not count:
        return source, 0
    import_line = required_import(path, source)
    if import_line:
        position = boundary.executable_code(updated).find('import ')
        if position < 0:
            return source, 0
        updated = updated[:position] + import_line + updated[position:]
    return updated, count


def reverse_source(path, source, expected):
    code = boundary.executable_code(source)
    matches = list(PRIME_CALL.finditer(code))
    if len(matches) != expected:
        return source, 0
    for match in reversed(matches):
        source = source[:match.start()] + 'Scaffold' + source[match.start() + len('PrimeScaffold'):]
    for import_line in (CORE_IMPORT, APP_IMPORT):
        if import_line in source:
            source = source.replace(import_line, '', 1)
    return source, expected


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=ROOT)
    parser.add_argument('--offset', type=int, default=0)
    parser.add_argument('--limit', type=int)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    if args.offset < 0 or args.limit is not None and args.limit < 0:
        parser.error('offset and limit must be non-negative')
    root = args.root.resolve()
    manifest = json.loads(MANIFEST_PATH.read_text())
    entries = sorted(manifest.items())[args.offset:]
    if args.limit is not None:
        entries = entries[:args.limit]
    files = []
    calls = 0
    for relative, (original_sha, expected) in entries:
        path = root / relative
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            parser.error(f'unsafe manifest path: {relative}')
        source = path.read_text()
        updated, count = migrate_source(relative, source, original_sha, expected)
        if count:
            if args.apply:
                path.write_text(updated)
            files.append(relative)
            calls += count
    print(json.dumps({'applied': args.apply, 'scaffolds': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
