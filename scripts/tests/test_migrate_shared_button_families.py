import hashlib
import importlib.util
from pathlib import Path
import re
import unittest

ROOT=Path(__file__).resolve().parents[2]
history_spec=importlib.util.spec_from_file_location('history',ROOT/'scripts/reviewed_migration_history.py')
history=importlib.util.module_from_spec(history_spec);history_spec.loader.exec_module(history)

s=importlib.util.spec_from_file_location('buttons',ROOT/'scripts/migrate-shared-button-families.py')
m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('previous',ROOT/'scripts/tests/test_migrate_clinical_semantic_palette.py')
old=importlib.util.module_from_spec(s);s.loader.exec_module(old)
s=importlib.util.spec_from_file_location('generator',ROOT/'scripts/generate-shared-button-adapters.py')
generator=importlib.util.module_from_spec(s);s.loader.exec_module(generator)


class SharedButtonFamiliesTest(unittest.TestCase):
    def test_all_exact_source_roundtrips_and_strict_deltas(self):
        self.assertEqual(len(m.MANIFEST),25)
        self.assertEqual(sum(r['calls'] for r in m.MANIFEST),75)
        self.assertEqual(sum(r['findings'] for r in m.MANIFEST),67)
        for row in m.MANIFEST:
            current=history.before_control_extensions((ROOT/row['path']).read_text(),row['path']);original=old.reverse(current,row)
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'],row['path'])
            self.assertEqual(m.migrate(original),(current,row['calls']))
            self.assertEqual(m.migrate(current),(current,0))
            if row['findings']:
                self.assertEqual(len(old.boundary.violations(original,True))-len(old.boundary.violations(current,True)),row['findings'])
            self.assertEqual([x[2] for x in old.boundary.violations(original,False)],
                             [x[2] for x in old.boundary.violations(current,False)])
            if row['path'].startswith('packages/flutter_core/'):
                self.assertNotIn("import 'package:primecare_ui/",current)

    def test_edited_sources_rejected(self):
        for row in m.MANIFEST:
            original=old.reverse(history.before_control_extensions((ROOT/row['path']).read_text(),row['path']),row)
            for changed in [original+'\n',original+'\nclass PrimeTextButton {}\n']:
                self.assertEqual(m.migrate(changed),(changed,0))

    def test_generator_matches_pinned_api_and_preserves_sdk_delegation(self):
        code=(ROOT/'packages/primecare_ui_foundation/lib/src/prime_material_buttons.dart').read_text()
        self.assertEqual(generator.generate(),code)
        for kind,entry in generator.API.items():
            self.assertEqual(entry['version'],'3.41.5')
            for parameter in entry['styleParameters']:
                self.assertIn(parameter['type']+' '+parameter['name']+',',code)
                self.assertIn(parameter['name']+': '+parameter['name']+',',code)
            self.assertIn('return '+kind+'.icon(',code)
            self.assertIn('return '+kind+'(',code)
        self.assertNotRegex(code,r'Colors\.|\bColor\(')
        self.assertIn('this.clipBehavior = Clip.none',code)
        self.assertIn('required this.child',code)
        self.assertEqual(code.count('icon: icon!,'),3)
        self.assertEqual(code.count('child: child!,'),3)
        self.assertEqual(code.count('if (_iconVariant && icon == null)'),3)
        self.assertEqual(code.count('child: label!,'),3)

    def test_actual_compile_imports_cover_every_consumer(self):
        for row in m.MANIFEST:
            package=Path(row['path']).parts[:2]
            directory=ROOT.joinpath(*package,'test')
            imports='\n'.join(p.read_text() for p in directory.glob('*compile_test.dart'))
            self.assertIn(row['path'].split('/lib/')[1],imports,row['path'])


if __name__=='__main__':unittest.main()
