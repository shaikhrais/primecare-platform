import hashlib,importlib.util,sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_controller_ref_aliases, before_native_widget_repairs
s=importlib.util.spec_from_file_location('m',ROOT/'scripts/migrate-controller-ref-aliases.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
class ControllerReferenceAliasTest(unittest.TestCase):
 def test_exact_injected_reference_aliases_preserve_constructors_and_actions(self):
  self.assertEqual(len(m.MANIFEST),19)
  for row in m.MANIFEST:
   current=before_native_widget_repairs((ROOT/row['path']).read_text(),row['path']);original=before_controller_ref_aliases(current,row['path'])
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256']);self.assertEqual(m.migrate(original),(current,1));self.assertEqual(m.migrate(current),(current,0));self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
   self.assertEqual(current,original.replace('final Ref ref;','Ref get ref => _ref;',1));self.assertIn(row['controller']+'(this._ref)',current)
   self.assertEqual(current.count('final Ref _ref;'),1)
if __name__=='__main__':unittest.main()
