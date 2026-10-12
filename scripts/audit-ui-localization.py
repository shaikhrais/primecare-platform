"""Find direct Flutter label/placeholder literals for manual localization review.

This is a candidate inventory, not proof of a missing translation. It excludes
test/build sources and simple .tr() calls; dynamic labels need separate review.
"""
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
LITERAL = re.compile(r'''\b(?:Text\s*\(\s*|(?:hintText|labelText|tooltip)\s*:\s*)(['"])(.*?)\1''')


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
        'shared_admin': [row for row in candidates if '/screens/admin/' in row['file']]},
        ensure_ascii=False, indent=2))
