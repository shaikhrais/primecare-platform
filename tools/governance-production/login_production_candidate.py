"""Inactive fixed-scope Login production metadata candidate.

No connect(), environment variables, secret binding or executable CLI.
Public entrypoint uses a fixed target/schema/manifest pin and returns status only.
Private fixture seam is never a production entrypoint. This does not establish
tenant identity, live relation trust, effective privileges or policy authority.
"""
import hashlib
import json
import math
import time

SCHEMA = 'governance_68b0b02dd1215f58630d2c1a'
MANIFEST_SHA = '68b0b02dd1215f58630d2c1aea3c5e1cfd488a9cbcfe5c96bea9dcfd89944c42'
MAX_ROWS = 64
MAX_FIELD = 8192
MAX_BYTES = 1024 * 1024
MAX_QUERIES = 16
FIELDS = {
    'auth_route_registry': {'id': 'integer', 'route_code': 'text',
        'route_path': 'text', 'flow_type': 'text'},
    'screens': {'id': 'integer', 'app_id': 'integer', 'role_id': 'integer',
        'screen_code': 'text', 'route_path': 'text', 'actual_file_path': 'text', 'active': 'integer'},
    'apps': {'id': 'integer', 'app_code': 'text', 'active': 'integer'},
    'screen_api_links': {'screen_id': 'integer', 'api_id': 'integer'},
    'api_endpoints': {'id': 'integer', 'app_id': 'integer', 'endpoint_code': 'text',
        'http_method': 'text', 'route_path': 'text', 'service_name': 'text',
        'auth_required': 'integer', 'permission_key': 'text', 'rate_limit_key': 'text',
        'request_schema': 'text', 'response_schema': 'text', 'implementation_status': 'text'},
    'api_endpoint_registry': {'id': 'integer', 'api_id': 'integer',
        'endpoint_code': 'text', 'method': 'text', 'endpoint_path': 'text'},
}
OPERATIONS = (
    ('credentialLogin', 'POST', '/v1/auth/login'),
    ('restoreGet', 'GET', '/v1/auth/me'),
    ('restorePost', 'POST', '/v1/auth/me'),
    ('logout', 'POST', '/v1/auth/logout'),
)
FAULTS = frozenset({'CONNECTION_UNVERIFIED', 'TLS_REQUIRED',
    'MANIFEST_UNVERIFIED', 'INVALID_METADATA', 'ROW_LIMIT', 'BYTE_LIMIT',
    'QUERY_LIMIT', 'TIME_LIMIT', 'READ_DENIED', 'RELATION_UNAVAILABLE',
    'COLUMN_UNAVAILABLE', 'QUERY_UNAVAILABLE', 'READONLY_UNVERIFIED',
    'ROLLBACK_UNVERIFIED'})


class Fault(Exception):
    def __init__(self, code):
        self.code = code if code in FAULTS else 'QUERY_UNAVAILABLE'
        super().__init__(self.code)


def require(value, reason):
    if not value:
        raise Fault(reason)


def canonical(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2,
                       allow_nan=False) + '\n').encode()


def _manifest(rows, expected_hash):
    require(len(rows) == 1, 'MANIFEST_UNVERIFIED')
    value = rows[0]['manifest']
    require(isinstance(value, dict) and
            value.get('format') == 'primecare-governance-snapshot-v1' and
            value.get('syntheticOnly') is not True, 'MANIFEST_UNVERIFIED')
    require(rows[0]['manifest_sha256'] == expected_hash and
            hashlib.sha256(canonical(value)).hexdigest() == expected_hash,
            'MANIFEST_UNVERIFIED')
    tables = value.get('tables')
    require(isinstance(tables, list) and all(isinstance(t, dict) and
            isinstance(t.get('name'), str) for t in tables), 'MANIFEST_UNVERIFIED')
    require(len({t['name'] for t in tables}) == len(tables), 'MANIFEST_UNVERIFIED')
    by_table = {t['name']: t for t in tables}
    storage = {}
    for table, fields in FIELDS.items():
        require(table in by_table, 'MANIFEST_UNVERIFIED')
        columns = by_table[table].get('columns')
        require(isinstance(columns, list) and all(isinstance(c, dict) and
                isinstance(c.get('name'), str) for c in columns), 'MANIFEST_UNVERIFIED')
        require(len({c['name'] for c in columns}) == len(columns), 'MANIFEST_UNVERIFIED')
        by_column = {c['name']: c for c in columns}
        storage[table] = {}
        for name, kind in fields.items():
            require(name in by_column, 'MANIFEST_UNVERIFIED')
            types = by_column[name].get('storage_types')
            require(types == [] or types == [kind], 'MANIFEST_UNVERIFIED')
            storage[table][name] = not types
    return storage


