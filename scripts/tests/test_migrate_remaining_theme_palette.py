import hashlib,importlib.util,json,re,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_remaining_palette,before_remaining_material_controls
s=importlib.util.spec_from_file_location('m',ROOT/'scripts/migrate-remaining-theme-palette.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('t',ROOT/'scripts/migrate-generated-theme.py');t=importlib.util.module_from_spec(s);s.loader.exec_module(t)
class RemainingThemePaletteTest(unittest.TestCase):
 def test_all_43_exact_sources_roundtrip_and_strict_counts(self):
  self.assertEqual(len(m.MANIFEST),43);self.assertEqual(sum(r['calls'] for r in m.MANIFEST),123)
  for row in m.MANIFEST:
   current=before_remaining_material_controls((ROOT/row['path']).read_text(),row['path']);original=before_remaining_palette(current,row['path'])
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256']);self.assertEqual(m.migrate(original),(current,row['calls']));self.assertEqual(m.migrate(current),(current,0));self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
   self.assertEqual(sum(k=='theme-color' for _,k,_ in t.boundary.violations(original,True)),row['calls']);self.assertEqual(sum(k=='theme-color' for _,k,_ in t.boundary.violations(current,True)),0)
   self.assertEqual(re.findall(r'https?://[^\s\'\"]+',original),re.findall(r'https?://[^\s\'\"]+',current))
 def test_dynamic_const_scopes_and_native_compile_inventory(self):
  inventory=json.loads((ROOT/'scripts/remaining-theme-compile-inventory.json').read_text());self.assertEqual(len(inventory),43)
  for row in inventory:
   native=(ROOT/row['fixture']).read_text();self.assertIn(row['path'].split('/lib/')[1],native);self.assertIn(row['name'],native)
  for row in m.MANIFEST:
   code=t.boundary.executable_code(before_remaining_material_controls((ROOT/row['path']).read_text(),row['path']));frames=t.frames(code);self.assertTrue(frames,row['path']);byopen={f[0]:f for f in frames}
   for m0 in t.CONST_CALL.finditer(code):
    f=byopen.get(m0.end()-1)
    if f:
     chunk=code[f[0]:f[1]]
     for marker in ['Theme.of(','context.theme','PrimeActionPalette.of(','PrimeSemanticPalette.of(']:self.assertNotIn(marker,chunk,row['path'])
if __name__=='__main__':unittest.main()
