"""Fixed, read-only metadata diagnostic. This is not an authorization engine.

No workflow invokes this candidate. The CLI has no inputs other than the two
existing database credential variables. Fixtures use an in-memory driver in the
separate test module; there is no production fixture mode or SQLite fallback.
"""
from __future__ import annotations

import hashlib
import json
import math
import os
from pathlib import Path
import re
import signal
import sys
import time
from urllib.parse import unquote, urlsplit

SCHEMA = 'governance_68b0b02dd1215f58630d2c1a'
MANIFEST_SHA = '68b0b02dd1215f58630d2c1aea3c5e1cfd488a9cbcfe5c96bea9dcfd89944c42'
MANIFEST_TABLE = 'govt_source_manifest'
CA_FILE = '/etc/ssl/certs/ca-certificates.crt'
MAX_ROWS = 256
MAX_QUERIES = 24
MAX_BYTES = 8 * 1024 * 1024
MAX_FIELD = 16384
TOTAL_SECONDS = 180
ROUTES = (
    '/admin/reality-check', '/admin/role-screen-carousel', '/admin/screenshot-gallery',
    '/generated/corporate/ceo/growth-pipeline',
    '/generated/corporate/ceo/region-performance',
    '/generated/corporate/ceo/leadership-reports', '/governance/placeholder',
)
# Distinct source-observed identities, never asserted to be aliases.
CODE_PAIRS = (
    ('ceo_growth_pipeline', 'growth_pipeline'),
    ('ceo_region_performance', 'regional_performance'),
    ('ceo_leadership_reports', 'leadership_reports'),
)
SOURCE_API_PATHS = ('/v1/growth-pipeline', '/v1/regional-performance', '/v1/leadership-reports')

# Types are the logical SQLite types used by the existing import/reader. Only
# these exact columns may be projected. No arbitrary relation/filter API exists.
FIELDS = {
    'screens': {'id': 'integer', 'screen_code': 'text', 'route_path': 'text',
                'app_id': 'integer', 'role_id': 'integer', 'active': 'integer'},
    'route_registry': {'id': 'integer', 'screen_id': 'integer', 'app_id': 'integer',
                       'role_id': 'integer', 'route_path': 'text', 'active': 'integer',
                       'auth_required': 'integer', 'role_guard_required': 'integer',
                       'permission_required': 'text'},
    'role_screen_permissions': {'role_id': 'integer', 'screen_id': 'integer',
                                'can_view': 'integer', 'can_create': 'integer',
                                'can_edit': 'integer', 'can_delete': 'integer',
                                'can_export': 'integer'},
    'roles': {'id': 'integer', 'role_code': 'text', 'active': 'integer'},
    'screen_api_links': {'screen_id': 'integer', 'api_id': 'integer'},
    'screen_api_map': {'screen_id': 'integer', 'api_id': 'integer'},
    'api_endpoints': {'id': 'integer', 'app_id': 'integer', 'endpoint_code': 'text',
                      'http_method': 'text', 'route_path': 'text', 'auth_required': 'integer',
                      'permission_key': 'text', 'request_schema': 'text',
                      'response_schema': 'text', 'service_name': 'text',
                      'implementation_status': 'text', 'api_version': 'text',
                      'rate_limit_key': 'text'},
    'api_endpoint_registry': {'id': 'integer', 'api_id': 'integer',
                              'endpoint_code': 'text', 'method': 'text', 'endpoint_path': 'text'},
    'api_permissions': {'id': 'integer', 'api_id': 'integer', 'role_id': 'integer',
                        'runtime_artifact_id': 'integer', 'permission_key': 'text',
                        'can_access': 'integer'},
    'runtime_artifacts': {'id': 'integer'},
    'runtime_catalog_permissions': {'role_id': 'integer', 'can_view_inventory': 'integer',
                                    'can_view_organization': 'integer'},
}
FAULTS = frozenset({
    'ARGUMENTS_REFUSED', 'CONFIGURATION_UNAVAILABLE', 'MISSING_DATABASE_URL',
    'CONFLICTING_DATABASE_URLS', 'INVALID_DATABASE_URL', 'UNEXPECTED_DATABASE_TARGET',
    'CONNECTION_OPTIONS_REFUSED', 'ENVIRONMENT_OPTIONS_REFUSED', 'HOME_CREDENTIALS_REFUSED',
    'CA_UNAVAILABLE', 'DEPENDENCY_UNAVAILABLE', 'CONNECTION_UNVERIFIED', 'CONNECTION_DENIED', 'TLS_UNVERIFIED',
    'PIN_MISMATCH', 'MANIFEST_MISMATCH', 'MANIFEST_INTEGRITY_MISMATCH', 'MANIFEST_INVALID',
    'RELATION_UNVERIFIED', 'COLUMN_UNVERIFIED', 'STORAGE_UNVERIFIED', 'READONLY_UNVERIFIED',
    'ROW_LIMIT', 'BYTE_LIMIT', 'QUERY_LIMIT', 'TOTAL_TIMEOUT', 'QUERY_UNAVAILABLE', 'READ_DENIED',
    'INVALID_METADATA', 'IDENTITY_AMBIGUOUS', 'ROLLBACK_UNVERIFIED', 'CLOSE_UNVERIFIED',
})


