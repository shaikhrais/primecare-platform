"""Regression checks for owner-read registration against drifted governance."""
import importlib.util
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
                    with sqlite3.connect(ROOT/'.agents/governance/governance.db') as source, sqlite3.connect(target) as db:
                        source.backup(db)
                        updated = db.execute('UPDATE api_endpoints SET '+column+'=? WHERE route_path=? AND http_method=\'GET\'',(value,route))
                        self.assertEqual(updated.rowcount,1)
                        db.commit()
                        before = '\n'.join(db.iterdump())
                    artifact = root/'cloudflare/workers/src'/registry
                    artifact.write_text('existing artifact must remain intact')
                    result = subprocess.run([sys.executable,str(root/'scripts'/script)],capture_output=True,text=True)
                    self.assertNotEqual(result.returncode,0)
                    self.assertIn('Owner-read endpoint authority drift: GET '+route,result.stderr)
                    self.assertEqual(artifact.read_text(),'existing artifact must remain intact')
                    self.assertEqual(list((root/'docs/api').iterdir()),[])
                    with sqlite3.connect(target) as db:
                        self.assertEqual('\n'.join(db.iterdump()),before)

if __name__ == '__main__':
    unittest.main()
