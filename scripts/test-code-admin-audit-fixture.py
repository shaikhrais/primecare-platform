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
                self.assertNotIn(HELPER, flutter)
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


if __name__ == '__main__':
    unittest.main()
