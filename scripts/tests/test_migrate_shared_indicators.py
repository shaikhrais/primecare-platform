import importlib.util
import unittest
from pathlib import Path
spec = importlib.util.spec_from_file_location('indicators', Path(__file__).parents[1] / 'migrate-shared-indicators.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"

class MigrationTest(unittest.TestCase):
    def test_preserves_const_parents_and_layout(self):
        source = PREFIX + 'const Center(child: Padding(padding: EdgeInsets.all(48), child: CircularProgressIndicator()))'
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('CircularProgressIndicator()', 'PrimeLoadingIndicator()'))
        self.assertEqual(m.migrate(result), (result, 0))

    def test_rejects_customized_qualified_shadowed_or_restricted_calls(self):
        cases = [
            PREFIX + 'CircularProgressIndicator(value: progress)',
            PREFIX + 'CircularProgressIndicator(color: Colors.red)',
            PREFIX + 'CircularProgressIndicator(key: key)',
            PREFIX + 'ui . CircularProgressIndicator()',
            PREFIX + 'class PrimeLoadingIndicator {} CircularProgressIndicator()',
            PREFIX + 'final CircularProgressIndicator = factory; CircularProgressIndicator()',
            PREFIX + 'final ctor = CircularProgressIndicator.new; CircularProgressIndicator()',
            PREFIX + 'part of app; CircularProgressIndicator()',
            PREFIX.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;") + 'CircularProgressIndicator()',
            PREFIX.replace("material.dart';", "material.dart' as ui;") + 'CircularProgressIndicator()',
            'CircularProgressIndicator()',
        ]
        for source in cases:
            with self.subTest(source=source):
                self.assertEqual(m.migrate(source), (source, 0))

    def test_preserves_comments_and_strings(self):
        source = PREFIX + '// CircularProgressIndicator()\nfinal sample = "CircularProgressIndicator()"; CircularProgressIndicator(/* keep */)'
        self.assertEqual(m.migrate(source), (source, 0))

    def test_multiple_calls_and_explicit_const(self):
        source = PREFIX + '[const CircularProgressIndicator(), CircularProgressIndicator(\n)]'
        result, count = m.migrate(source)
        self.assertEqual(count, 2)
        self.assertIn('[const PrimeLoadingIndicator(), PrimeLoadingIndicator()]', result)
