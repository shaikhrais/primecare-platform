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
SOURCE_DIRECTORIES = ('docs/api', 'docs/appearance', 'docs/care', 'docs/marketing',
                      'docs/platform-bundle', 'docs/platform-operations', 'docs/territories')
SOURCE_FILES = ('docs/auth-openapi.json', 'docs/api-openapi.yaml',
                'packages/contracts/communications.openapi.json',
                'tests/fixtures/clinical-director-api-candidate/api-only-contract.openapi.json')
METHODS = {'get', 'post', 'put', 'patch', 'delete', 'head', 'options', 'trace'}


def clean(value, limit=2000):
    return str(value or '').replace('\x00', '').replace('\r', '')[:limit]


def specification_files(root=ROOT):
    """Enumerate known contract locations, excluding the generated catalogue."""
    files = {root / path for path in SOURCE_FILES if (root / path).is_file()}
    for directory in SOURCE_DIRECTORIES:
        for file in (root / directory).rglob('*'):
            if file.is_file() and 'openapi' in file.stem and file.suffix in {'.json', '.yaml', '.yml'}:
                files.add(file)
    return sorted(files)


def load_specification(file):
    contents = file.read_bytes()
    if file.suffix == '.json':
        return json.loads(contents), hashlib.sha256(contents).hexdigest()
    import yaml
    return yaml.safe_load(contents), hashlib.sha256(contents).hexdigest()


def document_sources(root=ROOT):
    """Index source evidence by exact HTTP method and path."""
    sources = defaultdict(list)
    for file in specification_files(root):
        doc, digest = load_specification(file)
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
                if operation.get('x-primecare-structure-status') == 'draft_missing_decisions':
                    continue
                sources[(method.upper(), path)].append({
                    'file': file.relative_to(root).as_posix(),
                    'sha256': digest,
                    'operation': operation, 'components': doc.get('components', {}),
                    'security': operation.get('security', doc.get('security')),
                    'securityLevel': 'operation' if 'security' in operation else 'document',
                    'parameters': operations.get('parameters', []),
                    'proposal': bool(doc.get('x-primecare-review', {}).get('noActivation')
                                     or doc.get('x-primecare-no-activation')
                                     or operation.get('x-primecare-no-activation')),
                })
    return sources


def resolve(value, components, section='schemas'):
    """Resolve references within the requested component section only."""
    prefix = f'#/components/{section}/'
    seen = set()
    while isinstance(value, dict) and '$ref' in value:
        ref = value['$ref']
        if not isinstance(ref, str) or not ref.startswith(prefix) or ref in seen or len(seen) >= 20:
            break
        seen.add(ref)
        key = ref[len(prefix):]
        if not key or '/' in key:
            break
        target = components.get(section, {}).get(key.replace('~1', '/').replace('~0', '~'))
        if target is None:
            break
        value = target
    if isinstance(value, dict) and '$ref' in value:
        return {'description': 'Reference requires explicit review; see source document.'}
    return value if isinstance(value, dict) else {}


def constraints(schema):
    """Summarize declared validation without copying example or literal values."""
    details = []
    kind = schema.get('type')
    if kind:
        details.append(' or '.join(map(str, kind)) if isinstance(kind, list) else clean(kind, 80))
    if schema.get('format'):
        details.append('format ' + clean(schema['format'], 80))
    if schema.get('nullable') is True:
        details.append('nullable')
    for key in ('minimum', 'maximum', 'exclusiveMinimum', 'exclusiveMaximum',
                'minLength', 'maxLength', 'minItems', 'maxItems'):
        value = schema.get(key)
        if isinstance(value, (int, float)) and not isinstance(value, bool):
            details.append(f'{key}={value}')
    if schema.get('uniqueItems') is True:
        details.append('unique items')
    if schema.get('readOnly') is True:
        details.append('read-only')
    if schema.get('writeOnly') is True:
        details.append('write-only; never log')
    if isinstance(schema.get('enum'), list):
        details.append(f'{len(schema["enum"])} allowed values; see source')
    if 'const' in schema:
        details.append('fixed value; see source')
    if 'pattern' in schema:
        details.append('pattern-constrained; see source')
    return details


