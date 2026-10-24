"""Endpoint comments from reviewed repository documents, without inventing contracts.

No database connection or write is performed here. Source schemas are described,
not promoted to a deployed contract; overlapping definitions remain visible.
"""
import hashlib
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
METHODS = {'get', 'post', 'put', 'patch', 'delete', 'head', 'options', 'trace'}


def clean(value, limit=2000):
    return str(value or '').replace('\x00', '').replace('\r', '')[:limit]


def document_sources(root=ROOT):
    """Use only tracked documentation locations; never load arbitrary URLs/refs."""
    sources = defaultdict(list)
    files = sorted((root / 'docs/api').glob('*.openapi.json'))
    communication = root / 'packages/contracts/communications.openapi.json'
    if communication.exists():
        files.append(communication)
    for file in files:
        doc = json.loads(file.read_text())
        if not isinstance(doc, dict) or not isinstance(doc.get('paths'), dict):
            raise ValueError('Invalid repository API documentation')
        for path, operations in doc['paths'].items():
            if not isinstance(operations, dict):
                raise ValueError('Invalid repository API path item')
            for method, operation in operations.items():
                if method not in METHODS:
                    continue
                if not isinstance(operation, dict):
                    raise ValueError('Invalid repository API operation')
                sources[(method.upper(), path)].append({
                    'file': file.relative_to(root).as_posix(),
                    'sha256': hashlib.sha256(file.read_bytes()).hexdigest(),
                    'operation': operation, 'components': doc.get('components', {}),
                })
    return sources


def resolve(value, components):
    """Resolve local schema refs only, with cycle/depth bounds."""
    seen = set()
    while isinstance(value, dict) and '$ref' in value:
        ref = value['$ref']
        if not isinstance(ref, str) or not ref.startswith('#/components/schemas/') or ref in seen or len(seen) >= 20:
            return {'description': 'Reference requires explicit review; see source document.'}
        seen.add(ref)
        value = components.get('schemas', {}).get(ref.split('/')[-1], {})
    return value if isinstance(value, dict) else {}


def shape(schema, components):
    schema = resolve(schema, components)
    if not schema:
        return 'Not defined in this source.'
    fields = []
    variants = schema.get('oneOf') or schema.get('anyOf') or [schema]
    if len(variants) > 1:
        fields.append(f'{len(variants)} alternative input shapes; see source for conditional requirements.')
    for number, variant in enumerate(variants[:20], 1):
        variant = resolve(variant, components)
        properties = variant.get('properties', {})
        if not properties:
            fields.append('No object fields; schema type: ' + clean(variant.get('type', 'unspecified'), 100) + '.')
        for name, definition in list(properties.items())[:100]:
            # Names/types/limits only. Never export examples, defaults, enum values,
            # credentials or arbitrary registry schema content into comments.
            field = resolve(definition, components)
            constraints = [clean(field.get('type', 'constrained value'), 80)]
            constraints.append('required' if name in variant.get('required', []) else 'optional')
            for key in ['minimum', 'maximum', 'minLength', 'maxLength', 'minItems', 'maxItems']:
                value = field.get(key)
                if isinstance(value, (int, float)) and not isinstance(value, bool):
                    constraints.append(f'{key}={value}')
            if field.get('writeOnly') is True:
                constraints.append('write-only; never log')
            if 'enum' in field and isinstance(field['enum'], list):
                constraints.append(f'{len(field["enum"])} allowed values; see source')
            if 'const' in field:
                constraints.append('fixed value; see source')
            if 'pattern' in field:
                constraints.append('pattern-constrained; see source')
            prefix = f'variant {number}: ' if len(variants) > 1 else ''
            fields.append('- ' + prefix + '`' + clean(name, 100).replace('`', '') + '`: ' + ', '.join(constraints))
        if variant.get('additionalProperties') is False:
            fields.append('Additional properties are rejected for this shape.')
    return '\n'.join(fields)


def source_comments(sources):
    if not sources:
        return ('## Endpoint-specific implementation references\nNo exact method-and-path documentation source was found. '
                'This is an explicit documentation/implementation gap, not permission to infer behavior from the route name.')
    sections = ['## Endpoint-specific implementation references',
                'The following repository documents match this exact HTTP method and path. '
                'Their claims describe source contracts; they are not fresh production acceptance evidence.']
    if len(sources) > 1:
        sections.append('Multiple source versions exist. Read every reference; incompatible request/security/response definitions '
                        'must be reconciled against the current runtime and governance before client generation. No version is silently selected.')
    for source in sources:
        operation, components = source['operation'], source['components']
        sections.extend(['### [' + source['file'] + '](../../' + source['file'] + ')',
                         '**Purpose / behavior from source:** ' + clean(operation.get('summary') or operation.get('description') or 'Not stated.', 5000)])
        if operation.get('summary') and operation.get('description'):
            sections.append(clean(operation['description'], 5000))
        security = operation.get('security')
        sections.append('**Authentication declared in source:** ' +
                        ('Not declared at operation level; inspect document-level security.' if security is None else
                         'No operation-level security requirement is declared; this does not authorize public exposure.' if not security else
                         '; '.join(', '.join(clean(k, 100) for k in item) or 'anonymous alternative' for item in security)))
        parameters = operation.get('parameters', [])
        if parameters:
            sections.append('**Parameters:**\n' + '\n'.join('- `' + clean(p.get('name'), 100).replace('`', '') + '` in ' + clean(p.get('in'), 50) +
                            (' (required)' if p.get('required') else ' (optional)') for p in parameters if isinstance(p, dict)))
        body = operation.get('requestBody', {})
        for media, content in body.get('content', {}).items():
            sections.append('**Request body — ' + clean(media, 100) + ':**\n' + shape(content.get('schema', {}), components))
        if not body:
            sections.append('**Request body:** Not declared in this source. This may be a bodyless operation or an incomplete patch document; inspect the linked runtime.')
        for status, response in operation.get('responses', {}).items():
            sections.append('**Response ' + clean(status, 20) + ':** ' + clean(response.get('description', 'See source response reference.'), 1000))
            for media, content in response.get('content', {}).items():
                sections.append('Content type `' + clean(media, 100) + '`:\n' + shape(content.get('schema', {}), components))
    return '\n\n'.join(sections)


