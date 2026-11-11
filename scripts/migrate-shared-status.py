#!/usr/bin/env python3
"""Replace exact generated error/empty-state color patterns with shared controls.

No arbitrary color mapping: only alertTriangle/red, inbox/grey and the exact
state.error! message with a red-only TextStyle qualify. Const parents are retained.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
buttons = importlib.util.module_from_spec(spec)
spec.loader.exec_module(buttons)
CALL = re.compile(r'(?<![\w.])(Icon|Text|PrimeText)\s*\(')
ROLES = {'LucideIcons.alertTriangle': ('Colors.red', 'error'), 'LucideIcons.inbox': ('Colors.grey', 'muted'),
         'Icons.error': ('Colors.red', 'error'), 'Icons.error_outline': ('Colors.red', 'error'),
         'Icons.inbox': ('Colors.grey', 'muted')}
STATUS_IMPORT = "import 'package:primecare_ui/src/components/prime_status.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;\n"


def migrate(source, add_import=False):
    code = buttons.text.boundary.executable_code(source)
    has_shared = any(code[m.start():].startswith('import') for m in buttons.SHARED.finditer(source))
    material = [m for m in buttons.text.MATERIAL.finditer(source) if code[m.start():].startswith('import')]
    if not has_shared and not (add_import and material):
        return source, 0
    if re.search(r'\b(?:class|typedef|mixin|enum|extension)\s+(?:Icon|Text|PrimeText|PrimeStatusIcon|PrimeStatusText|PrimeStatusTone)\b|\bpart\b', code):
        return source, 0
    # Concrete types, constructor aliases and tear-offs need resolved review.
    for name in ('Icon', 'Text'):
        if any(not re.match(r'\s*(?:\(|\.)', code[m.end():]) for m in re.finditer(r'\b' + name + r'\b', code)):
            return source, 0
    edits = []
    for call in CALL.finditer(code):
        if code[:call.start()].rstrip().endswith('.'):
            continue
        parsed = buttons.arguments(code, call.end())
        if not parsed:
            continue
        parts, end = parsed
        if not parts:
            continue
        begin, finish = parts[0]
        positional = re.sub(r'\s+', '', code[begin:finish])
        named = {}
        for begin, finish in parts[1:]:
            if not code[begin:finish].strip():
                continue
            match = re.match(r'\s*(\w+)\s*:', code[begin:finish])
            if not match or match[1] in named:
                break
            named[match[1]] = (begin + match.end(), finish)
        else:
            if call[1] == 'Icon':
                if positional not in ROLES or not {'color'} <= named.keys() <= {'color', 'size'}:
                    continue
                expected, tone = ROLES[positional]
                if re.sub(r'\s+', '', code[slice(*named['color'])]) != expected:
                    continue
                # Only a simple numeric size is eligible; retain default sizing.
                size = source[slice(*named['size'])].strip() if 'size' in named else None
                if size is not None and not re.fullmatch(r'\d+(?:\.\d+)?', size):
                    continue
                replacement = f'PrimeStatusIcon({positional}, tone: PrimeStatusTone.{tone}'
                if size is not None:
                    replacement += f', size: {size}'
                replacement += ')'
            else:
                if positional != 'state.error!' or named.keys() != {'style'}:
                    continue
                style = re.sub(r'\s+', '', code[slice(*named['style'])])
                if style not in ('constTextStyle(color:Colors.red)', 'TextStyle(color:Colors.red)',
                                 'constTextStyle(color:Colors.red,)', 'TextStyle(color:Colors.red,)'):
                    continue
                replacement = 'PrimeStatusText(state.error!, tone: PrimeStatusTone.error)'
            # Do not erase comments or string fragments attached to arguments.
            fragment = source[call.start():end + 1]
            if '//' in fragment or '/*' in fragment:
                continue
            edits.append((call.start(), end + 1, replacement))
    for begin, finish, replacement in reversed(edits):
        source = source[:begin] + replacement + source[finish:]
    if edits and not has_shared and STATUS_IMPORT.strip() not in source:
        source = source[:material[0].start()] + STATUS_IMPORT + source[material[0].start():]
    return source, len(edits)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--apply', action='store_true')
    parser.add_argument('--add-imports', action='store_true', help='Add a narrow shared status import within this package')
    args = parser.parse_args()
    root = args.root.resolve()
    files, calls = [], 0
    for base in ('features', 'screens'):
        for path in sorted((root / 'packages/primecare_ui/lib/src' / base).rglob('*.dart')):
            if path.is_symlink() or not path.resolve().is_relative_to(root):
                continue
            updated, count = migrate(path.read_text(encoding='utf-8'), add_import=args.add_imports)
            if count:
                if args.apply:
                    path.write_text(updated, encoding='utf-8')
                calls += count
                files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied': args.apply, 'calls': calls, 'files': files}, indent=2))


if __name__ == '__main__':
    main()
