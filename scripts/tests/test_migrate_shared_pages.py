import importlib.util
import unittest
from pathlib import Path
spec = importlib.util.spec_from_file_location('m', Path(__file__).parents[1] / 'migrate-shared-pages.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX="import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"

class PageMigrationTests(unittest.TestCase):
    def test_preserves_title_body_and_callbacks(self):
        source=PREFIX+"Scaffold(appBar: AppBar(title: const PrimeText('Page')), body: buildBody(() { save(a,b); }));"
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertEqual(result,PREFIX+"PrimePageScaffold(title: const PrimeText('Page'), body: buildBody(() { save(a,b); }));")
        self.assertEqual(m.migrate(result),(result,0))

    def test_custom_header_or_shell_options_and_keys_stay(self):
        for source in ["Scaffold(key: key, appBar: AppBar(title: heading), body: body);",
                       "Scaffold(appBar: AppBar(key: key, title: heading), body: body);",
                       "Scaffold(appBar: AppBar(title: heading, actions: actions), body: body);",
                       "Scaffold(appBar: AppBar(title: heading), body: body, drawer: drawer);",
                       "Scaffold(appBar: AppBar(title: heading), body: body, backgroundColor: color);",
                       "Scaffold(appBar: AppBar(title: heading, centerTitle: true), body: body);"]:
            self.assertEqual(m.migrate(PREFIX+source),(PREFIX+source,0))

    def test_type_ambiguity_qualified_calls_and_parts_stay(self):
        for prefix in ['class Scaffold {}', 'final ctor=AppBar.new;', 'final List<Scaffold> pages=[];',
                       'Widget PrimePageScaffold()=>other;', "part 'other.dart';"]:
            source=PREFIX+prefix+'Scaffold(appBar: AppBar(title: heading), body: body);'
            self.assertEqual(m.migrate(source),(source,0))
        source=PREFIX+'ui . Scaffold(appBar: AppBar(title: heading), body: body);'
        self.assertEqual(m.migrate(source),(source,0))

    def test_narrow_import_is_opt_in_and_preserves_library_directive(self):
        source="library example;\nimport 'package:flutter/material.dart';\nScaffold(appBar: AppBar(title: heading), body: body);"
        result,count=m.migrate(source,add_import=True)
        self.assertEqual(count,1)
        self.assertTrue(result.startswith('library example;\n'+m.IMPORT))
        self.assertEqual(m.migrate(result,add_import=True),(result,0))
        self.assertEqual(m.migrate(source),(source,0))

    def test_comments_strings_and_comment_in_header_stay(self):
        for source in ["// Scaffold(appBar: AppBar(title: heading), body: body);",
                       'final example="Scaffold(appBar: AppBar(title: heading), body: body)";',
                       'Scaffold(appBar: AppBar(/*retain*/ title: heading), body: body);']:
            self.assertEqual(m.migrate(PREFIX+source),(PREFIX+source,0))

    def test_nested_body_shells_remain_valid_and_independent(self):
        source=PREFIX+'Scaffold(appBar: AppBar(title: outer), body: Scaffold(appBar: AppBar(title: inner), body: leaf));'
        result,count=m.migrate(source)
        self.assertEqual(count,2)
        self.assertEqual(result.count('PrimePageScaffold('),2)
        self.assertEqual(m.migrate(result),(result,0))

    def test_strict_gate_accepts_only_the_shared_shell(self):
        source=PREFIX+"Scaffold(appBar: AppBar(title: PrimeText('Title')), body: content);"
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertEqual(m.b.text.boundary.violations(result,True),[])
