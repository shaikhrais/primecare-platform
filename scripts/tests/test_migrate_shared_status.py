import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('status', Path(__file__).parents[1] / 'migrate-shared-status.py')
status = importlib.util.module_from_spec(spec)
spec.loader.exec_module(status)
IMPORTS = "import 'package:primecare_ui/primecare_ui.dart';\n"


class SharedStatusMigrationTest(unittest.TestCase):
    def test_error_and_empty_icon_semantics_and_sizes(self):
        source = IMPORTS + 'const Icon(LucideIcons.alertTriangle, color: Colors.red, size: 48); const Icon(LucideIcons.inbox, size: 64, color: Colors.grey);'
        result, count = status.migrate(source)
        self.assertEqual(count, 2)
        self.assertIn('const PrimeStatusIcon(LucideIcons.alertTriangle, tone: PrimeStatusTone.error, size: 48)', result)
        self.assertIn('const PrimeStatusIcon(LucideIcons.inbox, tone: PrimeStatusTone.muted, size: 64)', result)
        self.assertEqual(status.migrate(result), (result, 0))

    def test_error_message_preserves_expression_and_const_parents(self):
        source = IMPORTS + 'const Column(children: [Text(state.error!, style: const TextStyle(color: Colors.red))]);'
        result, count = status.migrate(source)
        self.assertEqual(count, 1)
        self.assertIn('const Column(children: [PrimeStatusText(state.error!, tone: PrimeStatusTone.error)])', result)

    def test_does_not_guess_other_colors_or_icon_meanings(self):
        for icon, color in [('LucideIcons.alertTriangle', 'Colors.orange'), ('LucideIcons.inbox', 'Colors.red'), ('Icons.star', 'Colors.red'), ('LucideIcons.inbox', 'Colors.grey.shade300')]:
            source = IMPORTS + f'Icon({icon}, color: {color})'
            self.assertEqual(status.migrate(source), (source, 0))

    def test_retains_unsupported_options_and_styles(self):
        for call in ['Icon(LucideIcons.inbox, color: Colors.grey, key: key)', 'Icon(LucideIcons.inbox, color: Colors.grey, semanticLabel: label)', 'Icon(LucideIcons.inbox, color: Colors.grey, size: width / 2)', 'Text(state.error!, style: TextStyle(color: Colors.red, fontSize: 12))', 'Text(message, style: TextStyle(color: Colors.red))']:
            source = IMPORTS + call
            self.assertEqual(status.migrate(source), (source, 0))

    def test_preserves_comments_strings_and_qualified_calls(self):
        source = IMPORTS + '''// Icon(LucideIcons.inbox, color: Colors.grey)
final s = "Text(state.error!, style: TextStyle(color: Colors.red))";
ui . Icon(LucideIcons.inbox, color: Colors.grey);
Icon(LucideIcons.inbox, /* keep this */ color: Colors.grey);'''
        self.assertEqual(status.migrate(source), (source, 0))

    def test_skips_concrete_types_local_types_and_restricted_imports(self):
        for prefix in ['final List<Icon> icons = [];', 'class PrimeStatusIcon {}', "part 'other.dart';"]:
            source = IMPORTS + prefix + 'Icon(LucideIcons.inbox, color: Colors.grey)'
            self.assertEqual(status.migrate(source), (source, 0))
        source = IMPORTS.replace(".dart';", ".dart' show PrimeText;") + 'Icon(LucideIcons.inbox, color: Colors.grey)'
        self.assertEqual(status.migrate(source), (source, 0))

    def test_narrow_import_for_package_sections(self):
        source = "library example;\nimport 'package:flutter/material.dart';\nconst icon = Icon(Icons.error_outline, color: Colors.red);"
        result, count = status.migrate(source, add_import=True)
        self.assertEqual(count, 1)
        self.assertIn('PrimeStatusIcon(Icons.error_outline, tone: PrimeStatusTone.error)', result)
        self.assertTrue(result.startswith("library example;\nimport 'package:primecare_ui/src/components/prime_status.dart' show PrimeStatusIcon, PrimeStatusTone;"))
        self.assertEqual(status.migrate(result, add_import=True), (result, 0))

    def test_app_migration_uses_public_api_and_is_idempotent(self):
        source = "import 'package:flutter/material.dart';\nIcon(Icons.error, color: Colors.red);"
        result, count = status.migrate(source, add_import=True, status_import=status.PUBLIC_STATUS_IMPORT)
        self.assertEqual(count, 1)
        self.assertIn("import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;", result)
        self.assertNotIn('primecare_ui/src/', result)
        self.assertEqual(status.migrate(result, add_import=True, status_import=status.PUBLIC_STATUS_IMPORT), (result, 0))

    def test_explicit_check_and_warning_pairs_use_existing_semantic_tokens(self):
        for icon, color, tone in [('Icons.check_circle_outline', 'Colors.green', 'success'),
                                  ('LucideIcons.checkCircle2', 'Colors.green', 'success'),
                                  ('Icons.warning', 'Colors.amber', 'warning')]:
            source = IMPORTS + f'const Icon({icon}, color: {color}, size: 64);'
            result, count = status.migrate(source)
            self.assertEqual(count, 1)
            self.assertIn(f'const PrimeStatusIcon({icon}, tone: PrimeStatusTone.{tone}, size: 64)', result)
            self.assertEqual(status.migrate(result), (result, 0))

    def test_unmatched_check_color_and_decorative_green_stay_for_review(self):
        for call in ['Icon(Icons.check_circle_outline, color: Colors.red)',
                     'Icon(Icons.star, color: Colors.green)',
                     'Icon(Icons.warning, color: Colors.green)']:
            source = IMPORTS + call
            self.assertEqual(status.migrate(source), (source, 0))

    def test_local_function_or_variable_shadow_is_not_rewritten(self):
        for prefix in ['Widget Icon(dynamic icon, {dynamic color}) => widget;',
                       'final Icon = createIcon;',
                       'Widget PrimeStatusIcon(dynamic icon, {dynamic tone}) => widget;']:
            source = IMPORTS + prefix + 'Icon(Icons.check_circle_outline, color: Colors.green);'
            self.assertEqual(status.migrate(source), (source, 0))


if __name__ == '__main__':
    unittest.main()