class Fault(Exception):
    def __init__(self, code):
        self.code = code if code in FAULTS else 'QUERY_UNAVAILABLE'
        super().__init__(self.code)


def require(condition, code):
    if not condition:
        raise Fault(code)


def canonical_manifest(value):
    """Exact export.py encoding, not JSONB display order or a stored hash label."""
    try:
        raw = (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2,
                          allow_nan=False) + '\n').encode('utf-8')
    except (TypeError, ValueError, UnicodeError, RecursionError):
        raise Fault('MANIFEST_INVALID') from None
    require(len(raw) <= MAX_BYTES, 'BYTE_LIMIT')
    return raw


def validate_manifest(rows, expected_hash):
    require(len(rows) == 1 and rows[0].get('manifest_sha256') == expected_hash, 'MANIFEST_MISMATCH')
    manifest = rows[0].get('manifest')
    require(isinstance(manifest, dict), 'MANIFEST_INVALID')
    require(hashlib.sha256(canonical_manifest(manifest)).hexdigest() == expected_hash,
            'MANIFEST_INTEGRITY_MISMATCH')
    require(manifest.get('format') == 'primecare-governance-snapshot-v1' and
            isinstance(manifest.get('tables'), list), 'MANIFEST_INVALID')
    tables = {}
    for item in manifest['tables']:
        require(isinstance(item, dict) and isinstance(item.get('name'), str), 'MANIFEST_INVALID')
        require(item['name'] not in tables, 'MANIFEST_INVALID')
        tables[item['name']] = item
    storage = {}
    for table, fields in FIELDS.items():
        require(table in tables, 'RELATION_UNVERIFIED')
        columns = tables[table].get('columns')
        require(isinstance(columns, list), 'COLUMN_UNVERIFIED')
        require(all(isinstance(c, dict) and isinstance(c.get('name'), str) for c in columns),
                'COLUMN_UNVERIFIED')
        require(len({c['name'] for c in columns}) == len(columns), 'COLUMN_UNVERIFIED')
        by_name = {c['name']: c for c in columns}
        storage[table] = {}
        for name, kind in fields.items():
            require(name in by_name, 'COLUMN_UNVERIFIED')
            types = by_name[name].get('storage_types')
            require(types == [kind] or types == [], 'STORAGE_UNVERIFIED')
            storage[table][name] = kind if types else 'tagged'
    return storage


def production_config(env):
    """Never pass a connection URI/conninfo to libpq. Reject all option sources.

    Explicit TLS and CA arguments cannot be replaced by URI query options or
    libpq/OpenSSL environment defaults. Require password authentication data in
    the URL so .pgpass is unnecessary; no credential file is read.
    """
    forbidden = {'SSL_CERT_FILE', 'SSL_CERT_DIR', 'OPENSSL_CONF', 'OPENSSL_MODULES',
                 'NODE_TLS_REJECT_UNAUTHORIZED', 'NODE_EXTRA_CA_CERTS', 'NODE_OPTIONS',
                 'GOVERNANCE_ALLOW_SQLITE_FIXTURES', 'GOVERNANCE_ALLOW_TEST_FIXTURE'}
    require(not any(k.startswith('PG') or k in forbidden for k in env), 'ENVIRONMENT_OPTIONS_REFUSED')
    first, second = env.get('GOVERNANCE_DATABASE_URL'), env.get('PRODUCTION_DATABASE_URL')
    require(not (first and second and first != second), 'CONFLICTING_DATABASE_URLS')
    raw = first or second
    require(isinstance(raw, str) and 0 < len(raw) <= 8192, 'MISSING_DATABASE_URL')
    try:
        url = urlsplit(raw)
        port = 5432 if url.port is None else url.port
        user, password = unquote(url.username or '', errors='strict'), unquote(url.password or '', errors='strict')
    except (ValueError, UnicodeError):
        raise Fault('INVALID_DATABASE_URL') from None
    require(url.scheme in ('postgres', 'postgresql') and url.hostname == 'pooled.db.prisma.io'
            and url.path == '/postgres' and port == 5432, 'UNEXPECTED_DATABASE_TARGET')
    require(not url.query and not url.fragment and '?' not in raw and '#' not in raw,
            'CONNECTION_OPTIONS_REFUSED')
    require(bool(user and password) and not any(ord(c) < 32 for c in raw + user + password)
            and not re.search(r'%(?![0-9A-Fa-f]{2})', raw), 'INVALID_DATABASE_URL')
    return {'host': 'pooled.db.prisma.io', 'port': 5432, 'dbname': 'postgres',
            'user': user, 'password': password, 'sslmode': 'verify-full',
            'sslrootcert': CA_FILE, 'gssencmode': 'disable',
            'passfile': '/dev/null', 'connect_timeout': 10,
            'prepare_threshold': None, 'autocommit': True,
            'application_name': 'primecare-fixed-authority-reader'}


