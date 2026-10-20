"""Recovery views preserve native routes and never earn completion credit."""
import os
import hashlib
import json
import sqlite3
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASELINE = json.loads((ROOT / 'docs/auth-recovery/native-presentation-baseline.json').read_text())['screens']


class RecoveryGovernance(unittest.TestCase):
    def setUp(self):
        if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):
            raise RuntimeError('Isolated recovery tests forbid production credentials')
        if not (ROOT / '.agents/governance/governance.db').is_file():
            raise RuntimeError('Explicit isolated checkpoint fixture required')
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.database = Path(self.temp.name) / 'governance.db'
        self.output = Path(self.temp.name) / 'policy.json'
        with sqlite3.connect(ROOT / '.agents/governance/governance.db') as source:
            with sqlite3.connect(self.database) as target:
                source.backup(target)

    def run_registrar(self, *extra, success=True):
        result = subprocess.run([sys.executable, str(ROOT / 'scripts/register-auth-recovery-web.py'),
                                 '--database', str(self.database), '--output', str(self.output), *extra],
                                capture_output=True, text=True, env={**os.environ, 'GOVERNANCE_ALLOW_SQLITE_FIXTURES':'1'})
        self.assertEqual(result.returncode == 0, success, result.stderr)

    def dump(self):
        with sqlite3.connect(self.database) as db:
            digest = hashlib.sha256()
            for line in db.iterdump():
                # Ignored INSERTs may advance SQLite allocation counters.
                if not line.startswith('INSERT INTO \"sqlite_sequence\"'):
                    digest.update(line.encode())
                    digest.update(b'\n')
            return digest.hexdigest()

    def test_native_routes_and_web_controls_are_independent_and_idempotent(self):
        self.run_registrar()
        with sqlite3.connect(self.database) as db:
            for row in BASELINE:
                self.assertEqual(db.execute('SELECT route_path,actual_file_path FROM screens WHERE screen_code=?',
                                            (row['screen_code'],)).fetchone(),
                                 (row['route_path'], row['actual_file_path']))
                self.assertTrue((ROOT / row['actual_file_path']).is_file())
                if row['actual_file_path'].endswith('/workspace/governed_workspace_screen.dart'):
                    routes = (ROOT / 'packages/primecare_ui/lib/src/features/workspace/workspace_routes_generated.dart').read_text()
                    self.assertTrue('"' + row['route_path'] + '"' in routes, row['route_path'])
                self.assertEqual(db.execute('SELECT production_ready FROM screens WHERE screen_code=?',
                                            (row['screen_code'],)).fetchone()[0], 0)
            policy = json.loads(db.execute("SELECT definition FROM auth_recovery_web_policy WHERE id='recovery-web-v1'").fetchone()[0])
            self.assertEqual(json.loads(self.output.read_text()), policy)
            for mode, view in policy['views'].items():
                self.assertEqual(view['route'], policy['routes'][mode])
                self.assertEqual(view['endpoint'], policy['endpoints'][mode])
                self.assertEqual((view['implementationTag'], view['testTag']), ('partial', 'test_pending'))
                self.assertEqual(len(view['controls']), 9)
                self.assertEqual(len({c['testId'] for c in view['controls']}), 9)
                for control in view['controls']:
                    self.assertEqual(db.execute('SELECT component_code FROM primecare_ui_component_registry WHERE id=?',
                                                (control['componentId'],)).fetchone()[0], control['component'])
        before = self.dump()
        self.run_registrar()
        self.assertEqual(self.dump(), before)
        source_digest = hashlib.sha256(self.database.read_bytes()).hexdigest()
        self.run_registrar('--check')
        self.assertEqual(hashlib.sha256(self.database.read_bytes()).hexdigest(), source_digest)

    def test_previous_web_registration_is_reconciled_without_removing_native_sections(self):
        native_sections = {}
        with sqlite3.connect(self.database) as db:
            for mode, row in zip(['forgot', 'reset'], BASELINE):
                sid = db.execute('SELECT id FROM screens WHERE screen_code=?', (row['screen_code'],)).fetchone()[0]
                native_sections[sid] = db.execute("SELECT section_code,section_name FROM screen_sections WHERE screen_id=? AND section_code<>'auth-recovery' ORDER BY section_order", (sid,)).fetchall()
                db.execute("UPDATE screens SET route_path=?,actual_file_path='websites/typescript/src/auth-recovery.ts' WHERE id=?", ('/' + mode + '-password', sid))
                db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,required,file_path,test_id,status) SELECT ?,'auth-recovery','Account recovery','form',0,1,'websites/typescript/src/auth-recovery.ts','auth-recovery','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='auth-recovery')", (sid, sid))
                section = db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='auth-recovery'", (sid,)).fetchone()[0]
                element = db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,element_order) VALUES(?,?,'recovery-email','input','Synthetic migration fixture','recovery-email',1,1,99)", (section, sid)).lastrowid
                component = db.execute("SELECT id FROM primecare_ui_component_registry WHERE component_code='prime_text_field'").fetchone()[0]
                db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) VALUES(?,?,?,'input',?,'html-accessible','Synthetic migration fixture',1)", (sid, section, element, component))
        self.run_registrar()
        with sqlite3.connect(self.database) as db:
            self.assertEqual(db.execute("SELECT COUNT(*) FROM screen_section_elements WHERE element_key='recovery-email'").fetchone()[0], 0)
            self.assertEqual(db.execute('SELECT COUNT(*) FROM element_primecare_component_map m LEFT JOIN screen_section_elements e ON e.id=m.element_id WHERE e.id IS NULL').fetchone()[0], 0)
            for sid, sections in native_sections.items():
                self.assertEqual(db.execute('SELECT section_code,section_name FROM screen_sections WHERE screen_id=? ORDER BY section_order', (sid,)).fetchall(), sections)

    def test_unreviewed_web_control_is_not_deleted(self):
        with sqlite3.connect(self.database) as db:
            sid = db.execute("SELECT id FROM screens WHERE screen_code='forgot_password'").fetchone()[0]
            section = db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,required,file_path,test_id,status) VALUES(?,'auth-recovery','Account recovery','form',0,1,'websites/typescript/src/auth-recovery.ts','auth-recovery','created')", (sid,)).lastrowid
            db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,element_order) VALUES(?,?,'unreviewed-control','input','Synthetic unreviewed control','unreviewed-control',1,1,99)", (section, sid))
        before = self.dump()
        self.run_registrar(success=False)
        self.assertEqual(self.dump(), before)

    def test_unreviewed_native_route_is_rejected_without_partial_database_changes(self):
        with sqlite3.connect(self.database) as db:
            db.execute("UPDATE screens SET route_path='/unreviewed-recovery' WHERE screen_code='forgot_password'")
        before = self.dump()
        self.run_registrar(success=False)
        self.assertEqual(self.dump(), before)
        self.assertFalse(self.output.exists())


if __name__ == '__main__':
    unittest.main()
