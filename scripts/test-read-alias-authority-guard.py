"""Compatibility registration must not copy drifted canonical authority."""
import json, shutil, sqlite3, subprocess, sys, tempfile, unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

class ReadAliasAuthorityTests(unittest.TestCase):
    def test_canonical_service_bearer_and_permission_drift_roll_back_prior_aliases(self):
        definitions=json.loads((ROOT/'scripts/governed-read-alias-definitions.json').read_text())
        # This canonical is fourth in the reviewed manifest, so earlier aliases
        # have already been processed when its mismatch is discovered.
        route='/v1/client/bookings'
        self.assertGreater(next(i for i,r in enumerate(definitions) if r['canonical']==route),0)
        for column,value in [('service_name','auth'),('auth_required',0),('permission_key','tenant_admin')]:
            with self.subTest(column=column),tempfile.TemporaryDirectory() as directory:
                root=Path(directory)
                for path in ['scripts','.agents/governance','docs/api','cloudflare/workers/src']:
                    (root/path).mkdir(parents=True)
                for name in ['register-governed-read-aliases.py','governed-read-alias-definitions.json']:
                    shutil.copyfile(ROOT/'scripts'/name,root/'scripts'/name)
                for name in {r['spec'] for r in definitions}:
                    shutil.copyfile(ROOT/'docs/api'/name,root/'docs/api'/name)
                target=root/'.agents/governance/governance.db'
                with sqlite3.connect(ROOT/'.agents/governance/governance.db') as source,sqlite3.connect(target) as db:
                    source.backup(db)
                    changed=db.execute('UPDATE api_endpoints SET '+column+'=? WHERE route_path=? AND http_method=\'GET\'',(value,route))
                    self.assertEqual(changed.rowcount,1)
                    db.commit();before='\n'.join(db.iterdump())
                artifacts=[root/'cloudflare/workers/src/governed-read-aliases.json',root/'docs/api/governed-read-aliases.openapi.json']
                for p in artifacts:p.write_text('existing artifact remains intact')
                result=subprocess.run([sys.executable,str(root/'scripts/register-governed-read-aliases.py')],capture_output=True,text=True)
                self.assertNotEqual(result.returncode,0)
                self.assertIn('Canonical owner authority drift: '+route,result.stderr)
                for p in artifacts:self.assertEqual(p.read_text(),'existing artifact remains intact')
                with sqlite3.connect(target) as db:self.assertEqual('\n'.join(db.iterdump()),before)

if __name__=='__main__':unittest.main()
