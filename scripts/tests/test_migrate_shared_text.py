import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('migration', Path(__file__).parents[1] / 'migrate-shared-text.py')
migration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(migration)
IMPORTS = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"


class SharedTextMigrationTest(unittest.TestCase):
    def test_named_key_before_label_preserves_source_order_and_expressions(self):
        source = IMPORTS + "Text(key: const Key('title'), state.title, style: theme.typography.h3);"
        result, count = migration.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('Text(', 'PrimeText('))
        self.assertEqual(migration.migrate(result), (result, 0))

    def test_literal_labels_after_named_arguments_and_trailing_commas(self):
        for label in ["'hello'", '""', "'hello ${user.name}'"]:
            source = IMPORTS + f'Text(key: key, style: style, {label},);'
            result, count = migration.migrate(source)
            self.assertEqual(count, 1)
            self.assertEqual(result, source.replace('Text(', 'PrimeText('))

    def test_missing_duplicate_and_unsupported_arguments_stay(self):
        for call in ["Text(key: key)", "Text(key: key, 'a', 'b')", "Text(key: a, key: b, 'x')", "Text(softWrap: false, 'x')"]:
            source = IMPORTS + call
            self.assertEqual(migration.migrate(source), (source, 0))

    def test_explicit_concrete_types_and_tearoffs_require_type_review(self):
        for suffix in ['final List<Text> labels = [Text("x")];',
                       'Text label = Text("x");',
                       'final ctor = Text.new; Text("x");',
                       'Widget Text(String label) => other; Text("x");']:
            source = IMPORTS + suffix
            self.assertEqual(migration.migrate(source), (source, 0))

    def test_raw_strings_and_nested_comments_remain_unchanged(self):
        source = IMPORTS + '/* outer /* inner */ Text("example") */ final x = r"${Text(1)}";'
        self.assertEqual(migration.migrate(source), (source, 0))

    def test_boundary_check_accepts_replaced_consumer_calls(self):
        source = IMPORTS + 'Text("Name", key: Key("name"));'
        result, count = migration.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(migration.boundary.violations(result, True), [])
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
        for imports in ['', '// ' + IMPORTS.replace('\n', '\n// '), IMPORTS.replace("primecare_ui.dart';", "primecare_ui.dart' as ui;"), IMPORTS.replace("primecare_ui.dart';", "primecare_ui.dart' show Other;"), '/*' + IMPORTS + '*/']:
            source = imports + "\nText('x');"
            self.assertEqual(migration.migrate(source), (source, 0))

    def test_skips_local_types_and_parts(self):
        for declaration in ['class Text {}', 'typedef Text = Other;', 'class PrimeText {}', "part 'other.dart';"]:
            source = IMPORTS + declaration + "\nText('x');"
            self.assertEqual(migration.migrate(source), (source, 0))

    def test_adds_narrow_import_after_library_directive(self):
        source = "library example;\nimport 'package:flutter/material.dart';\nconst value = Text('x');"
        result, count = migration.migrate(source, add_import=True)
        self.assertEqual(count, 1)
        self.assertTrue(result.startswith("library example;\nimport 'package:primecare_ui/primecare_ui.dart' show PrimeText;\n"))
        self.assertEqual(migration.migrate(result, add_import=True), (result, 0))

    def test_dependency_must_be_runtime_dependency(self):
        self.assertTrue(migration.shared_dependency('dependencies:\n  primecare_ui:\n    path: ../../packages/primecare_ui'))
        self.assertFalse(migration.shared_dependency('dev_dependencies:\n  primecare_ui:\n    path: ../../packages/primecare_ui'))
        self.assertFalse(migration.shared_dependency('dependencies:\n  other:\n    primecare_ui: example'))


if __name__ == '__main__':
    unittest.main()


class SharedBarrelTextTests(unittest.TestCase):
    def test_shared_barrel_and_unrelated_hides_preserve_labels_and_styles(self):
        for clause in ['', ' hide ScreenRegistry', ' hide ScreenRegistry, languageProvider']:
            source = "import 'package:primecare_ui/primecare_ui.dart'" + clause + "; Text(localize(key), style: theme.typography.body);"
            result, count = migration.migrate(source)
            self.assertEqual(count, 1)
            self.assertEqual(result, source.replace(' Text(', ' PrimeText('))
            self.assertEqual(migration.migrate(result), (result, 0))

    def test_hidden_or_aliased_text_symbols_stay(self):
        for clause in [' hide Text', ' hide PrimeText', ' as ui', ' show PrimeText']:
            source = "import 'package:primecare_ui/primecare_ui.dart'" + clause + "; Text('Care');"
            self.assertEqual(migration.migrate(source), (source, 0))

class CoreBarrelMigrationTest(unittest.TestCase):
    def test_core_material_export_with_dependency_opt_in_preserves_calls(self):
        source = "import 'package:flutter_core/flutter_core.dart';\nconst Text('Care', style: style, key: key)"
        result,count = migration.migrate(source,add_import=True)
        self.assertEqual(count,1)
        self.assertEqual(result,"import 'package:primecare_ui/primecare_ui.dart' show PrimeText;\n"+source.replace('const Text(', 'const PrimeText('))
        self.assertEqual(migration.migrate(result,add_import=True),(result,0))
        self.assertEqual(migration.migrate(source),(source,0))

    def test_unrelated_hide_is_safe_but_text_hide_alias_show_parts_and_examples_stay(self):
        base="import 'package:flutter_core/flutter_core.dart';\nText('Care')"
        eligible=base.replace("dart';", "dart' hide ProviderTTL;")
        self.assertEqual(migration.migrate(eligible,add_import=True)[1],1)
        for source in [base.replace("dart';", "dart' hide Text;"),base.replace("dart';", "dart' show Text;"),
                       base.replace("dart';", "dart' as core;"), '// '+base, "part 'other.dart';\n"+base]:
            self.assertEqual(migration.migrate(source,add_import=True),(source,0))

    def test_core_barrel_does_not_allow_concrete_types_or_unsupported_signatures(self):
        prefix="import 'package:flutter_core/flutter_core.dart';\n"
        for body in ["Text value = Text('x');", "final make = Text.new; Text('x');", "Text('x', softWrap: false);", "class Text {} Text('x');"]:
            source=prefix+body
            self.assertEqual(migration.migrate(source,add_import=True),(source,0))
