"""Submission reconciliation fails closed without changing registry or contracts."""
import shutil, sqlite3, subprocess, sys, tempfile, unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class BookingSubmissionAuthorityTests(unittest.TestCase):
 def test_authority_and_contract_drift_leave_all_artifacts_unchanged(self):
  cases=[('/v1/client/booking-requests','service_name','auth'),('/v1/client/booking-requests','permission_key','tenant_admin'),('/v1/client/booking-requests','request_schema','{}'),('/v1/client/bookings','service_name','billing'),('/v1/client/bookings','auth_required',0),('/v1/client/bookings','permission_key','tenant_admin')]
  for route,column,value in cases:
   with self.subTest(route=route,column=column),tempfile.TemporaryDirectory() as directory:
    root=Path(directory)
    for file in ['scripts/register-booking-collection-delivery.py','docs/api/client-booking-lifecycle-batch-19.openapi.json']:
     target=root/file;target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/file,target)
    target=root/'.agents/governance/governance.db';target.parent.mkdir(parents=True)
    with sqlite3.connect(ROOT/'.agents/governance/governance.db') as source,sqlite3.connect(target) as db:
     source.backup(db);self.assertEqual(db.execute('UPDATE api_endpoints SET '+column+'=? WHERE http_method=\'POST\' AND route_path=?',(value,route)).rowcount,1);db.commit();before='\n'.join(db.iterdump())
    artifact=root/'docs/api/booking-collection-delivery.openapi.json';artifact.write_text('existing contract')
    result=subprocess.run([sys.executable,str(root/'scripts/register-booking-collection-delivery.py')],capture_output=True,text=True)
    self.assertNotEqual(result.returncode,0);self.assertIn('Booking collection',result.stderr);self.assertEqual(artifact.read_text(),'existing contract')
    with sqlite3.connect(target) as db:self.assertEqual('\n'.join(db.iterdump()),before)
if __name__=='__main__':unittest.main()
