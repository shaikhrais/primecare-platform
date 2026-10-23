"""Pure contract checks; no database, provider request or activation."""
import copy,json,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
from jsonschema import Draft202012Validator
import twilio_contracts_registration as m
class DefinitionTests(unittest.TestCase):
 def setUp(self):self.doc=m.definition()
 def amended(self,change):
  doc=copy.deepcopy(self.doc);change(doc)
  with tempfile.TemporaryDirectory() as root:
   file=Path(root)/'definition.json';file.write_text(json.dumps(doc))
   with patch.object(m,'FILE',file):return m.definition()
 def test_exact_boundary_set_and_pinned_scope_without_activation(self):
  self.assertEqual(len(self.doc['operations']),21);self.assertEqual(len(m.expected_scope()['endpointIdentities']),21)
  self.assertFalse(m.expected_scope()['activation']);self.assertFalse(m.expected_scope()['permissionChanges']);self.assertEqual(m.expected_scope()['tables'],['api_endpoints'])
  pin=json.loads((m.ROOT/'tools/governance-production/production-pin.json').read_text());self.assertEqual(pin['twilioContractRegistrationWriter'],m.expected_scope())
 def test_all_schemas_are_valid_and_native_identity_overrides_are_rejected(self):
  for op in self.doc['operations']:
   Draft202012Validator.check_schema(op['request']);Draft202012Validator.check_schema(op['response'])
   if op['key'] in m.NATIVE:
    validator=Draft202012Validator(op['request'])
    for key in ['actor','tenantId','sessionHash','roles','phone','to']:
     self.assertTrue(list(validator.iter_errors({key:'forged'})),op['key'])
 def test_otp_contracts_match_actual_service_receipts(self):
  ops={o['key']:o for o in self.doc['operations']}
  Draft202012Validator(ops['otp.start']['response']).validate({'verificationRequested':True})
  for verified in [True,False]:Draft202012Validator(ops['otp.check']['response']).validate({'verified':verified})
  self.assertTrue(list(Draft202012Validator(ops['otp.check']['request']).iter_errors({'callSid':'CA'+'a'*32,'code':'000000\n'})))
 def test_provider_forms_allow_future_parameters_without_changing_required_identity(self):
  for op in self.doc['operations']:
   if op['authentication']!='twilio-signed-form':continue
   self.assertIsInstance(op['request']['additionalProperties'],dict)
   self.assertIn('AccountSid',op['request']['required'])
   self.assertNotIn('actor',op['request']['properties'])
  gather=next(o for o in self.doc['operations'] if o['key']=='voice.gather')
  Draft202012Validator(gather['request']).validate({'AccountSid':'AC'+'a'*32,'CallSid':'CA'+'b'*32,'To':'+15550001000','Direction':'inbound','FutureParameter':'signed by SDK','Digits':''})
 def test_activation_unknown_routes_duplicates_and_authentication_changes_are_refused(self):
  mutations=[lambda d:d.update(activation=True),lambda d:d.update(version=True),lambda d:d.update(implementationStatus='implemented'),lambda d:d.update(service='auth'),lambda d:d['operations'].pop(),lambda d:d['operations'][-1].update(path='/unrelated'),lambda d:d['operations'][-1].update(key=d['operations'][0]['key']),lambda d:d['operations'][0].update(authentication='none'),lambda d:d['operations'][0].update(permission='public'),lambda d:d['operations'][0]['request'].update(additionalProperties=True),lambda d:d['operations'][0]['request']['properties'].update(tenantId={'type':'string'})]
  for change in mutations:
   with self.subTest(change=change),self.assertRaises(m.GovernanceReadError):self.amended(change)
 def test_no_model_confirmation_or_arbitrary_business_execution_endpoint(self):
  self.assertFalse(any(key in m.IDENTITIES for key in ['task.execute','task.propose','task.confirm_by_voice']))
  approve=next(o for o in self.doc['operations'] if o['key']=='task.approve');self.assertEqual(approve['authentication'],'native-session-csrf');self.assertEqual(approve['request']['required'],['intentId','digest'])
class IndependentReadbackTests(unittest.TestCase):
 def reader(self,mode=None):
  doc=m.definition();operations={(op['method'],op['path']):(index+1000,op) for index,op in enumerate(doc['operations'])}
  class Result:
   def __init__(self,rows):self.rows=rows
   def fetchall(self):return self.rows
  class Reader:
   calls=[]
   def __enter__(self):return self
   def __exit__(self,*args):return False
   def execute(self,sql,args=()):
    if not sql.startswith('SELECT '):raise AssertionError('Readback attempted a write')
    self.calls.append(sql)
    if sql=='SELECT app_id FROM api_endpoints WHERE id=710':return Result([] if mode=='anchor' else [(2,)])
    if sql.startswith('SELECT COUNT(*)'):return Result([(2 if mode=='idcollision' else 1,)])
    aid,op=operations[args];values=m.values(doc,op,2);row=(aid,*[values[k] for k in m.FIELDS])
    if mode=='edited':row=(*row[:-1],'{"type":"null"}')
    return Result([] if mode=='missing' else [row,row] if mode=='duplicate' else [row])
  return Reader()
 def test_independent_verification_only_reads_and_requires_every_exact_row(self):
  reader=self.reader()
  with patch('production_reader.connect',return_value=reader):receipt=m.verify()
  self.assertEqual(receipt['registered'],21);self.assertTrue(receipt['independentReadback']);self.assertFalse(receipt['writesAttempted']);self.assertEqual(len(reader.calls),43)
 def test_missing_duplicate_edited_rows_and_anchor_fail_readback(self):
  for mode in ['anchor','missing','duplicate','edited','idcollision']:
   with self.subTest(mode=mode),patch('production_reader.connect',return_value=self.reader(mode)),self.assertRaises(m.GovernanceReadError):m.verify()

if __name__=='__main__':unittest.main()
