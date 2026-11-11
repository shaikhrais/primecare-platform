#!/usr/bin/env python3
"""Fail on direct Flutter controls in app code and literal colors outside theme definitions.

No baseline exemptions: existing violations also fail. This lexical guard complements,
not replaces, analyzer/widget acceptance. Shared UI implementations may build Flutter
controls; application consumers must use shared controls.
"""
import argparse
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
# Keep offsets while removing comments and strings, including multiline/raw strings.
LEX = re.compile(r"//[^\n]*|/\*[\s\S]*?\*/|r?(?:'''[\s\S]*?'''|\"\"\"[\s\S]*?\"\"\"|'(?:\\.|[^'\\])*'|\"(?:\\.|[^\"\\])*\")")
CONTROLS = ('Text', 'RichText', 'TextField', 'TextFormField', 'ElevatedButton',
    'FilledButton', 'OutlinedButton', 'TextButton', 'IconButton', 'DropdownButton',
    'DropdownButtonFormField', 'Checkbox', 'CheckboxListTile', 'Radio', 'RadioListTile',
    'Switch', 'SwitchListTile', 'Slider', 'RangeSlider', 'Card', 'ListTile', 'Scaffold',
    'AppBar', 'BottomAppBar', 'NavigationBar', 'NavigationRail', 'Drawer', 'AlertDialog',
    'SimpleDialog', 'SnackBar', 'DataTable', 'PaginatedDataTable', 'TabBar', 'Chip',
    'ActionChip', 'ChoiceChip', 'FilterChip', 'InputChip', 'PopupMenuButton',
    'FloatingActionButton', 'CupertinoButton', 'CupertinoTextField', 'CupertinoSwitch', 'CupertinoPageScaffold')
DIRECT = re.compile(r'\b(' + '|'.join(CONTROLS) + r')\s*(?:<[^;{}()]*>)?\s*(?:\.\s*\w+\s*)?\(')
TEAR_OFF = re.compile(r'\b(' + '|'.join(CONTROLS) + r')\s*(?:<[^;{}()]*>)?\s*\.\s*(?:new|rich|icon|tonal|tonalIcon|adaptive|large|small|extended)\b(?!\s*\()')
COLOR = re.compile(r'\b(?:Color\s*\(|Color\s*\.\s*(?:fromARGB|fromRGBO|from)\s*\(|Colors\s*\.\s*\w+)')
THEME_DEFINITION = ('packages/primecare_ui/lib/src/theme/', 'packages/flutter_core/lib/theme/')


def violations(source, application):
    code = LEX.sub(lambda m: ''.join('\n' if c == '\n' else ' ' for c in m[0]), source)
    findings = [(m.start(), 'shared-control', m[1]) for m in DIRECT.finditer(code)] if application else []
    if application:
        findings += [(m.start(), 'shared-control', m[1]) for m in TEAR_OFF.finditer(code)]
    findings += [(m.start(), 'theme-color', m[0]) for m in COLOR.finditer(code)]
    return [(source.count('\n', 0, pos) + 1, rule, symbol) for pos, rule, symbol in sorted(findings)]


def scan(root):
    result = []
    for base in ('apps', 'packages/primecare_ui/lib', 'packages/flutter_core/lib'):
        for path in sorted((root / base).rglob('*.dart')):
            relative = path.relative_to(root).as_posix()
            if base == 'apps' and '/lib/' not in relative:
                continue
            if relative.startswith(THEME_DEFINITION):
                continue
            for line, rule, symbol in violations(path.read_text(encoding='utf-8'), base == 'apps'):
                result.append((relative, line, rule, symbol))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=ROOT)
    args = parser.parse_args()
    results = scan(args.root)
    for path, line, rule, symbol in results:
        print(f'{path}:{line}: error [{rule}] {symbol}: use the shared UI library and theme tokens')
    print(f'{len(results)} shared UI/theme boundary violations; no baseline exemptions')
    return bool(results)


if __name__ == '__main__':
    raise SystemExit(main())
