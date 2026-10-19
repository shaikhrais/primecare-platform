"""Add missing governance bindings for existing report/training/operations code.

This imports already exported contracts and existing educational authority; it
never executes the broad registrars, replaces rows, assigns users, changes role
permissions/translations, generates source, or records workflow verification.
The caller owns the transaction. Conflicting metadata fails atomically.
"""
import argparse
import hashlib
import json
import sqlite3
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCOPES = ('reports', 'training', 'operations')
ALLOWED_TABLES = (
    'shared_report_definitions', 'shared_report_grants', 'shared_report_surfaces',
    'admin_training_courses', 'admin_training_learning_grants',
    'admin_training_native_surfaces', 'tenant_operations_policy',
    'api_endpoints', 'screen_api_links',
)
SCHEMA = {
    'shared_report_definitions': '''report_id TEXT PRIMARY KEY,source TEXT NOT NULL,
        classification TEXT NOT NULL,requirement TEXT NOT NULL''',
    'shared_report_grants': '''report_id TEXT NOT NULL REFERENCES shared_report_definitions(report_id),
        role_id INTEGER NOT NULL REFERENCES roles(id),can_view INTEGER NOT NULL,
        can_export INTEGER NOT NULL,can_email INTEGER NOT NULL,PRIMARY KEY(report_id,role_id)''',
    'shared_report_surfaces': '''screen_id INTEGER PRIMARY KEY REFERENCES screens(id),
        section_code TEXT NOT NULL,controls_json TEXT NOT NULL''',
    'admin_training_courses': '''course_id TEXT PRIMARY KEY,version TEXT NOT NULL,
        modules_json TEXT NOT NULL,progress_scope TEXT NOT NULL,requirement TEXT NOT NULL''',
    'admin_training_learning_grants': '''role_id INTEGER PRIMARY KEY REFERENCES roles(id),
        course_id TEXT NOT NULL REFERENCES admin_training_courses(course_id),can_read INTEGER NOT NULL''',
    'admin_training_native_surfaces': '''surface TEXT PRIMARY KEY,source_path TEXT NOT NULL,authority TEXT NOT NULL''',
    'tenant_operations_policy': '''id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL''',
}


def encoded(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True)