def enrich(spec, records, sources):
    coverage = []
    by_id = {str(row['id']): dict(row) for row in records}
    for path, operations in spec['paths'].items():
        for method, operation in operations.items():
            matches = sources.get((method.upper(), path), [])
            operation['description'] += '\n\n' + source_comments(matches)
            operation['x-documentation-sources'] = [{'file': s['file'], 'sha256': s['sha256']} for s in matches]
            operation['x-documentation-status'] = 'source-linked-needs-runtime-review' if matches else 'registry-only-explicit-gaps'
            operation['x-documentation-complete'] = True
            row = by_id[str(operation['x-governance-id'])]
            coverage.append({'id': row['id'], 'method': method.upper(), 'path': path,
                             'service': clean(row.get('service_name') or 'unassigned', 100),
                             'sourceCount': len(matches), 'status': operation['x-documentation-status']})
    return {'registeredRecords': len(records), 'documentedOperations': len(coverage),
            'sourceLinkedOperations': sum(row['sourceCount'] > 0 for row in coverage),
            'multipleSourceOperations': sum(row['sourceCount'] > 1 for row in coverage),
            'registryOnlyOperations': sum(row['sourceCount'] == 0 for row in coverage),
            'omittedOrQuarantinedRecords': len(records) - len(coverage),
            'productionReady': False, 'services': dict(sorted(Counter(row['service'] for row in coverage).items())),
            'operations': coverage}


def handbook(spec, coverage, findings):
    groups = defaultdict(list)
    for path, operations in spec['paths'].items():
        for method, operation in operations.items():
            groups[path.split('/')[2] if path.startswith('/v1/') and len(path.split('/')) > 2 else 'other'].append((path, method, operation))
    lines = ['# PrimeCare endpoint reference',
             'Generated from the pinned production governance catalogue and exact repository documentation references. '
             'Comments cover every exported operation; missing business contracts remain explicit. '
             'This is documentation coverage, not implementation or production certification.',
             f'Exported operations: {coverage["documentedOperations"]}. Source-linked: {coverage["sourceLinkedOperations"]}. '
             f'Registry-only with explicit gaps: {coverage["registryOnlyOperations"]}. '
             f'Omitted/quarantined records: {coverage["omittedOrQuarantinedRecords"]}.',
             '## Contents']
    for group in sorted(groups):
        lines.append(f'- [{group}](#family-{group}) — {len(groups[group])} operations')
    for group, operations in sorted(groups.items()):
        lines += [f'<a id="family-{group}"></a>\n\n## {group}']
        for path, method, operation in sorted(operations):
            lines += [f'<a id="api-{operation["x-governance-id"]}"></a>\n\n### {operation["x-governance-id"]}: {method.upper()} {path}', operation['description']]
    quarantine = [row for row in findings if 'invalid_route_or_method' in row['gaps'] or 'duplicate_operation' in row['gaps']]
    if quarantine:
        lines.append('## Quarantined registrations — not silently omitted')
        for row in quarantine:
            lines.append(f'- Registry ID {row["endpoint_id"]}: ' + ', '.join(row['gaps']) + '. Resolve the catalogue identity before documenting it as a callable operation.')
    return '\n\n'.join(lines) + '\n'


def index_markdown(coverage):
    lines = ['# API documentation index',
             'Every listed operation has comments in ENDPOINT_REFERENCE.md. Source-linked means exact repository references were found; '
             'registry-only means missing contracts are explicitly documented. Neither means production verified.',
             '| ID | Method | Path | Service | Source documents | Documentation |',
             '| --- | --- | --- | --- | --- | --- |']
    for row in coverage['operations']:
        path = clean(row['path'], 500).replace('|', '\\|')
        lines.append(f'| {row["id"]} | {row["method"]} | `{path}` | {row["service"]} | {row["sourceCount"]} | '
                     f'[Comments](ENDPOINT_REFERENCE.md#api-{row["id"]}) |')
    return '\n\n'.join(lines[:2]) + '\n\n' + '\n'.join(lines[2:]) + '\n'
