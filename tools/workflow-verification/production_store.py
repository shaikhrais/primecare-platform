"""Explicit, transaction-bound PostgreSQL store for workflow execution tracking.

No DDL, business-table writes, grant changes or general SQL write interface.
The original import's row ordinal remains its physical primary key. Serial table
locks and checked natural keys preserve identities without rewriting the snapshot.
"""
import datetime
import json
import os
import re
import sys
from pathlib import Path
from urllib.parse import urlsplit, unquote

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'governance-production'))
from production_reader import Connection as Reader, GovernanceReadError

PIN = Path(__file__).resolve().parents[1] / 'governance-production/production-pin.json'
KEYS = {
    'virtual_workflow_definitions': ('flow_id',),
    'virtual_workflow_attempts': ('attempt_id',),
    'virtual_workflow_issues': ('issue_id',),
    'virtual_workflow_evidence': ('evidence_id',),
    'virtual_workflow_issue_resolutions': ('issue_id', 'attempt_id'),
    'virtual_workflow_checkpoints': ('flow_id',),
    'virtual_flow_catalog_snapshots': ('name',),
}
INSERTS = {
    'virtual_workflow_attempts': ('flow_id', 'definition_sha256', 'requested_status', 'test_status', 'scope', 'source_bindings_json', 'gate_result_json', 'result_json'),
    'virtual_workflow_issues': ('attempt_id', 'criterion_id', 'reproduction', 'expected_text', 'actual_text', 'affected_sources_json'),
    'virtual_workflow_evidence': ('attempt_id', 'kind', 'path', 'sha256', 'url'),
    'virtual_workflow_issue_resolutions': ('issue_id', 'attempt_id', 'resolution_note'),
    'virtual_workflow_checkpoints': ('flow_id', 'attempt_id', 'next_action'),
}
UPDATES = {
    'virtual_workflow_definitions': ('verification_status', 'test_status', 'blocker_json', 'updated_at'),
    'virtual_workflow_checkpoints': ('invalidation_json', 'updated_at'),
}


def quote(name):
    return '"' + name.replace('"', '""') + '"'


class Result:
    def __init__(self, rows=(), *, lastrowid=None):
        self.rows = list(rows)
        self.lastrowid = lastrowid
    def fetchone(self):
        return self.rows.pop(0) if self.rows else None
    def fetchall(self):
        rows, self.rows = self.rows, []
        return rows
    def __iter__(self):
        return iter(self.rows)


