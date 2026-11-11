import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('workspace_pages', Path(__file__).parents[1] / 'migrate-shared-workspace-pages.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"
SHELL = "Scaffold(key: const Key('workspace'), backgroundColor: theme.colors.background, appBar: AppBar(backgroundColor: theme.colors.surface, elevation: 0, title: heading, actions: [PrimeIconButton(icon: icon, onPressed: () => controller.refresh())]), body: content)"


class WorkspacePageMigrationTest(unittest.TestCase):
    def test_preserves_scaffold_identity_colors_title_body_and_actions(self):
        source = PREFIX + SHELL
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        for fragment in ["scaffoldKey: const Key('workspace')", 'backgroundColor: theme.colors.background',
                         'headerColor: theme.colors.surface', 'title: heading', 'body: content',
                         'actions: [PrimeIconButton(icon: icon, onPressed: () => controller.refresh())]']:
            self.assertIn(fragment, result)
        self.assertEqual(m.migrate(result), (result, 0))
        self.assertEqual(m.b.text.boundary.violations(result, True), [])

    def test_global_dynamic_and_interpolated_keys_require_review(self):
        for key in ['globalKey', 'const ValueKey(1)', "Key('workspace')", "const Key('$id')"]:
            source = PREFIX + SHELL.replace("const Key('workspace')", key)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_unmatched_color_and_elevation_semantics_stay(self):
        for original, replacement in [('theme.colors.background', 'theme.colors.surface'),
                                      ('theme.colors.surface', 'theme.colors.primary'),
                                      ('elevation: 0', 'elevation: 4')]:
            source = PREFIX + SHELL.replace(original, replacement)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_custom_scaffold_and_header_options_stay(self):
        for source in [PREFIX + SHELL.replace('body: content', 'body: content, resizeToAvoidBottomInset: false'),
                       PREFIX + SHELL.replace('title: heading', 'title: heading, centerTitle: true'),
                       PREFIX + SHELL.replace('title: heading', 'key: headerKey, title: heading')]:
            self.assertEqual(m.migrate(source), (source, 0))

    def test_nested_body_shells_preserve_both(self):
        source = PREFIX + SHELL.replace('body: content', 'body: '+SHELL)
        result, count = m.migrate(source)
        self.assertEqual(count, 2)
        self.assertEqual(result.count('PrimeWorkspaceScaffold('), 2)
        self.assertEqual(m.migrate(result), (result, 0))

    def test_concrete_types_parts_qualified_and_shadowed_symbols_stay(self):
        for declaration in ['class Scaffold {}', 'final List<AppBar> headers=[];',
                            'final ctor=Scaffold.new;', 'Widget PrimeWorkspaceScaffold()=>other;',
                            "part 'fragment.dart';"]:
            source = PREFIX + declaration + SHELL
            self.assertEqual(m.migrate(source), (source, 0))
        source = PREFIX + 'ui . '+SHELL
        self.assertEqual(m.migrate(source), (source, 0))

    def test_restricted_imports_and_commented_headers_stay(self):
        for source in [PREFIX.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;") + SHELL,
                       '// '+PREFIX + SHELL,
                       PREFIX + SHELL.replace('title: heading', 'title: /* keep */ heading')]:
            self.assertEqual(m.migrate(source), (source, 0))

    def test_body_and_title_string_interpolation_is_preserved(self):
        source = PREFIX + SHELL.replace('title: heading', '''title: PrimeText('Care ${state.title}')''').replace('body: content', 'body: buildContent(context, data)')
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertIn("title: PrimeText('Care ${state.title}')", result)
        self.assertIn('body: buildContent(context, data)', result)


if __name__ == '__main__':
    unittest.main()
