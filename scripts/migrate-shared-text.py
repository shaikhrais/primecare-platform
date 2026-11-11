#!/usr/bin/env python3
"""Conservatively migrate compatible app Text calls to the shared PrimeText.

Dry run by default. --apply writes only eligible calls; unsupported signatures,
qualified calls, strings/comments and files without an unrestricted shared import
remain unchanged. The strict boundary check still reports remaining violations.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('boundary', Path(__file__).with_name('check-shared-ui-boundary.py'))
boundary = importlib.util.module_from_spec(spec)
spec.loader.exec_module(boundary)
SHARED = re.compile(r"\bimport\s+(['\"])package:primecare_ui/primecare_ui.dart\1\s*(?:show\s+PrimeText\s*)?;")
MATERIAL = re.compile(r"\bimport\s+(['\"])package:flutter/material.dart\1\s*;")
CALL = re.compile(r'(?<![\w.])Text\s*\(')
PARAMETERS = {'key', 'style', 'textAlign', 'maxLines', 'overflow'}


def compatible(code, start):
    """Accept one positional argument and only the wrapper's named arguments."""
    stack, parts, begin = [], [], start
    pairs = {')': '(', ']': '[', '}': '{'}
    for pos in range(start, len(code)):
        char = code[pos]
        if char in '([{':
            stack.append(char)
        elif char in ')]}':
            if not stack:
                if char != ')':
                    return False
                parts.append(code[begin:pos])
                break
            if stack.pop() != pairs[char]:
                return False
        elif char == ',' and not stack:
            parts.append(code[begin:pos])
            begin = pos + 1
    else:
        return False
    # String arguments are masked, so an empty first part is still positional.
    if not parts or re.match(r'\s*\w+\s*:', parts[0]):
        return False
    seen = set()
    for part in parts[1:]:
        if not part.strip():
            continue
        match = re.match(r'\s*(\w+)\s*:', part)
        if not match or match[1] not in PARAMETERS or match[1] in seen:
            return False
        seen.add(match[1])
    return True


def migrate(source, add_import=False):
    # Import text is inspected separately because the lexer masks string literals.
    # Require real, top-level imports, not examples embedded in comments/strings.
    code = boundary.executable_code(source)
    def imported(pattern):
        return any(code[m.start():].startswith('import') for m in pattern.finditer(source))
    has_shared = imported(SHARED)
    if not imported(MATERIAL) or not (has_shared or add_import):
        return source, 0
    # A local declaration or constructor/type alias makes symbol ownership unclear.
    if re.search(r'\b(?:class|typedef|mixin|enum)\s+(?:Text|PrimeText)\b', code):
        return source, 0
    if re.search(r'\bpart\b', code):
        return source, 0
    # Preserve files whose concrete Text type or constructor references may
    # constrain inferred consumers. These need resolved Dart type review.
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+Text\s*\(|\bText\s*=|\bextension\s+(?:type\s+)?(?:Text|PrimeText)\b', code):
        return source, 0
    if re.search(r'\bText\s*\.\s*\w+\b(?!\s*\()', code) or any(
        not re.match(r'\s*(?:\(|\.)', code[match.end():]) for match in re.finditer(r'\bText\b', code)
    ):
        return source, 0
    edits = [m.start() for m in CALL.finditer(code)
             if not code[:m.start()].rstrip().endswith('.')
             and compatible(code, m.end())]
    for offset in reversed(edits):
        source = source[:offset] + 'PrimeText' + source[offset + 4:]
    if edits and not has_shared:
        # Before an existing import, after any library directive/doc comments.
        position = next(m.start() for m in MATERIAL.finditer(source)
                        if boundary.executable_code(source)[m.start():].startswith('import'))
        source = source[:position] + "import 'package:primecare_ui/primecare_ui.dart' show PrimeText;\n" + source[position:]
    return source, len(edits)


def shared_dependency(pubspec):
    section = None
    for line in pubspec.splitlines():
        if line and not line[0].isspace() and not line.startswith('#'):
            section = line.split(':', 1)[0]
        if section == 'dependencies' and re.match(r'^  primecare_ui\s*:', line):
            return True
    return False


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--apply', action='store_true')
    parser.add_argument('--add-imports', action='store_true',
                        help='Add a narrow PrimeText import only when the app declares primecare_ui as a runtime dependency')
    parser.add_argument('--path', action='append', help='Optional app lib file/directory relative to root; repeat for more scopes')
    args = parser.parse_args()
    root = args.root.resolve()
    paths = set()
    for relative in args.path or ['apps']:
        path = root / relative
        if path.is_symlink() or not path.resolve().is_relative_to(root / 'apps'):
            parser.error('paths must stay inside apps without symlink escapes')
        paths.update([path] if path.is_file() else path.rglob('*.dart'))
    files, calls = [], 0
    for path in sorted(paths):
        if path.suffix != '.dart' or 'lib' not in path.relative_to(root).parts or path.is_symlink() or not path.resolve().is_relative_to(root / 'apps'):
            continue
        original = path.read_text(encoding='utf-8')
        pubspec = root / Path(*path.relative_to(root).parts[:2]) / 'pubspec.yaml'
        add_import = args.add_imports and pubspec.is_file() and shared_dependency(pubspec.read_text(encoding='utf-8'))
        updated, count = migrate(original, add_import=add_import)
        if not count:
            continue
        if args.apply:
            path.write_text(updated, encoding='utf-8')
        calls += count
        files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'calls': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