class ProductionWorkflowStore:
    is_production_workflow_store = True
    in_transaction = True

    def __init__(self, *, _test_connection=None):
        self.pin = json.loads(PIN.read_text())
        scope = self.pin.get('workflowTrackingWriter', {})
        if (set(scope.get('tables', [])) != set(KEYS) or scope.get('schemaChanges') is not False
                or scope.get('businessDataWrites') is not False
                or scope.get('optInVariable') != 'GOVERNANCE_WORKFLOW_WRITES'):
            raise GovernanceReadError('Workflow write scope is not explicitly pinned')
        self.db = None
        if _test_connection is not None:
            if (os.environ.get('GOVERNANCE_ALLOW_TEST_FIXTURE') != '1'
                    or os.environ.get('NODE_ENV') != 'test'
                    or os.environ.get('GOVERNANCE_DATABASE_URL')
                    or os.environ.get('PRODUCTION_DATABASE_URL')):
                raise GovernanceReadError('Explicit isolated PostgreSQL fixture mode required')
            self.db = _test_connection
        else:
            if os.environ.get('GOVERNANCE_WORKFLOW_WRITES') != '1':
                raise GovernanceReadError('Explicit GOVERNANCE_WORKFLOW_WRITES=1 required')
            if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES') == '1':
                raise GovernanceReadError('Production writes cannot use SQLite fixture mode')
            primary, existing = os.environ.get('GOVERNANCE_DATABASE_URL'), os.environ.get('PRODUCTION_DATABASE_URL')
            if primary and existing and primary != existing:
                raise GovernanceReadError('Conflicting governance database configuration')
            url = urlsplit(primary or existing or '')
            if url.scheme not in ('postgres', 'postgresql') or url.hostname != 'pooled.db.prisma.io' or url.path != '/postgres':
                raise GovernanceReadError('Missing or unexpected production governance target')
            import psycopg
            # Prisma pooler URLs may contain client-only query flags (e.g. pgbouncer).
            # Bind parsed credentials/target explicitly and keep TLS verification mandatory.
            self.db = psycopg.connect(host=url.hostname, port=url.port or 5432,
                dbname='postgres', user=unquote(url.username or ''), password=unquote(url.password or ''),
                sslmode='verify-full', sslrootcert='system', connect_timeout=10, prepare_threshold=None)
        try:
            self.db.execute("SET LOCAL lock_timeout='10s'")
            self.db.execute("SET LOCAL statement_timeout='120s'")
            row = self.db.execute('SELECT manifest_sha256,manifest FROM ' + self.table('source_manifest')).fetchall()
            if len(row) != 1 or row[0][0] != self.pin['manifestSha256']:
                raise GovernanceReadError('Production governance manifest mismatch')
            self.manifest = row[0][1]
            self.tables = {t['name']: t for t in self.manifest['tables']}
            # Locks also serialize non-cooperating SQL writers, not just this client.
            self.db.execute('LOCK TABLE ' + ','.join(self.table(t) for t in sorted(KEYS)) + ' IN SHARE ROW EXCLUSIVE MODE')
            self._check_schema_and_keys()
            self.reader = Reader.__new__(Reader)
            self.reader.pin = self.pin
            self.reader.tables = {k.lower(): v for k, v in self.tables.items()}
        except Exception:
            self.db.rollback()
            self.db.close()
            raise

    def table(self, name):
        return quote(self.pin['schema']) + '.' + quote('govt_' + name)

    def _check_schema_and_keys(self):
        for table, keys in KEYS.items():
            metadata = self.tables.get(table)
            if not metadata:
                raise GovernanceReadError('Missing registered tracking table: ' + table)
            actual = dict(self.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s', (self.pin['schema'], 'govt_' + table)).fetchall())
            expected = {'_primecare_import_row': 'bigint'}
            for col in metadata['columns']:
                kinds = col['storage_types']
                if len(kinds) > 1:
                    raise GovernanceReadError('Mixed tracking storage requires migration')
                expected[col['name']] = {'integer': 'bigint', 'real': 'double precision', 'text': 'text', 'blob': 'bytea'}.get(kinds[0] if kinds else None, 'jsonb')
            if actual != expected:
                raise GovernanceReadError('Tracking physical schema differs from pinned import: ' + table)
            columns = ','.join(quote(k) for k in keys)
            if self.db.execute('SELECT 1 FROM ' + self.table(table) + ' GROUP BY ' + columns + ' HAVING COUNT(*)>1 LIMIT 1').fetchone():
                raise GovernanceReadError('Duplicate tracking natural key: ' + table)
            if self.db.execute('SELECT 1 FROM ' + self.table(table) + ' WHERE ' + ' OR '.join(quote(k) + ' IS NULL' for k in keys) + ' LIMIT 1').fetchone():
                raise GovernanceReadError('Null tracking natural key: ' + table)

    def _value(self, table, column, value):
        meta = next(c for c in self.tables[table]['columns'] if c['name'] == column)
        if meta['storage_types']:
            return value
        if value is None:
            return None
        # Match the import's tagged JSONB representation, never change the manifest.
        from psycopg.types.json import Jsonb
        if isinstance(value, str) and any(x in meta['declared_type'].upper() for x in ('TEXT', 'CHAR', 'CLOB')):
            return Jsonb({'t': 'text', 'v': value})
        if type(value) is int and 'INT' in meta['declared_type'].upper():
            return Jsonb({'t': 'integer', 'v': str(value)})
        raise GovernanceReadError('Unsupported formerly-null tracking value')

    def _insert(self, table, values):
        if table not in INSERTS and table != 'virtual_flow_catalog_snapshots':
            raise GovernanceReadError('Tracking insert refused')
        now = datetime.datetime.now(datetime.timezone.utc).isoformat()
        columns = {c['name'] for c in self.tables[table]['columns']}
        for name in ('created_at', 'updated_at'):
            if name in columns:
                values.setdefault(name, now)
        if 'invalidation_json' in columns:
            values.setdefault('invalidation_json', '[]')
        identity = {'virtual_workflow_attempts': 'attempt_id', 'virtual_workflow_issues': 'issue_id', 'virtual_workflow_evidence': 'evidence_id'}.get(table)
        if identity:
            values[identity] = self.execute('SELECT COALESCE(MAX(' + quote(identity) + '),0)+1 FROM ' + table).fetchone()[0]
        values['_primecare_import_row'] = self.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM ' + self.table(table)).fetchone()[0]
        fields = list(values)
        parameters = [values[c] if c == '_primecare_import_row' else self._value(table, c, values[c]) for c in fields]
        self.db.execute('INSERT INTO ' + self.table(table) + '(' + ','.join(map(quote, fields)) + ') VALUES (' + ','.join(['%s'] * len(fields)) + ')', parameters)
        return Result(lastrowid=values.get(identity))

    def _update(self, table, values, key, *, optional=False):
        if table not in UPDATES and table != 'virtual_flow_catalog_snapshots':
            raise GovernanceReadError('Tracking update refused')
        fields = list(values)
        cur = self.db.execute('UPDATE ' + self.table(table) + ' SET ' + ','.join(quote(c) + '=%s' for c in fields) + ' WHERE ' + quote(KEYS[table][0]) + '=%s', [self._value(table, c, values[c]) for c in fields] + [self._value(table, KEYS[table][0], key)])
        if cur.rowcount != 1 and not (optional and cur.rowcount == 0):
            raise GovernanceReadError('Tracking update did not affect exactly one row')
        return cur.rowcount

    def execute(self, sql, parameters=()):
        normalized = ' '.join(sql.split())
        if normalized in ('SAVEPOINT workflow_attempt', 'RELEASE workflow_attempt', 'ROLLBACK TO workflow_attempt'):
            self.db.execute(normalized)
            return Result()
        if normalized.startswith('SELECT '):
            compiled, args = self.reader.compile(sql, parameters)
            ordered = []
            def bind(match):
                ordered.append(args[int(match[1]) - 1])
                return '%s'
            # All statement text comes from execution.py; values remain bound.
            compiled = re.sub(r'\$(\d+)', bind, compiled)
            return Result(self.db.execute(compiled, ordered).fetchall())
        for table, fields in INSERTS.items():
            prefix = 'INSERT INTO ' + table + '(' + ','.join(fields) + ') VALUES(' + ','.join('?' for _ in fields) + ')'
            compact = normalized.replace(' ', '')
            if table == 'virtual_workflow_checkpoints':
                suffix = "ON CONFLICT(flow_id) DO UPDATE SET attempt_id=excluded.attempt_id, next_action=excluded.next_action,invalidation_json='[]',updated_at=CURRENT_TIMESTAMP"
                expected = (prefix + suffix).replace(' ', '')
            else:
                expected = prefix.replace(' ', '')
            if compact != expected:
                continue
            if len(parameters) != len(fields):
                raise GovernanceReadError('Tracking parameter count mismatch')
            values = dict(zip(fields, parameters))
            if table == 'virtual_workflow_checkpoints':
                updated = self._update(table, {**{k: v for k, v in values.items() if k != 'flow_id'}, 'invalidation_json': '[]', 'updated_at': datetime.datetime.now(datetime.timezone.utc).isoformat()}, values['flow_id'], optional=True)
                if updated:
                    return Result()
            return self._insert(table, values)
        if normalized == 'UPDATE virtual_workflow_definitions SET verification_status=?, test_status=?,blocker_json=?,updated_at=CURRENT_TIMESTAMP WHERE flow_id=?':
            status, test_status, blockers, flow_id = parameters
            self._update('virtual_workflow_definitions', {'verification_status': status, 'test_status': test_status, 'blocker_json': blockers, 'updated_at': datetime.datetime.now(datetime.timezone.utc).isoformat()}, flow_id)
            return Result()
        if normalized == "UPDATE virtual_workflow_definitions SET verification_status=?, test_status='stale',blocker_json=?,updated_at=CURRENT_TIMESTAMP WHERE flow_id=?":
            self._update('virtual_workflow_definitions', {'verification_status': parameters[0], 'test_status': 'stale', 'blocker_json': parameters[1], 'updated_at': datetime.datetime.now(datetime.timezone.utc).isoformat()}, parameters[2])
            return Result()
        if normalized == 'UPDATE virtual_workflow_checkpoints SET invalidation_json=?, updated_at=CURRENT_TIMESTAMP WHERE flow_id=?':
            self._update('virtual_workflow_checkpoints', {'invalidation_json': parameters[0], 'updated_at': datetime.datetime.now(datetime.timezone.utc).isoformat()}, parameters[1])
            return Result()
        if normalized == 'INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP':
            values = {'summary_json': parameters[1], 'updated_at': datetime.datetime.now(datetime.timezone.utc).isoformat()}
            if not self._update('virtual_flow_catalog_snapshots', values, parameters[0], optional=True):
                self._insert('virtual_flow_catalog_snapshots', {'name': parameters[0], **values})
            return Result()
        raise GovernanceReadError('Unsupported production workflow statement')

    def executemany(self, sql, rows):
        for row in rows:
            self.execute(sql, row)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, *_):
        try:
            self.db.rollback() if exc_type else self.db.commit()
        finally:
            self.db.close()
