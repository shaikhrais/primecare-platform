import copy,json,unittest
from pathlib import Path
from unittest.mock import patch
from jsonschema import Draft202012Validator
import messaging_contracts_registration as m

class DefinitionTests(unittest.TestCase):
 def setUp(self):
  self.doc=m.definition();self.op=self.doc['operations'][0]
  self.request=Draft202012Validator(self.op['request'])
  self.response=Draft202012Validator(self.op['response'])
 def example(self):
  return dict(AccountSid='AC'+'a'*32,MessageSid='SM'+'b'*32,From='+15550002000',To='+15550001000',Body='Hello',NumMedia='0')
 def test_exact_nonactivating_pin(self):
  pin=json.loads(Path(__file__).with_name('production-pin.json').read_text())
  self.assertEqual(pin['messagingContractRegistrationWriter'],m.expected_scope())
  self.assertEqual(m.IDENTITIES,{'sms.incoming':('POST','/v1/twilio/sms/incoming')})
  self.assertEqual(self.op['authentication'],'twilio-signed-form')
  self.assertEqual(self.op['permission'],'twilio.signature')
  self.assertFalse(self.doc['activation'])
  self.assertFalse(m.expected_scope()['permissionChanges'])
  self.assertFalse(m.expected_scope()['businessDataWrites'])
  self.assertFalse(m.expected_scope()['providerWrites'])
  for schema in [self.op['request'],self.op['response']]:Draft202012Validator.check_schema(schema)
 def test_text_control_and_media_receipts(self):
  for change in [{},{'OptOutType':'STOP'},{'OptOutType':'START'},{'OptOutType':'HELP'},
   {'Body':'','NumMedia':'1'},{'Body':'','NumMedia':'10'},
   {'MessagingServiceSid':'MG'+'c'*32},{'Future':['one','two']},
   {'tenantId':'ignored','actorId':'ignored','roles':'ignored'}]:
   self.request.validate({**self.example(),**change})
  self.response.validate('<Response/>')
  for value in [{'status':'success'},'<Response><Message>Unverified reply</Message></Response>','']:
   self.assertFalse(self.response.is_valid(value))
 def test_duplicate_critical_fields_and_invalid_payloads(self):
  for key in self.example():
   self.assertFalse(self.request.is_valid({**self.example(),key:[self.example()[key],self.example()[key]]}))
  for change in [{'From':'whatsapp:+15550002000'},{'AccountSid':'ACbad'},
   {'Body':''},{'Body':'   '},{'Body':'x'*1601},{'Body':'a\x00b'},
   {'NumMedia':'11'},{'NumMedia':'01'},{'NumMedia':0},
   {'MessagingServiceSid':'bad'},{'OptOutType':'OTHER'}]:
   self.assertFalse(self.request.is_valid({**self.example(),**change}),change)
  for key in self.example():
   changed=self.example();del changed[key];self.assertFalse(self.request.is_valid(changed))
 def test_identity_transport_and_activation_cannot_be_widened(self):
  for target,field,value in [('doc','activation',True),('doc','service','notification'),
   ('op','key','sms.status'),('op','path','/unregistered'),('op','method','GET'),
   ('op','authentication','none'),('op','permission','admin'),('op','responseKind','json')]:
   changed=copy.deepcopy(self.doc);(changed if target=='doc' else changed['operations'][0])[field]=value
   with patch.object(m.json,'loads',return_value=changed),self.assertRaises(m.GovernanceReadError):m.definition()
if __name__=='__main__':unittest.main()
