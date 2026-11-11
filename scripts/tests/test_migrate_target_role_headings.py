import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('heading', ROOT / 'scripts/migrate-target-role-headings.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)


class TargetRoleHeadingsTest(unittest.TestCase):
    def test_all_actual_sources_round_trip_and_idempotence(self):
        self.assertEqual(len(m.MANIFEST), 131)
        imports = '\n'.join(p.read_text() for p in (ROOT/'packages/primecare_ui/test').glob('*compile_test.dart'))
        for row in m.MANIFEST:
            current = (ROOT/row['path']).read_text()
            original = current.replace(row['new'], row['old'])
            updated, count = m.migrate(original)
            self.assertEqual(count, 1, row['path'])
            self.assertEqual(updated.replace(row['new'], row['old']), original)
            self.assertEqual(m.migrate(updated), (updated, 0))
            self.assertIn(Path(row['path']).name, imports)

    def test_native_fixture_matches_each_former_palette(self):
        fixture = (ROOT/'packages/primecare_ui/test/fixtures/target_role_headings_fixture.dart').read_text()
        for row in m.MANIFEST:
            self.assertIn(row['new'].splitlines()[2].strip(), fixture)
        self.assertEqual(fixture.count('return Text('), 5)

    def test_modified_source_is_rejected(self):
        row = m.MANIFEST[0]
        current = (ROOT/row['path']).read_text()
        source = current.replace(row['new'], row['old'])
        for changed in [source+'\n', source.replace('context.theme','otherTheme'),
                        source.replace("import 'package:flutter/material.dart';", ''),
                        source.replace('Target Role:', 'Target Person:'),
                        source.replace('fontSize: 14', 'fontSize: 15'),
                        source.replace('theme.colors.surface', 'theme.colors.primary')]:
            self.assertEqual(m.migrate(changed), (changed, 0))

    def test_all_patterns_use_the_same_heading_role(self):
        for row in m.MANIFEST:
            self.assertIn('theme.colors.onSurface', row['new'])
            self.assertNotIn('const TextStyle', row['new'])
            self.assertEqual(row['old'].splitlines()[1], row['new'].splitlines()[1])
            self.assertEqual(row['new'].replace('style: TextStyle', 'style: const TextStyle').replace(
                'theme.colors.onSurface', row['old'].split('color: ')[1].split(', fontSize')[0]), row['old'])


if __name__ == '__main__':
    unittest.main()