def validate_local_configuration(env):
    require(isinstance(env.get('HOME'), str) and Path(env['HOME']).is_absolute(), 'CONFIGURATION_UNAVAILABLE')
    home = Path(env['HOME'])
    # Existence checks only. Never open/read any credential file.
    require(not any((home / name).exists() for name in
                    ('.pgpass', '.pg_service.conf', '.postgresql/postgresql.crt',
                     '.postgresql/postgresql.key', '.postgresql/root.crl')),
            'HOME_CREDENTIALS_REFUSED')
    require(Path(CA_FILE).is_file(), 'CA_UNAVAILABLE')
    try:
        pin = json.loads(Path(__file__).with_name('production-pin.json').read_text())
    except Exception:
        raise Fault('PIN_MISMATCH') from None
    require(pin.get('schema') == SCHEMA and pin.get('manifestTable') == MANIFEST_TABLE
            and pin.get('tablePrefix') == 'govt_' and pin.get('manifestSha256') == MANIFEST_SHA
            and pin.get('readOnly') is True and pin.get('sqliteFallback') is False, 'PIN_MISMATCH')


def safe_error(error):
    if isinstance(error, Fault):
        return error.code
    # SQLSTATE only, never exception names/messages/details/provider fields.
    return {'42P01': 'RELATION_UNVERIFIED', '42703': 'COLUMN_UNVERIFIED', '42501': 'READ_DENIED',
            '57014': 'TOTAL_TIMEOUT'}.get(getattr(error, 'sqlstate', None), 'QUERY_UNAVAILABLE')


def quote(value):
    # Called exclusively with hard-coded names from FIELDS or pinned constants.
    return '"' + value.replace('"', '""') + '"'


class _Session:
    def __init__(self, db):
        self.db, self.started, self.queries, self.bytes = db, time.monotonic(), 0, 0

    def _check_budget(self):
        require(time.monotonic() - self.started < TOTAL_SECONDS, 'TOTAL_TIMEOUT')
        self.queries += 1
        require(self.queries <= MAX_QUERIES, 'QUERY_LIMIT')

    def command(self, sql):
        """Fixed transaction controls must not be mistaken for SELECT results."""
        self._check_budget()
        with self.db.cursor() as cursor:
            cursor.execute(sql)
            require(cursor.description is None, 'INVALID_METADATA')

    def query(self, sql, values=(), cap=MAX_ROWS, *, expected_columns):
        self._check_budget()
        with self.db.cursor() as cursor:
            cursor.execute(sql, values)
            require(cursor.description is not None, 'INVALID_METADATA')
            try:
                names = tuple(column.name for column in cursor.description)
            except (AttributeError, TypeError):
                raise Fault('INVALID_METADATA') from None
            # Validate the exact fixed projection before fetching, including
            # zero-row results. Never infer columns from rows or accept extras.
            require(all(isinstance(name, str) for name in names) and
                    len(names) == len(set(names)) and names == expected_columns,
                    'INVALID_METADATA')
            rows = cursor.fetchmany(cap + 1)
        require(len(rows) <= cap, 'ROW_LIMIT')
        require(all(isinstance(row, (tuple, list)) and len(row) == len(names) for row in rows),
                'INVALID_METADATA')
        result = [dict(zip(names, row)) for row in rows]
        try:
            size = len(json.dumps(result, ensure_ascii=False, allow_nan=False).encode())
        except (TypeError, ValueError, UnicodeError, RecursionError):
            raise Fault('INVALID_METADATA') from None
        self.bytes += size
        require(self.bytes <= MAX_BYTES, 'BYTE_LIMIT')
        return result