class Reconciler:
    def __init__(self, db, root):
        self.db, self.root = db, Path(root).resolve()
        self.inserted = Counter()
        self.sources = {}

    def source(self, name):
        path = (self.root / name).resolve()
        if not path.is_relative_to(self.root) or not path.is_file():
            raise ValueError('Required existing contract is unavailable: ' + name)
        data = path.read_bytes()
        self.sources[name] = hashlib.sha256(data).hexdigest()
        return data.decode()

    def load(self, name):
        return json.loads(self.source(name))

    def one(self, sql, values, label):
        rows = self.db.execute(sql, values).fetchall()
        if len(rows) != 1:
            raise ValueError('Missing or ambiguous existing ' + label)
        return rows[0]

    def table(self, name):
        # A production metadata trigger could have unrelated side effects.
        if self.db.execute("SELECT 1 FROM sqlite_master WHERE type='trigger' AND tbl_name=?", (name,)).fetchone():
            raise ValueError('Unreviewed metadata trigger on ' + name)
        if name in SCHEMA:
            self.db.execute('CREATE TABLE IF NOT EXISTS ' + name + '(' + SCHEMA[name] + ')')

    def row(self, table, key, values, json_columns=()):
        """Insert absent rows, require an exact existing contract otherwise."""
        self.table(table)
        data = {**key, **values}
        columns = list(data)
        where = ' AND '.join(k + '=?' for k in key)
        found = self.db.execute('SELECT ' + ','.join(columns) + ' FROM ' + table + ' WHERE ' + where, tuple(key.values())).fetchall()
        if found:
            if len(found) != 1:
                raise ValueError('Ambiguous existing binding in ' + table)
            for column, actual in zip(columns, found[0]):
                expected = data[column]
                if column in json_columns:
                    try:
                        actual, expected = json.loads(actual), json.loads(expected)
                    except (ValueError, TypeError) as exc:
                        raise ValueError('Invalid existing JSON in ' + table + '.' + column) from exc
                if actual != expected:
                    raise ValueError('Conflicting existing binding: ' + table + '.' + column + ' ' + encoded(key))
            return
        self.db.execute('INSERT INTO ' + table + '(' + ','.join(columns) + ') VALUES(' + ','.join('?' for _ in columns) + ')', tuple(data.values()))
        self.inserted[table] += 1

    def screen(self, code):
        return self.one('SELECT id FROM screens WHERE screen_code=? AND active=1', (code,), 'active screen ' + code)[0]

    def role(self, code):
        return self.one('SELECT id FROM roles WHERE role_code=? AND active=1', (code,), 'active role ' + code)[0]

    def link(self, screen_id, api_id, purpose):
        # A different explanation on an already identical binding is preserved.
        existing = self.db.execute('SELECT id FROM screen_api_links WHERE screen_id=? AND api_id=?', (screen_id, api_id)).fetchall()
        if len(existing) > 1:
            raise ValueError('Ambiguous existing screen/API binding')
        if not existing:
            self.row('screen_api_links', {'screen_id': screen_id, 'api_id': api_id}, {'purpose': purpose})

    def api(self, code, path, method, request, response, permission, rate, paginated=0):
        app = self.one("SELECT id FROM apps WHERE app_code='gv' AND active=1", (), 'governance API application')[0]
        collision = [tuple(row) for row in self.db.execute('SELECT app_id,route_path,http_method FROM api_endpoints WHERE endpoint_code=?', (code,))]
        if collision and collision != [(app, path, method)]:
            raise ValueError('Endpoint-code collision: ' + code)
        self.row('api_endpoints', {'app_id': app, 'route_path': path, 'http_method': method}, {
            'endpoint_code': code, 'service_name': 'governance', 'auth_required': 1,
            'permission_key': permission, 'request_schema': encoded(request),
            'response_schema': encoded(response), 'rate_limit_key': rate,
            'uses_pagination': paginated,
        }, ('request_schema', 'response_schema'))
        # New records retain schema defaults (planned/no last_tested_at). Importing
        # source metadata does not attest implementation or execution.
        return self.one('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?', (app, path, method), 'registered API')[0]

    def reports(self):
        self.source('cloudflare/workers/src/reporting.ts')
        self.source('websites/typescript/src/reports.ts')
        contract = self.load('cloudflare/workers/src/report-registry.json')
        document = self.load('docs/api/admin-reports.openapi.json')
        expected_ids = {'organization_summary', 'page_readiness', 'platform_administration'}
        if {d['report_id'] for d in contract['definitions']} != expected_ids or len(contract['definitions']) != 3:
            raise ValueError('Review changed report definitions before reconciliation')
        expected = {
            'organization_summary': {r[0] for r in self.db.execute('''SELECT r.role_code FROM roles r
                JOIN runtime_catalog_permissions p ON p.role_id=r.id WHERE r.active=1 AND p.can_view_organization=1''')},
            'page_readiness': {r[0] for r in self.db.execute('''SELECT r.role_code FROM roles r WHERE r.active=1
                AND EXISTS(SELECT 1 FROM role_screen_permissions p WHERE p.role_id=r.id AND p.can_view=1)''')},
            'platform_administration': {'platform_admin'},
        }
        for definition in contract['definitions']:
            rid = definition['report_id']
            grants = definition['grants']
            if len({g['role'] for g in grants}) != len(grants) or {g['role'] for g in grants} != expected[rid]:
                raise ValueError('Existing report authority differs from source registry: ' + rid)
            self.row('shared_report_definitions', {'report_id': rid}, {key: definition[key] for key in ('source', 'classification', 'requirement')})
            for grant in grants:
                if any(type(grant[k]) is not int or grant[k] not in (0, 1) for k in ('view', 'export', 'email')):
                    raise ValueError('Invalid existing report grant')
                self.row('shared_report_grants', {'report_id': rid, 'role_id': self.role(grant['role'])}, {'can_view': grant['view'], 'can_export': grant['export'], 'can_email': grant['email']})
        surfaces = []
        for surface in contract['surfaces']:
            sid = self.screen(surface['screen'])
            if sid in surfaces:
                raise ValueError('Duplicate report surface')
            surfaces.append(sid)
            self.row('shared_report_surfaces', {'screen_id': sid}, {'section_code': surface['section_code'], 'controls_json': surface['controls_json']}, ('controls_json',))
        base = contract['endpoint']
        if base != '/v1/governance/reports':
            raise ValueError('Review changed report endpoint')
        routes = [('CATALOG', base, 'GET'), ('RUN', base+'/{reportId}', 'GET'), ('PDF', base+'/{reportId}/pdf', 'GET'), ('EMAIL', base+'/{reportId}/email', 'POST')]
        if set(document['paths']) != {path for _, path, _ in routes}:
            raise ValueError('Report OpenAPI paths differ from existing runtime contract')
        for code, path, method in routes:
            operation = document['paths'][path][method.lower()]
            if method == 'GET':
                request = {'type': 'object', 'additionalProperties': False, 'properties': {p['name']: p['schema'] for p in operation['parameters'] if p['in'] == 'query'}}
            else:
                request = operation['requestBody']['content']['application/json']['schema']
            response = operation['responses']['200']['content'][('application/pdf' if code == 'PDF' else 'application/json')]['schema']
            aid = self.api('SHARED_REPORT_'+code, path, method, request, response, 'shared_report_grants', 'reports.actor')
            for sid in surfaces:
                self.link(sid, aid, 'Existing source-governed report ' + code.lower())

    def training(self):
        seed = self.load('docs/training/admin-course-seed.json')
        if seed != self.load('websites/typescript/src/training/admin-course.json'):
            raise ValueError('Existing training source and seed differ')
        registrar = self.source('scripts/register-admin-training.py')
        if 'INSERT OR REPLACE INTO admin_training_learning_grants SELECT id,?,1 FROM roles WHERE active=1' not in registrar:
            raise ValueError('Existing authenticated educational grant scope changed')
        self.source('websites/typescript/src/admin-training.ts')
        self.row('admin_training_courses', {'course_id': seed['course']}, {'version': seed['version'], 'modules_json': encoded(seed['modules']), 'progress_scope': 'device_account_self_assessment', 'requirement': 'User request: admin duties, management reporting and in-system training; no certification or domain authority'}, ('modules_json',))
        for role_id, in self.db.execute('SELECT id FROM roles WHERE active=1').fetchall():
            self.row('admin_training_learning_grants', {'role_id': role_id}, {'course_id': seed['course'], 'can_read': 1})
        for surface, path in [('account', 'packages/primecare_ui/lib/src/features/auth/auth_experience.dart'), ('workspace', 'packages/primecare_ui/lib/src/features/workspace/governed_workspace_screen.dart')]:
            self.source(path)
            self.row('admin_training_native_surfaces', {'surface': surface}, {'source_path': path, 'authority': 'Authenticated active account with verified userId; educational only; no domain authority'})

    def operations(self):
        source = self.load('packages/shared/src/tenant-operations.json')
        if source != self.load('docs/platform-operations/seed.json'):
            raise ValueError('Existing operations source and seed differ')
        self.source('cloudflare/workers/src/tenant-operations.ts')
        self.source('websites/typescript/src/tenant-operations/controller.ts')
        self.source('websites/typescript/src/tenant-operations/client.ts')
        hierarchy = self.load('cloudflare/workers/src/admin-hierarchy.json')
        sid = self.screen('PLATFORM_ADMINISTRATION')
        for code in source['roles']:
            rid = self.role(code)
            permission = self.one('SELECT can_view FROM role_screen_permissions WHERE role_id=? AND screen_id=?', (rid, sid), 'operations parent-screen permission')
            expected_scope = {'global': 'global', 'tenant': 'own'}.get(hierarchy['roles'].get(code, {}).get('scope'))
            if permission[0] != 1 or not hierarchy['permissions'].get(code, {}).get('view') or source['roles'][code] != expected_scope:
                raise ValueError('Existing operations authority differs from source: ' + code)
        if source['endpoint'] != '/v1/governance/platform/operations':
            raise ValueError('Review changed operations endpoint')
        self.row('tenant_operations_policy', {'id': 'admin-v1'}, {'definition': encoded(source), 'requirement': 'User: more platform features; central/tenant admins, operational gaps and fix navigation, API-owned database reads; 2026-10-16'}, ('definition',))
        aid = self.api('TENANT_OPERATIONS_GET', source['endpoint'], 'GET', source['request'], source['response'], 'tenant_operations_policy', 'authenticated_read', 1)
        self.link(sid, aid, 'Existing scoped administrative counts; no patient or employee contact data')


