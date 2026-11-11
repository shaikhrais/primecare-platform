import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('buttons', Path(__file__).parents[1] / 'migrate-shared-buttons.py')
buttons = importlib.util.module_from_spec(spec)
spec.loader.exec_module(buttons)
IMPORTS = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"


class SharedButtonMigrationTest(unittest.TestCase):
    def test_preserves_callback_key_localization_and_const(self):
        source = IMPORTS + "const TextButton(key: Key('id'), onPressed: null, child: PrimeText('Retry'.tr()))"
        result, count = buttons.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, IMPORTS + "const PrimeButton(isGhost: true, key: Key('id'), onPressed: null, label: 'Retry'.tr())")

    def test_preserves_complex_callback(self):
        callback = "() async { await controller.load(a, b); if (mounted) setState(() {}); }"
        source = IMPORTS + 'TextButton(onPressed: ' + callback + ", child: PrimeText(format(a, b)),)"
        result, count = buttons.migrate(source)
        self.assertEqual(count, 1)
        self.assertIn('onPressed: ' + callback, result)
        self.assertIn('label: format(a, b)', result)
        self.assertEqual(buttons.migrate(result), (result, 0))

    def test_skips_styled_labels_and_other_options(self):
        for value in ["TextButton(onPressed: go, child: PrimeText('x', style: style))", "TextButton(onPressed: go, style: style, child: PrimeText('x'))", "TextButton(onLongPress: go, onPressed: go, child: PrimeText('x'))", "TextButton.icon(onPressed: go, label: PrimeText('x'), icon: icon)"]:
            source = IMPORTS + value
            self.assertEqual(buttons.migrate(source), (source, 0))

    def test_preserves_comments_strings_and_qualified_calls(self):
        source = IMPORTS + "// TextButton(onPressed: go, child: PrimeText('x'))\nfinal s = \"TextButton(onPressed: go, child: PrimeText('x'))\"; ui . TextButton(onPressed: go, child: PrimeText('x'));"
        self.assertEqual(buttons.migrate(source), (source, 0))

    def test_requires_unrestricted_import_and_no_local_type(self):
        for prefix in ['', IMPORTS.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;"), IMPORTS + 'class PrimeButton {}']:
            source = prefix + "TextButton(onPressed: go, child: PrimeText('x'))"
            self.assertEqual(buttons.migrate(source), (source, 0))

    def test_handles_nested_callback_button_without_overlapping_edits(self):
        source = IMPORTS + "TextButton(onPressed: () { TextButton(onPressed: go, child: PrimeText('inner')); }, child: PrimeText('outer'))"
        result, count = buttons.migrate(source)
        self.assertEqual(count, 2)
        self.assertEqual(result.count('PrimeButton('), 2)
        self.assertIn("label: 'inner'", result)
        self.assertIn("label: 'outer'", result)


if __name__ == '__main__':
    unittest.main()