def _projection(storage, table):
    expressions = []
    for name, kind in FIELDS[table].items():
        col = quote(name)
        if storage[table][name] == 'tagged':
            # Same typed tags as import.py/production_reader.py; malformed tags
            # cause a read failure, never a false/NULL authorization decision.
            typ = 'bigint' if kind == 'integer' else 'text'
            col = (f"CASE WHEN {col} IS NULL OR ({col}->>'t'='null' AND {col}->'v'='null'::jsonb) "
                   f"THEN NULL::{typ} WHEN {col}->>'t'='{kind}' AND jsonb_typeof({col}->'v')='string' "
                   f"THEN ({col}->>'v')::{typ} ELSE (1/(length({col}::text)-length({col}::text)))::{typ} END")
        # Do not silently truncate private strings or contracts. Too-large
        # selected values cause an exception without returning their contents.
        if kind == 'text':
            col = (f'CASE WHEN octet_length({col})<={MAX_FIELD} THEN {col} '
                   f'ELSE (1/(length({col})-length({col})))::text END')
        expressions.append(col + ' AS ' + quote(name))
    return ','.join(expressions)


def _select(session, storage, table, filters):
    """Private compiler; filter names and groups are fixed at call sites below."""
    require(table in FIELDS and filters, 'CONFIGURATION_UNAVAILABLE')
    values, clauses = [], []
    for name, items in filters:
        require(name in FIELDS[table] and isinstance(items, (tuple, list)), 'CONFIGURATION_UNAVAILABLE')
        require(len(items) <= MAX_ROWS, 'ROW_LIMIT')
        if items:
            values.extend(items)
            clauses.append(quote(name) + ' IN (' + ','.join('%s' for _ in items) + ')')
    if not clauses:
        return []
    sql = (f'SELECT {",".join(quote(k) for k in FIELDS[table])} FROM '
           f'(SELECT {_projection(storage, table)} FROM {quote(SCHEMA)}.{quote("govt_" + table)}) '
           f'AS scoped WHERE ({" OR ".join(clauses)}) LIMIT {MAX_ROWS + 1}')
    rows = session.query(sql, values, expected_columns=tuple(FIELDS[table]))
    if 'id' in FIELDS[table]:
        require(len({r['id'] for r in rows}) == len(rows), 'IDENTITY_AMBIGUOUS')
    for row in rows:
        for key, kind in FIELDS[table].items():
            value = row[key]
            require(value is None or (kind == 'integer' and type(value) is int) or
                    (kind == 'text' and isinstance(value, str) and len(value.encode()) <= MAX_FIELD),
                    'INVALID_METADATA')
        # Validate returned scopes as well as the query. Unknown outputs do
        # not become evidence when a fixture/driver or relation is malformed.
        require(any(row[k] in items for k, items in filters), 'INVALID_METADATA')
    return rows


def _ids(rows, key):
    values = {row[key] for row in rows if row[key] is not None}
    require(all(type(v) is int and 0 < v <= 2**63 - 1 for v in values), 'INVALID_METADATA')
    require(len(values) <= MAX_ROWS, 'ROW_LIMIT')
    return sorted(values)