def _safe_error(error):
    if isinstance(error, Fault):
        return error.code
    return {'42501': 'READ_DENIED', '42P01': 'RELATION_UNAVAILABLE',
            '42703': 'COLUMN_UNAVAILABLE', '57014': 'TIME_LIMIT'}.get(
                getattr(error, 'sqlstate', None), 'QUERY_UNAVAILABLE')


def _quote(value):
    return '"' + value.replace('"', '""') + '"'


class _Session:
    def __init__(self, db):
        self.db, self.queries, self.bytes, self.start = db, 0, 0, time.monotonic()

    def _budget(self):
        self.queries += 1
        require(self.queries <= MAX_QUERIES, 'QUERY_LIMIT')
        require(time.monotonic() - self.start < 30, 'TIME_LIMIT')

    def command(self, text):
        self._budget()
        with self.db.cursor() as cur:
            cur.execute(text)
            require(cur.description is None, 'INVALID_METADATA')

    def query(self, text, values, names, cap=MAX_ROWS):
        self._budget()
        with self.db.cursor() as cur:
            cur.execute(text, values)
            require(cur.description is not None, 'INVALID_METADATA')
            actual = tuple(c.name for c in cur.description)
            require(actual == names and len(set(actual)) == len(actual), 'INVALID_METADATA')
            rows = cur.fetchmany(cap + 1)
        require(len(rows) <= cap, 'ROW_LIMIT')
        require(all(len(r) == len(names) for r in rows), 'INVALID_METADATA')
        result = [dict(zip(names, row)) for row in rows]
        try:
            self.bytes += len(canonical(result))
        except (TypeError, ValueError, RecursionError, UnicodeError):
            raise Fault('INVALID_METADATA') from None
        require(self.bytes <= MAX_BYTES, 'BYTE_LIMIT')
        return result


def _projection(table, tagged):
    out = []
    for name, kind in FIELDS[table].items():
        col = _quote(name)
        if tagged[table][name]:
            typ = 'bigint' if kind == 'integer' else 'text'
            col = (f"CASE WHEN {col} IS NULL OR ({col}->>'t'='null' AND {col}->'v'='null'::jsonb) "
                   f"THEN NULL::{typ} WHEN {col}->>'t'='{kind}' AND jsonb_typeof({col}->'v')='string' "
                   f"THEN ({col}->>'v')::{typ} ELSE (1/(length({col}::text)-length({col}::text)))::{typ} END")
        if kind == 'text':
            col = (f'CASE WHEN octet_length({col})<={MAX_FIELD} THEN {col} '
                   f'ELSE (1/(length({col})-length({col})))::text END')
        out.append(col + ' AS ' + _quote(name))
    return ','.join(out)


def _select(session, tagged, table, groups):
    # Fixed caller groups only; public API accepts neither SQL nor filters.
    values, predicates = [], []
    for pairs in groups:
        terms = []
        for field, items in pairs:
            require(field in FIELDS[table] and len(items) <= MAX_ROWS, 'INVALID_METADATA')
            if not items:
                terms = []
                break
            terms.append(_quote(field) + ' IN (' + ','.join('%s' for _ in items) + ')')
        if terms:
            predicates.append('(' + ' AND '.join(terms) + ')')
            values.extend(value for _, items in pairs for value in items)
    if not predicates:
        return []
    names = tuple(FIELDS[table])
    sql = (f'SELECT {",".join(map(_quote, names))} FROM '
           f'(SELECT {_projection(table, tagged)} FROM "{SCHEMA}"."govt_{table}") '
           f'AS scoped WHERE {" OR ".join(predicates)} LIMIT {MAX_ROWS + 1}')
    rows = session.query(sql, values, names)
    for row in rows:
        for key, kind in FIELDS[table].items():
            value = row[key]
            require(value is None or (kind == 'integer' and type(value) is int) or
                    (kind == 'text' and isinstance(value, str) and len(value.encode()) <= MAX_FIELD),
                    'INVALID_METADATA')
        require(any(all(row[key] in items for key, items in group) for group in groups), 'INVALID_METADATA')
        if 'id' in FIELDS[table]:
            require(type(row['id']) is int and 0 < row['id'] < 2**63, 'INVALID_METADATA')
    return rows


