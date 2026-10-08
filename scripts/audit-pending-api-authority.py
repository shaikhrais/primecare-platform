"""Read exact pending-operation authority facts from governance SQLite, without writes.

Observed grants are evidence for further review, never activation or completeness.
Missing schema information is reported as unknown, not as absence of authority.
"""
import argparse
import hashlib
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REQUIRED_ENDPOINT_FIELDS = ('request_schema_id', 'response_schema_id', 'request_schema',
                            'response_schema', 'permission_key', 'auth_required')


def audit(database, checklist):
    try:
        database = Path(database).resolve(strict=True)
    except OSError as error:
        raise ValueError('Governance database must exist') from error
    if not database.is_file():
        raise ValueError('Governance database must be an existing file')
    if not isinstance(checklist, dict) or not isinstance(checklist.get('operations'), list):
        raise ValueError('Invalid finite checklist')
    operations = checklist['operations']
    seen = set()
    for operation in operations:
        if not isinstance(operation, dict) or not isinstance(operation.get('api'), str):
            raise ValueError('Invalid operation identity')
        api = operation['api']
        if api in seen or api != operation.get('method', '') + ' ' + operation.get('route', ''):
            raise ValueError('Duplicate or inconsistent operation identity')
        seen.add(api)
        if not isinstance(operation.get('declarationIds'), list) or any(type(i) is not int for i in operation['declarationIds']):
            raise ValueError('Invalid declaration IDs')
    pending = [o for o in operations if o.get('stage') == 'needs_contract_and_verification']
    conn = sqlite3.connect(database.as_uri() + '?mode=ro', uri=True)
    conn.row_factory = sqlite3.Row
    try:
        conn.execute('PRAGMA query_only=ON')
        conn.execute('BEGIN')
        names = {r['name'] for r in conn.execute("SELECT name FROM sqlite_master WHERE type='table'")}
        tables = {}
        for name in ('api_endpoints', 'api_permissions', 'roles'):
            tables[name] = [r['name'] for r in conn.execute('PRAGMA table_info("' + name + '")')] if name in names else []
        endpoint_columns = set(tables['api_endpoints'])
        permission_columns = set(tables['api_permissions'])
        role_columns = set(tables['roles'])
        endpoint_identity = {'id', 'http_method', 'route_path'} <= endpoint_columns
        grant_identity = {'api_id', 'role_id', 'can_access', 'permission_key'} <= permission_columns
        role_label = next((c for c in ('role_code', 'code', 'name', 'role_name') if c in role_columns), None)
        role_identity = 'id' in role_columns and role_label is not None
        results = []
        for operation in pending:
            unknowns = []
            for name, required in (
                ('api_endpoints', {'id', 'http_method', 'route_path', *REQUIRED_ENDPOINT_FIELDS}),
                ('api_permissions', {'api_id', 'role_id', 'can_access', 'permission_key'})):
                missing = required - set(tables[name])
                if missing:
                    unknowns.append(name + ' missing columns: ' + ','.join(sorted(missing)))
            if not role_identity:
                unknowns.append('roles missing id or recognized role label column')
            rows = [dict(r) for r in conn.execute(
                'SELECT * FROM api_endpoints WHERE http_method=? COLLATE BINARY AND route_path=? COLLATE BINARY ORDER BY id',
                (operation['method'], operation['route']))] if endpoint_identity else []
            grants = []
            endpoint_rows = []
            for row in rows:
                if not isinstance(row.get('permission_key'), str) or not row['permission_key'].strip():
                    unknowns.append('Missing endpoint permission key for endpoint ' + str(row['id']))
                endpoint_rows.append({key: row.get(key) for key in (
                    'id', 'http_method', 'route_path', 'auth_required', 'permission_key',
                    'rate_limit_key', 'controller_name', 'controller', 'service_name',
                    'implementation_status', 'status', 'api_version')} | {
                    'requestSchema': schema_evidence(row, 'request', endpoint_columns),
                    'responseSchema': schema_evidence(row, 'response', endpoint_columns)})
                if grant_identity:
                    permissions = conn.execute('SELECT * FROM api_permissions WHERE api_id=? ORDER BY role_id', (row['id'],)).fetchall()
                    seen_roles = set()
                    duplicate_roles = {r['role_id'] for r in permissions if sum(p['role_id'] == r['role_id'] for p in permissions) > 1}
                    for permission in permissions:
                        if permission['role_id'] in seen_roles:
                            unknowns.append('Duplicate permission rows for endpoint ' + str(row['id']) + ' role ' + str(permission['role_id']))
                        seen_roles.add(permission['role_id'])
                        if permission['role_id'] in duplicate_roles:
                            continue
                        if not isinstance(permission['permission_key'], str) or not permission['permission_key'].strip() or permission['permission_key'] != row.get('permission_key'):
                            unknowns.append('Permission key mismatch for endpoint ' + str(row['id']))
                            continue
                        # SQLite integer 1 is the only explicit positive grant.
                        if type(permission['can_access']) is not int or permission['can_access'] != 1:
                            continue
                        role = conn.execute('SELECT * FROM roles WHERE id=?', (permission['role_id'],)).fetchall() if role_identity else []
                        if len(role) != 1:
                            unknowns.append('Unresolved role reference ' + str(permission['role_id']))
                        if len(role) != 1:
                            continue
                        grants.append({'endpointId': row['id'], 'roleId': permission['role_id'],
                                       'roleCode': role[0][role_label] if len(role) == 1 else None,
                                       'permissionKey': permission['permission_key'], 'canAccess': 1})
            disposition = ('unknown_schema' if unknowns else 'ambiguous_endpoint' if len(rows) > 1
                           else 'explicit_grant_observed' if grants else 'no_explicit_grant')
            results.append({'api': operation['api'], 'declarationIds': operation['declarationIds'],
                            'exactEndpointIds': [r['id'] for r in rows], 'endpointRows': endpoint_rows,
                            'explicitGrants': grants, 'unknowns': sorted(set(unknowns)),
                            'disposition': disposition})
        summary = {'pendingUniqueOperations': len(results), 'implementationCredits': 0,
                   'retirementCredits': 0, 'databaseWrites': 0,
                   'dispositions': {key: sum(r['disposition'] == key for r in results) for key in
                                    ('unknown_schema', 'ambiguous_endpoint', 'explicit_grant_observed', 'no_explicit_grant')}}
        return {'version': 1, 'noActivation': True, 'implementationCredits': 0, 'retirementCredits': 0,
                'databaseSha256': file_hash(database),
                'meaning': 'Exact governance row evidence only. A grant row is not an approved contract, ownership policy, handler implementation, or completion.',
                'schema': {'tables': tables, 'roleLabelColumn': role_label},
                'summary': summary, 'operations': results}
    finally:
        conn.close()


