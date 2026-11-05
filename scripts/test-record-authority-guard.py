"""Regression checks for owner-read registration against drifted governance."""
import importlib.util
from contextlib import closing
import sqlite3
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location('guard', ROOT/'scripts/record_authority_guard.py')
GUARD = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GUARD)

def logical_snapshot(db):
    """Compare all schema and row multisets without validating historical FKs.

    Recent Python versions' iterdump checks foreign keys, which can reject
    unrelated historical fixture schemas before the authority guard is exercised.
    Include allocation counters: an aborted registrar must change nothing.
    """
    schema = db.execute(
        'SELECT type,name,tbl_name,sql FROM sqlite_schema ORDER BY type,name'
    ).fetchall()
    rows = []
    for kind, name, _, _ in schema:
        if kind != 'table':
            continue
        quoted_name = '"' + name.replace('"', '""') + '"'
        rows.append((name, sorted(repr(row) for row in db.execute('SELECT * FROM ' + quoted_name))))
    return schema, rows


class LogicalSnapshotTests(unittest.TestCase):
    def test_schema_and_row_values_including_duplicates_are_compared(self):
        with closing(sqlite3.connect(':memory:')) as db:
            db.execute('CREATE TABLE "quoted""table" (value)')
            before = logical_snapshot(db)
            db.execute('INSERT INTO "quoted""table" VALUES (?)', (b'\x00\xff',))
            self.assertNotEqual(logical_snapshot(db), before)
            before = logical_snapshot(db)
            db.execute('INSERT INTO "quoted""table" VALUES (?)', (b'\x00\xff',))
            self.assertNotEqual(logical_snapshot(db), before)
            before = logical_snapshot(db)
            db.execute('CREATE INDEX value_index ON "quoted""table" (value)')
            self.assertNotEqual(logical_snapshot(db), before)

    def test_row_order_is_ignored_but_allocation_counters_are_compared(self):
        with closing(sqlite3.connect(':memory:')) as db:
            db.executescript('CREATE TABLE sample (value);'
                             "INSERT INTO sample VALUES ('a'), ('b');")
            before = logical_snapshot(db)
            db.executescript('DELETE FROM sample;'
                             "INSERT INTO sample VALUES ('b'), ('a');")
            self.assertEqual(logical_snapshot(db), before)
            db.execute('CREATE TABLE allocated (id INTEGER PRIMARY KEY AUTOINCREMENT)')
            db.execute('INSERT INTO allocated DEFAULT VALUES')
            before = logical_snapshot(db)
            db.execute("UPDATE sqlite_sequence SET seq=99 WHERE name='allocated'")
            self.assertNotEqual(logical_snapshot(db), before)

    def test_invalid_historical_fk_is_not_repaired_or_hidden(self):
        with closing(sqlite3.connect(':memory:')) as db:
            db.executescript('CREATE TABLE languages (language_id INTEGER PRIMARY KEY);'
                             'CREATE TABLE translations (language TEXT REFERENCES languages(id));'
                             "INSERT INTO translations VALUES ('en');")
            before = logical_snapshot(db)
            with self.assertRaisesRegex(sqlite3.OperationalError, 'foreign key mismatch'):
                db.execute('PRAGMA foreign_key_check').fetchall()
            self.assertEqual(logical_snapshot(db), before)
            db.execute("UPDATE translations SET language='fr'")
            self.assertNotEqual(logical_snapshot(db), before)


class AuthorityGuardTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        self.addCleanup(self.db.close)
        self.db.execute('CREATE TABLE api_endpoints(route_path TEXT,http_method TEXT,service_name TEXT,auth_required INTEGER,permission_key TEXT)')
        self.definitions = [{'path':'/records','summaryField':'status'}, {'path':'/singleton','singleton':True}]

    def row(self, route='/v1/auth/records', service='auth', auth=1, permission='owner', method='GET'):
        self.db.execute('INSERT INTO api_endpoints VALUES(?,?,?,?,?)', (route,method,service,auth,permission))

    def validate(self):
        GUARD.validate_record_authority(self.db,self.definitions,'auth','owner')

    def test_new_routes_and_matching_registered_routes_allowed(self):
        self.validate()
        for route in ['/v1/auth/records','/v1/auth/records/{recordId}','/v1/auth/records/summary','/v1/auth/singleton']:
            self.row(route)
        self.validate()

    def test_each_read_mode_rejects_service_auth_or_permission_drift(self):
        for route in ['/v1/auth/records','/v1/auth/records/{recordId}','/v1/auth/records/summary','/v1/auth/singleton']:
            for changes in [{'service':'client'}, {'auth':0}, {'permission':None}, {'permission':'tenant_admin'}]:
                with self.subTest(route=route,changes=changes):
                    self.db.execute('DELETE FROM api_endpoints')
                    self.row(route,**changes)
                    with self.assertRaisesRegex(RuntimeError,'authority drift'):
                        self.validate()

    def test_duplicate_rows_rejected_even_when_authority_matches(self):
        self.row(); self.row()
        with self.assertRaisesRegex(RuntimeError,'authority drift'):
            self.validate()

    def test_other_method_and_unrelated_routes_do_not_change_read_authority(self):
        self.row(service='other',auth=0,permission=None,method='POST')
        self.row(route='/v1/auth/unrelated',service='other',auth=0,permission=None)
        self.validate()

    def test_actual_generators_abort_before_database_or_artifact_changes(self):
        cases = [
            ('register-provider-records-api.py','/v1/provider/conversation-threads/summary','provider-records-registry.json'),
            ('register-self-records-api.py','/v1/auth/me/notifications/{recordId}','self-records-registry.json'),
        ]
        for script,route,registry in cases:
            for column,value in [('service_name','other'),('auth_required',0),('permission_key','tenant_admin')]:
                with self.subTest(script=script,column=column), tempfile.TemporaryDirectory() as directory:
                    root = Path(directory)
                    for path in ['scripts','.agents/governance','cloudflare/workers/src','docs/api']:
                        (root/path).mkdir(parents=True)
                    for name in [script,'record_authority_guard.py']:
                        (root/'scripts'/name).write_bytes((ROOT/'scripts'/name).read_bytes())
                    target = root/'.agents/governance/governance.db'
                    with closing(sqlite3.connect(ROOT/'.agents/governance/governance.db')) as source, closing(sqlite3.connect(target)) as db:
                        source.backup(db)
                        updated = db.execute('UPDATE api_endpoints SET '+column+'=? WHERE route_path=? AND http_method=\'GET\'',(value,route))
                        self.assertEqual(updated.rowcount,1)
                        db.commit()
                        before = logical_snapshot(db)
                    artifact = root/'cloudflare/workers/src'/registry
                    artifact.write_text('existing artifact must remain intact')
                    result = subprocess.run([sys.executable,str(root/'scripts'/script)],capture_output=True,text=True)
                    self.assertNotEqual(result.returncode,0)
                    self.assertIn('Owner-read endpoint authority drift: GET '+route,result.stderr)
                    self.assertEqual(artifact.read_text(),'existing artifact must remain intact')
                    self.assertEqual(list((root/'docs/api').iterdir()),[])
                    with closing(sqlite3.connect(target)) as db:
                        self.assertEqual(logical_snapshot(db),before)

if __name__ == '__main__':
    unittest.main()