def _read_snapshot(db, expected_hash):
    """Internal dependency seam for synthetic tests; never an executable API."""
    session = _Session(db)
    result = None
    failure = None
    try:
        session.command('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY')
        session.command('SET LOCAL search_path=pg_catalog')
        session.command("SET LOCAL statement_timeout='30s'")
        session.command("SET LOCAL lock_timeout='3s'")
        session.command("SET LOCAL idle_in_transaction_session_timeout='15s'")
        readonly = session.query("SELECT current_setting('transaction_read_only') AS readonly", cap=1,
                                 expected_columns=('readonly',))
        require(readonly == [{'readonly': 'on'}], 'READONLY_UNVERIFIED')
        manifest = session.query(
            f'SELECT manifest_sha256,CASE WHEN octet_length(manifest::text)<={MAX_BYTES} '
            f'THEN manifest ELSE NULL END AS manifest FROM {quote(SCHEMA)}.{quote(MANIFEST_TABLE)} LIMIT 2', cap=1,
            expected_columns=('manifest_sha256', 'manifest'))
        storage = validate_manifest(manifest, expected_hash)
        route_rows = _select(session, storage, 'route_registry', [('route_path', ROUTES)])
        screens = _select(session, storage, 'screens', [
            ('route_path', ROUTES), ('screen_code', tuple(c for pair in CODE_PAIRS for c in pair)),
            ('id', _ids(route_rows, 'screen_id'))])
        screen_ids = _ids(screens, 'id')
        ownership = _select(session, storage, 'route_registry', [('screen_id', screen_ids)])
        grants = _select(session, storage, 'role_screen_permissions', [('screen_id', screen_ids)])
        links = _select(session, storage, 'screen_api_links', [('screen_id', screen_ids)])
        mapping = _select(session, storage, 'screen_api_map', [('screen_id', screen_ids)])
        # screen_api_map has conflicting historical FK domains (apis versus
        # api_registry). Do not treat equal numeric IDs as api_endpoints links.
        endpoints = _select(session, storage, 'api_endpoints', [
            ('id', _ids(links, 'api_id')), ('route_path', SOURCE_API_PATHS)])
        endpoint_ids = _ids(endpoints, 'id')
        registry = _select(session, storage, 'api_endpoint_registry', [('api_id', endpoint_ids)])
        api_grants = _select(session, storage, 'api_permissions', [('api_id', endpoint_ids)])
        role_ids = sorted(set(_ids(screens + route_rows + ownership + grants + api_grants, 'role_id')))
        roles = _select(session, storage, 'roles', [('id', role_ids)])
        inventory = _select(session, storage, 'runtime_catalog_permissions', [('role_id', role_ids)])
        artifacts = _select(session, storage, 'runtime_artifacts', [('id', _ids(api_grants, 'runtime_artifact_id'))])
        result = dict(screens=screens, routes=route_rows, ownership=ownership, grants=grants,
                      links=links, mapping=mapping, endpoints=endpoints, registry=registry,
                      api_grants=api_grants, roles=roles, inventory=inventory, artifacts=artifacts)
    except Exception as error:
        failure = safe_error(error)
    finally:
        try:
            # Always attempt rollback, even when BEGIN or a later SELECT fails.
            with db.cursor() as cursor:
                cursor.execute('ROLLBACK')
                require(cursor.description is None, 'ROLLBACK_UNVERIFIED')
        except Exception:
            failure = 'ROLLBACK_UNVERIFIED'
    if failure:
        raise Fault(failure) from None
    return result


def _identity(rows):
    if not rows:
        return 'ABSENT'
    if len(rows) != 1:
        return 'AMBIGUOUS'
    if type(rows[0].get('id')) is not int or rows[0]['id'] <= 0 or any(
            not isinstance(rows[0][k], str) or not rows[0][k].strip()
            for k in ('screen_code', 'role_code') if k in rows[0]):
        return 'IDENTITY_UNVERIFIED'
    if rows[0].get('active') == 0:
        return 'INACTIVE'
    if rows[0].get('active') != 1:
        return 'ACTIVE_UNVERIFIED'
    return 'EXACT_ACTIVE'


def _strict_json(value):
    def pairs(items):
        result = {}
        for key, item in items:
            if key in result:
                raise ValueError('Duplicate key')
            result[key] = item
        return result
    def constant(_value):
        raise ValueError('Non-finite number')
    def finite_float(value):
        number = float(value)
        if not math.isfinite(number):
            raise ValueError('Number outside finite range')
        return number
    return json.loads(value, object_pairs_hook=pairs, parse_constant=constant, parse_float=finite_float)


def _schema_state(value):
    if value is None or value == '':
        return 'ABSENT'
    try:
        parsed = _strict_json(value)
    except (ValueError, TypeError, RecursionError):
        return 'INVALID_JSON'
    # Syntax only. No remote refs are followed; no examples/defaults are printed.
    if not isinstance(parsed, dict) or not parsed:
        return 'SHAPE_UNVERIFIED'
    if parsed in ({'type': 'object'}, {'type': 'object', 'properties': {'id': {'type': 'integer'}}}):
        return 'GENERIC_SHAPE_UNVERIFIED'
    return 'OBJECT_PRESENT_UNVERIFIED'


def _role_state(snapshot, role_id):
    return _identity([r for r in snapshot['roles'] if r['id'] == role_id])


def _screen_grant_state(snapshot, screen_id):
    rows = [r for r in snapshot['grants'] if r['screen_id'] == screen_id]
    if not rows:
        return 'NO_ROWS'
    if len({r['role_id'] for r in rows}) != len(rows):
        return 'AMBIGUOUS'
    if any(_role_state(snapshot, r['role_id']) != 'EXACT_ACTIVE' or
           any(r[k] not in (0, 1) for k in ('can_view', 'can_create', 'can_edit', 'can_delete', 'can_export'))
           for r in rows):
        return 'ROLE_OR_FLAGS_UNVERIFIED'
    return 'VIEW_GRANT_PRESENT' if any(r['can_view'] == 1 for r in rows) else 'EXPLICIT_VIEW_DENIAL_ONLY'


