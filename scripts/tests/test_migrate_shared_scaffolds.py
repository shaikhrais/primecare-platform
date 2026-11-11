import hashlib
import importlib.util
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('scaffolds', ROOT/'scripts/migrate-shared-scaffolds.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
MANIFEST = json.loads((ROOT/'scripts/shared-scaffold-constructors-manifest.json').read_text())


class SharedScaffoldMigrationTest(unittest.TestCase):
    def original_and_updated(self, path, original_sha, expected):
        current = (ROOT/path).read_text()
        if m.digest(current) == original_sha:
            original = current
            updated, count = m.migrate_source(path, original, original_sha, expected)
        else:
            original, reversed_count = m.reverse_source(path, current, expected)
            self.assertEqual(reversed_count, expected)
            updated, count = current, expected
        self.assertEqual(m.digest(original), original_sha)
        return original, updated, count

    def test_all_actual_sources_round_trip_exactly_and_are_idempotent(self):
        calls = 0
        for path, (original_sha, expected) in MANIFEST.items():
            original, updated, count = self.original_and_updated(path, original_sha, expected)
            self.assertEqual(count, expected, path)
            self.assertEqual(m.reverse_source(path, updated, expected), (original, expected), path)
            self.assertEqual(m.migrate_source(path, updated, original_sha, expected), (updated, 0), path)
            self.assertEqual(original.count('Scaffold.of('), updated.count('Scaffold.of('), path)
            calls += count
        self.assertEqual(len(MANIFEST), 23)
        self.assertEqual(calls, 25)

    def test_only_constructor_identifier_and_narrow_import_change(self):
        for path, (original_sha, expected) in MANIFEST.items():
            original, updated, _ = self.original_and_updated(path, original_sha, expected)
            normalized = updated.replace(m.CORE_IMPORT, '').replace(m.APP_IMPORT, '')
            normalized = normalized.replace('PrimeScaffold', 'Scaffold')
            self.assertEqual(normalized, original, path)

    def test_scaffold_state_lookup_is_not_a_constructor(self):
        source = 'Widget build(BuildContext context) => Scaffold.of(context).widget;'
        self.assertEqual(m.replace_scaffolds(source, 1), (source, 0))

    def test_parts_shadows_qualified_calls_and_wrong_counts_stay_unresolved(self):
        sources = [
            "part 'x.dart'; Widget build() => Scaffold();",
            'class Scaffold {} Widget build() => Scaffold();',
            'Widget Scaffold() => value;',
            'Widget build() => material.Scaffold();',
            'Widget build() => Scaffold();',
        ]
        for source in sources:
            self.assertEqual(m.replace_scaffolds(source, 2), (source, 0))

    def test_import_selection_respects_package_boundary(self):
        self.assertEqual(m.required_import('packages/flutter_core/lib/a.dart', "import 'package:flutter/material.dart';\n"), m.CORE_IMPORT)
        self.assertEqual(m.required_import('apps/demo/lib/a.dart', "import 'package:primecare_ui/primecare_ui.dart';\n"), '')
        self.assertEqual(m.required_import('apps/demo/lib/a.dart', "import 'package:flutter/material.dart';\n"), m.APP_IMPORT)

    def test_all_consumers_are_already_in_native_compile_fixtures(self):
        core = (ROOT/'packages/flutter_core/test/shared_primitives_migration_compile_test.dart').read_text()
        clinic = (ROOT/'apps/primecare_clinic/test/shared_text_migration_compile_test.dart').read_text()
        clinic += (ROOT/'apps/primecare_clinic/test/shared_control_extensions_compile_test.dart').read_text()
        governance = (ROOT/'apps/primecare_governance/test/shared_text_migration_compile_test.dart').read_text()
        governance += (ROOT/'apps/primecare_governance/test/shared_control_extensions_compile_test.dart').read_text()
        enterprise = (ROOT/'apps/primecare_enterprise_blueprint/test/widget_test.dart').read_text()
        for path in MANIFEST:
            name = Path(path).name
            if path.startswith('packages/flutter_core/'):
                self.assertIn(name, core, path)
            elif 'primecare_clinic' in path:
                self.assertIn(name, clinic, path)
            elif 'primecare_governance' in path:
                self.assertIn(name, governance, path)
            else:
                self.assertIn('MyApp', enterprise, path)


if __name__ == '__main__':
    unittest.main()
