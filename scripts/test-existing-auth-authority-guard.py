"""Existing auth reconciliation validates all declarations before any write."""
import shutil, sqlite3, subprocess, sys, tempfile, unittest
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

class ExistingAuthAuthorityTests(unittest.TestCase):
    def test_late_drift_leaves_earlier_declarations_and_spec_unchanged(self):
        for column, value in [('service_name', 'clinical'), ('auth_required', 0), ('permission_key', 'unreviewed_admin')]:
            with self.subTest(column=column), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                for file in ['scripts/register-existing-auth-contracts.py', 'cloudflare/workers/src/account-policy.json', 'docs/api/account-batch-2.openapi.json']:
                    target = root / file
                    target.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copyfile(ROOT / file, target)
                target = root / '.agents/governance/governance.db'
                target.parent.mkdir(parents=True)
                with sqlite3.connect(ROOT / '.agents/governance/governance.db') as source, sqlite3.connect(target) as db:
                    source.backup(db)
                    self.assertEqual(db.execute('UPDATE api_endpoints SET ' + column + "=? WHERE http_method='POST' AND route_path='/v1/user/change-password'", (value,)).rowcount, 1)
                    db.commit()
                    before = '\n'.join(db.iterdump())
                artifact = root / 'docs/api/existing-auth-batches-242-247.openapi.json'
                artifact.write_text('existing contract')
                result = subprocess.run([sys.executable, str(root / 'scripts/register-existing-auth-contracts.py')], capture_output=True, text=True)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn('Existing authority drift', result.stderr)
                self.assertEqual(artifact.read_text(), 'existing contract')
                with sqlite3.connect(target) as db:
                    self.assertEqual('\n'.join(db.iterdump()), before)

if __name__ == '__main__':
    unittest.main()