def _screen_role_states(snapshot, screen_id):
    return sorted({_role_state(snapshot, g['role_id']) for g in snapshot['grants']
                   if g['screen_id'] == screen_id})


def _api_summary(snapshot, screen_id):
    links = [r for r in snapshot['links'] if r['screen_id'] == screen_id]
    ids = sorted({r['api_id'] for r in links if type(r['api_id']) is int})
    reasons, contracts, role_states = set(), [], set()
    if not links:
        reasons.add('NO_LINKED_API')
    if any(r['screen_id'] == screen_id for r in snapshot['mapping']):
        reasons.add('SCREEN_API_MAP_ID_DOMAIN_UNVERIFIED')
    if len(ids) != len({r['api_id'] for r in links}):
        reasons.add('LINK_ID_UNVERIFIED')
    for source in ('links', 'mapping'):
        rows = [r for r in snapshot[source] if r['screen_id'] == screen_id]
        if len({r['api_id'] for r in rows}) != len(rows):
            reasons.add('DUPLICATE_API_LINK')
    for aid in ids:
        endpoints = [a for a in snapshot['endpoints'] if a['id'] == aid]
        if len(endpoints) != 1:
            reasons.add('ENDPOINT_ABSENT' if not endpoints else 'ENDPOINT_AMBIGUOUS')
            continue
        endpoint = endpoints[0]
        contracts.append({'request': _schema_state(endpoint['request_schema']),
                          'response': _schema_state(endpoint['response_schema'])})
        if any(not isinstance(endpoint[k], str) or not endpoint[k].strip()
               for k in ('endpoint_code', 'route_path', 'http_method', 'permission_key', 'service_name', 'api_version', 'rate_limit_key')):
            reasons.add('ENDPOINT_IDENTITY_OR_POLICY_UNVERIFIED')
        if endpoint['http_method'] not in ('GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS', 'TRACE') or not (
                isinstance(endpoint['route_path'], str) and endpoint['route_path'].startswith('/') and
                '?' not in endpoint['route_path'] and '#' not in endpoint['route_path']):
            reasons.add('ENDPOINT_ROUTE_OR_METHOD_UNVERIFIED')
        if endpoint['auth_required'] != 1:
            reasons.add('API_AUTHENTICATION_UNVERIFIED')
        if _schema_state(endpoint['request_schema']) != 'OBJECT_PRESENT_UNVERIFIED':
            reasons.add('REQUEST_CONTRACT_UNVERIFIED')
        if _schema_state(endpoint['response_schema']) != 'OBJECT_PRESENT_UNVERIFIED':
            reasons.add('RESPONSE_CONTRACT_UNVERIFIED')
        same_operation = [a for a in snapshot['endpoints'] if (a['app_id'], a['http_method'], a['route_path']) ==
                          (endpoint['app_id'], endpoint['http_method'], endpoint['route_path'])]
        if len(same_operation) != 1:
            reasons.add('ENDPOINT_OPERATION_AMBIGUOUS')
        registry = [r for r in snapshot['registry'] if r['api_id'] == aid]
        if not registry:
            reasons.add('API_REGISTRY_ABSENT')
        if len(registry) > 1:
            reasons.add('API_REGISTRY_AMBIGUOUS')
        if any((r['method'], r['endpoint_path']) != (endpoint['http_method'], endpoint['route_path']) for r in registry):
            reasons.add('API_REGISTRY_IDENTITY_CONFLICT')
        grants = [g for g in snapshot['api_grants'] if g['api_id'] == aid]
        if not grants:
            reasons.add('NO_API_GRANT_ROWS')
        if len({(g['role_id'], g['runtime_artifact_id'], g['permission_key']) for g in grants}) != len(grants):
            reasons.add('API_GRANT_AMBIGUOUS')
        for grant in grants:
            key = grant['permission_key']
            direct = bool(key) and key == endpoint['permission_key'] and not key.startswith('api_permission_')
            origins = [r for r in registry if key == 'api_permission_' + str(r['endpoint_code'])]
            legacy = len(origins) == 1 and (origins[0]['method'], origins[0]['endpoint_path']) == (endpoint['http_method'], endpoint['route_path'])
            if not direct and not legacy:
                reasons.add('API_GRANT_IDENTITY_UNVERIFIED')
            if not direct and legacy:
                reasons.add('LEGACY_API_GRANT_REQUIRES_RECONCILIATION')
            role_state = _role_state(snapshot, grant['role_id'])
            role_states.add(role_state)
            if role_state != 'EXACT_ACTIVE' or grant['can_access'] not in (0, 1):
                reasons.add('API_GRANT_ROLE_OR_FLAG_UNVERIFIED')
            if grant['runtime_artifact_id'] is not None and len([a for a in snapshot['artifacts'] if a['id'] == grant['runtime_artifact_id']]) != 1:
                reasons.add('API_ARTIFACT_REFERENCE_UNVERIFIED')
        if grants and all(g['can_access'] == 0 for g in grants):
            reasons.add('EXPLICIT_API_DENIAL_ONLY')
    # Presence never means business authority or deployability.
    return {'linkedApiCount': len(ids), 'metadataReasons': sorted(reasons),
            'contractMetadataStates': contracts,
            'grantRoleIdentityStates': sorted(role_states),
            'operationUniquenessVerified': False,
            'contractSemanticsVerified': False, 'tenantAuthorizationVerified': False,
            'runtimeConnectivityVerified': False, 'activeEndpointStateVerified': False}


