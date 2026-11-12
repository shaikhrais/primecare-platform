import hashlib,json,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_native_widget_repairs
class NativeWidgetRepairTest(unittest.TestCase):
 def test_exact_reverse_hash_and_all_other_source_retained(self):
  rows=json.loads((ROOT/'scripts/native-widget-repairs.json').read_text())
  self.assertEqual(len(rows),7)
  for row in rows:
   current=(ROOT/row['path']).read_text()
   self.assertEqual(hashlib.sha256(current.encode()).hexdigest(),row['updated_sha256'])
   original=before_native_widget_repairs(current,row['path'])
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
   for e in reversed(row['edits']):original=original[:e['begin']]+e['new']+original[e['end']:]
   self.assertEqual(original,current)
   if 'live_dispatch' in row['path']:
    self.assertIn('runSpacing: 8,',current)
    self.assertEqual(current.count('controller.assignCaregiver'),1)
