#!/usr/bin/env python3
"""Flag changed Dart route-construction sites for screen-management review.

This textual scan is deliberately conservative, not a Dart parser or proof of
authorization. A changed route must be reviewed before its baseline is updated.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT / 'docs/screen-management/route-sites.json'
START = re.compile(r'\b(GoRoute|ShellRoute|MaterialPageRoute|CupertinoPageRoute|PageRouteBuilder|ManagedPublicRoute)\s*(?:<[^>\n]+>)?\s*\(')
TARGET = re.compile(r'=>\s*(?:const\s+)?([A-Z]\w+)\s*\(')


def end_of_call(source, start):
    depth = 0
    quote = None
    escape = False
    line_comment = False
    block_comment = False
    i = start
    while i < len(source):
        ch = source[i]
        pair = source[i:i + 2]
        if line_comment:
            if ch == '\n':
                line_comment = False
        elif block_comment:
            if pair == '*/':
                block_comment = False
                i += 1
        elif quote:
            if escape:
                escape = False
            elif ch == '\\':
                escape = True
            elif ch == quote:
                quote = None
        elif pair == '//':
            line_comment = True
            i += 1
        elif pair == '/*':
            block_comment = True
            i += 1
        elif ch in "'\"":
            quote = ch
        elif ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth == 0:
                return i + 1
        i += 1
    return len(source)


def scan(root):
    rows = []
    for base in ('apps', 'packages/primecare_ui', 'packages/flutter_core'):
        for path in (root / base).glob('**/lib/**/*.dart'):
            source = path.read_text(encoding='utf-8')
            for match in START.finditer(source):
                segment = source[match.start():end_of_call(source, match.end() - 1)]
                target = TARGET.search(segment)
                rows.append({
                    'file': path.relative_to(root).as_posix(),
                    'line': source.count('\n', 0, match.start()) + 1,
                    'constructor': match.group(1),
                    'class': target.group(1) if target else '<dynamic or nested builder>',
                    'digest': hashlib.sha256(re.sub(r'\s+', ' ', segment).encode()).hexdigest(),
                })
    return sorted(rows, key=lambda row: (row['file'], row['line'], row['constructor']))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--update-baseline', action='store_true')
    args = parser.parse_args()
    current = scan(ROOT)
    if args.update_baseline:
        BASELINE.write_text(json.dumps(current, indent=2) + '\n', encoding='utf-8')
        print(f'Wrote {len(current)} route sites to {BASELINE.relative_to(ROOT)}')
        return 0
    previous = json.loads(BASELINE.read_text(encoding='utf-8'))
    key = lambda row: (row['file'], row['constructor'], row['digest'])
    remaining = Counter(key(row) for row in previous)
    new = []
    for row in current:
        item = key(row)
        if remaining[item]:
            remaining[item] -= 1
        else:
            new.append(row)
    for row in new:
        print(f"REVIEW {row['file']}:{row['line']} {row['class']} ({row['constructor']})")
    print(f'{len(current)} route sites; {len(new)} new or changed; {sum(remaining.values())} removed or changed')
    return 1 if new else 0


if __name__ == '__main__':
    raise SystemExit(main())
