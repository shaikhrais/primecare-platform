import hashlib,json,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_native_compile_repairs

class NativeCompileRepairsTest(unittest.TestCase):
 def test_exact_reversible_repairs_preserve_all_other_source(self):
  rows=json.loads((ROOT/'scripts/native-generated-compile-repairs.json').read_text())
  self.assertEqual(len(rows),11)
  for row in rows:
   current=(ROOT/row['path']).read_text()
   self.assertEqual(hashlib.sha256(current.encode()).hexdigest(),row['updated_sha256'])
   original=before_native_compile_repairs(current,row['path'])
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
   updated=original
   for edit in reversed(row['edits']):
    self.assertEqual(original[edit['begin']:edit['end']],edit['old'])
    updated=updated[:edit['begin']]+edit['new']+updated[edit['end']:]
   self.assertEqual(updated,current)
   if row['path'].endswith(('cases.dart','policy_manager.dart','compliance_hub.dart')):
    self.assertIn('Controller(this.ref)',current)
    self.assertEqual(len(row['edits']),1)
    self.assertTrue(row['edits'][0]['old'].strip().endswith('Controller()'))
    self.assertEqual(row['edits'][0]['old'].replace('()','(this.ref)'),row['edits'][0]['new'])
   else:self.assertEqual(original.replace('italic: true','fontStyle: FontStyle.italic'),current)
