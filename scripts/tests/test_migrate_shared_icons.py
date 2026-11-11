import importlib.util
import unittest
import subprocess
import sys
import tempfile
from pathlib import Path
spec = importlib.util.spec_from_file_location('m', Path(__file__).parents[1] / 'migrate-shared-icons.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"

class IconMigrationTests(unittest.TestCase):
    def test_cli_scope_and_symlink_escape_are_enforced(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory)/'repo';lib=root/'apps/demo/lib';lib.mkdir(parents=True)
            (lib.parent/'pubspec.yaml').write_text('dependencies:\n  primecare_ui:\n    path: ../../packages/primecare_ui\n')
            source=PREFIX+'const Icon(Icons.star);'
            external=Path(directory)/'outside.dart';external.write_text(source)
            (lib/'linked.dart').symlink_to(external)
            selected=lib/'selected.dart';selected.write_text(source)
            command=[sys.executable,m.__file__,'--root',str(root)]
            result=subprocess.run(command,capture_output=True,text=True)
            self.assertEqual(result.returncode,0,result.stderr)
            self.assertEqual(selected.read_text(),source)
            result=subprocess.run(command+['--apply','--path','apps/demo/lib/selected.dart'],capture_output=True,text=True)
            self.assertEqual(result.returncode,0,result.stderr)
            self.assertIn('PrimeIcon(',selected.read_text())
            result=subprocess.run(command+['--apply','--path','apps/demo/lib/linked.dart'],capture_output=True,text=True)
            self.assertNotEqual(result.returncode,0)
            result=subprocess.run(command+['--apply','--path','../outside.dart'],capture_output=True,text=True)
            self.assertNotEqual(result.returncode,0)
            self.assertEqual(external.read_text(),source)

    def test_supported_arguments_const_and_comments_remain_exact(self):
        source = PREFIX + "const Icon(Icons.star, /*meaning*/ key: Key('x'), color: theme.colors.primary, size: 20, semanticLabel: 'Section', textDirection: TextDirection.rtl);"
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('const Icon(', 'const PrimeIcon('))
        self.assertEqual(m.migrate(result), (result, 0))

    def test_concrete_types_tearoffs_and_shadows_stay(self):
        for prefix in ['final List<Icon> x=[];', 'final factory=Icon.new;', 'class Icon {}',
                       'typedef Icon = Custom;', 'Widget PrimeIcon(dynamic icon)=>other;',
                       'final Icon=other;', "part 'child.dart';"]:
            source=PREFIX+prefix+'Icon(Icons.star);'
            self.assertEqual(m.migrate(source),(source,0))

    def test_unsupported_signatures_qualifiers_and_imports_stay(self):
        for call in ['Icon(Icons.star, weight: 300);', 'Icon(Icons.star, opticalSize: 20);',
                     'Icon(Icons.star, size: 20, size: 30);', 'Icon(Icons.star, other);',
                     'ui . Icon(Icons.star);', 'Icon(semanticLabel: label);']:
            source=PREFIX+call
            self.assertEqual(m.migrate(source),(source,0))
        source=PREFIX.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;")+'Icon(Icons.star);'
        self.assertEqual(m.migrate(source),(source,0))

    def test_nested_expressions_and_interpolation_preserve_source(self):
        source=PREFIX+'// Icon(Icons.star)\nfinal sample="Icon(Icons.star) ${Icon(choose(a,b), color: pick(x,y))}";'
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertIn('${PrimeIcon(choose(a,b), color: pick(x,y))}',result)
        self.assertIn('// Icon(Icons.star)',result)
        self.assertIn('"Icon(Icons.star)',result)

    def test_unstyled_icon_keeps_inheritance_and_gate_accepts_shared_call(self):
        source=PREFIX+'const Icon(Icons.star);'
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertEqual(m.b.text.boundary.violations(result,True),[])
        self.assertNotIn('color:',result)


class NarrowIconImportTests(unittest.TestCase):
    def test_opt_in_preserves_library_and_exact_icon_arguments(self):
        source = "library patient;\nimport 'package:flutter/material.dart';\nconst Icon(Icons.info, size: 64, color: activeColor);"
        self.assertEqual(m.migrate(source), (source, 0))
        result, count = m.migrate(source, add_import=True)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace("import 'package:flutter/material.dart';", "import 'package:primecare_ui/primecare_ui.dart' show PrimeIcon;\nimport 'package:flutter/material.dart';").replace('const Icon(', 'const PrimeIcon('))
        self.assertEqual(m.migrate(result, add_import=True), (result, 0))

    def test_ambiguous_shared_symbol_and_restricted_material_stay(self):
        for prefix in ["import 'package:other/other.dart' show PrimeIcon;", 'final PrimeIcon=other;']:
            source = "import 'package:flutter/material.dart';" + prefix + 'Icon(Icons.info);'
            self.assertEqual(m.migrate(source, add_import=True), (source, 0))
        source = "import 'package:flutter/material.dart' as ui; Icon(Icons.info);"
        self.assertEqual(m.migrate(source, add_import=True), (source, 0))

    def test_existing_narrow_shared_import_and_callbacks_preserved(self):
        source = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart' show PrimeText;\nIcon(choose(a,b), color: resolve(context));"
        result, count = m.migrate(source, add_import=True)
        self.assertEqual(count, 1)
        self.assertIn('show PrimeText;', result)
        self.assertIn('PrimeIcon(choose(a,b), color: resolve(context))', result)


class SharedBarrelIconTests(unittest.TestCase):
    def test_barrel_exports_material_and_shared_icon_with_unrelated_hides(self):
        for clause in ['', ' hide ScreenRegistry', ' hide languageProvider, ScreenRegistry']:
            source = "import 'package:primecare_ui/primecare_ui.dart'" + clause + '; Icon(Icons.info);'
            result, count = m.migrate(source)
            self.assertEqual(count, 1)
            self.assertEqual(result, source.replace(' Icon(', ' PrimeIcon('))
            self.assertEqual(m.migrate(result), (result, 0))

    def test_hidden_icon_or_shared_icon_and_aliased_barrel_stay(self):
        for clause in [' hide Icon', ' hide PrimeIcon', ' as ui', ' show PrimeText']:
            source = "import 'package:primecare_ui/primecare_ui.dart'" + clause + '; Icon(Icons.info);'
            self.assertEqual(m.migrate(source), (source, 0))