def attestation(snapshot, *, production=False):
    """Allowlisted public projection. No source value is copied except fixed routes."""
    route_results = []
    for index, path in enumerate(ROUTES):
        if index == 6:
            route_results.append({'route': path, 'classification': 'NONBUSINESS_FALLBACK',
                                  'authorityEstablished': False,
                                  'metadataUnexpectedlyPresent': any(s['route_path'] == path for s in snapshot['screens']) or
                                  any(r['route_path'] == path for r in snapshot['routes'])})
            continue
        direct = [s for s in snapshot['screens'] if s['route_path'] == path]
        owners = [r for r in snapshot['routes'] if r['route_path'] == path]
        reasons = set()
        screen_state = _identity(direct)
        ownership_state = _identity(owners)
        if screen_state != 'EXACT_ACTIVE':
            reasons.add('SCREEN_' + screen_state)
        if ownership_state != 'EXACT_ACTIVE':
            reasons.add('ROUTE_' + ownership_state)
        if len(direct) == 1 and len(owners) == 1:
            screen, owner = direct[0], owners[0]
            if (screen['id'], screen['app_id'], screen['role_id']) != (owner['screen_id'], owner['app_id'], owner['role_id']):
                reasons.add('ROUTE_OWNERSHIP_CONFLICT')
            if owner['auth_required'] != 1 or owner['role_guard_required'] != 1 or not owner['permission_required']:
                reasons.add('ROUTE_GUARD_METADATA_UNVERIFIED')
            owner_role_state = _role_state(snapshot, owner['role_id'])
            if owner_role_state != 'EXACT_ACTIVE':
                reasons.add('OWNER_ROLE_' + owner_role_state)
        item = {'route': path, 'screenIdentity': screen_state, 'routeOwnership': ownership_state,
                'authorityEstablished': False, 'tenantAuthorizationVerified': False,
                'runtimeAuthorizationVerified': False, 'appIdentityVerified': False}
        if len(owners) == 1:
            item['ownerRoleIdentity'] = _role_state(snapshot, owners[0]['role_id'])
        if index >= 3:
            pair = CODE_PAIRS[index - 3]
            states = [_identity([s for s in snapshot['screens'] if s['screen_code'] == code]) for code in pair]
            item['sourceIdentityCandidates'] = {'ceo': states[0], 'importedGenerated': states[1]}
            item['sourceCandidateMetadata'] = {}
            for label, code in zip(('ceo', 'importedGenerated'), pair):
                candidates = [s for s in snapshot['screens'] if s['screen_code'] == code]
                if len(candidates) == 1:
                    sid = candidates[0]['id']
                    item['sourceCandidateMetadata'][label] = {
                        'screenGrantMetadata': _screen_grant_state(snapshot, sid),
                        'screenGrantRoleIdentityStates': _screen_role_states(snapshot, sid),
                        'apis': _api_summary(snapshot, sid)}
            # A registered native path is insufficient to reconcile the source
            # import/controller mismatch. No data-driven alias is manufactured.
            reasons.add('CEO_GENERATED_SOURCE_MAPPING_UNRESOLVED')
            if all(state == 'EXACT_ACTIVE' for state in states):
                reasons.add('DISTINCT_CEO_AND_GENERATED_IDENTITIES_PRESENT')
            observed = [a for a in snapshot['endpoints'] if a['route_path'] == SOURCE_API_PATHS[index - 3] and a['http_method'] == 'GET']
            item['sourceListApiIdentity'] = 'ABSENT' if not observed else 'SINGLE_RECORD_UNVERIFIED' if len(observed) == 1 else 'AMBIGUOUS'
        if len(direct) == 1:
            same_code = [s for s in snapshot['screens'] if s['screen_code'] == direct[0]['screen_code']]
            if len(same_code) != 1:
                reasons.add('SCREEN_CODE_AMBIGUOUS')
            all_owners = [r for r in snapshot['ownership'] if r['screen_id'] == direct[0]['id']]
            if len(all_owners) > 1:
                reasons.add('MULTIPLE_OWNERSHIP_RECORDS_REVIEW_REQUIRED')
            if any((o['app_id'], o['role_id']) != (direct[0]['app_id'], direct[0]['role_id']) for o in all_owners):
                reasons.add('LINKED_ROUTE_OWNERSHIP_CONFLICT')
            item['screenGrantMetadata'] = _screen_grant_state(snapshot, direct[0]['id'])
            item['screenGrantRoleIdentityStates'] = _screen_role_states(snapshot, direct[0]['id'])
            item['apis'] = _api_summary(snapshot, direct[0]['id'])
            if index < 3:
                view_roles = {g['role_id'] for g in snapshot['grants'] if g['screen_id'] == direct[0]['id'] and g['can_view'] == 1}
                policies = [p for p in snapshot['inventory'] if p['role_id'] in view_roles]
                item['inventoryPolicyMetadata'] = ('PRESENT_REQUIRES_SCOPE_REVIEW' if view_roles and
                    all(len([p for p in policies if p['role_id'] == role and p['can_view_inventory'] == 1]) == 1 for role in view_roles)
                    else 'UNVERIFIED')
        else:
            item['screenGrantMetadata'] = 'IDENTITY_UNVERIFIED'
        item['reasons'] = sorted(reasons)
        route_results.append(item)
    return {'format': 'primecare-fixed-authority-attestation-v1',
            'evidenceMode': 'production-metadata-read-only' if production else 'synthetic-fixture-only',
            'productionAuthorityEstablished': False, 'releaseReady': False, 'writes': 0,
            'routes': route_results}


