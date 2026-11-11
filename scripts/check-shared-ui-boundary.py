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
# Keep offsets and executable interpolation expressions while masking string text.
def executable_code(source):
    masked = list(source)
    size = len(source)

    def hide(start, end):
        for offset in range(start, end):
            if source[offset] != '\n':
                masked[offset] = ' '

    def string(start, raw=False):
        quote = start + int(raw)
        delimiter = source[quote] * (3 if source.startswith(source[quote] * 3, quote) else 1)
        position = quote + len(delimiter)
        hide(start, position)
        while position < size:
            if source.startswith(delimiter, position):
                hide(position, min(size, position + len(delimiter)))
                return position + len(delimiter)
            if not raw and source[position] == '\\':
                hide(position, min(size, position + 2))
                position += 2
            elif not raw and source.startswith('${', position):
                hide(position, position + 2)
                position = code(position + 2, interpolation=True)
            else:
                hide(position, position + 1)
                position += 1
        return position

    def code(position, interpolation=False):
        braces = 0
        while position < size:
            if source.startswith('//', position):
                end = source.find('\n', position)
                end = size if end < 0 else end
                hide(position, end)
                position = end
            elif source.startswith('/*', position):
                start, depth = position, 1
                position += 2
                while position < size and depth:
                    if source.startswith('/*', position):
                        depth += 1
                        position += 2
                    elif source.startswith('*/', position):
                        depth -= 1
                        position += 2
                    else:
                        position += 1
                hide(start, position)
            elif source[position] in ('r', 'R') and position + 1 < size and source[position + 1] in ('\"', "'"):
                position = string(position, raw=True)
            elif source[position] in ('\"', "'"):
                position = string(position)
            elif interpolation and source[position] == '}' and braces == 0:
                hide(position, position + 1)
                return position + 1
            else:
                if source[position] == '{':
                    braces += 1
                elif source[position] == '}':
                    braces -= 1
                position += 1
        return position

    code(0)
    return ''.join(masked)
CONTROLS = ('Icon', 'CircularProgressIndicator', 'LinearProgressIndicator', 'Text', 'RichText', 'TextField', 'TextFormField', 'ElevatedButton',
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
ALIASES = re.compile(r'\btypedef\s+\w+\s*(?:<[^;=]*>)?\s*=\s*(?:\w+\s*\.\s*)?(\w+)\b')
CONTROL_IMPLEMENTATIONS = {
    'packages/primecare_ui_foundation/lib/src/prime_text.dart': ('Text',),
    'packages/primecare_ui_foundation/lib/src/prime_icon.dart': ('Icon',),
    'packages/primecare_ui_foundation/lib/src/prime_material_buttons.dart':
        ('TextButton', 'ElevatedButton', 'OutlinedButton'),
}
THEME_DEFINITION = ('packages/primecare_ui/lib/src/theme/', 'packages/flutter_core/lib/theme/')


def violations(source, application):
    code = executable_code(source)
    findings = [(m.start(), 'shared-control', m[1]) for m in DIRECT.finditer(code)] if application else []
    if application:
        findings += [(m.start(), 'shared-control', m[1]) for m in TEAR_OFF.finditer(code)]
    findings += [(m.start(), 'theme-color', m[0]) for m in COLOR.finditer(code)]
    for match in ALIASES.finditer(code):
        symbol = match[1]
        if symbol == 'Color' or application and symbol in CONTROLS:
            findings.append((match.start(1), 'theme-color' if symbol == 'Color' else 'shared-control', symbol))
    return [(source.count('\n', 0, pos) + 1, rule, symbol) for pos, rule, symbol in sorted(findings)]


def scan(root):
    result = []
    for base in ('apps', 'packages'):
        for path in sorted((root / base).rglob('*.dart')):
            relative = path.relative_to(root).as_posix()
            if '/lib/' not in relative:
                continue
            if relative.startswith(THEME_DEFINITION):
                continue
            for line, rule, symbol in violations(path.read_text(encoding='utf-8'), not relative.startswith('packages/primecare_ui/lib/')):
                # Only the exact relocated primitive may build its underlying
                # Material constructor. Other controls and all colors still fail.
                if rule == 'shared-control' and symbol in CONTROL_IMPLEMENTATIONS.get(relative, ()):
                    continue
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
