import hashlib
import importlib.util
import sys
from pathlib import Path
import unittest
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import reverse_manifest
s=importlib.util.spec_from_file_location('metrics',ROOT/'scripts/migrate-shared-metric-contrast.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
class SharedMetricContrastTest(unittest.TestCase):
 def test_both_actual_sources_roundtrip_and_reject_drift(self):
  self.assertEqual(len(m.MANIFEST),2)
  for row in m.MANIFEST:
   current=(ROOT/row['path']).read_text();original=reverse_manifest(current,row['path'],'shared-metric-contrast-manifest.json')
   self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
   self.assertEqual(m.migrate(original),(current,3))
   self.assertEqual(m.migrate(current),(current,0))
   self.assertEqual(m.migrate(original+'\n'),(original+'\n',0))
if __name__=='__main__':unittest.main()