def failure_attestation(code):
    return {'format': 'primecare-fixed-authority-attestation-v1', 'status': 'UNVERIFIED',
            'reason': code if code in FAULTS else 'QUERY_UNAVAILABLE',
            'productionAuthorityEstablished': False, 'releaseReady': False, 'writes': 0}


def main():
    db = None
    output = None
    timed_out = False
    def timeout(_signum, _frame):
        nonlocal timed_out
        if timed_out:
            # Hard exit after the bounded rollback/close grace. No secret or
            # provider exception enters this last-resort fixed receipt.
            os.write(1, (json.dumps(failure_attestation('TOTAL_TIMEOUT')) + '\n').encode())
            os._exit(1)
        timed_out = True
        signal.alarm(5)
        raise Fault('TOTAL_TIMEOUT')
    try:
        require(len(sys.argv) == 1, 'ARGUMENTS_REFUSED')
        require(hasattr(signal, 'SIGALRM'), 'CONFIGURATION_UNAVAILABLE')
        signal.signal(signal.SIGALRM, timeout)
        signal.alarm(TOTAL_SECONDS - 5)
        config = production_config(os.environ)
        validate_local_configuration(os.environ)
        try:
            import psycopg
        except Exception:
            raise Fault('DEPENDENCY_UNAVAILABLE') from None
        try:
            db = psycopg.connect(**config)
        except Exception as error:
            code = 'CONNECTION_DENIED' if getattr(error, 'sqlstate', None) in ('28P01', '28000') else 'CONNECTION_UNVERIFIED'
            raise Fault(code) from None
        require(getattr(db.pgconn, 'ssl_in_use', False) is True, 'TLS_UNVERIFIED')
        output = attestation(_read_snapshot(db, MANIFEST_SHA), production=True)
        output.update(status='METADATA_READ_COMPLETED', tlsCertificateVerificationRequired=True,
                      manifestJsonIntegrityVerified=True, readOnlySnapshotVerified=True,
                      rollbackVerified=True, trustedExecutionProvenanceVerified=False)
    except Exception as error:
        output = failure_attestation(safe_error(error))
    finally:
        if db is not None:
            try:
                db.close()
            except Exception:
                output = failure_attestation('CLOSE_UNVERIFIED')
        signal.alarm(0)
    print(json.dumps(output, sort_keys=True, separators=(',', ':')))
    return 0 if output.get('status') == 'METADATA_READ_COMPLETED' else 1


if __name__ == '__main__':
    raise SystemExit(main())
