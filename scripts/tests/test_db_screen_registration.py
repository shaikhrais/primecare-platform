import importlib.util
import sqlite3
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import MagicMock, patch

SCRIPTS = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SCRIPTS))
spec = importlib.util.spec_from_file_location('db_screen_generator', SCRIPTS / 'implement_screens_from_db.py')
generator = importlib.util.module_from_spec(spec)
spec.loader.exec_module(generator)


def fixture(root, duplicate=False):
    database = root / '.agents/governance/governance.db'
    database.parent.mkdir(parents=True)
    with sqlite3.connect(database) as db:
        db.executescript('''
          CREATE TABLE screens (id INTEGER PRIMARY KEY, screen_code TEXT, screen_name TEXT, route_path TEXT,
            actual_file_path TEXT, app_id INTEGER, role_id INTEGER, active INTEGER,
            implementation_tag TEXT, content_tag TEXT, api_tag TEXT, test_tag TEXT, review_tag TEXT,
            completeness_score INTEGER, production_ready INTEGER, runtime_verified INTEGER, cypress_verified INTEGER);
          CREATE TABLE apps (id INTEGER, app_code TEXT, app_name TEXT);
          CREATE TABLE roles (id INTEGER, role_code TEXT, role_name TEXT);
          CREATE TABLE screen_requirements (screen_id INTEGER, business_purpose TEXT, user_story TEXT, acceptance_criteria TEXT);
          CREATE TABLE screen_sections (id INTEGER, screen_id INTEGER, section_name TEXT, section_type TEXT, purpose TEXT, section_order INTEGER);
          CREATE TABLE screen_section_elements (screen_id INTEGER, section_id INTEGER, label TEXT, element_type TEXT, test_id TEXT);
          CREATE TABLE screen_api_map (screen_id INTEGER, api_id INTEGER);
          CREATE TABLE api_registry (id INTEGER, api_name TEXT, method TEXT, endpoint_path TEXT);
          INSERT INTO apps VALUES (1, 'test', 'Test');
          INSERT INTO roles VALUES (1, 'client', 'Client');
          INSERT INTO api_registry VALUES (1, 'Read', 'GET', '/v1/example');
        ''')
        for index in range(1, 3 if duplicate else 2):
            db.execute('INSERT INTO screens (id, screen_code, screen_name, route_path, app_id, role_id, active) VALUES (?, ?, ?, ?, 1, 1, 1)',
                       (index, f'EXAMPLE{index}', f'Example{index}Screen', '/example'))
            db.execute('INSERT INTO screen_sections VALUES (?, ?, ?, ?, ?, 1)', (index, index, 'Main', 'general', 'Review'))
            db.execute('INSERT INTO screen_section_elements VALUES (?, ?, ?, ?, ?)', (index, index, 'Open', 'button', 'open'))
            db.execute('INSERT INTO screen_api_map VALUES (?, 1)', (index,))
    return database


class DatabaseScreenRegistrationTest(unittest.TestCase):
    def test_generates_registration_and_keeps_runtime_unverified(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            database = fixture(root)
            handler = MagicMock()
            with patch.object(generator, '__file__', str(root / 'scripts/implement_screens_from_db.py')), \
                 patch.object(generator, 'ReportHandler', return_value=handler):
                generator.implement_creative_screens_from_db()
            catalog = root / 'packages/primecare_ui/lib/src/features/auth/generated_managed_routes.g.dart'
            self.assertIn("  '/example',", catalog.read_text())
            with sqlite3.connect(database) as db:
                row = db.execute('SELECT actual_file_path, runtime_verified, production_ready FROM screens').fetchone()
            self.assertTrue((root / row[0]).is_file())
            self.assertEqual(row[1:], (0, 0))
            handler.generate_report.assert_called_once()

    def test_existing_generated_source_is_not_overwritten(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            database = fixture(root)
            output = root / 'packages/primecare_ui/lib/src/features/generated_screens/example1.dart'
            output.parent.mkdir(parents=True)
            output.write_text('// Generated directly from SQLite Database\nexisting content')
            with patch.object(generator, '__file__', str(root / 'scripts/implement_screens_from_db.py')), \
                 patch.object(generator, 'ReportHandler', return_value=MagicMock()):
                generator.implement_creative_screens_from_db()
            self.assertEqual(output.read_text(), '// Generated directly from SQLite Database\nexisting content')
            self.assertFalse((root / 'packages/primecare_ui/lib/src/features/auth/generated_managed_routes.g.dart').exists())
            with sqlite3.connect(database) as db:
                self.assertIsNone(db.execute('SELECT actual_file_path FROM screens').fetchone()[0])

    def test_duplicate_routes_fail_before_writing_screens(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            fixture(root, duplicate=True)
            with patch.object(generator, '__file__', str(root / 'scripts/implement_screens_from_db.py')), \
                 patch.object(generator, 'ReportHandler'):
                with self.assertRaisesRegex(ValueError, 'Duplicate'):
                    generator.implement_creative_screens_from_db()
            self.assertFalse((root / 'packages/primecare_ui/lib/src/features/auth/generated_managed_routes.g.dart').exists())
            self.assertEqual(list((root / 'packages/primecare_ui/lib/src/features/generated_screens').glob('*.dart')), [])


if __name__ == '__main__':
    unittest.main()
