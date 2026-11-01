import importlib.util,json,os,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
import metadata_store as m
class MetadataGateTests(unittest.TestCase):
 def scope(self):return {'optInVariable':'CATALOGUE_TEST_WRITES','tables':['screen_components'],'schemaChanges':False,'businessDataWrites':False,'roleGrants':False,'runtimeActivation':False}
 def test_unscoped_tables_and_flags_fail_before_connection(self):
  for mutate in [lambda s:s['tables'].append('api_permissions'),lambda s:s.update(roleGrants=True),lambda s:s.update(runtimeActivation=True)]:
   scope=self.scope();mutate(scope)
   with tempfile.TemporaryDirectory() as d:
    p=Path(d)/'pin.json';p.write_text(json.dumps({'test':scope}))
    with patch.object(m,'PIN',p),patch.dict(os.environ,{'CATALOGUE_TEST_WRITES':'1'}):
     with self.assertRaises(m.GovernanceReadError):m.MetadataStore('test',scope)
 def test_missing_target_and_sqlite_mode_fail_closed(self):
  scope=self.scope()
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'pin.json';p.write_text(json.dumps({'test':scope}))
   for env in [{'CATALOGUE_TEST_WRITES':'1'},{'CATALOGUE_TEST_WRITES':'1','GOVERNANCE_ALLOW_SQLITE_FIXTURES':'1'}]:
    with patch.object(m,'PIN',p),patch.dict(os.environ,env,clear=True):
     with self.assertRaises(m.GovernanceReadError):m.MetadataStore('test',scope)
 def test_read_interface_cannot_inherit_workflow_writes(self):
  store=m.MetadataStore.__new__(m.MetadataStore)
  for sql in ['UPDATE virtual_workflow_definitions SET test_status=1','INSERT INTO screen_components VALUES(1)','DELETE FROM users','DROP TABLE users']:
   with self.assertRaises(m.GovernanceReadError):store.execute(sql)
if __name__=='__main__':unittest.main()
