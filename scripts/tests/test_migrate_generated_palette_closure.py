import hashlib
import importlib.util
import json
from pathlib import Path
import re
import unittest

ROOT=Path(__file__).resolve().parents[2]
import sys
sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_controller_ref_aliases
s=importlib.util.spec_from_file_location('operations',ROOT/'scripts/migrate-generated-palette-closure.py')
m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('previous',ROOT/'scripts/tests/test_migrate_clinical_semantic_palette.py')
previous=importlib.util.module_from_spec(s);s.loader.exec_module(previous)

s=importlib.util.spec_from_file_location('theme',ROOT/'scripts/migrate-generated-theme.py')
theme=importlib.util.module_from_spec(s);s.loader.exec_module(theme)


class GeneratedPaletteClosureTest(unittest.TestCase):
    def test_all_original_hashes_roundtrip_and_strict_counts(self):
        self.assertEqual(len(m.MANIFEST),6)
        self.assertEqual(sum(r['calls'] for r in m.MANIFEST),25)
        for row in m.MANIFEST:
            current=before_controller_ref_aliases((ROOT/row['path']).read_text(),row['path']);original=previous.reverse(current,row)
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
            self.assertEqual(m.migrate(original),(current,row['calls']))
            self.assertEqual(m.migrate(current),(current,0))
            self.assertEqual(len(previous.boundary.violations(original,False))-len(previous.boundary.violations(current,False)),row['calls'])
            self.assertEqual(re.findall(r'(?m)^.*(?:onPressed|onTap|onChanged|route:|eventType:).*$',original),re.findall(r'(?m)^.*(?:onPressed|onTap|onChanged|route:|eventType:).*$',current))
            self.assertEqual(theme.frames(previous.boundary.executable_code(current)) != [], True)

    def test_unreviewed_source_rejected(self):
        for row in m.MANIFEST:
            source=previous.reverse(before_controller_ref_aliases((ROOT/row['path']).read_text(),row['path']),row)
            for changed in [source+'\n',source+'\nclass PrimeActionPalette {}\n']:
                self.assertEqual(m.migrate(changed),(changed,0))

    def test_actual_native_helper_fixture_parity_and_compile_imports(self):
        fixture=(ROOT/'packages/primecare_ui/test/fixtures/generated_palette_closure_fixture.dart').read_text()
        compile=(ROOT/'packages/primecare_ui/test/generated_palette_closure_compile_test.dart').read_text()
        spec=importlib.util.spec_from_file_location('t',ROOT/'scripts/migrate-generated-theme.py')
        theme=importlib.util.module_from_spec(spec);spec.loader.exec_module(theme)
        metadata=json.loads((ROOT/'scripts/generated-palette-closure-fixture-map.json').read_text())
        for row in metadata:
            source=before_controller_ref_aliases((ROOT/row['path']).read_text(),row['path'])
            self.assertIn(row['path'].split('/lib/')[1],compile)
            if 'className' in row:
                start=source.index('class '+row['className']+' extends StatelessWidget');opening=source.index('{',start)
                frame=next(f for f in theme.frames(theme.boundary.executable_code(source)) if f[0]==opening)
                expected=re.sub(r'\b'+re.escape(row['className'])+r'\b',row['fixture'],source[start:frame[1]+1])
                self.assertIn(re.sub(r'(?m)^[ \t]+$','',expected),fixture)
            else:
                for key in ['statements','snippet']:
                    self.assertIn(row[key],source);self.assertIn(row[key],fixture)


if __name__=='__main__':unittest.main()
