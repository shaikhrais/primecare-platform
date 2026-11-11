import importlib.util
import unittest
from pathlib import Path
spec = importlib.util.spec_from_file_location('m', Path(__file__).parents[1] / 'migrate-generated-typography.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = '// Generated directly from SQLite Database\n'

class TypographyTests(unittest.TestCase):
    def test_literal_flags_and_const_are_preserved(self):
        source = PREFIX + 'const TextStyle(italic: true); TextStyle(italic: false);'
        result, count = m.migrate(source)
        self.assertEqual(count, 2)
        self.assertEqual(result, source.replace('italic: true', 'fontStyle: FontStyle.italic').replace('italic: false', 'fontStyle: FontStyle.normal'))
        self.assertEqual(m.migrate(result), (result, 0))

    def test_custom_dynamic_conflicting_and_qualified_styles_stay(self):
        for source in ['TextStyle(italic: value);', 'CustomStyle(italic: true);',
                       'ui.TextStyle(italic: true);', 'TextStyle(fontStyle: FontStyle.normal, italic: true);',
                       'class TextStyle {} TextStyle(italic: true);', 'final FontStyle = value; TextStyle(italic: true);']:
            self.assertEqual(m.migrate(PREFIX + source), (PREFIX + source, 0))

    def test_comments_literals_and_non_template_stay(self):
        for source in [PREFIX + '// TextStyle(italic: true);', PREFIX + 'final s="TextStyle(italic: true)";',
                       PREFIX + 'TextStyle(italic: /*retain*/ true);', 'TextStyle(italic: true);']:
            self.assertEqual(m.migrate(source), (source, 0))
