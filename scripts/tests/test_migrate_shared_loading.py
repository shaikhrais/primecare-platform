import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('loading', Path(__file__).parents[1] / 'migrate-shared-loading.py')
loading = importlib.util.module_from_spec(spec)
spec.loader.exec_module(loading)
IMPORT = "import 'package:flutter/material.dart';\n"


class SharedLoadingMigrationTest(unittest.TestCase):
    def test_default_spinner_and_const_parent_use_public_shared_state(self):
        source = IMPORT + 'const Center(child: CircularProgressIndicator());'
        result, count = loading.migrate(source)
        self.assertEqual(count, 1)
        self.assertIn('const DashboardLoadingWidget();', result)
        self.assertIn(loading.IMPORT, result)
        self.assertEqual(loading.migrate(result), (result, 0))

    def test_retains_custom_geometry_keys_and_progress_semantics(self):
        for call in ['Center(key: key, child: CircularProgressIndicator())',
                     'Center(child: CircularProgressIndicator(value: progress))',
                     'Center(child: CircularProgressIndicator(color: color))',
                     'Center(widthFactor: 2, child: CircularProgressIndicator())',
                     'ui . Center(child: CircularProgressIndicator())',
                     'Center(child: ui.CircularProgressIndicator())']:
            source = IMPORT + call
            self.assertEqual(loading.migrate(source), (source, 0))

    def test_retains_comments_examples_and_shadowed_symbols(self):
        for call in ['// Center(child: CircularProgressIndicator())',
                     'final example = "Center(child: CircularProgressIndicator())";',
                     'Center(/* keep */ child: CircularProgressIndicator())',
                     'class Center {} Center(child: CircularProgressIndicator())',
                     "part 'view.dart'; Center(child: CircularProgressIndicator())",
                     'Widget Center() => widget; Center(child: CircularProgressIndicator())']:
            source = IMPORT + call
            self.assertEqual(loading.migrate(source), (source, 0))

    def test_unrestricted_shared_import_is_reused(self):
        source = IMPORT + "import 'package:primecare_ui/primecare_ui.dart';\n" + 'Center(child: const CircularProgressIndicator(),)'
        result, count = loading.migrate(source)
        self.assertEqual(count, 1)
        self.assertNotIn(loading.IMPORT, result)
