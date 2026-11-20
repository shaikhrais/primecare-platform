"""Compare exact OpenAPI source operations with the generated governance catalog."""
import argparse
from collections import Counter
import json
from pathlib import Path
from urllib.parse import quote

from api_documentation import METHODS, ROOT, document_sources


def cell(value):
    return ' '.join(str(value).split()).replace('|', '&#124;').replace('<', '&lt;').replace('>', '&gt;')


def link(source):
    path = source['file']
    marker = ' (proposal)' if source['proposal'] else ''
    return f'[{cell(Path(path).name)}](../../{quote(path)}){marker}'


def success_codes(operation):
    return tuple(sorted(str(code) for code in operation.get('responses', {})
                        if str(code).startswith('2')))


def review_notes(matches):
    notes = []
    success = {success_codes(item['operation']) for item in matches}
    success.discard(())
    if len(success) > 1:
        notes.append('success status sets differ')
    required = any(item['security'] and all(item['security']) for item in matches)
    optional = any(item['security'] is not None and
                   (not item['security'] or not all(item['security'])) for item in matches)
    if required and optional:
        notes.append('required and optional authentication declarations coexist')
    if all(not item['operation'].get('summary') and not item['operation'].get('description') for item in matches):
        notes.append('no operation-level purpose text')
    if all(not success_codes(item['operation']) for item in matches):
        notes.append('no explicit 2xx response')
    if all(item['security'] is None for item in matches):
        notes.append('no security declaration')
    return notes


def build_review(catalogue, sources):
    keys = {(method.upper(), path): op for path, item in catalogue['paths'].items()
            for method, op in item.items() if method in METHODS}
    matched = keys.keys() & sources.keys()
    missing = keys.keys() - sources.keys()
    source_only = sources.keys() - keys.keys()
    reviewed = {key: review_notes(items) for key, items in sources.items()}
    findings = Counter(note for notes in reviewed.values() for note in notes)
    lines = [
        '# OpenAPI operation reconciliation', '',
        'This is a documentation comparison against the generated production-governance catalog. '
        'Exact matching preserves HTTP methods, server-relative path strings and parameter names. '
        'A source-only path can represent an alternate prefix, older name, proposal or unregistered operation. '
        'Review the gateway, caller, fixture and approved contract before changing a binding.', '',
        '| Coverage | Exact operations |', '| --- | ---: |',
        f'| Catalog operations | {len(keys):,} |',
        f'| Catalog operations with a matching source | {len(matched):,} |',
        f'| Catalog operations without a matching source | {len(missing):,} |',
        f'| Source operations without an exact catalog match | {len(source_only):,} |',
        '', '## Comment and contract review signals', '',
        'Missing fields can be intentional in partial specifications. Differing declarations are review signals. '
        'They do not establish differences in deployed behavior or authorize a change in access.', '',
        '| Signal | Source operations |', '| --- | ---: |',
    ]
    lines.extend(f'| {note} | {total:,} |' for note, total in sorted(findings.items()))
    lines.extend(['', '## Exact source operations missing from the catalog', '',
                  '| Operation | Source specifications | Review signals |', '| --- | --- | --- |'])
    for method, path in sorted(source_only, key=lambda key: (key[1], key[0])):
        key = (method, path)
        lines.append(f'| `{method} {cell(path)}` | ' + ', '.join(map(link, sources[key]))
                     + ' | ' + ('; '.join(reviewed[key]) or 'reconcile exact path') + ' |')
    lines.extend(['', '## Catalog operations with comment or contract review signals', '',
                  '| Operation | Catalog comments | Source specifications | Review signals |',
                  '| --- | --- | --- | --- |'])
    for method, path in sorted(matched, key=lambda key: (key[1], key[0])):
        key = (method, path)
        if reviewed[key]:
            row_id = keys[key]['x-governance-id']
            lines.append(f'| `{method} {cell(path)}` | [API {row_id}](../../packages/contracts/ENDPOINT_REFERENCE.md#api-{row_id}) | '
                         + ', '.join(map(link, sources[key])) + ' | ' + '; '.join(reviewed[key]) + ' |')
    lines.extend(['', '## Logout comment reconciliation', '',
                  '`POST /v1/auth/logout` accepts optional credentials. The auth specification '
                  'lists an empty security requirement object alongside bearer and cookie alternatives. '
                  'The auth work-package specification uses an empty security array. Both allow a request '
                  'without credentials. The Worker invalidates only a presented token, then clears the '
                  'session cookie on success. See the [auth specification](../auth-openapi.json), '
                  '[work-package contract](auth-delivery-work-package.openapi.json) and '
                  '[Worker handler](../../cloudflare/workers/src/auth.ts).'])
    lines.extend(['', '## Catalog operation follow-through', '',
                  'Use the [endpoint comment index](../../packages/contracts/API_DOCUMENTATION_INDEX.md) for '
                  'all catalog operations, including registry-only entries. Use the '
                  '[delivery checklist](API_DELIVERY_CHECKLIST.md) and '
                  '[route audit](API_REACHABILITY_AUDIT.md) to inspect implementation and test evidence.', '',
                  'Regenerate after refreshing the catalog with `python scripts/reconcile-openapi-documentation.py`.'])
    return '\n'.join(lines) + '\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--catalog', type=Path, default=ROOT / 'packages/contracts/openapi.json')
    parser.add_argument('--output', type=Path, default=ROOT / 'docs/api/OPENAPI_OPERATION_RECONCILIATION.md')
    args = parser.parse_args()
    args.output.write_text(build_review(json.loads(args.catalog.read_text()), document_sources()), encoding='utf-8')


if __name__ == '__main__':
    main()
