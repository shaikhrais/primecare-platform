#!/usr/bin/env python3
"""Track direct Flutter screen widget subclasses pending architectural review.

This is a candidate scan, not a route graph or a registration/access check.
Run with --update-baseline only after reviewing the resulting changes.
"""
import argparse
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT / 'docs/screen-management/direct-widget-exceptions.json'
DIRECT = {'StatelessWidget', 'StatefulWidget', 'ConsumerWidget', 'ConsumerStatefulWidget', 'HookWidget', 'HookConsumerWidget'}
DECLARATION = re.compile(r'\bclass\s+(\w+)\s+extends\s+(\w+)\b')


def scan(root):
    results = []
    for base in ('apps', 'packages/primecare_ui', 'packages/flutter_core'):
        for path in (root / base).glob('**/lib/**/*.dart'):
            relative = path.relative_to(root).as_posix()
            for name, parent in DECLARATION.findall(path.read_text(encoding='utf-8')):
                candidate_name = name.endswith(('Screen', 'View', 'Page'))
                candidate_file = path.stem.endswith(('_screen', '_view', '_page'))
                if parent in DIRECT and (candidate_name or candidate_file):
                    results.append({'file': relative, 'class': name, 'base': parent})
    return sorted(results, key=lambda item: (item['file'], item['class'], item['base']))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--update-baseline', action='store_true')
    args = parser.parse_args()
    current = scan(ROOT)
    if args.update_baseline:
        BASELINE.write_text(json.dumps(current, indent=2) + '\n', encoding='utf-8')
        print(f'Wrote {len(current)} candidates to {BASELINE.relative_to(ROOT)}')
        return 0
    baseline = json.loads(BASELINE.read_text(encoding='utf-8'))
    key = lambda item: (item['file'], item['class'], item['base'])
    old = {key(item) for item in baseline}
    now = {key(item) for item in current}
    for path, name, parent in sorted(now - old):
        print(f'NEW candidate: {path}: {name} extends {parent}')
    for path, name, parent in sorted(old - now):
        print(f'REMOVED candidate: {path}: {name} extends {parent}')
    print(f'{len(now)} current candidates; {len(now - old)} new, {len(old - now)} removed')
    return 1 if now != old else 0


if __name__ == '__main__':
    raise SystemExit(main())
