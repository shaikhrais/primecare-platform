import importlib.util,pathlib,tempfile,unittest,os,json,subprocess,sys
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
class GrowthFixtureWorkflowTests(unittest.TestCase):
 def test_recovery_fixture_and_trusted_production_parity_are_separate(self):
  root=pathlib.Path(__file__).resolve().parents[2]
  workflow=(root/'.github/workflows/growth-marketing.yml').read_text()
  before='python3 scripts/test-auth-recovery-governance.py'
  check='python3 scripts/register-auth-recovery-web.py --check'
  after='python3 scripts/register-workspace-visual-review.py'
  command=' && '.join((before,after))
  self.assertNotIn(check,workflow)
  self.assertEqual(workflow.count('        run: '+command),1)
  build='      - run: GOVERNANCE_ALLOW_SQLITE_FIXTURES=1 node scripts/build-typescript-websites.mjs'
  self.assertEqual(workflow.count(build),1)
  self.assertLess(workflow.index(build),workflow.index('        run: '+command))
  preparation="      - name: Prepare isolated historical governance test fixture\n        env:\n          GOVERNANCE_ALLOW_SQLITE_FIXTURES: '1'\n"
  self.assertEqual(workflow.count(preparation),1)
  # The existing preparation step and build are the only other opt-ins.
  # In particular, reject job-wide, adjacent-command or step-wide fallback.
  remainder=workflow.replace(preparation,'').replace(build,'').replace('      - run: '+command,'')
  self.assertNotIn('GOVERNANCE_ALLOW_SQLITE_FIXTURES',remainder)
  build_source=(root/'scripts/build-typescript-websites.mjs').read_text()
  self.assertIn("execFileSync('python3',['scripts/register-auth-recovery-web.py']);",build_source)
  production=(root/'.github/workflows/governance-production-reader.yml').read_text()
  self.assertEqual(production.count(check.replace('python3 ','python ')),1)
  gate="  production:\n    if: github.event_name == 'workflow_dispatch' && github.ref == 'refs/heads/main'\n    needs: test\n    runs-on: ubuntu-latest\n    environment: production\n"
  self.assertIn(gate,production)
  offline,live=production.split('  production:',1)
  self.assertNotIn('scripts/register-auth-recovery-web.py',offline)
  self.assertNotIn('secrets.PRODUCTION_DATABASE_URL',offline)
  self.assertNotIn('GOVERNANCE_ALLOW_SQLITE_FIXTURES',live)
  self.assertIn('          persist-credentials: false',live)
  self.assertIn("      - name: Verify pinned production recovery catalog parity\n        env:\n          PRODUCTION_DATABASE_URL: ${{ secrets.PRODUCTION_DATABASE_URL }}\n        run: python scripts/register-auth-recovery-web.py --check",live)
  with tempfile.TemporaryDirectory() as temp:
   directory=pathlib.Path(temp);log=directory/'calls.jsonl';shim=directory/'python3'
   shim.write_text('#!'+sys.executable+'\nimport json,os,sys\n'
                   'with open(os.environ["FIXTURE_SCOPE_LOG"],"a") as output:\n'
                   ' output.write(json.dumps([sys.argv[1:],os.environ.get("GOVERNANCE_ALLOW_SQLITE_FIXTURES")])+"\\n")\n')
   shim.chmod(0o700)
   result=subprocess.run(['/bin/sh','-c',command],cwd=directory,
                         env={'PATH':str(directory),'HOME':str(directory),'TMPDIR':str(directory),
                              'PYTHONDONTWRITEBYTECODE':'1','FIXTURE_SCOPE_LOG':str(log)},
                         capture_output=True,text=True,timeout=10)
   self.assertEqual(result.returncode,0,result.stderr)
   calls=[json.loads(line) for line in log.read_text().splitlines()]
   self.assertEqual(calls,[[['scripts/test-auth-recovery-governance.py'],None],
                           [['scripts/register-workspace-visual-review.py'],None]])
if __name__=='__main__':unittest.main()
