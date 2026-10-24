import json,unittest
from pathlib import Path
from jsonschema import Draft202012Validator,FormatChecker
import voice_contact_contracts_registration as m
class DefinitionTests(unittest.TestCase):
 def setUp(self):self.doc=m.definition();self.ops={o['key']:o for o in self.doc['operations']}
 def test_pinned_native_only_nonactivating_contracts(self):
  pin=json.loads(Path(__file__).with_name('production-pin.json').read_text());self.assertEqual(pin['voiceContactRegistrationWriter'],m.expected_scope());self.assertFalse(self.doc['activation']);self.assertEqual(len(self.ops),3)
  for op in self.ops.values():
   self.assertEqual(op['authentication'],'native-session-csrf');self.assertEqual(op['permission'],'role_screen_permissions')
   for key in ['request','response']:Draft202012Validator.check_schema(op[key])
 def test_native_requests_are_bounded_and_cannot_override_identity_or_verification(self):
  examples={'contact.status':{},'contact.start':{'phone':'+15550001001','requestId':'11111111-1111-4111-8111-111111111111'},'contact.check':{'challengeId':'11111111-1111-4111-8111-111111111111','code':'123456'}}
  for key,body in examples.items():
   validator=Draft202012Validator(self.ops[key]['request'],format_checker=FormatChecker());validator.validate(body)
   for field in ['actor','tenantId','roles','sessionHash','verified','verificationSid','url']:self.assertFalse(validator.is_valid({**body,field:'untrusted'}))
  self.assertFalse(Draft202012Validator(self.ops['contact.start']['request']).is_valid({**examples['contact.start'],'phone':'15550001001'}));self.assertFalse(Draft202012Validator(self.ops['contact.check']['request']).is_valid({**examples['contact.check'],'code':'12345'}))
if __name__=='__main__':unittest.main()
