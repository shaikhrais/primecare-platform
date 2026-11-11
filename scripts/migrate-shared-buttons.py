#!/usr/bin/env python3
"""Replace plain TextButton labels with existing shared PrimeButton ghost controls.

Only key/onPressed/child signatures with an unstyled PrimeText child qualify.
Dry run is the default; unsupported options stay visible to the strict gate.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('text_migration', Path(__file__).with_name('migrate-shared-text.py'))
text = importlib.util.module_from_spec(spec)
spec.loader.exec_module(text)
CALL = re.compile(r'(?<![\w.])TextButton\s*\(')
SHARED = re.compile(r"\bimport\s+(['\"])package:primecare_ui/primecare_ui.dart\1\s*;")


def arguments(code, start):
    stack, parts, begin = [], [], start
    pairs = {')': '(', ']': '[', '}': '{'}
    for pos in range(start, len(code)):
        char = code[pos]
        if char in '([{':
            stack.append(char)
        elif char in ')]}':
            if not stack:
                if char != ')':
                    return None
                parts.append((begin, pos))
                return parts, pos
            if stack.pop() != pairs[char]:
                return None
        elif char == ',' and not stack:
            parts.append((begin, pos))
            begin = pos + 1
    return None


def migrate(source):
    code = text.boundary.executable_code(source)
    if not any(code[m.start():].startswith('import') for m in SHARED.finditer(source)):
        return source, 0
    if not any(code[m.start():].startswith('import') for m in text.MATERIAL.finditer(source)):
        return source, 0
    if re.search(r'\b(?:class|typedef|mixin|enum)\s+(?:TextButton|PrimeButton|PrimeText)\b|\bpart\b', code):
        return source, 0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+TextButton\s*\(|\bTextButton\s*=|\bextension\s+(?:type\s+)?(?:TextButton|PrimeButton)\b', code):
        return source, 0
    if re.search(r'\bTextButton\s*\.\s*\w+\b(?!\s*\()', code) or any(
        not re.match(r'\s*(?:\(|\.)', code[m.end():]) for m in re.finditer(r'\bTextButton\b', code)
    ):
        return source, 0
    edits, count = [], 0
    for call in CALL.finditer(code):
        if code[:call.start()].rstrip().endswith('.'):
            continue
        parsed = arguments(code, call.end())
        if parsed is None:
            continue
        parts, end = parsed
        named = {}
        for begin, finish in parts:
            if not code[begin:finish].strip():
                continue
            match = re.match(r'\s*(key|onPressed|child)\s*:', code[begin:finish])
            if not match or match[1] in named:
                break
            named[match[1]] = (begin, finish, match)
        else:
            if not {'onPressed', 'child'} <= named.keys():
                continue
            begin, finish, label = named['child']
            value_start = begin + label.end()
            child = re.match(r'\s*(?:const\s+)?PrimeText\s*\(', code[value_start:finish])
            if not child:
                continue
            value = arguments(code, value_start + child.end())
            if value is None:
                continue
            child_parts, child_end = value
            if code[child_end + 1:finish].strip():
                continue
            # One positional expression only; trailing comma is allowed.
            if len(child_parts) > 2 or len(child_parts) == 2 and code[slice(*child_parts[1])].strip():
                continue
            arg_begin, arg_end = child_parts[0]
            if re.match(r'\s*\w+\s*:', code[arg_begin:arg_end]):
                continue
            if CALL.search(code[arg_begin:arg_end]):
                continue
            # Keep the label expression byte-for-byte, including localization calls.
            edits.extend([(call.start(), call.start() + len('TextButton'), 'PrimeButton'),
                          (call.end(), call.end(), 'isGhost: true, '),
                          (begin + label.start(1), begin + label.end(1), 'label'),
                          (value_start, child_end + 1, ' ' + source[arg_begin:arg_end])])
            count += 1
    # Nested buttons inside callbacks are independent and must not overlap edits.
    for begin, finish, replacement in sorted(edits, reverse=True):
        source = source[:begin] + replacement + source[finish:]
    return source, count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--apply', action='store_true')
    parser.add_argument('--path', action='append', help='Optional app lib scope relative to root; repeat for multiple scopes')
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
        updated, count = migrate(path.read_text(encoding='utf-8'))
        if count:
            if args.apply:
                path.write_text(updated, encoding='utf-8')
            calls += count
            files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'calls': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
