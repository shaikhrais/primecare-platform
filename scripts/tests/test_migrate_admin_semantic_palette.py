import hashlib
import importlib.util
from pathlib import Path
import unittest
import re

ROOT=Path(__file__).resolve().parents[2]
s=importlib.util.spec_from_file_location('admin',ROOT/'scripts/migrate-admin-semantic-palette.py')
m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('previous',ROOT/'scripts/tests/test_migrate_clinical_semantic_palette.py')
previous=importlib.util.module_from_spec(s);s.loader.exec_module(previous)


class AdminSemanticPaletteTest(unittest.TestCase):
    def test_every_original_hash_reproduces_and_second_pass_is_empty(self):
        self.assertEqual(len(m.MANIFEST),4)
        self.assertEqual(sum(r['calls'] for r in m.MANIFEST),81)
        for row in m.MANIFEST:
            current=(ROOT/row['path']).read_text();original=previous.reverse(current,row)
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
            self.assertEqual(m.migrate(original),(current,row['calls']))
            self.assertEqual(m.migrate(current),(current,0))
            self.assertEqual(len(previous.boundary.violations(original,False))-len(previous.boundary.violations(current,False)),row['calls'])
            for e in row['edits']:
                self.assertTrue(e['old']=='const' or e['old'].startswith(('Colors.','ShaderMask(')))

    def test_solid_shader_preserves_its_visible_theme_color(self):
        row=next(r for r in m.MANIFEST if 'screenshot_gallery' in r['path'])
        shader=next(e for e in row['edits'] if e['old'].startswith('ShaderMask('))
        expression='readableThemeForeground(theme.colorScheme.surface, theme.colorScheme.primary)'
        self.assertEqual(shader['old'].count(expression),2)
        self.assertIn('color: Colors.white',shader['old'])
        self.assertEqual(shader['new'],'Icon(LucideIcons.image, size: 28, color: '+expression+')')

    def test_changed_source_is_rejected(self):
        for row in m.MANIFEST:
            original=previous.reverse((ROOT/row['path']).read_text(),row)
            for changed in [original+'\n',original+'\nclass PrimeActionPalette {}\n']:
                self.assertEqual(m.migrate(changed),(changed,0))

    def test_native_fixtures_match_the_actual_private_status_helpers(self):
        fixture=(ROOT/'packages/primecare_ui/test/fixtures/admin_semantic_palette_fixture.dart').read_text()
        s=importlib.util.spec_from_file_location('theme',ROOT/'scripts/migrate-generated-theme.py')
        theme=importlib.util.module_from_spec(s);s.loader.exec_module(theme)
        for name,path in [('_buildStatusPill','packages/primecare_ui/lib/src/governance/screen_health_panel.dart'),
                          ('_buildPurposeStatusPill','packages/primecare_ui/lib/src/screens/admin/admin_reality_check_screen.dart')]:
            source=(ROOT/path).read_text();start=source.index('  Widget '+name+'(');opening=source.index('{',start)
            frame=next(f for f in theme.frames(theme.boundary.executable_code(source)) if f[0]==opening)
            self.assertIn(source[start:frame[1]+1],fixture)
        for row in m.MANIFEST:
            self.assertIn(row['path'].split('/lib/')[1],(ROOT/'packages/primecare_ui/test/admin_semantic_palette_compile_test.dart').read_text())


if __name__=='__main__':unittest.main()