def shape(schema, components):
    schema = resolve(schema, components)
    if not schema:
        return 'Not defined in this source.'
    if schema.get('description') == 'Reference requires explicit review; see source document.':
        return schema['description']
    fields = []
    variants = schema.get('oneOf') or schema.get('anyOf') or [schema]
    if len(variants) > 1:
        fields.append(f'{len(variants)} alternative input shapes; see source for conditional requirements.')
    for number, variant in enumerate(variants[:20], 1):
        variant = resolve(variant, components)
        properties = variant.get('properties', {})
        if not properties:
            fields.append('Schema: ' + (', '.join(constraints(variant)) or 'type unspecified') + '.')
            if variant.get('type') == 'array' and isinstance(variant.get('items'), dict):
                item = resolve(variant['items'], components)
                fields.append('Array item schema: ' + (', '.join(constraints(item)) or 'see source') + '.')
                properties = item.get('properties', {})
                variant = item
        for name, definition in list(properties.items())[:100]:
            field = resolve(definition, components)
            details = constraints(field) or ['constrained value']
            if field.get('type') == 'array' and isinstance(field.get('items'), dict):
                item = resolve(field['items'], components)
                if item.get('type'):
                    details.append('items: ' + constraints(item)[0])
            details.append('required' if name in variant.get('required', []) else 'optional')
            prefix = f'variant {number}: ' if len(variants) > 1 else ''
            fields.append('- ' + prefix + '`' + clean(name, 100).replace('`', '') + '`: ' + ', '.join(details))
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
        if source.get('proposal'):
            sections.append('**Review status:** Proposal or non-activated source.')
        if operation.get('summary') and operation.get('description'):
            sections.append(clean(operation['description'], 5000))
        security = source.get('security', operation.get('security'))
        sections.append('**Authentication declared in source:** ' +
                        ('No security requirement is declared in this source.' if security is None else
                         'An explicit empty security requirement is declared; review the runtime before treating access as public.' if not security else
                         source.get('securityLevel', 'operation') + ' level: ' +
                         ' OR '.join(' AND '.join(clean(k, 100) for k in item) or 'no credentials' for item in security)))
        parameters = {}
        for parameter in [*source.get('parameters', []), *operation.get('parameters', [])]:
            resolved = resolve(parameter, components, 'parameters')
            key = (resolved.get('name'), resolved.get('in'), parameter.get('$ref') if not resolved.get('name') else None)
            parameters[key] = resolved
        parameter_notes = []
        for parameter in parameters.values():
            if not parameter.get('name'):
                parameter_notes.append('- ' + clean(parameter.get('description') or 'Parameter needs review.'))
                continue
            requirement = 'required' if parameter.get('required') else 'optional'
            name = clean(parameter['name'], 100).replace('`', '')
            location = clean(parameter.get('in'), 50)
            details = constraints(resolve(parameter.get('schema', {}), components))
            description = clean(parameter.get('description'), 800)
            note = f'- `{name}` in {location} ({requirement})'
            if details:
                note += ' — ' + ', '.join(details)
            if description:
                note += '. ' + description
            parameter_notes.append(note)
        if parameter_notes:
            sections.append('**Parameters:**\n' + '\n'.join(parameter_notes))
        body = resolve(operation.get('requestBody', {}), components, 'requestBodies')
        if body:
            requirement = 'required' if body.get('required') else 'optional'
            description = clean(body.get('description'), 1000)
            if '$ref' in operation.get('requestBody', {}) and 'content' not in body:
                sections.append('**Request body:** ' + description)
            else:
                sections.append('**Request body:** ' + requirement.capitalize() + '. ' + description)
        for media, content in body.get('content', {}).items():
            sections.append('**Request body — ' + clean(media, 100) + ':**\n' + shape(content.get('schema', {}), components))
        if not body:
            sections.append('**Request body:** Not declared in this source. This may be a bodyless operation or an incomplete patch document; inspect the linked runtime.')
        for status, raw_response in operation.get('responses', {}).items():
            response = resolve(raw_response, components, 'responses')
            sections.append('**Response ' + clean(status, 20) + ':** ' + clean(response.get('description', 'See source response reference.'), 1000))
            for name, raw_header in response.get('headers', {}).items():
                header = resolve(raw_header, components, 'headers')
                details = constraints(resolve(header.get('schema', {}), components))
                if header.get('required') is True:
                    details.insert(0, 'required')
                label = '`' + clean(name, 100).replace('`', '') + '`'
                note = 'Response headers: ' + label
                if details:
                    note += ' — ' + ', '.join(details)
                description = clean(header.get('description'), 800)
                sections.append(note + '.' + (' ' + description if description else ''))
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
