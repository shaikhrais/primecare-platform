import hashlib,importlib.util,json,re,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import reverse_manifest
s=importlib.util.spec_from_file_location('m',ROOT/'scripts/migrate-success-profile-palette.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('t',ROOT/'scripts/migrate-generated-theme.py');t=importlib.util.module_from_spec(s);s.loader.exec_module(t)
class SuccessProfilePaletteTest(unittest.TestCase):
 def test_all_four_exact_sources_roundtrip_with_strict_counts(self):
  self.assertEqual(len(m.MANIFEST),4);self.assertEqual(sum(r['calls'] for r in m.MANIFEST),33)
  for row in m.MANIFEST:
   current=(ROOT/row['path']).read_text();original=reverse_manifest(current,row['path'],'success-profile-palette-manifest.json')
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256']);self.assertEqual(m.migrate(original),(current,row['calls']));self.assertEqual(m.migrate(current),(current,0));self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
   self.assertEqual(len(t.boundary.violations(original,False))-len(t.boundary.violations(current,False)),row['calls'])
   self.assertEqual(re.findall(r'(?m)^.*(?:onTap|onPressed|launchUrl|logout\(\)|authState.role).*$',original),re.findall(r'(?m)^.*(?:onTap|onPressed|launchUrl|logout\(\)|authState.role).*$',current))
   if 'action_bar' in row['path']:self.assertEqual(original.split('  @override')[0],current.split('  @override')[0])
 def test_dynamic_const_scopes_and_actual_native_imports(self):
  native=(ROOT/'packages/primecare_ui/test/success_profile_palette_test.dart').read_text()
  for row in m.MANIFEST:
   self.assertIn(row['path'].split('/lib/')[1],native);source=(ROOT/row['path']).read_text();code=t.boundary.executable_code(source);frames=t.frames(code);self.assertTrue(frames);byopen={f[0]:f for f in frames}
   for m0 in t.CONST_CALL.finditer(code):
    f=byopen.get(m0.end()-1)
    if f:self.assertNotIn('theme.colors',code[f[0]:f[1]])
if __name__=='__main__':unittest.main()
