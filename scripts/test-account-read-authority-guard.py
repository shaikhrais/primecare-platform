"""Registration must reject any authority drift before changing this read family."""
import sqlite3,subprocess,sys,tempfile,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
ROUTES=['/v1/admin/users','/v1/admin/users/{userId}','/v1/admin/users/{userId}/sessions','/v1/admin/users/audit','/v1/admin/users/creation-audit']
class AccountReadAuthorityTests(unittest.TestCase):
 def test_all_routes_and_legacy_list_are_validated_before_any_write(self):
  for route in ROUTES:
   for column,value in [('service_name','other'),('auth_required',0),('permission_key','tenant_admin')]:
    with self.subTest(route=route,column=column),tempfile.TemporaryDirectory() as directory:
     root=Path(directory)
     for path in ['scripts','.agents/governance','docs/api']:(root/path).mkdir(parents=True)
     script=root/'scripts/register-account-read-validation-api.py'
     script.write_bytes((ROOT/'scripts'/script.name).read_bytes())
     target=root/'.agents/governance/governance.db'
     with sqlite3.connect(target) as db:
      db.execute('CREATE TABLE api_endpoints(id INTEGER PRIMARY KEY,route_path TEXT,http_method TEXT,service_name TEXT,auth_required INTEGER,permission_key TEXT)')
      for registered in [*ROUTES,ROUTES[0]]:db.execute("INSERT INTO api_endpoints(route_path,http_method,service_name,auth_required,permission_key) VALUES(?,'GET','auth',1,'auth_account_management_policy')",(registered,))
      # Include the second legacy list declaration in the preflight contract.
      aid=db.execute('SELECT MAX(id) FROM api_endpoints WHERE route_path=?',(route,)).fetchone()[0]
      db.execute('UPDATE api_endpoints SET '+column+'=? WHERE id=?',(value,aid));db.commit()
      before=list(db.execute('SELECT * FROM api_endpoints ORDER BY id'))
     result=subprocess.run([sys.executable,str(script)],capture_output=True,text=True)
     self.assertNotEqual(result.returncode,0);self.assertIn('Account read authority drift: GET '+route,result.stderr)
     self.assertEqual(list((root/'docs/api').iterdir()),[])
     with sqlite3.connect(target) as db:self.assertEqual(list(db.execute('SELECT * FROM api_endpoints ORDER BY id')),before)
if __name__=='__main__':unittest.main()
