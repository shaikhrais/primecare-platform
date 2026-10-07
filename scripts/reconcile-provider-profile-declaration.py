"""Retire the scanner POST after moving the self-profile caller to its owned GET."""
import json
import re
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LEGACY_ID = 786
LEGACY_PATH = '/v1/provider/dashboard'
CANONICAL_ID = 16446
CANONICAL_PATH = '/v1/provider/profile'
NULL_AUTHORITY = ('runtime_artifact_id', 'request_schema', 'response_schema', 'permission_key', 'rate_limit_key',
                  'controller_id', 'service_id', 'request_schema_id', 'response_schema_id')
REQUEST_SCHEMA = {'type': 'object', 'additionalProperties': False, 'properties': {}}
PROFILE_FIELDS = ['id', 'full_name', 'bio', 'languages', 'service_areas', 'provider_type', 'is_approved', 'skills']
RESPONSE_SCHEMA = {'type': 'object', 'additionalProperties': False, 'required': ['profile'], 'properties': {
    'profile': {'type': 'object', 'additionalProperties': False, 'required': PROFILE_FIELDS,
                'properties': {field: {'type': ['string', 'null'] if field == 'bio' else 'boolean' if field == 'is_approved' else 'string'} for field in PROFILE_FIELDS}}}}


def check_callers(root):
    config = root / 'packages/flutter_core/lib/src/network/api_client.dart'
    service = root / 'packages/flutter_core/lib/provider_service.dart'
    source = config.read_text()
    for key in ('providerProfile', 'providerDashboard'):
        if "'" + key + "': '" + CANONICAL_PATH + "'" not in source:
            raise ValueError('Provider caller config is not canonical: ' + key)
    if "ApiConfig.endpoints['providerProfile']" not in service.read_text():
        raise ValueError('Provider self-profile caller is not canonical')
    allowed = "return route == '/v1/provider/profile' || route == '/v1/provider/dashboard';"
    for directory in ('apps', 'packages', 'services', 'cloudflare/workers/src', 'generated_screen_backup_before_template_reset'):
        for path in (root / directory).rglob('*'):
            if path.suffix not in ('.dart', '.js', '.ts') or any(part in ('test', 'tests', 'node_modules', 'build', '.dart_tool') for part in path.parts):
                continue
            lines = [line.strip() for line in path.read_text(errors='replace').splitlines() if LEGACY_PATH in line]
            # The sole retained reference denies old transport cache/mock fallback.
            if lines and not (path == config and len(lines) == 1 and re.sub(r'\s+', '', allowed) in re.sub(r'\s+', '', source)):
                raise ValueError('Provider legacy route caller remains: ' + str(path.relative_to(root)))


def reconcile(db, source_root=ROOT):
    check_callers(Path(source_root))
    db.execute('SAVEPOINT retire_provider_profile')
    try:
        canonical = db.execute('SELECT endpoint_code,route_path,http_method,service_name,auth_required,permission_key,request_schema,response_schema,app_id,implementation_status FROM api_endpoints WHERE id=?', (CANONICAL_ID,)).fetchone()
        if canonical is None or tuple(canonical[:6]) != ('PROVIDER_SELF_PROFILE', CANONICAL_PATH, 'GET', 'provider', 1, 'authenticated_provider_profile_owner') or canonical[8:] != (6, 'implemented'):
            raise ValueError('Canonical provider ownership/identity changed')
        if not isinstance(canonical[6], str) or not isinstance(canonical[7], str) or json.loads(canonical[6]) != REQUEST_SCHEMA or json.loads(canonical[7]) != RESPONSE_SCHEMA:
            raise ValueError('Canonical provider contract changed')
        if db.execute("SELECT 1 FROM sqlite_master WHERE type='trigger' AND tbl_name='api_endpoints' LIMIT 1").fetchone():
            raise ValueError('Provider retirement has unreviewed endpoint trigger')
        fields = ['endpoint_code', 'route_path', 'http_method', 'service_name', 'auth_required', 'controller_name', 'implementation_status', 'health_status', *NULL_AUTHORITY, 'app_id']
        legacy = db.execute('SELECT ' + ','.join(fields) + ' FROM api_endpoints WHERE id=?', (LEGACY_ID,)).fetchone()
        if legacy is None or tuple(legacy[:6]) != ('API__V1_PROVIDER_DASHBOARD', LEGACY_PATH, 'POST', 'PRISMA', 1, '') or legacy[-1] != 1:
            raise ValueError('Legacy provider declaration identity changed')
        if legacy[6] not in ('active', 'retired') or (legacy[6] == 'retired' and legacy[7] != 'unverified') or any(v is not None for v in legacy[8:-1]):
            raise ValueError('Legacy provider authority/status changed')
        tables = [r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'")]
        for table in tables:
            quoted = '"' + table.replace('"', '""') + '"'
            columns = {r[1] for r in db.execute('PRAGMA table_info(' + quoted + ')')}
            if 'api_id' in columns and db.execute('SELECT 1 FROM ' + quoted + ' WHERE api_id=? LIMIT 1', (LEGACY_ID,)).fetchone():
                raise ValueError('Legacy provider canonical API reference: ' + table)
            for key in ('endpoint_path', 'route_path'):
                if table != 'api_endpoints' and key in columns and db.execute('SELECT 1 FROM ' + quoted + ' WHERE "' + key + '"=? LIMIT 1', (LEGACY_PATH,)).fetchone():
                    raise ValueError('Legacy provider registered route reference: ' + table)
            for fk in db.execute('PRAGMA foreign_key_list(' + quoted + ')'):
                if fk[2] != 'api_endpoints' or fk[3] == 'api_id':
                    continue
                if table == 'governance_findings' and fk[3] == 'related_api_id':
                    findings = db.execute('SELECT finding_category,finding_code,status,related_screen_id,related_file_id,description FROM governance_findings WHERE related_api_id=?', (LEGACY_ID,)).fetchall()
                    expected = ('drift', 'missing_test_coverage', 'closed', None, None, 'API Endpoint POST ' + LEGACY_PATH + ' is missing verification test proof.')
                    if any(tuple(f) != expected for f in findings):
                        raise ValueError('Legacy provider unreviewed diagnostic')
                elif db.execute('SELECT 1 FROM ' + quoted + ' WHERE "' + fk[3].replace('"', '""') + '"=? LIMIT 1', (LEGACY_ID,)).fetchone():
                    raise ValueError('Legacy provider foreign-key reference: ' + table)
        db.execute("UPDATE api_endpoints SET implementation_status='retired',health_status='unverified' WHERE id=?", (LEGACY_ID,))
        db.execute('RELEASE retire_provider_profile')
    except BaseException:
        db.execute('ROLLBACK TO retire_provider_profile')
        db.execute('RELEASE retire_provider_profile')
        raise


if __name__ == '__main__':
    with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
        reconcile(db)
    print('Retired one scanner POST declaration; caller uses existing owned GET; zero new APIs implemented.')
