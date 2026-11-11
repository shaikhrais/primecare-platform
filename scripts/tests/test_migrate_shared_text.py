import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('migration', Path(__file__).parents[1] / 'migrate-shared-text.py')
migration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(migration)
IMPORTS = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"


class SharedTextMigrationTest(unittest.TestCase):
    def test_preserves_arguments_const_and_callbacks(self):
        source = IMPORTS + "const Text('Hi', key: ValueKey('id'), style: TextStyle(fontSize: 18), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)"
        result, count = migration.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('const Text(', 'const PrimeText('))

    def test_skips_unsupported_signature_and_qualified_calls(self):
        source = IMPORTS + "Text('hi', softWrap: false); Text.rich(span); ui.Text('x'); ui . Text('x'); Text.new;"
        self.assertEqual(migration.migrate(source), (source, 0))

    def test_masks_comments_and_strings_but_keeps_interpolation(self):
        source = IMPORTS + '''// Text('comment')
/* Text('comment') */
final label = "Text('literal') ${Text('interpolation')}";
'''
        result, count = migration.migrate(source)
        self.assertEqual(count, 1)
        self.assertIn("${PrimeText('interpolation')}", result)
        self.assertIn("// Text('comment')", result)
        self.assertIn('"Text(\'literal\')', result)

    def test_nested_calls_and_idempotence(self):
        source = IMPORTS + "Text(format(a, b), style: choose(flag ? a : b, [c,d]),); Text('nested ${Text('x')}');"
        result, count = migration.migrate(source)
        self.assertEqual(count, 3)
        self.assertEqual(migration.migrate(result), (result, 0))

    def test_requires_real_unrestricted_imports(self):
        for imports in ['', '// ' + IMPORTS, IMPORTS.replace("primecare_ui.dart';", "primecare_ui.dart' as ui;"), IMPORTS.replace("primecare_ui.dart';", "primecare_ui.dart' show Other;"), '/*' + IMPORTS + '*/']:
            source = imports + "\nText('x');"
            self.assertEqual(migration.migrate(source), (source, 0))

    def test_skips_local_types_and_parts(self):
        for declaration in ['class Text {}', 'typedef Text = Other;', 'class PrimeText {}', "part 'other.dart';"]:
            source = IMPORTS + declaration + "\nText('x');"
            self.assertEqual(migration.migrate(source), (source, 0))


if __name__ == '__main__':
    unittest.main()
