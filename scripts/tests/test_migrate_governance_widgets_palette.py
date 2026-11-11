import hashlib,importlib.util,json,re,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_shared_snack_bars,reverse_manifest
s=importlib.util.spec_from_file_location('m',ROOT/'scripts/migrate-governance-widgets-palette.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('t',ROOT/'scripts/migrate-generated-theme.py');t=importlib.util.module_from_spec(s);s.loader.exec_module(t)
class GovernanceWidgetsPaletteTest(unittest.TestCase):
 def test_all_seven_exact_sources_roundtrip_and_strict_counts(self):
  self.assertEqual(len(m.MANIFEST),7);self.assertEqual(sum(r['calls'] for r in m.MANIFEST),100)
  for row in m.MANIFEST:
   latest=(ROOT/row['path']).read_text();current=before_shared_snack_bars(latest,row['path']);original=reverse_manifest(current,row['path'],'governance-widgets-palette-manifest.json')
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256']);self.assertEqual(m.migrate(original),(current,row['calls']));self.assertEqual(m.migrate(current),(current,0));self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
   self.assertEqual(len(t.boundary.violations(original,True))-len(t.boundary.violations(current,True)),row['calls'])
   self.assertEqual(re.findall(r'(?m)^.*(?:onPressed|onTap|onChanged|RegistryPatchEngine.applyFix|launchUrl|exportReport\().*$',original),re.findall(r'(?m)^.*(?:onPressed|onTap|onChanged|RegistryPatchEngine.applyFix|launchUrl|exportReport\().*$',current))
 def test_actual_native_fixtures_and_const_scopes(self):
  fixture=(ROOT/'apps/primecare_governance/test/governance_palette_fixture.dart').read_text();native=(ROOT/'apps/primecare_governance/test/governance_palette_test.dart').read_text()
  for row in json.loads((ROOT/'scripts/governance-widgets-fixture-methods.json').read_text()):
   self.assertIn(row['method'],(ROOT/row['path']).read_text());self.assertIn(row['method'],fixture)
  for row in m.MANIFEST:
   self.assertIn(row['path'].split('/lib/')[1],native);code=t.boundary.executable_code((ROOT/row['path']).read_text());frames=t.frames(code);self.assertTrue(frames);byopen={f[0]:f for f in frames}
   for m0 in t.CONST_CALL.finditer(code):
    f=byopen.get(m0.end()-1)
    if f:self.assertNotIn('PrimeActionPalette.',code[f[0]:f[1]])
if __name__=='__main__':unittest.main()
