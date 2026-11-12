import hashlib,importlib.util,json,re,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_remaining_material_controls,before_native_widget_repairs
s=importlib.util.spec_from_file_location('m',ROOT/'scripts/migrate-remaining-material-controls.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('t',ROOT/'scripts/migrate-generated-theme.py');t=importlib.util.module_from_spec(s);s.loader.exec_module(t)
s=importlib.util.spec_from_file_location('g',ROOT/'scripts/generate-shared-material-controls.py');g=importlib.util.module_from_spec(s);s.loader.exec_module(g)
class RemainingMaterialControlsTest(unittest.TestCase):
 def test_all_26_sources_exact_roundtrip_and_strict_counts(self):
  self.assertEqual(len(m.MANIFEST),26);self.assertEqual(sum(r['calls'] for r in m.MANIFEST),61)
  for row in m.MANIFEST:
   current=before_native_widget_repairs((ROOT/row['path']).read_text(),row['path']);original=before_remaining_material_controls(current,row['path'])
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256']);self.assertEqual(m.migrate(original),(current,row['calls']));self.assertEqual(m.migrate(current),(current,0));self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
   self.assertEqual(len(t.boundary.violations(original,True))-len(t.boundary.violations(current,True)),row['calls'])
   line=current.splitlines()[0];self.assertTrue(line.startswith("import 'package:"));normalized=current[len(line)+1:]
   for symbol in row['symbols']:
    shared='PrimeMaterialLinearProgressIndicator' if symbol=='LinearProgressIndicator' else 'Prime'+symbol
    normalized=re.sub(r'\b'+shared+r'\b',symbol,normalized)
   if 'duplicate_import_cleanup' in row:
    line=row['duplicate_import_cleanup'];self.assertEqual(normalized.count(line),1);normalized=normalized.replace(line,line+line,1)
   if 'removed_duplicate_import' in row:
    self.assertNotIn(row['removed_duplicate_import'],normalized);normalized=normalized.replace(row['duplicate_import_anchor'],row['duplicate_import_anchor']+row['removed_duplicate_import'],1)
   if 'source_cleanup' in row:
    cleanup=row['source_cleanup'];self.assertIn(cleanup['after'],normalized);normalized=normalized.replace(cleanup['after'],cleanup['before'],1)
   self.assertEqual(normalized,original)
 def test_pinned_sdk_generator_is_current_and_forwards_required_parameters(self):
  rows=json.loads((ROOT/'scripts/shared-material-controls-api-3.41.5.json').read_text());self.assertEqual(len(rows),19)
  generated=(ROOT/'packages/primecare_ui_foundation/lib/src/prime_material_controls.dart').read_text();self.assertEqual(g.generate(),generated)
  for row in rows:
   self.assertIn('/3.41.5/',row['sdk_url']);self.assertEqual(len(row['sdk_sha256']),64)
   for ctor in row['constructors']:
    for parameter in ctor['parameters']:
     if parameter['required']:self.assertIn('required super.'+parameter['name'],generated)
  self.assertNotIn('Colors.',generated);self.assertNotIn('Color(',generated)
 def test_native_inventory_includes_all_26_actual_consumer_libraries(self):
  rows=json.loads((ROOT/'scripts/remaining-material-controls-compile-inventory.json').read_text());self.assertEqual(len(rows),26)
  for row in rows:
   native=(ROOT/row['fixture']).read_text();self.assertIn(row['path'].split('/lib/')[1],native);self.assertIn(row['name'],native)
 def test_public_adapter_names_do_not_collide_with_shared_ui_declarations(self):
  names={row.get('shared_name','Prime'+row['name']) for row in json.loads((ROOT/'scripts/shared-material-controls-api-3.41.5.json').read_text())}
  for path in (ROOT/'packages/primecare_ui/lib').rglob('*.dart'):
   code=t.boundary.executable_code(path.read_text());declared=set(re.findall(r'\b(?:class|enum|mixin|typedef)\s+(\w+)',code));self.assertFalse(names&declared,(str(path),names&declared))
if __name__=='__main__':unittest.main()
