"""Export an explicitly draft inventory; never modify governance or infer access rules."""
import argparse
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
METHODS = {'get', 'post', 'put', 'patch', 'delete', 'head', 'options', 'trace'}


def commentary(row, gaps):
    """Human-readable comments shared by OpenAPI and the endpoint handbook."""
    return '\n\n'.join([
        f"## Registered operation\n`{row['http_method']} {row['route_path']}`\n\n"
        f"Governance ID: {row['id']}. Registry code: `{row['endpoint_code']}`. "
        f"Registry status: `{row['implementation_status']}` (not runtime evidence).",
        '## Purpose and behavior\nThe route identifies the registered operation. '
        'A verified business-purpose description, side effects, prerequisites and '
        'completion criteria are not supplied by this endpoint record. Do not infer them from its name.',
        f"## Authentication and permissions\nRegistered auth_required: `{row['auth_required']}`. "
        f"Permission key: `{row['permission_key'] or 'NOT DEFINED'}`. "
        'No reviewed endpoint-specific role allowlist, authentication scheme, or tenant scope is established '
        'by this export. Missing security metadata does not mean anonymous access is allowed.',
        '## Request contract\n' + ('A schema value is registered but has not been verified; it is not promoted '
        'to an executable contract.' if row['request_schema'] else 'No endpoint-level request schema is registered.') +
        ' Required fields, types, limits, content types, query parameters and validation behavior need approval.',
        '## Response contract\n' + ('A schema value is registered but has not been verified.'
        if row['response_schema'] else 'No endpoint-level response schema is registered.') +
        ' Success codes, payloads, pagination and error bodies are unverified. '
        'The default response below is a documentation placeholder, not a runtime guarantee.',
        '## Persistence and tenant isolation\nDatabase mappings, tenant predicates, transaction boundaries, '
        'idempotency and write/read-back evidence must be validated before this operation is considered functional.',
        f"## Rate limiting and audit\nRate-limit key: `{row['rate_limit_key'] or 'NOT DEFINED'}`. "
        'Audit events, retention and retry policy require a reviewed contract. Do not automatically retry mutations.',
        '## Required verification\n- Approved successful journey and persistence/read-back where applicable.\n'
        '- Missing, expired and invalid credentials.\n- Forbidden roles and cross-tenant requests.\n'
        '- Invalid input, resource absence and database failure.\n- Rate limiting and audit event emission.\n'
        'These are proposed checks, not passed tests.',
        '## Blocking findings\n' + '\n'.join('- ' + gap for gap in gaps),
    ])


def build(records):
    spec = {
        'openapi': '3.1.0',
        'info': {
            'title': 'PrimeCare governed API inventory (DRAFT)',
            'version': '0.0.0-draft',
            'description': 'Inventory only. Registered does not mean implemented or tested. '
                           'Security schemes, schemas, and success responses are deliberately '
                           'not fabricated. Do not use this document as a production contract.',
        },
        'x-production-ready': False,
        'paths': {},
    }
    findings = []
    for row in records:
        path = row['route_path'] or ''
        method = (row['http_method'] or '').lower()
        gaps = []
        for field in ('request_schema', 'response_schema', 'permission_key', 'rate_limit_key'):
            if not row[field] or not str(row[field]).strip():
                gaps.append('missing_' + field)
        for field in ('request_schema', 'response_schema'):
            if row[field]:
                try:
                    schema = json.loads(row[field])
                    if not isinstance(schema, (dict, bool)):
                        gaps.append('invalid_' + field)
                except (ValueError, TypeError):
                    gaps.append('invalid_' + field)
        # Even populated registry fields need a reviewed binding to the deployed code.
        gaps.append('runtime_security_persistence_and_tests_not_verified')
        if not path.startswith('/') or '?' in path or '#' in path or method not in METHODS:
            gaps.append('invalid_route_or_method')
        elif method in spec['paths'].get(path, {}):
            gaps.append('duplicate_operation')
        else:
            spec['paths'].setdefault(path, {})[method] = {
                'operationId': 'governed_endpoint_' + str(row['id']),
                'summary': row['endpoint_code'],
                'description': commentary(row, gaps),
                'tags': [path.strip('/').split('/')[1] if path.startswith('/v1/') else 'other'],
                'x-governance-id': row['id'],
                'x-governance-status': row['implementation_status'],
                'x-governance-auth-required': row['auth_required'],
                'x-contract-status': 'blocked',
                'x-gaps': gaps,
                'responses': {'default': {'description': 'Response contract is not yet verified.'}},
            }
        findings.append({'endpoint_id': row['id'], 'method': method.upper(), 'path': path, 'gaps': gaps})
    return spec, {
        'production_ready': False,
        'registered_endpoints': len(records),
        'exported_operations': sum(len(ops) for ops in spec['paths'].values()),
        'blocked_endpoints': len(findings),
        'findings': findings,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--database', type=Path, default=ROOT / '.agents/governance/governance.db')
    parser.add_argument('--output', type=Path, default=ROOT / 'packages/contracts/openapi.json')
    parser.add_argument('--report', type=Path, default=ROOT / 'packages/contracts/api-readiness.json')
    parser.add_argument('--handbook', type=Path, default=ROOT / 'packages/contracts/ENDPOINT_REFERENCE.md')
    parser.add_argument('--check', action='store_true', help='Read only; exit 1 if deployment is blocked.')
    args = parser.parse_args()
    with sqlite3.connect(args.database.resolve().as_uri() + '?mode=ro', uri=True) as db:
        db.row_factory = sqlite3.Row
        # Explicit allowlist: never export passwords, emails, DB URLs, or unrelated tables.
        records = list(db.execute('SELECT id, endpoint_code, route_path, http_method, '
                                  'auth_required, implementation_status, request_schema, '
                                  'response_schema, permission_key, rate_limit_key '
                                  'FROM api_endpoints ORDER BY id'))
    spec, report = build(records)
    if not args.check:
        for path, value in ((args.output, spec), (args.report, report)):
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
        handbook = ['# PrimeCare endpoint reference — DRAFT',
                    'All operations below are registered, not verified implementations. '
                    'Descriptions preserve missing requirements explicitly. No production requests are executed.']
        for path, operations in spec['paths'].items():
            for method, operation in operations.items():
                handbook.append(f"# {operation['x-governance-id']}: {method.upper()} {path}\n\n" + operation['description'])
        args.handbook.parent.mkdir(parents=True, exist_ok=True)
        args.handbook.write_text('\n\n'.join(handbook) + '\n', encoding='utf-8')
    print(json.dumps({key: value for key, value in report.items() if key != 'findings'}))
    return 1 if args.check else 0


if __name__ == '__main__':
    raise SystemExit(main())
