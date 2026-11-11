import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import unittest
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import reverse_manifest
s=importlib.util.spec_from_file_location('m',ROOT/'scripts/migrate-branding-settings-palette.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('t',ROOT/'scripts/migrate-generated-theme.py');t=importlib.util.module_from_spec(s);s.loader.exec_module(t)
class BrandingSettingsPaletteTest(unittest.TestCase):
 def test_exact_revision_roundtrip_and_strict_count(self):
  self.assertEqual(len(m.MANIFEST),1);row=m.MANIFEST[0];self.assertEqual(row['calls'],38)
  current=(ROOT/row['path']).read_text();original=reverse_manifest(current,row['path'],'branding-settings-palette-manifest.json')
  self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
  self.assertEqual(m.migrate(original),(current,38));self.assertEqual(m.migrate(current),(current,0))
  self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
  self.assertEqual(len(t.boundary.violations(original,False))-len(t.boundary.violations(current,False)),38)
  for fragment in ["api.post('/v1/admin/settings/branding', body: payload)","notifier.updateCustomColors(","final hexRegex = RegExp(r'^[0-9a-fA-F]+$')",'setState(() {});']:
   self.assertIn(fragment,original);self.assertIn(fragment,current)
 def test_actual_native_methods_and_dynamic_const_scopes(self):
  fixture=(ROOT/'packages/primecare_ui/test/fixtures/branding_settings_fixture.dart').read_text();source=(ROOT/m.MANIFEST[0]['path']).read_text()
  for method in json.loads((ROOT/'scripts/branding-settings-fixture-methods.json').read_text()):self.assertIn(method,source);self.assertIn(method,fixture)
  for text in [source,fixture]:
   code=t.boundary.executable_code(text);frames=t.frames(code);self.assertTrue(frames);byopen={f[0]:f for f in frames}
   for m0 in t.CONST_CALL.finditer(code):
    f=byopen.get(m0.end()-1)
    if f:self.assertNotIn('PrimeActionPalette.',code[f[0]:f[1]])
if __name__=='__main__':unittest.main()
