import importlib.util,pathlib,tempfile,unittest,os
from unittest.mock import patch,Mock
spec=importlib.util.spec_from_file_location('fixture',pathlib.Path(__file__).with_name('prepare-ci-fixture.py'));m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
class FixtureTests(unittest.TestCase):
 def test_refuses_default_invocation(self):
  with patch.dict(os.environ,{},clear=True),self.assertRaises(RuntimeError):m.prepare()
 def test_refuses_production_credentials(self):
  with patch.dict(os.environ,{'CI':'true','GOVERNANCE_ALLOW_SQLITE_FIXTURES':'1','PRODUCTION_DATABASE_URL':'never-log-this'},clear=True),self.assertRaises(RuntimeError):m.prepare()
 def test_hash_checked_fixture_and_unknown_data_preserved(self):
  data=b'isolated synthetic fixture';digest=m.hashlib.sha256(data).hexdigest()
  with tempfile.TemporaryDirectory() as temp,patch.dict(os.environ,{'CI':'true','GOVERNANCE_ALLOW_SQLITE_FIXTURES':'1'},clear=True),patch.object(m,'SHA256',digest),patch.object(m.subprocess,'run',return_value=Mock(returncode=0)),patch.object(m.subprocess,'check_output',return_value=data):
   root=pathlib.Path(temp);m.prepare(root);target=root/m.SOURCE_PATH;self.assertEqual(target.read_bytes(),data);m.prepare(root)
   target.write_bytes(b'unknown local edits')
   with self.assertRaises(RuntimeError):m.prepare(root)
   self.assertEqual(target.read_bytes(),b'unknown local edits')
 def test_refuses_wrong_source_hash(self):
  with tempfile.TemporaryDirectory() as temp,patch.dict(os.environ,{'CI':'true','GOVERNANCE_ALLOW_SQLITE_FIXTURES':'1'},clear=True),patch.object(m.subprocess,'run',return_value=Mock(returncode=0)),patch.object(m.subprocess,'check_output',return_value=b'wrong source'),self.assertRaises(RuntimeError):m.prepare(pathlib.Path(temp))
if __name__=='__main__':unittest.main()