def _ids(rows, name):
    values = {row[name] for row in rows if row[name] is not None}
    require(all(type(v) is int and 0 < v < 2**63 for v in values), 'INVALID_METADATA')
    require(len(values) <= MAX_ROWS, 'ROW_LIMIT')
    return sorted(values)


def read_candidate(db):
    """No connection creation. Caller must separately approve protected execution.

    These checks constrain connection options, not tenant identity or privileges.
    No raw snapshot escapes this API; failures have fixed codes only.
    """
    try:
        info = db.info
        require(info.host == 'pooled.db.prisma.io' and info.port == 5432 and
                info.dbname == 'postgres', 'CONNECTION_UNVERIFIED')
        require(db.pgconn.ssl_in_use is True, 'TLS_REQUIRED')
        options = info.get_parameters()
        require(options.get('sslmode') == 'verify-full' and
                options.get('sslrootcert') == '/etc/ssl/certs/ca-certificates.crt' and
                not options.get('hostaddr') and not options.get('service') and
                options.get('gssencmode') == 'disable', 'TLS_REQUIRED')
        require(db.autocommit is True and
                int(info.transaction_status) == 0, 'READONLY_UNVERIFIED')
        return _read_snapshot(db, MANIFEST_SHA)
    except Exception as error:
        raise Fault(_safe_error(error)) from None


def _read_snapshot(db, expected_hash):
    # Private seam permits synthetic fixture hashes; public API always uses pin.
    session, failure, result = _Session(db), None, None
    try:
        session.command('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY')
        session.command('SET LOCAL search_path=pg_catalog')
        session.command("SET LOCAL statement_timeout='5s'")
        session.command("SET LOCAL lock_timeout='1s'")
        session.command("SET LOCAL idle_in_transaction_session_timeout='10s'")
        require(session.query("SELECT current_setting('transaction_read_only') AS readonly",
            (), ('readonly',), 1) == [{'readonly': 'on'}], 'READONLY_UNVERIFIED')
        manifest = session.query(
            f'SELECT CASE WHEN octet_length(manifest_sha256)<=64 THEN manifest_sha256 ELSE NULL END AS manifest_sha256,'
            f'CASE WHEN octet_length(manifest::text)<={MAX_BYTES} THEN manifest ELSE NULL END AS manifest '
            f'FROM "{SCHEMA}".govt_source_manifest LIMIT 2', (), ('manifest_sha256', 'manifest'), 1)
        tagged = _manifest(manifest, expected_hash)
        routes = _select(session, tagged, 'auth_route_registry',
            [[('route_code', ['login'])], [('route_path', ['/login'])]])
        screens = _select(session, tagged, 'screens',
            [[('screen_code', ['login', 'auth_login_web'])], [('route_path', ['/login'])]])
        apps = _select(session, tagged, 'apps', [[('id', _ids(screens, 'app_id'))]])
        links = _select(session, tagged, 'screen_api_links', [[('screen_id', _ids(screens, 'id'))]])
        endpoints = _select(session, tagged, 'api_endpoints',
            [[('http_method', [method]), ('route_path', [path])] for _, method, path in OPERATIONS])
        registry = _select(session, tagged, 'api_endpoint_registry', [[('api_id', _ids(endpoints, 'id'))]])
        result = _receipt(routes, screens, apps, links, endpoints, registry)
    except Exception as error:
        failure = _safe_error(error)
    finally:
        try:
            with db.cursor() as cur:
                cur.execute('ROLLBACK')
                require(cur.description is None, 'ROLLBACK_UNVERIFIED')
        except Exception:
            failure = 'ROLLBACK_UNVERIFIED'
    if failure:
        raise Fault(failure) from None
    return result


