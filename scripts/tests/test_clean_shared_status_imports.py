import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('cleanup', Path(__file__).parents[1] / 'clean-shared-status-imports.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
HEADER = "import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;\n"


class StatusImportCleanupTest(unittest.TestCase):
    def test_removes_only_unused_text_and_is_idempotent(self):
        source = HEADER + 'const PrimeStatusIcon(Icons.inbox, tone: PrimeStatusTone.muted);'
        result, count = m.clean(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('PrimeStatusIcon, PrimeStatusText,', 'PrimeStatusIcon,'))
        self.assertEqual(m.clean(result), (result, 0))

    def test_text_only_usage_and_executable_interpolation(self):
        for body in ['PrimeStatusText(message, tone: PrimeStatusTone.error);', 'final label="${PrimeStatusText(message, tone: PrimeStatusTone.error)}";']:
            result, count = m.clean(HEADER + body)
            self.assertEqual(count, 1)
            self.assertIn('show PrimeStatusText, PrimeStatusTone;', result)
            self.assertTrue(result.endswith(body))

    def test_comments_and_literal_examples_do_not_count(self):
        body = '// PrimeStatusText\nfinal s="PrimeStatusText"; PrimeStatusIcon(Icons.inbox, tone: PrimeStatusTone.muted);'
        result, count = m.clean(HEADER + body)
        self.assertEqual(count, 1)
        self.assertTrue(result.endswith(body))

    def test_keeps_all_used_names(self):
        source = HEADER + 'PrimeStatusIcon; PrimeStatusText; PrimeStatusTone;'
        self.assertEqual(m.clean(source), (source, 0))

    def test_removes_entire_unused_import(self):
        self.assertEqual(m.clean(HEADER + 'final number=1;'), ('\nfinal number=1;', 3))

    def test_parts_aliases_extra_names_and_commented_imports_stay(self):
        for source in [HEADER + "part 'fragment.dart';", '// ' + HEADER,
                       HEADER.replace(' show ', ' as status show '),
                       HEADER.replace('PrimeStatusTone;', 'PrimeStatusTone, PrimeStatusOther;'),
                       HEADER.replace(' show ', ' /* retained */ show ')]:
            self.assertEqual(m.clean(source), (source, 0))

    def test_multiple_imports_do_not_count_as_usage(self):
        result, count = m.clean(HEADER + HEADER + 'PrimeStatusText;')
        self.assertEqual(count, 4)
        self.assertEqual(result.count('show PrimeStatusText;'), 2)


if __name__ == '__main__':
    unittest.main()
