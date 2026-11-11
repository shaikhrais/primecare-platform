import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('boundary', Path(__file__).parents[1] / 'check-shared-ui-boundary.py')
boundary = importlib.util.module_from_spec(spec)
spec.loader.exec_module(boundary)

class SharedUiBoundaryTest(unittest.TestCase):
    def test_direct_alias_named_and_generic_controls_fail(self):
        findings = boundary.violations('ui.Text("Name"); FilledButton.tonal(onPressed: null); DropdownButton<String>();', True)
        self.assertEqual([f[2] for f in findings], ['Text', 'FilledButton', 'DropdownButton'])

    def test_comments_and_strings_do_not_create_violations(self):
        self.assertEqual(boundary.violations('// Text("x")\n/* Colors.red */\nfinal label = "Color(0xff000000)";', True), [])

    def test_shared_implementations_may_build_controls_but_not_literal_colors(self):
        self.assertEqual(boundary.violations('Text(label, style: theme.typography.bodyMedium);', False), [])
        self.assertEqual(len(boundary.violations('ui.Color(1); Color.fromARGB(1, 2, 3, 4); Colors.red.shade100;', False)), 3)

    def test_shared_controls_and_theme_tokens_pass(self):
        self.assertEqual(boundary.violations('PrimeCareCard(child: PrimeCareTextField(label: label)); final color = theme.colors.surface;', True), [])

    def test_line_numbers_survive_multiline_comments(self):
        self.assertEqual(boundary.violations('/* first\n second */\nText(label);', True)[0][0], 3)
