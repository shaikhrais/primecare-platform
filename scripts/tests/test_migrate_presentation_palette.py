import hashlib,importlib.util,json,re,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import reverse_manifest
s=importlib.util.spec_from_file_location('m',ROOT/'scripts/migrate-presentation-palette.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('t',ROOT/'scripts/migrate-generated-theme.py');t=importlib.util.module_from_spec(s);s.loader.exec_module(t)
class PresentationPaletteTest(unittest.TestCase):
 def test_exact_revision_roundtrip_and_strict_count(self):
  self.assertEqual(len(m.MANIFEST),1);row=m.MANIFEST[0];self.assertEqual(row['calls'],115)
  current=(ROOT/row['path']).read_text();original=reverse_manifest(current,row['path'],'presentation-palette-manifest.json')
  self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256']);self.assertEqual(m.migrate(original),(current,115));self.assertEqual(m.migrate(current),(current,0));self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
  self.assertEqual(len(t.boundary.violations(original,True))-len(t.boundary.violations(current,True)),115)
  self.assertEqual(re.findall(r'(?m)^.*(?:onPressed|onTap|screenshotPresentationMode).*$',original),re.findall(r'(?m)^.*(?:onPressed|onTap|screenshotPresentationMode).*$',current))
  # Context was added only to helper calls; role/screen dispatch conditions stay identical.
  self.assertEqual(re.findall(r'normalizedType.contains\([^)]*\)',original),re.findall(r'normalizedType.contains\([^)]*\)',current))
 def test_actual_native_helper_fixtures_and_const_scopes(self):
  source=(ROOT/m.MANIFEST[0]['path']).read_text();fixture=(ROOT/'packages/flutter_core/test/fixtures/presentation_palette_fixture.dart').read_text()
  rows=json.loads((ROOT/'scripts/presentation-palette-fixture-methods.json').read_text())
  self.assertEqual(len(rows),23)
  for row in rows:
   self.assertIn(row['source'],source);expected=row['source']
   for rename in rows:expected=re.sub(r'\b'+rename['name']+r'\b',rename['fixture'],expected)
   self.assertIn(expected,fixture)
  for source in [source,fixture]:
   code=t.boundary.executable_code(source);frames=t.frames(code);self.assertTrue(frames);byopen={f[0]:f for f in frames}
   for m0 in t.CONST_CALL.finditer(code):
    f=byopen.get(m0.end()-1)
    if f:self.assertNotIn('Theme.of(',code[f[0]:f[1]])
if __name__=='__main__':unittest.main()
