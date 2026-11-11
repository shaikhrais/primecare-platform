"""Regression coverage for the CI-only role supplement, using disposable SQLite."""
from pathlib import Path
import shutil
import ast
import re
import sqlite3
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
HELPER = 'scripts/prepare-code-admin-audit-fixture.py'
BASE = 'tools/governance-production/prepare-ci-fixture.py'


class CodeAdminFixtureTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / 'scripts').mkdir()
        shutil.copy2(ROOT / HELPER, self.root / HELPER)
        (self.root / BASE).parent.mkdir(parents=True)
        shutil.copy2(ROOT / BASE, self.root / BASE)
        self.database = self.root / '.agents/governance/governance.db'
        self.database.parent.mkdir(parents=True)
        with sqlite3.connect(self.database) as db:
            db.executescript('''
                CREATE TABLE roles(id INTEGER PRIMARY KEY AUTOINCREMENT, role_code TEXT UNIQUE,
                    role_name TEXT, role_type TEXT, active INTEGER,
                    primary_app_code TEXT, post_login_route TEXT);
                INSERT INTO roles VALUES(1,'existing','Existing','Existing',1,'go','/existing');
                CREATE TABLE grants(role_id INTEGER, permission TEXT);
                INSERT INTO grants VALUES(1,'existing');
                CREATE TABLE accounts(id INTEGER PRIMARY KEY, name TEXT);
                INSERT INTO accounts VALUES(1,'unchanged');
            ''')

    def run_helper(self, **env):
        # Never inherit credentials or configuration from the invoking shell.
        return subprocess.run([sys.executable, str(self.root / HELPER)],
                              env={'CI': 'true', **env}, capture_output=True, text=True)

    def snapshot(self):
        with sqlite3.connect(self.database) as db:
            return {name: db.execute(f'SELECT * FROM "{name}" ORDER BY rowid').fetchall()
                    for (name,) in db.execute("SELECT name FROM sqlite_master WHERE type='table'")}

    def test_only_role_added_and_second_run_is_idempotent(self):
        before = self.snapshot()
        result = self.run_helper(GOVERNANCE_ALLOW_SQLITE_FIXTURES='1')
        self.assertEqual(result.returncode, 0, result.stderr)
        after = self.snapshot()
        self.assertEqual(set(after), set(before))
        self.assertEqual({name for name in before if before[name] != after[name]},
                         {'roles', 'sqlite_sequence'})
        self.assertEqual(after['sqlite_sequence'], [('roles', 2)])
        self.assertEqual(after['roles'][:-1], before['roles'])
        self.assertEqual(after['roles'][-1][1:],
                         ('code_admin', 'Code Administrator', 'Infrastructure', 1,
                          'go', '/platform/administration'))
        result = self.run_helper(GOVERNANCE_ALLOW_SQLITE_FIXTURES='1')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.snapshot(), after)

    def test_refuses_missing_opt_in_and_production_urls_without_changes(self):
        before = self.database.read_bytes()
        for env in ({}, {'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '0'},
                    {'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '1', 'PRODUCTION_DATABASE_URL': 'blocked'},
                    {'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '1', 'GOVERNANCE_DATABASE_URL': 'blocked'}):
            with self.subTest(env=env):
                result = self.run_helper(**env)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn('Explicit isolated CI fixture required', result.stderr)
                self.assertEqual(self.database.read_bytes(), before)

    def test_failed_base_preparer_prevents_role_supplement(self):
        before = self.database.read_bytes()
        for env in ({'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '1'}, {'CI': 'true'},
                    {'CI': 'true', 'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '1',
                     'GOVERNANCE_DATABASE_URL': 'blocked'},
                    {'CI': 'true', 'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '1',
                     'PRODUCTION_DATABASE_URL': 'blocked'}):
            with self.subTest(env=env):
                # GitHub Actions uses bash -e for run steps: failure must stop the chain.
                result = subprocess.run(
                    ['bash', '-e', '-c', f'{sys.executable} {BASE}\n{sys.executable} {HELPER}'],
                    cwd=self.root, env=env, capture_output=True, text=True)
                self.assertNotEqual(result.returncode, 0)
                self.assertNotIn('Code Admin role added', result.stdout)
                self.assertEqual(self.database.read_bytes(), before)

    def test_workflows_chain_after_guarded_base_in_only_target_jobs(self):
        for workflow, job in (('auth-worker-tests', 'auth'), ('growth-marketing', 'growth'),
                              ('admin-reports', 'api')):
            text = (ROOT / f'.github/workflows/{workflow}.yml').read_text()
            body = text.split(f'  {job}:\n', 1)[1]
            if workflow == 'admin-reports':
                body, flutter = body.split('  flutter:\n', 1)
                self.assertIn(HELPER, flutter)
            self.assertIn("GOVERNANCE_ALLOW_SQLITE_FIXTURES: '1'", body)
            self.assertIn(f'run: |\n          python3 {BASE}\n          python3 {HELPER}', body)
            events = ('push', 'pull_request') if workflow == 'auth-worker-tests' else ('pull_request',)
            for event in events:
                match = re.search(rf'^  {event}:\n(?:(?!  \S)[^\n]*\n)*?    paths: (\[[^\n]+\])$', text, re.MULTILINE)
                self.assertIsNotNone(match, (workflow, event))
                paths = ast.literal_eval(match.group(1))
                for path in (BASE, HELPER, 'tools/governance-production/test-ci-fixture.py',
                             'scripts/test-code-admin-audit-fixture.py'):
                    self.assertIn(path, paths, (workflow, event))
            if workflow == 'auth-worker-tests':
                self.assertIn('identity: [uuid, text]', body)



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
