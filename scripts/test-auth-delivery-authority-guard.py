"""Auth delivery reconciliation validates all declarations before any write."""
import shutil, sqlite3, subprocess, sys, tempfile, unittest
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

class AuthDeliveryAuthorityTests(unittest.TestCase):
    def test_late_drift_leaves_earlier_declarations_and_spec_unchanged(self):
        for column, value in [('service_name', 'clinical'), ('auth_required', 1), ('permission_key', 'unreviewed_admin')]:
            with self.subTest(column=column), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                for file in ['scripts/register-auth-delivery-work-package.py', 'docs/api/auth-body-bounds-batches-254-258.openapi.json', 'docs/api/auth-result-validation-batches-259-263.openapi.json']:
                    target = root / file
                    target.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copyfile(ROOT / file, target)
                target = root / '.agents/governance/governance.db'
                target.parent.mkdir(parents=True)
                with sqlite3.connect(ROOT / '.agents/governance/governance.db') as source, sqlite3.connect(target) as db:
                    source.backup(db)
                    self.assertEqual(db.execute('UPDATE api_endpoints SET ' + column + "=? WHERE http_method='POST' AND route_path='/v1/auth/reset-password'", (value,)).rowcount, 1)
                    db.commit()
                    before = '\n'.join(db.iterdump())
                artifact = root / 'docs/api/auth-delivery-work-package.openapi.json'
                artifact.write_text('existing contract')
                result = subprocess.run([sys.executable, str(root / 'scripts/register-auth-delivery-work-package.py')], capture_output=True, text=True)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn('Auth delivery authority drift', result.stderr)
                self.assertEqual(artifact.read_text(), 'existing contract')
                with sqlite3.connect(target) as db:
                    self.assertEqual('\n'.join(db.iterdump()), before)

if __name__ == '__main__':
    unittest.main()
