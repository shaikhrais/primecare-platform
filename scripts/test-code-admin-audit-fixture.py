import importlib.util
import os
import sqlite3
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('fixture', Path(__file__).with_name('prepare-code-admin-audit-fixture.py'))
fixture = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fixture)


class FixtureTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.path = self.root / '.agents/governance/governance.db'
        self.path.parent.mkdir(parents=True)
        self.env = patch.dict(os.environ, {'CI':'true','GOVERNANCE_ALLOW_SQLITE_FIXTURES':'1'}, clear=True)
        self.env.start()
        self.addCleanup(self.env.stop)

    def install(self):
        with sqlite3.connect(self.path) as db:
            db.execute('CREATE TABLE roles(role_code TEXT UNIQUE,role_name TEXT,role_type TEXT,active INTEGER,primary_app_code TEXT,post_login_route TEXT)')
            db.execute("INSERT INTO roles VALUES('fixture','Original','staff',1,'ci','/original')")

    def test_idempotent_and_preserves_existing_roles(self):
        self.install()
        fixture.prepare(self.root)
        fixture.prepare(self.root)
        with sqlite3.connect(self.path) as db:
            self.assertEqual(db.execute('SELECT COUNT(*) FROM roles').fetchone()[0], 2)
            self.assertEqual(db.execute("SELECT role_name,post_login_route FROM roles WHERE role_code='fixture'").fetchone(), ('Original','/original'))
            self.assertEqual(db.execute("SELECT primary_app_code,post_login_route FROM roles WHERE role_code='code_admin'").fetchone(), ('go','/platform/administration'))

    def test_missing_database_is_not_created(self):
        with self.assertRaises(RuntimeError): fixture.prepare(self.root)
        self.assertFalse(self.path.exists())

    def test_missing_optin_or_ci_rejected(self):
        for key in ('CI','GOVERNANCE_ALLOW_SQLITE_FIXTURES'):
            with patch.dict(os.environ, {key:''}):
                with self.assertRaises(RuntimeError): fixture.prepare(self.root)

    def test_both_production_credential_names_rejected(self):
        self.install()
        before=self.path.read_bytes()
        for key in ('PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL'):
            with patch.dict(os.environ, {key:'synthetic-forbidden'}):
                with self.assertRaises(RuntimeError): fixture.prepare(self.root)
        self.assertEqual(self.path.read_bytes(), before)

    def test_symlink_refused(self):
        target=self.root/'target.db'
        target.touch()
        self.path.symlink_to(target)
        with self.assertRaises(RuntimeError): fixture.prepare(self.root)
        self.assertEqual(target.stat().st_size,0)


if __name__ == '__main__': unittest.main()
