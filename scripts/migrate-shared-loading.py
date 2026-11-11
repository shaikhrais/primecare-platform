#!/usr/bin/env python3
"""Replace only default centered spinners with the existing shared loading state."""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
buttons = importlib.util.module_from_spec(spec)
spec.loader.exec_module(buttons)
IMPORT = "import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;\n"
CALL = re.compile(r"(?<![\w.])Center\s*\(\s*child\s*:\s*(?:const\s+)?CircularProgressIndicator\s*\(\s*\)\s*,?\s*\)")


def migrate(source):
    code = buttons.text.boundary.executable_code(source)
    if not any(code[m.start():].startswith('import') for m in buttons.text.MATERIAL.finditer(source)):
        return source, 0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Center|CircularProgressIndicator|DashboardLoadingWidget)\b', code):
        return source, 0
    for symbol in ('Center', 'CircularProgressIndicator', 'DashboardLoadingWidget'):
        if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+' + symbol + r'\s*\(|\b' + symbol + r'\s*=', code):
            return source, 0
    edits = [m for m in CALL.finditer(code)
             if not code[:m.start()].rstrip().endswith('.')
             and '/*' not in source[m.start():m.end()] and '//' not in source[m.start():m.end()]]
    if not edits:
        return source, 0
    has_import = any(code[m.start():].startswith('import') for m in buttons.SHARED.finditer(source))
    for m in reversed(edits):
        source = source[:m.start()] + 'DashboardLoadingWidget()' + source[m.end():]
    if not has_import and IMPORT.strip() not in source:
        position = next(m.start() for m in buttons.text.MATERIAL.finditer(source) if code[m.start():].startswith('import'))
        source = source[:position] + IMPORT + source[position:]
    return source, len(edits)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    root = args.root.resolve()
    files, calls = [], 0
    for path in sorted((root / 'apps').glob('*/lib/**/*.dart')):
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        pubspec = root / Path(*path.relative_to(root).parts[:2]) / 'pubspec.yaml'
        if not pubspec.is_file() or not buttons.text.shared_dependency(pubspec.read_text(encoding='utf-8')):
            continue
        updated, count = migrate(path.read_text(encoding='utf-8'))
        if count:
            if args.apply:
                path.write_text(updated, encoding='utf-8')
            calls += count
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'calls': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
