import copy,json,unittest
from pathlib import Path
from unittest.mock import patch
from jsonschema import Draft202012Validator,FormatChecker
import sms_link_contracts_registration as m
class DefinitionTests(unittest.TestCase):
 def setUp(self):
  self.d=m.definition();self.ops={o['key']:o for o in self.d['operations']}
  self.validators={key:Draft202012Validator(o['request'],format_checker=FormatChecker()) for key,o in self.ops.items()}
  self.id='11111111-1111-4111-8111-111111111111'
 def examples(self):return {'link.status':{'conversationId':'thread-1'},'link.bind':{'id':self.id,'conversationId':'thread-1','consent':True},'link.revoke':{'id':self.id}}
 def test_exact_nonactivating_pin_and_valid_schemas(self):
  pin=json.loads(Path(__file__).with_name('production-pin.json').read_text());self.assertEqual(pin['smsLinkContractRegistrationWriter'],m.expected_scope());self.assertFalse(self.d['activation'])
  for o in self.d['operations']:
   self.assertEqual(o['authentication'],'native-session-csrf');self.assertEqual(o['permission'],'role_screen_permissions')
   for schema in [o['request'],o['response']]:Draft202012Validator.check_schema(schema)
 def test_only_owner_request_fields_are_accepted(self):
  for key,value in self.examples().items():
   self.validators[key].validate(value)
   for name in ['actor','actorId','tenantId','phone','provider','sessionHash','roles','verified','channel']:
    self.assertFalse(self.validators[key].is_valid({**value,name:'forged'}))
  for change in [{'consent':False},{'consent':'true'},{'id':'bad'},{'conversationId':''}]:self.assertFalse(self.validators['link.bind'].is_valid({**self.examples()['link.bind'],**change}))
 def test_bounded_success_responses_do_not_expose_account_identity_or_phone(self):
  link={'id':self.id,'version':1,'conversationId':'thread-1','channel':'sms'}
  for key,examples in {'link.status':[{'linked':False},{'linked':True,'link':link}],'link.bind':[{'linked':True,'link':link}],'link.revoke':[{'revoked':True}]}.items():
   validator=Draft202012Validator(self.ops[key]['response'])
   for value in examples:
    validator.validate(value)
    for field in ['actorId','tenantId','phone','sessionHash']:self.assertFalse(validator.is_valid({**value,field:'private'}))
 def test_changed_identity_authentication_or_activation_fails(self):
  for target,field,value in [('doc','activation',True),('op','path','/unregistered'),('op','authentication','none'),('op','permission','admin'),('op','method','GET')]:
   changed=copy.deepcopy(self.d);(changed if target=='doc' else changed['operations'][0])[field]=value
   with patch.object(m.json,'loads',return_value=changed),self.assertRaises(m.GovernanceReadError):m.definition()
if __name__=='__main__':unittest.main()
