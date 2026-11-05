#!/usr/bin/env python3
"""Check statically declared app module routes against the reviewed catalog.

This is a conservative textual check, not a Dart parser or an authorization
test. Dynamic expressions are reported for review instead of being guessed.
"""
import re
from pathlib import Path

from check_route_sites import ROOT, START, TARGET, end_of_call

CLASS = re.compile(r'\bclass\s+(\w+)')
CONSTANT = re.compile(r"static\s+const\s+(?:String\s+)?(\w+)\s*=\s*['\"]([^'\"]+)['\"]\s*;")
ROUTE = re.compile(r'\broute\s*:\s*([^,\n]+)')
REFERENCE = re.compile(r'^(\w+)\.(\w+)$')
LITERAL = re.compile(r"^['\"]([^'\"]+)['\"]$")
INTERPOLATION = re.compile(r'\$\{(\w+)\.(\w+)\}')
CATALOG = ROOT / 'packages/primecare_ui/lib/src/screens/module_screen_registrations.dart'


def constants(source):
    """Collect simple const strings; duplicate class declarations need review."""
    classes = list(CLASS.finditer(source))
    result = {}
    for index, match in enumerate(classes):
        end = classes[index + 1].start() if index + 1 < len(classes) else len(source)
        result[match.group(1)] = dict(CONSTANT.findall(source[match.end():end]))
    return result


def check(root=ROOT):
    definitions = {}
    for file in sorted((root / 'packages/flutter_core/lib/routes/groups').glob('*.dart')):
        for name, values in constants(file.read_text(encoding='utf-8')).items():
            if name in definitions:
                raise ValueError(f'duplicate route constant class {name}: {file}')
            definitions[name] = values
    catalog = root / CATALOG.relative_to(ROOT)
    registered = set(re.findall(r"^  '([^'$]+)',\s*$", catalog.read_text(encoding='utf-8'), re.M))
    problems, total = [], 0
    for file in sorted((root / 'apps').glob('*/lib/**/*.dart')):
        source = file.read_text(encoding='utf-8')
        local = constants(source)
        for match in START.finditer(source):
            if match.group(1) != 'PrimeCareScreen':
                continue
            total += 1
            segment = source[match.start():end_of_call(source, match.end() - 1)]
            route = ROUTE.search(segment)
            target = TARGET.search(segment)
            line = source.count('\n', 0, match.start()) + 1
            name = target.group(1) if target else '<dynamic screen builder>'
            expression = route.group(1).strip() if route else '<missing route>'
            literal = LITERAL.fullmatch(expression)
            ref = REFERENCE.fullmatch(expression)
            value = literal.group(1) if literal else None
            if ref:
                # A class declared in this file shadows the imported class.
                values = local.get(ref.group(1), definitions.get(ref.group(1), {}))
                value = values.get(ref.group(2))
            if value and '$' in value:
                def expand(part):
                    values = local.get(part.group(1), definitions.get(part.group(1), {}))
                    return values.get(part.group(2), part.group(0))
                value = INTERPOLATION.sub(expand, value)
            location = f'{file.relative_to(root)}:{line} {name}'
            if not value or '$' in value:
                problems.append(f'{location}: cannot resolve route {expression}; review manually')
            elif value not in registered:
                problems.append(f'{location}: screen route {value} is not registered')
    return total, problems


if __name__ == '__main__':
    count, issues = check()
    for issue in issues:
        print(issue)
    print(f'{count} module route declarations checked; {len(issues)} need review')
    raise SystemExit(bool(issues))