def file_hash(path):
    hasher = hashlib.sha256()
    with path.open('rb') as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b''):
            hasher.update(chunk)
    return hasher.hexdigest()


def schema_evidence(row, prefix, columns):
    direct = prefix + '_schema'
    ref = prefix + '_schema_id'
    value = row.get(direct)
    parsed = None
    if isinstance(value, str) and value.strip():
        try:
            parsed = json.loads(value)
        except json.JSONDecodeError:
            pass
    return {'columnKnown': direct in columns, 'referenceColumnKnown': ref in columns,
            'referenceId': row.get(ref), 'directValuePresent': value is not None and value != '',
            'directJsonShape': type(parsed).__name__ if parsed is not None else None,
            'referenceResolution': 'not_resolved_by_this_audit' if row.get(ref) is not None else 'no_reference' if ref in columns else 'unknown'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--database', type=Path, default=ROOT / '.agents/governance/governance.db')
    parser.add_argument('--checklist', type=Path, default=ROOT / 'docs/api/api-delivery-checklist.json')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    output = None
    if args.output:
        if '..' in args.output.parts:
            parser.error('Output must not traverse parent directories')
        output = args.output if args.output.is_absolute() else ROOT / args.output
        if any(p.is_symlink() for p in [output, *output.parents]):
            parser.error('Unsafe output path')
        if output.resolve() in (args.database.resolve(), args.checklist.resolve()) or output.suffix != '.json':
            parser.error('Output must be JSON and cannot overwrite an input')
        if output.exists():
            try:
                previous = json.loads(output.read_text())
            except (OSError, ValueError):
                parser.error('Refusing to overwrite unknown output')
            if previous.get('meaning') != 'Exact governance row evidence only. A grant row is not an approved contract, ownership policy, handler implementation, or completion.':
                parser.error('Refusing to overwrite unknown output')
    result = audit(args.database, json.loads(args.checklist.read_text()))
    if output:
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_text(json.dumps(result, sort_keys=True, separators=(',', ':')) + '\n')
    candidates = [{'api': r['api'], 'endpointIds': r['exactEndpointIds'], 'roles': [g['roleCode'] for g in r['explicitGrants']]}
                  for r in result['operations'] if r['disposition'] == 'explicit_grant_observed']
    print(json.dumps({'databaseSha256': result['databaseSha256'], 'schema': result['schema'], 'summary': result['summary'], 'reviewCandidates': candidates}, sort_keys=True))


if __name__ == '__main__':
    main()
