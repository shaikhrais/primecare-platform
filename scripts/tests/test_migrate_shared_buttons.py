import importlib.util
import unittest
import subprocess
import sys
import tempfile
from pathlib import Path

spec = importlib.util.spec_from_file_location('buttons', Path(__file__).parents[1] / 'migrate-shared-buttons.py')
buttons = importlib.util.module_from_spec(spec)
spec.loader.exec_module(buttons)
IMPORTS = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"


class SharedButtonMigrationTest(unittest.TestCase):
    def test_tearoffs_require_type_review_before_migrating_other_calls(self):
        for suffix in ['final ctor = TextButton.new;', 'final ctor = TextButton.icon;']:
            source = IMPORTS + suffix + "TextButton(onPressed: go, child: PrimeText('x'));"
            self.assertEqual(buttons.migrate(source), (source, 0))

    def test_cli_rejects_escape_scopes_and_skips_symlinked_sources(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory) / 'repo'
            lib = root / 'apps' / 'sample' / 'lib'
            lib.mkdir(parents=True)
            source = IMPORTS + "TextButton(onPressed: go, child: PrimeText('x'))"
            external = Path(directory) / 'external.dart'
            external.write_text(source)
            (lib / 'linked.dart').symlink_to(external)
            outside_dir = Path(directory) / 'outside'
            outside_dir.mkdir()
            (outside_dir / 'screen.dart').write_text(source)
            (lib / 'linked_directory').symlink_to(outside_dir, target_is_directory=True)
            command = [sys.executable, buttons.__file__, '--root', str(root), '--apply']
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(external.read_text(), source)
            self.assertEqual((outside_dir / 'screen.dart').read_text(), source)
            for scope in ['../external.dart', 'apps/sample/lib/linked.dart', 'apps/sample/lib/linked_directory']:
                result = subprocess.run(command + ['--path', scope], capture_output=True, text=True)
                self.assertNotEqual(result.returncode, 0)
            self.assertEqual(external.read_text(), source)

    def test_cli_dry_run_and_scoped_application(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            lib = root / 'apps' / 'sample' / 'lib'
            lib.mkdir(parents=True)
            source = IMPORTS + "TextButton(onPressed: go, child: PrimeText('x'))"
            selected, other = lib / 'selected.dart', lib / 'other.dart'
            selected.write_text(source)
            other.write_text(source)
            command = [sys.executable, buttons.__file__, '--root', str(root), '--path', 'apps/sample/lib/selected.dart']
            result = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(selected.read_text(), source)
            result = subprocess.run(command + ['--apply'], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn('PrimeButton(', selected.read_text())
            self.assertEqual(other.read_text(), source)

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

    def test_primary_action_preserves_callback_key_and_localized_label(self):
        source = IMPORTS + "ElevatedButton(key: actionKey, onPressed: () => retry(id), child: const PrimeText('Retry'));"
        result, count = buttons.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, IMPORTS + "PrimeButton(key: actionKey, onPressed: () => retry(id), label: 'Retry');")
        self.assertEqual(buttons.migrate(result), (result, 0))

    def test_primary_action_unsupported_options_and_ownership_are_retained(self):
        for call in ["ElevatedButton(style: style, onPressed: go, child: PrimeText('Go'))",
                     "ElevatedButton(onLongPress: hold, onPressed: go, child: PrimeText('Go'))",
                     "ElevatedButton(onPressed: go, child: PrimeText('Go', style: style))",
                     "ui.ElevatedButton(onPressed: go, child: PrimeText('Go'))",
                     "final ctor = ElevatedButton.new; ElevatedButton(onPressed: go, child: PrimeText('Go'))",
                     "class ElevatedButton {} ElevatedButton(onPressed: go, child: PrimeText('Go'))"]:
            source = IMPORTS + call
            self.assertEqual(buttons.migrate(source), (source, 0))


if __name__ == '__main__':
    unittest.main()
