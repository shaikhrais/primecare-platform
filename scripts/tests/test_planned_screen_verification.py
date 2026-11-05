import importlib.util
import json
import sqlite3
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

SCRIPTS = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SCRIPTS))
spec = importlib.util.spec_from_file_location('planned_screen_generator', SCRIPTS / 'generate_and_verify_planned_screens.py')
generator = importlib.util.module_from_spec(spec)
spec.loader.exec_module(generator)


class PlannedScreenVerificationTest(unittest.TestCase):
    def test_generation_does_not_claim_runtime_verification(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            database = root / 'fixture.db'
            ui_entry = root / 'packages/primecare_ui/lib/primecare_ui.dart'
            ui_entry.parent.mkdir(parents=True)
            ui_entry.write_text('library primecare_ui;\n')
            with sqlite3.connect(database) as db:
                db.executescript('''
                    CREATE TABLE screens (
                      id INTEGER PRIMARY KEY, screen_code TEXT, screen_name TEXT,
                      expected_file_path TEXT, app_id INTEGER, route_path TEXT,
                      verification_status TEXT, actual_file_path TEXT, file_exists INTEGER,
                      import_works INTEGER, class_exists INTEGER, route_exists INTEGER,
                      widget_exported INTEGER, widget_renders INTEGER,
                      component_list_text TEXT, component_behavior_text TEXT,
                      component_audit_json TEXT, last_checked_at TEXT
                    );
                    CREATE TABLE code_files (
                      id INTEGER PRIMARY KEY, app_id INTEGER, file_name TEXT,
                      file_path TEXT, file_type TEXT, language TEXT, is_generated INTEGER,
                      purpose TEXT, lines_of_code INTEGER
                    );
                    INSERT INTO screens (id, screen_code, screen_name, expected_file_path,
                      app_id, route_path, verification_status)
                    VALUES (1, 'EXAMPLE', 'ExampleScreen',
                      'packages/primecare_ui/lib/src/screens/example_screen.dart',
                      1, '/example', 'pending');
                ''')
            with patch.object(generator, 'PROJECT_ROOT', str(root)), \
                 patch.object(generator, 'DB_PATH', str(database)), \
                 patch.object(generator, 'UI_ENTRY_PATH', str(ui_entry)):
                generator.generate_planned_screens()
            with sqlite3.connect(database) as db:
                row = db.execute('SELECT file_exists, class_exists, import_works, route_exists, '
                                 'widget_exported, widget_renders, component_audit_json FROM screens').fetchone()
            self.assertEqual(row[:6], (1, 1, 0, 0, 0, 0))
            self.assertTrue(all(item['status'] == 'generated' for item in json.loads(row[6])))
            catalog = root / generator.CATALOG_RELATIVE
            self.assertIn("  '/example',", catalog.read_text())
            generated = root / 'packages/primecare_ui/lib/src/screens/example_screen.dart'
            source = generated.read_text()
            self.assertNotIn('Security posture sync complete.', source)
            self.assertNotIn('All governance invariants validated via API.', source)
            self.assertNotIn('Dashboard telemetry synchronized.', source)
            self.assertNotIn('Level 4 Approved', source)
            self.assertNotIn('Zero exceptions logged', source)
            self.assertNotIn('/compliance/scan', source)
            self.assertIn('Dashboard data is not available yet.', source)

    def test_preflight_rejects_duplicate_or_existing_output(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            screen = {'screen_name': 'ExampleScreen', 'route_path': '/example',
                      'expected_file_path': 'apps/example/lib/example_screen.dart'}
            with self.assertRaisesRegex(ValueError, 'Duplicate'):
                generator.prepare_route_catalog(root, [screen, screen])
            self.assertFalse((root / generator.CATALOG_RELATIVE).exists())
            output = root / screen['expected_file_path']
            output.parent.mkdir(parents=True)
            output.write_text('existing user source')
            with self.assertRaisesRegex(ValueError, 'existing output'):
                generator.prepare_route_catalog(root, [screen])
            self.assertEqual(output.read_text(), 'existing user source')
            self.assertFalse((root / generator.CATALOG_RELATIVE).exists())

    def test_route_validation_accepts_root_and_named_parameters(self):
        self.assertTrue(generator.valid_route('/'))
        self.assertTrue(generator.valid_route('/clients/:clientId/details'))
        for route in ('', '//clients', '/clients/:', '/clients?token=secret', '/clients/:id(.*)'):
            self.assertFalse(generator.valid_route(route), route)


if __name__ == '__main__':
    unittest.main()
