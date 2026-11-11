import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('migration', Path(__file__).parents[1] / 'migrate-shared-icon-buttons.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"


class SharedIconButtonMigrationTest(unittest.TestCase):
    def test_preserves_callback_key_icon_and_argument_order(self):
        source = PREFIX + "IconButton(key: const Key('refresh'), icon: PrimeIcon(Icons.refresh, color: theme.colors.primary), onPressed: () => controller.refreshData());"
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('IconButton(', 'PrimeIconButton('))
        self.assertEqual(m.migrate(result), (result, 0))
        self.assertEqual(m.b.text.boundary.violations(result, True), [])

    def test_const_and_disabled_controls_are_retained(self):
        source = PREFIX + 'const IconButton(onPressed: null, icon: PrimeIcon(Icons.refresh),);'
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('IconButton(', 'PrimeIconButton('))

    def test_unsupported_options_named_constructors_and_missing_arguments_stay(self):
        for call in ['IconButton(icon: icon, onPressed: action, tooltip: label)',
                     'IconButton.filled(icon: icon, onPressed: action)',
                     'IconButton(icon: icon)', 'IconButton(onPressed: action)',
                     'IconButton(icon: icon, onPressed: a, onPressed: b)']:
            source = PREFIX + call
            self.assertEqual(m.migrate(source), (source, 0))

    def test_concrete_types_parts_and_shadowed_constructors_stay(self):
        for declaration in ['class IconButton {}', 'Widget IconButton()=>other;',
                            'final PrimeIconButton=other;', 'final ctor=IconButton.new;',
                            'final List<IconButton> actions=[];', "part 'fragment.dart';"]:
            source = PREFIX + declaration + 'IconButton(icon: icon, onPressed: action);'
            self.assertEqual(m.migrate(source), (source, 0))

    def test_comments_strings_and_qualified_calls_stay(self):
        source = PREFIX + '''// IconButton(icon: icon, onPressed: action)
final example="IconButton(icon: icon, onPressed: action)";
ui . IconButton(icon: icon, onPressed: action);'''
        self.assertEqual(m.migrate(source), (source, 0))

    def test_restricted_and_fake_imports_stay(self):
        for prefix in [PREFIX.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeIcon;"),
                       PREFIX.replace("material.dart';", "material.dart' as ui;"), '// '+PREFIX]:
            source = prefix + 'IconButton(icon: icon, onPressed: action);'
            self.assertEqual(m.migrate(source), (source, 0))

    def test_comments_inside_arguments_are_preserved(self):
        source = PREFIX + 'IconButton(/* keep */ icon: icon, onPressed: action /* async later */);'
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('IconButton(', 'PrimeIconButton('))


if __name__ == '__main__':
    unittest.main()
