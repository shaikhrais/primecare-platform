import importlib.util
from contextlib import closing
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
            with closing(sqlite3.connect(database)) as db, db:
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
            with closing(sqlite3.connect(database)) as db, db:
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

    def test_preflight_rejects_duplicate_output_paths_before_writes(self):
        for check_states in (True, False):
            for second_path in ('apps/example/lib/shared_screen.dart',
                                'apps/example/lib/nested/../shared_screen.dart'):
                with self.subTest(check_states=check_states, second_path=second_path), \
                     tempfile.TemporaryDirectory() as directory:
                    root = Path(directory)
                    screens = [
                        {'screen_name': 'FirstScreen', 'route_path': '/first',
                         'expected_file_path': 'apps/example/lib/shared_screen.dart'},
                        {'screen_name': 'SecondScreen', 'route_path': '/second',
                         'expected_file_path': second_path},
                    ]
                    with self.assertRaisesRegex(ValueError, 'Duplicate generated output'):
                        generator.prepare_route_catalog(root, screens,
                                                        check_state_output=check_states)
                    self.assertEqual(list(root.iterdir()), [])

    def test_preflight_reserves_the_catalog_and_extracted_state_paths(self):
        source = 'apps/example/lib/first_screen.dart'
        model = 'packages/primecare_models/lib/src/generated_screen_states/' + source
        for second_path in (str(generator.CATALOG_RELATIVE), model):
            for reverse in (False, True):
                with self.subTest(second_path=second_path, reverse=reverse), \
                     tempfile.TemporaryDirectory() as directory:
                    root = Path(directory)
                    screens = [
                        {'screen_name': 'FirstScreen', 'route_path': '/first',
                         'expected_file_path': source},
                        {'screen_name': 'SecondScreen', 'route_path': '/second',
                         'expected_file_path': second_path},
                    ]
                    if reverse:
                        screens.reverse()
                    with self.assertRaisesRegex(ValueError, 'Duplicate generated output'):
                        generator.prepare_route_catalog(root, screens)
                    self.assertEqual(list(root.iterdir()), [])

    def test_preflight_rejects_ancestor_and_descendant_file_targets(self):
        source = Path('apps/example/lib/shared.dart')
        model = Path('packages/primecare_models/lib/src/generated_screen_states') / source
        for check_states in (True, False):
            conflicts = [source / 'other.dart', generator.CATALOG_RELATIVE.parent,
                         generator.CATALOG_RELATIVE / 'other.dart']
            if check_states:
                conflicts += [model.parent, model / 'other.dart']
            for second_path in conflicts:
                for reverse in (False, True):
                    with self.subTest(check_states=check_states, second_path=second_path,
                                      reverse=reverse), tempfile.TemporaryDirectory() as directory:
                        root = Path(directory)
                        screens = [
                            {'screen_name': 'FirstScreen', 'route_path': '/first',
                             'expected_file_path': str(source)},
                            {'screen_name': 'SecondScreen', 'route_path': '/second',
                             'expected_file_path': str(second_path)},
                        ]
                        if reverse:
                            screens.reverse()
                        with self.assertRaisesRegex(ValueError, 'Conflicting generated output paths'):
                            generator.prepare_route_catalog(root, screens,
                                                            check_state_output=check_states)
                        self.assertEqual(list(root.iterdir()), [])

    def test_preflight_rejects_existing_nondirectory_parents(self):
        source = Path('apps/example/lib/shared.dart')
        model = Path('packages/primecare_models/lib/src/generated_screen_states') / source
        for parent in (source.parent, model.parent, generator.CATALOG_RELATIVE.parent):
            with self.subTest(parent=parent), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                existing = root / parent
                existing.parent.mkdir(parents=True)
                existing.write_text('preserve this file')
                screens = [{'screen_name': 'ExampleScreen', 'route_path': '/example',
                            'expected_file_path': str(source)}]
                with self.assertRaisesRegex(ValueError, 'parent is not a directory'):
                    generator.prepare_route_catalog(root, screens)
                self.assertEqual(existing.read_text(), 'preserve this file')
                self.assertEqual([path for path in root.rglob('*') if path.is_file()], [existing])

    def test_preflight_rejects_state_and_catalog_symlink_escape(self):
        for target in (generator.CATALOG_RELATIVE.parent,
                       Path('packages/primecare_models/lib/src/generated_screen_states')):
            with self.subTest(target=target), tempfile.TemporaryDirectory() as directory:
                root = Path(directory) / 'project'
                outside = Path(directory) / 'outside'
                outside.mkdir()
                link = root / target
                link.parent.mkdir(parents=True)
                link.symlink_to(outside, target_is_directory=True)
                screens = [{'screen_name': 'ExampleScreen', 'route_path': '/example',
                            'expected_file_path': 'apps/example/lib/example_screen.dart'}]
                with self.assertRaisesRegex(ValueError, 'outside the project'):
                    generator.prepare_route_catalog(root, screens)
                self.assertEqual(list(outside.iterdir()), [])
                self.assertFalse((root / 'apps').exists())

    def test_preflight_matches_state_writer_with_source_directory_alias(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            original = root / 'apps/original'
            original.mkdir(parents=True)
            (root / 'apps/alias').symlink_to(original, target_is_directory=True)
            screen_path = 'apps/alias/lib/example_screen.dart'
            model = (root / 'packages/primecare_models/lib/src/generated_screen_states'
                     / screen_path)
            model.parent.mkdir(parents=True)
            model.write_text('existing state source')
            screens = [{'screen_name': 'ExampleScreen', 'route_path': '/example',
                        'expected_file_path': screen_path}]
            with self.assertRaisesRegex(ValueError, 'Generated state already exists'):
                generator.prepare_route_catalog(root, screens)
            self.assertEqual(model.read_text(), 'existing state source')
            self.assertFalse((root / generator.CATALOG_RELATIVE).exists())

    def test_conflicting_batches_preserve_database_exports_and_sources(self):
        source = 'apps/example/lib/shared.dart'
        model = 'packages/primecare_models/lib/src/generated_screen_states/' + source
        for second_path in (source, source + '/other.dart',
                            str(generator.CATALOG_RELATIVE.parent),
                            str(generator.CATALOG_RELATIVE / 'other.dart'),
                            str(Path(model).parent), model + '/other.dart'):
            for reverse in (False, True):
                with self.subTest(second_path=second_path, reverse=reverse), \
                     tempfile.TemporaryDirectory() as directory:
                    root = Path(directory)
                    database = root / 'fixture.db'
                    entry = root / 'packages/primecare_ui/lib/primecare_ui.dart'
                    entry.parent.mkdir(parents=True)
                    entry.write_text('library primecare_ui;\n')
                    rows = [(1, 'FIRST', 'FirstScreen', source, '/first'),
                            (2, 'SECOND', 'SecondScreen', second_path, '/second')]
                    if reverse:
                        rows = [(1, *rows[1][1:]), (2, *rows[0][1:])]
                    with closing(sqlite3.connect(database)) as db, db:
                        db.execute('''CREATE TABLE screens (
                            id INTEGER PRIMARY KEY, screen_code TEXT, screen_name TEXT,
                            expected_file_path TEXT, app_id INTEGER, route_path TEXT,
                            verification_status TEXT)''')
                        db.executemany("INSERT INTO screens VALUES (?, ?, ?, ?, 1, ?, 'pending')", rows)
                    before = {path.relative_to(root): path.read_bytes()
                              for path in root.rglob('*') if path.is_file()}
                    with patch.object(generator, 'PROJECT_ROOT', str(root)), \
                         patch.object(generator, 'DB_PATH', str(database)), \
                         patch.object(generator, 'UI_ENTRY_PATH', str(entry)), \
                         self.assertRaisesRegex(ValueError, '(Duplicate|Conflicting) generated output'):
                        generator.generate_planned_screens()
                    after = {path.relative_to(root): path.read_bytes()
                             for path in root.rglob('*') if path.is_file()}
                    self.assertEqual(after, before)



if __name__ == '__main__':
    unittest.main()
