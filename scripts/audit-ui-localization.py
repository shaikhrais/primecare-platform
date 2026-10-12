"""Find direct Flutter label/placeholder literals for manual localization review.

This is a candidate inventory, not proof of a missing translation. It excludes
test/build sources and simple .tr() calls; dynamic labels need separate review.
"""
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
LITERAL = re.compile(r'''\b(?:Text\s*\(\s*|(?:hintText|labelText|tooltip)\s*:\s*)(['"])(.*?)\1''')
PARAMETER = re.compile(r'\{([A-Za-z0-9_]+)\}')


def flatten(value, prefix=''):
    result = {}
    if isinstance(value, dict):
        for key, child in value.items():
            result.update(flatten(child, f'{prefix}.{key}' if prefix else key))
    elif isinstance(value, str):
        result[prefix] = value
    return result


def audit_catalogs():
    results = []
    paths = list((ROOT / 'apps').rglob('en.json'))
    paths += list((ROOT / 'packages/flutter_core').rglob('en.json'))
    paths += list((ROOT / 'packages/primecare_ui/lib').rglob('en.json'))
    for path in sorted(paths):
        if any(part in ('build', '.dart_tool', 'node_modules') for part in path.relative_to(ROOT).parts):
            continue
        row = {'directory': str(path.parent.relative_to(ROOT)), 'locales': {}}
        try:
            english = flatten(json.loads(path.read_text()))
            row['english_keys'] = len(english)
            for language in ('es', 'fr'):
                target = path.with_name(f'{language}.json')
                if not target.exists():
                    row['locales'][language] = {'missing_catalog': True}
                    continue
                entries = flatten(json.loads(target.read_text()))
                missing = sorted(set(english) - set(entries))
                empty = sorted(key for key in english.keys() & entries.keys() if not entries[key].strip())
                mismatch = sorted(key for key in english.keys() & entries.keys()
                    if set(PARAMETER.findall(english[key])) != set(PARAMETER.findall(entries[key])))
                identical = sum(english[key] == entries[key] for key in english.keys() & entries.keys())
                row['locales'][language] = {'missing_keys': len(missing), 'empty_values': len(empty),
                    'parameter_mismatches': len(mismatch), 'identical_values_for_review': identical,
                    'missing_examples': missing[:10], 'parameter_examples': mismatch[:10]}
        except (ValueError, OSError) as error:
            row['error'] = str(error)
        results.append(row)
    return results


def audit():
    candidates = []
    for directory in ('apps', 'packages/primecare_ui/lib', 'packages/flutter_core/lib'):
        for path in (ROOT / directory).rglob('*.dart'):
            if any(part in ('test', 'build', '.dart_tool') for part in path.relative_to(ROOT).parts):
                continue
            source = path.read_text(errors='replace')
            for match in LITERAL.finditer(source):
                value = match.group(2)
                if not value.strip() or '$' in value or source[match.end():].lstrip().startswith('.tr('):
                    continue
                candidates.append({'file': str(path.relative_to(ROOT)),
                    'line': source.count('\n', 0, match.start()) + 1, 'text': value})
    return candidates


if __name__ == '__main__':
    candidates = audit()
    print(json.dumps({'kind': 'static candidates requiring review; not verified defects',
        'files': len({row['file'] for row in candidates}), 'candidate_literals': len(candidates),
        'shared_admin': [row for row in candidates if '/screens/admin/' in row['file']],
        'catalog_parity': audit_catalogs()},
        ensure_ascii=False, indent=2))
