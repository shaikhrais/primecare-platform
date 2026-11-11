import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('migration', Path(__file__).parents[1] / 'migrate-api-error-borders.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
IMPORTS = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"
PANEL = "Cy(id: 'api-error', child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.red)), child: content))"


def screen(body):
    return IMPORTS + 'class Screen { Widget buildScreen(BuildContext context, WidgetRef ref) { final theme = context.theme; ' + body + '; } }'


class ApiErrorBorderMigrationTest(unittest.TestCase):
    def test_exact_error_border_and_surrounding_behavior_preserved(self):
        source = screen('return '+PANEL)
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('Colors.red', 'theme.colors.error'))
        self.assertEqual(m.migrate(result), (result, 0))

    def test_const_ancestors_removed_and_unrelated_consts_retained(self):
        source = screen('return const Column(children: ['+PANEL+', const SizedBox(height: 12)])')
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertNotIn('const Column', result)
        self.assertIn('const SizedBox(height: 12)', result)

    def test_decorative_unlabelled_modified_and_custom_border_colors_stay(self):
        for panel in [PANEL.replace('api-error', 'decoration'), PANEL.replace('Colors.red', 'Colors.red.shade100'),
                      PANEL.replace('Colors.red', 'Colors.red.withOpacity(.5)'),
                      PANEL.replace('Container(', 'CustomPanel('), PANEL.replace('color: Colors.red', 'color: Colors.red, width: 2')]:
            source = screen('return '+panel)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_scope_without_binding_reassignment_parts_and_shadows_stay(self):
        source = screen('return '+PANEL)
        for modified in [source.replace('final theme = context.theme;', ''),
                         source.replace('return ', 'theme = other; return '),
                         source.replace('class Screen', "part 'fragment.dart'; class Screen"),
                         source.replace('class Screen', 'class Colors {} class Screen'),
                         source.replace('final theme', 'final Colors = other; final theme')]:
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_comments_strings_and_restricted_imports_stay(self):
        for modified in [screen('return '+PANEL).replace('color: Colors.red', 'color: /*keep*/ Colors.red'),
                         screen('return '+PANEL).replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;"),
                         screen('final example="'+PANEL+'"; return content')]:
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_multiple_panels_are_independent(self):
        source = screen('return Column(children: ['+PANEL+','+PANEL+'])')
        result, count = m.migrate(source)
        self.assertEqual(count, 2)
        self.assertEqual(result.count('theme.colors.error'), 2)


if __name__ == '__main__':
    unittest.main()
