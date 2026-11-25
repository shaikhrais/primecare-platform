import hashlib,json,sys,unittest,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_native_widget_repairs,read_reviewed_source
class NativeWidgetRepairTest(unittest.TestCase):
 def test_exact_reverse_hash_and_all_other_source_retained(self):
  rows=json.loads((ROOT/'scripts/native-widget-repairs.json').read_text())
  self.assertEqual(len(rows),8)
  for row in rows:
   current=read_reviewed_source(row['path'])
   self.assertEqual(hashlib.sha256(current.encode()).hexdigest(),row['updated_sha256'])
   original=before_native_widget_repairs(current,row['path'])
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
   for e in reversed(row['edits']):original=original[:e['begin']]+e['new']+original[e['end']:]
   self.assertEqual(original,current)
   if 'live_dispatch' in row['path']:
    self.assertIn('runSpacing: 8,',current)
    self.assertEqual(current.count('controller.assignCaregiver'),1)

 def test_relocated_source_rejects_changed_export_or_import(self):
  path='packages/flutter_core/lib/dashboard_widgets/prime_dashboard_widgets.dart'
  with tempfile.TemporaryDirectory() as directory:
   root=Path(directory);shim=root/path
   shim.parent.mkdir(parents=True)
   canonical=root/'packages/primecare_dashboard_native/lib/dashboard_widgets/prime_dashboard_widgets.dart'
   canonical.parent.mkdir(parents=True)
   shim.write_text("export 'package:primecare_dashboard_native/dashboard_widgets/prime_dashboard_widgets.dart';\n")
   canonical.write_text("import 'package:primecare_component_factory/component_catalogue/prime_component_catalogue.dart';\nclass Example {}\n")
   self.assertEqual(read_reviewed_source(path,root),"import '../component_catalogue/prime_component_catalogue.dart';\nclass Example {}\n")
   canonical.write_text('class Example {}\n')
   with self.assertRaisesRegex(AssertionError,'import drift'):read_reviewed_source(path,root)
   shim.write_text('class Example {}\n')
   with self.assertRaisesRegex(AssertionError,'export drift'):read_reviewed_source(path,root)
