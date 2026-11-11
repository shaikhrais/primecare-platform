import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('repair', ROOT/'scripts/migrate-generated-possessives.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)


class GeneratedPossessiveTest(unittest.TestCase):
    def test_three_actual_invalid_sources_repaired_and_migrated(self):
        for row in m.MANIFEST:
            original = json.loads((ROOT/'scripts/tests/fixtures/generated_possessives'/Path(row['path']).with_suffix('.json').name).read_text())['source']
            self.assertFalse(m.palette.frames(m.palette.boundary.executable_code(original)))
            updated, count = m.migrate(original)
            self.assertEqual(count, 73)
            self.assertEqual(updated, (ROOT/row['path']).read_text())
            self.assertTrue(m.palette.frames(m.palette.boundary.executable_code(updated)))
            self.assertIn(m.NEW, updated)
            self.assertEqual(m.migrate(updated), (updated, 0))
            before = m.palette.boundary.violations(original, False)
            after = m.palette.boundary.violations(updated, False)
            # Invalid strings hide the tail from a lexical scan. Compare after
            # syntax repair so all tail literals are counted on both sides.
            fixed = original.replace(m.OLD, m.NEW)
            self.assertEqual(len(m.palette.boundary.violations(fixed, False))-len(after), 73)
            self.assertIn("fontSize: 14", updated)
            self.assertIn("theme.colors.onSurface", updated)

    def test_changed_sources_never_repaired_by_guessing(self):
        for row in m.MANIFEST:
            source = json.loads((ROOT/'scripts/tests/fixtures/generated_possessives'/Path(row['path']).with_suffix('.json').name).read_text())['source']
            for changed in [source+'\n', source.replace('context.theme','otherTheme'),
                            source.replace("client's", "patient's"), source.replace('0xFF881337','0xFF000000')]:
                self.assertEqual(m.migrate(changed), (changed, 0))

    def test_new_compile_fixture_references_all_three_actual_classes(self):
        fixture = (ROOT/'packages/primecare_ui/test/generated_possessives_compile_test.dart').read_text()
        for row in m.MANIFEST:
            self.assertIn('src/features/generated_screens/'+Path(row['path']).name, fixture)


if __name__ == '__main__':
    unittest.main()
