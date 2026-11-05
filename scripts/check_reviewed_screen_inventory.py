#!/usr/bin/env python3
"""Validate a bounded static review against source; never auto-approve drift.

This verifies the recorded review, not routing, production dispatch or behavior.
"""
import argparse
import collections
import csv
import hashlib
import json
import re
from pathlib import Path

from check_screen_inheritance import scan

ROOT = Path(__file__).resolve().parents[1]
DATA = Path('docs/screen-management/reviewed-candidates')


def safe_path(root, relative):
    path = (root / relative).resolve()
    if Path(relative).is_absolute() or not path.is_relative_to(root.resolve()):
        raise ValueError(f'Unsafe inventory path: {relative}')
    return path


def validate(root, rows, manifest, candidates):
    errors = []
    current = {(r['file'], r['class'], r['base']) for r in candidates}
    seen = set()
    hashes = manifest['source_sha256']
    if manifest['schema_version'] != 1 or manifest['runtime_verified'] != 0:
        errors.append('Unsupported schema or runtime verification claim')
    if len(current) != manifest['total_candidates']:
        errors.append('Candidate total changed; review the inventory again')
    if len(rows) != manifest['reviewed_candidates']:
        errors.append('Reviewed count mismatch')
    if dict(collections.Counter(r['category'] for r in rows)) != manifest['categories']:
        errors.append('Category counts mismatch')
    batches = collections.Counter(r['batch'] for r in rows)
    if dict(batches) != {b['batch']: b['entries'] for b in manifest['batches']}:
        errors.append('Batch counts mismatch')
    for row in rows:
        key = (row['file'], row['class_name'], row['base'])
        if key in seen:
            errors.append(f'Duplicate identity: {key}')
        seen.add(key)
        if key not in current:
            errors.append(f'Stale or noncandidate identity: {key}')
        for field in ('category', 'reason', 'next_action', 'evidence'):
            if not row[field].strip():
                errors.append(f'Missing {field}: {key}')
        refs = [(row['file'], None)]
        refs += [(m[0], int(m[1])) for m in re.findall(
            r'((?:apps|packages)/[^;\s]+\.dart):(\d+)',
            row['evidence'] + '; ' + row['declaration'])]
        refs += [(p, None) for p in row['selected_module_files'].split('; ') if p]
        if row['owner_module']:
            refs.append((row['owner_module'], None))
        for relative, line in refs:
            if relative not in hashes:
                errors.append(f'Unhashed evidence: {relative}')
            path = safe_path(root, relative)
            if not path.is_file():
                errors.append(f'Missing evidence: {relative}')
            elif line is not None and not 1 <= line <= len(path.read_text().splitlines()):
                errors.append(f'Invalid evidence line: {relative}:{line}')
    for relative, expected in hashes.items():
        path = safe_path(root, relative)
        if not path.is_file():
            errors.append(f'Missing reviewed source: {relative}')
        elif hashlib.sha256(path.read_bytes()).hexdigest() != expected:
            errors.append(f'Changed reviewed source (re-review required): {relative}')
    return errors


def summary(rows, manifest):
    total = manifest['total_candidates']
    counts = collections.Counter(r['category'] for r in rows)
    contents = collections.Counter(r.get('content', '') for r in rows)
    lines = [
        '# Reviewed direct-widget candidate inventory', '',
        f"Source review: `{manifest['reviewed_commit']}`.", '',
        f'**{len(rows)} / {total} candidate identities statically classified**; '
        f'**{total - len(rows)} remain unclassified**. Runtime-verified by this inventory: **0**.', '',
        'Identity is exact file + class + direct base, not a unique production screen.', '',
        '## Categories', '', '| Category | Count |', '| --- | ---: |',
    ]
    lines += [f'| {category} | {count} |' for category, count in sorted(manifest['categories'].items())]
    lines += ['', '## Scope and next actions', '',
        '`inventory.csv` contains each exact file/class, reason, evidence location and next action. '
        'It combines the initial 38 and three subsequent 100-entry static reviews. '
        'The three 100-entry batches were the first scanner-ordered identities not in earlier batches.', '',
        'An exact owner-module declaration is **not production dispatch evidence**. '
        'A source-selected route is not proof of authorized access, API connectivity, working actions, '
        'localization, accessibility, or release readiness. Static classification is not tested behavior. '
        'No production access or screen migration is performed by this inventory.', '',
        f"The {counts['owner_module_selects_other_file']} same-name alternatives and "
        f"{counts['owner_module_binding_unresolved']} unresolved owner-module bindings must not be called dead code. "
        'Their scope is the inspected owner module, not all navigation paths. '
        'The three embedded controls and abstract base are not standalone screen migration targets. '
        'Existing router boundaries must be preserved; a direct widget base alone does not prove missing management.', '',
        f"The {counts['module_declared_placeholder']} exact owner-module placeholders need dispatch/authorization investigation and authoritative "
        f"requirements before implementation. The three 100-entry batches include {contents['false_completion_placeholder']} unsupported completion-text "
        f"placeholders and {contents['section_scaffold_with_todo_placeholders']} scaffolds importing TODO sections. Neither is evidence of implemented business behavior.", '',
        '## Reproduce and maintain', '',
        'From the repository root:', '',
        '```sh', 'python3 scripts/check_screen_inheritance.py',
        'python3 scripts/check_reviewed_screen_inventory.py',
        'python3 scripts/test_reviewed_screen_inventory.py', '```', '',
        'The checker scans current source, checks unique candidate membership, all cited file paths/line ranges, '
        'SHA-256 hashes of reviewed source dependencies, category/batch totals and this generated summary. '
        'It fails closed when reviewed source changes. It does not auto-refresh source hashes or classify new candidates. '
        'After a deliberate source review, update the affected rows and hashes, then use '
        '`python3 scripts/check_reviewed_screen_inventory.py --write-summary` to regenerate this page.', '',
        'The manifest records original batch commits and refreshed fields. All four classifications were rerun '
        'against the recorded source commit: 23 initial-batch rows needed current evidence line numbers; '
        'the three 100-entry CSVs were unchanged. Hashes cover transitive barrel-resolution inputs too, so unrelated '
        'barrel edits may conservatively require review. Do not blindly rehash to silence the checker.', '',
        'The lexical scanner is library-only and can miss indirect inheritance or alternative naming. '
        'The import review is not a Dart analyzer or runtime route resolver. Test fixtures outside lib trees '
        'are outside the denominator. No completeness, dead-code or production-readiness claim follows.', '',
    ]
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write-summary', action='store_true')
    args = parser.parse_args()
    directory = ROOT / DATA
    with (directory / 'inventory.csv').open(newline='') as handle:
        rows = list(csv.DictReader(handle))
    manifest = json.loads((directory / 'manifest.json').read_text())
    errors = validate(ROOT, rows, manifest, scan(ROOT))
    if errors:
        print('\n'.join(errors))
        return 1
    expected = summary(rows, manifest)
    target = directory / 'README.md'
    if args.write_summary:
        target.write_text(expected)
    elif not target.exists() or target.read_text() != expected:
        print('Summary differs; regenerate only after source/data review')
        return 1
    print(f"{len(rows)}/{manifest['total_candidates']} statically classified; "
          f"{manifest['total_candidates'] - len(rows)} unclassified; "
          f"{len(manifest['source_sha256'])} source hashes verified; runtime-verified: 0")
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