def reconcile(db, scopes=SCOPES, root=ROOT):
    if not scopes or len(set(scopes)) != len(scopes) or any(scope not in SCOPES for scope in scopes):
        raise ValueError('Choose distinct report/training/operations scopes')
    # An outermost SAVEPOINT would commit on RELEASE. BEGIN leaves final commit
    # with the caller, including when no caller DML preceded this operation.
    if not db.in_transaction:
        db.execute('BEGIN')
    db.execute('SAVEPOINT reconcile_workflow_bindings')
    importer = Reconciler(db, root)
    baseline_fk = {table: {tuple(row) for row in db.execute('PRAGMA foreign_key_check(' + table + ')')}
                   for table in ALLOWED_TABLES
                   if db.execute("SELECT 1 FROM sqlite_master WHERE type='table' AND name=?", (table,)).fetchone()}
    try:
        for scope in scopes:
            getattr(importer, scope)()
        for table in ALLOWED_TABLES:
            if db.execute("SELECT 1 FROM sqlite_master WHERE type='table' AND name=?", (table,)).fetchone():
                # Restrict FK checks: legacy global translation schema is unrelated.
                after = {tuple(row) for row in db.execute('PRAGMA foreign_key_check(' + table + ')')}
                if after - baseline_fk.get(table, set()):
                    raise ValueError('New foreign key failure in ' + table)
        db.execute('RELEASE reconcile_workflow_bindings')
    except Exception:
        db.execute('ROLLBACK TO reconcile_workflow_bindings')
        db.execute('RELEASE reconcile_workflow_bindings')
        raise
    return {'scopes': list(scopes), 'inserted': dict(importer.inserted), 'source_bindings': importer.sources,
            'allowed_tables': list(ALLOWED_TABLES),
            'preserved_existing_fk_issue_counts': {table: len(issues) for table, issues in baseline_fk.items() if issues},
            'workflow_tests_executed': 0,
            'verification_status_changed': False, 'generated_sources_changed': False}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--database', type=Path, required=True)
    parser.add_argument('--scope', choices=SCOPES, action='append')
    parser.add_argument('--check', action='store_true', help='Reconcile only an isolated in-memory copy')
    args = parser.parse_args()
    if not args.database.is_file():
        parser.error('Existing database required; refusing to create an empty database')
    source = sqlite3.connect('file:' + str(args.database.resolve()) + '?mode=ro', uri=True) if args.check else sqlite3.connect(args.database)
    db = sqlite3.connect(':memory:') if args.check else source
    try:
        if args.check:
            source.backup(db)
        with db:
            result = reconcile(db, args.scope or SCOPES)
        print(json.dumps({**result, 'check_only': args.check}, indent=2))
    finally:
        db.close()
        if db is not source:
            source.close()


if __name__ == '__main__':
    main()
