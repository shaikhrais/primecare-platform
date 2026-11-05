import re
import unittest
from pathlib import Path


CATALOG = (Path(__file__).resolve().parents[2] /
           'packages/primecare_ui/lib/src/screens/module_screen_registrations.dart')


class ModuleScreenCatalogTest(unittest.TestCase):
    def test_snapshot_contains_unique_literal_paths_without_interpolation(self):
        lines = CATALOG.read_text(encoding='utf-8').splitlines()
        entries = [line.strip() for line in lines if line.startswith('  ')]
        self.assertTrue(entries)
        paths = []
        for entry in entries:
            match = re.fullmatch(r"'(/[^'$]*)',", entry)
            self.assertIsNotNone(match, f'Invalid catalog entry: {entry}')
            paths.append(match.group(1))
        self.assertEqual(len(paths), len(set(paths)), 'Duplicate catalog paths')


if __name__ == '__main__':
    unittest.main()
