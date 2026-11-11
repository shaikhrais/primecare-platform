import importlib.util,json,unittest,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('fields',ROOT/'scripts/migrate-shared-text-fields.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
sys.path.insert(0,str(ROOT/'scripts'))
import reviewed_migration_history as history
MANIFEST=json.loads((ROOT/'scripts/shared-text-fields-manifest.json').read_text())

class SharedTextFieldMigrationTest(unittest.TestCase):
 def pair(self,path,sha,count):
  current=history.before_governance_palette((ROOT/path).read_text(),path)
  if m.digest(current)==sha:original=current;updated,actual=m.migrate_source(path,current,sha,count)
  else:original,actual=m.reverse_source(path,current,count);updated=current
  self.assertEqual(m.digest(original),sha);return original,updated,actual
 def test_actual_sources_exact_roundtrip_and_idempotence(self):
  total=0
  for path,(sha,count) in MANIFEST.items():
   original,updated,actual=self.pair(path,sha,count);self.assertEqual(actual,count,path)
   self.assertEqual(m.reverse_source(path,updated,count),(original,count));self.assertEqual(m.migrate_source(path,updated,sha,count),(updated,0));total+=count
  self.assertEqual(len(MANIFEST),12);self.assertEqual(total,19)
 def test_only_constructor_and_narrow_import_change(self):
  for path,(sha,count) in MANIFEST.items():
   original,updated,_=self.pair(path,sha,count);normalized=updated
   if path in m.CLEANUPS:normalized=normalized.replace(m.CLEANUPS[path][1],m.CLEANUPS[path][0],1)
   normalized=normalized.replace(m.CORE_IMPORT,'').replace(m.APP_IMPORT,'').replace('PrimeTextField','TextField');self.assertEqual(normalized,original,path)
 def test_unsupported_options_parts_shadows_types_and_tearoffs_stay(self):
  samples=["part 'x.dart'; Widget f()=>TextField();",'class TextField{} Widget f()=>TextField();','Widget TextField()=>value;','Widget f()=>material.TextField();','Widget f()=>TextField(style: style);','final value=TextField.new;']
  for source in samples:self.assertEqual(m.replace_text_fields(source,1),(source,0))
 def test_reviewed_argument_surface_is_exact(self):
  source="TextField(key:key,controller:c,focusNode:f,decoration:d,keyboardType:k,maxLines:1,maxLength:2,enabled:true,autofocus:false,obscureText:true,onChanged:a,onSubmitted:s)"
  updated,count=m.replace_text_fields(source,1);self.assertEqual(count,1);self.assertTrue(updated.startswith('PrimeTextField('))
 def test_all_consumers_are_compile_referenced(self):
  core=(ROOT/'packages/flutter_core/test/shared_primitives_migration_compile_test.dart').read_text();governance=(ROOT/'apps/primecare_governance/test/shared_text_migration_compile_test.dart').read_text()+(ROOT/'apps/primecare_governance/test/shared_control_extensions_compile_test.dart').read_text()
  for path in MANIFEST:self.assertIn(Path(path).name,core if path.startswith('packages/flutter_core/') else governance,path)

if __name__=='__main__':unittest.main()