def _screen(rows, code, apps):
    selected = [r for r in rows if r['screen_code'] == code]
    if not selected:
        return {'identity': 'ABSENT', 'sourceBinding': 'UNVERIFIED', 'appBinding': 'UNVERIFIED'}
    if len(selected) != 1 or sum(r['id'] == selected[0]['id'] for r in rows) != 1:
        return {'identity': 'AMBIGUOUS', 'sourceBinding': 'UNVERIFIED', 'appBinding': 'UNVERIFIED'}
    row = selected[0]
    state = ('ROUTE_CONFLICT' if row['route_path'] != '/login' else
             'INACTIVE' if row['active'] == 0 else 'PRESENT_UNVERIFIED' if row['active'] == 1 else 'ACTIVE_UNVERIFIED')
    expected = ('packages/primecare_ui/lib/src/features/auth/login_view.dart' if code == 'login'
                else 'websites/typescript/src/auth-screen.ts')
    owners = [a for a in apps if a['id'] == row['app_id']]
    return {'identity': state,
        'sourceBinding': 'CURRENT_SOURCE_PATH' if row['actual_file_path'] == expected else 'UNRESOLVED',
        'appBinding': 'UNIQUE_ACTIVE_UNVERIFIED' if len(owners) == 1 and owners[0]['active'] == 1 else 'UNRESOLVED'}


def _schema(value):
    if value is None:
        return 'ABSENT'
    def pairs(items):
        result = {}
        for key, item in items:
            if key in result:
                raise ValueError()
            result[key] = item
        return result
    def number(value):
        parsed = float(value)
        if not math.isfinite(parsed):
            raise ValueError()
        return parsed
    def invalid(_):
        raise ValueError()
    try:
        parsed = json.loads(value, object_pairs_hook=pairs, parse_constant=invalid, parse_float=number)
        return 'OBJECT_UNVERIFIED' if isinstance(parsed, dict) and parsed else 'GENERIC_UNVERIFIED'
    except (TypeError, ValueError, RecursionError):
        return 'INVALID_JSON'


def _receipt(routes, screens, apps, links, endpoints, registry):
    route_state = ('ABSENT' if not routes else 'AMBIGUOUS' if len(routes) != 1 else
        'PRESENT_UNVERIFIED' if (routes[0]['route_code'], routes[0]['route_path'], routes[0]['flow_type']) ==
        ('login', '/login', 'shared_credentials') else 'IDENTITY_CONFLICT')
    operations = {}
    for label, method, path in OPERATIONS:
        selected = [e for e in endpoints if (e['http_method'], e['route_path']) == (method, path)]
        unique = len(selected) == 1 and sum(e['id'] == selected[0]['id'] for e in endpoints) == 1
        item = {'identity': 'ABSENT' if not selected else 'PRESENT_UNVERIFIED' if unique else 'AMBIGUOUS',
                'policyReviewRequired': True, 'runtimeVerified': False}
        if unique:
            endpoint = selected[0]
            for key, code in (('nativeLinkObserved', 'login'), ('webLinkObserved', 'auth_login_web')):
                owners = [s for s in screens if s['screen_code'] == code]
                item[key] = len(owners) == 1 and sum(s['id'] == owners[0]['id'] for s in screens) == 1 and any(link['screen_id'] == owners[0]['id'] and
                    link['api_id'] == endpoint['id'] for link in links)
            matches = [r for r in registry if r['api_id'] == endpoint['id']]
            item['registry'] = ('ABSENT' if not matches else 'MATCHED_UNVERIFIED' if len(matches) == 1 and
                (matches[0]['endpoint_code'], matches[0]['method'], matches[0]['endpoint_path']) ==
                (endpoint['endpoint_code'], method, path) else 'IDENTITY_CONFLICT')
            item['requestSchema'] = _schema(endpoint['request_schema'])
            item['responseSchema'] = _schema(endpoint['response_schema'])
        operations[label] = item
    selected_ids = {e['id'] for e in endpoints}
    return {'evidenceMode': 'login-metadata-unverified',
        'productionAuthorityEstablished': False, 'releaseReady': False,
        'contractComplete': False, 'nativeWebEquivalenceEstablished': False,
        'routeMetadata': route_state,
        'native': _screen(screens, 'login', apps),
        'web': _screen(screens, 'auth_login_web', apps),
        'unresolvedScreenCount': sum(r['screen_code'] not in ('login', 'auth_login_web') for r in screens),
        'unresolvedApiLinkCount': sum(r['api_id'] not in selected_ids for r in links),
        'operations': operations}


if __name__ == '__main__':
    raise SystemExit('Candidate library only: no credential connection or CLI is provided')
