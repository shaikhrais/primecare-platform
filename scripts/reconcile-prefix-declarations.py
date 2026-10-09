"""Retire scanner-created middleware-prefix POST declarations, never implement an API."""
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RETIREMENTS = ((810, '/v1/public/', 'API__V1_PUBLIC_'), (811, '/v1/debug/', 'API__V1_DEBUG_'), (812, '/v1/marketing/', 'API__V1_MARKETING_'))
NULL_AUTHORITY = ('runtime_artifact_id', 'request_schema', 'response_schema', 'permission_key', 'rate_limit_key',
                  'controller_id', 'service_id', 'request_schema_id', 'response_schema_id')


def reconcile(db):
    # SAVEPOINT also protects callers that already have an open transaction.
    db.execute('SAVEPOINT retire_namespace_prefixes')
    try:
        tables = [r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'")]
        for api_id, path, code in RETIREMENTS:
            fields = ['endpoint_code', 'route_path', 'http_method', 'service_name', 'auth_required',
                      'controller_name', 'implementation_status', 'health_status', *NULL_AUTHORITY, 'app_id']
            row = db.execute('SELECT ' + ','.join(fields) + ' FROM api_endpoints WHERE id=?', (api_id,)).fetchone()
            if row is None or tuple(row[:6]) != (code, path, 'POST', 'PRISMA', 1, '') or row[-1] != 1:
                raise ValueError('Namespace prefix declaration identity changed: ' + path)
            if row[6] not in ('active', 'retired') or (row[6] == 'retired' and row[7] != 'unverified') or any(v is not None for v in row[8:-1]):
                raise ValueError('Namespace prefix authority/status changed: ' + path)
            # api_id means canonical API domain. endpoint_id in screen_endpoint_map
            # means registry domain; its legitimate registry link must remain untouched.
            for table in tables:
                quoted = '"' + table.replace('"', '""') + '"'
                columns = {r[1] for r in db.execute('PRAGMA table_info(' + quoted + ')')}
                if 'api_id' in columns and db.execute('SELECT 1 FROM ' + quoted + ' WHERE api_id=? LIMIT 1', (api_id,)).fetchone():
                    raise ValueError('Namespace prefix has canonical API reference: ' + table + ' ' + path)
                for key in ('endpoint_path', 'route_path'):
                    if table != 'api_endpoints' and key in columns and db.execute('SELECT 1 FROM ' + quoted + ' WHERE "' + key + '"=? LIMIT 1', (path,)).fetchone():
                        raise ValueError('Namespace prefix has registered route reference: ' + table + ' ' + path)
                # Reject additional FK namespaces pointing at this canonical API.
                for fk in db.execute('PRAGMA foreign_key_list(' + quoted + ')'):
                    if table == 'governance_findings' and fk[3] == 'related_api_id':
                        diagnostics = db.execute('SELECT finding_category,finding_code,status,related_screen_id,related_file_id,description FROM governance_findings WHERE related_api_id=?', (api_id,)).fetchall()
                        expected = ('drift', 'missing_test_coverage', 'closed', None, None, 'API Endpoint POST ' + path + ' is missing verification test proof.')
                        if any(tuple(d) != expected for d in diagnostics):
                            raise ValueError('Namespace prefix has unreviewed governance finding: ' + path)
                        continue
                    if fk[2] == 'api_endpoints' and fk[3] != 'api_id' and db.execute('SELECT 1 FROM ' + quoted + ' WHERE "' + fk[3].replace('"','""') + '"=? LIMIT 1', (api_id,)).fetchone():
                        raise ValueError('Namespace prefix has foreign-key reference: ' + table + ' ' + path)
        for api_id, _, _ in RETIREMENTS:
            db.execute("UPDATE api_endpoints SET implementation_status='retired',health_status='unverified' WHERE id=?", (api_id,))
        db.execute('RELEASE retire_namespace_prefixes')
    except BaseException:
        db.execute('ROLLBACK TO retire_namespace_prefixes')
        db.execute('RELEASE retire_namespace_prefixes')
        raise


if __name__ == '__main__':
    with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
        reconcile(db)
    print('Retired three namespace-prefix POST declarations; zero APIs implemented; runtime unchanged.')
