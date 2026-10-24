import copy,json,unittest
from pathlib import Path
from unittest.mock import patch
from jsonschema import Draft202012Validator,FormatChecker
import vapi_contracts_registration as m
class DefinitionTests(unittest.TestCase):
 def setUp(self):
  self.doc=m.definition();self.op=self.doc['operations'][0]
  self.request=Draft202012Validator(self.op['request'],format_checker=FormatChecker())
  self.response=Draft202012Validator(self.op['response'],format_checker=FormatChecker())
 def test_exact_nonactivating_pin_and_schemas(self):
  pin=json.loads(Path(__file__).with_name('production-pin.json').read_text())
  self.assertEqual(pin['vapiContractRegistrationWriter'],m.expected_scope());self.assertFalse(self.doc['activation'])
  self.assertEqual(m.IDENTITIES,{'vapi.tasks':('POST','/v1/vapi/voice/tasks')})
  self.assertEqual(self.op['authentication'],'vapi-service-credential-and-canonical-call')
  for schema in [self.op['request'],self.op['response']]:Draft202012Validator.check_schema(schema)
 def examples(self):
  common={'action':'propose','requestId':'11111111-1111-4111-8111-111111111111'}
  return [{**common,'taskId':'reception.callback.request','args':{'reason':'general','windowStartsAt':'2026-11-02T15:00:00.000Z','windowEndsAt':'2026-11-02T16:00:00.000Z'}},{**common,'taskId':'appointment.booking.request','args':{'serviceId':'psw','slotId':'slot1','slotVersion':1,'startsAt':'2026-11-02T15:00:00.000Z'}},{**common,'taskId':'appointment.reschedule.request','args':{'appointmentId':'appt1','expectedVersion':1,'slotId':'slot1','slotVersion':1,'startsAt':'2026-11-02T15:00:00.000Z'}},{'action':'execute','intentId':'22222222-2222-4222-8222-222222222222','requestId':common['requestId']}]
 def test_only_allowlisted_proposals_and_execution_are_accepted(self):
  for example in self.examples():self.request.validate(example)
  for example in self.examples():
   for key in ['actor','tenantId','sessionId','approved','url','credential']:
    changed={**example,key:'untrusted'};self.assertFalse(self.request.is_valid(changed))
  for change in [{'action':'approve'},{'action':'otp.check'},{'taskId':'arbitrary.fetch'},{'requestId':'bad'},{'args':{'serviceId':'psw','actor':'admin'}}]:self.assertFalse(self.request.is_valid({**self.examples()[1],**change}))
 def test_response_exposes_no_identity_approval_digest_or_booking_confirmation(self):
  intent=self.examples()[3]['intentId']
  responses=[{'status':'awaiting_confirmation','intentId':intent,'summary':'Request help','expiresAt':1,'requiresConfirmation':True},{'status':'awaiting_confirmation','intentId':intent,'requiresConfirmation':True},{'status':'completed','intentId':intent},{'error':'Task unavailable'}]
  for response in responses:
   self.response.validate(response)
   for key in ['actor','tenantId','digest','appointmentConfirmed']:self.assertFalse(self.response.is_valid({**response,key:True}))
 def test_changed_route_or_auth_or_activation_is_rejected(self):
  for target,field,value in [('doc','activation',True),('op','path','/unregistered'),('op','authentication','none'),('op','permission','admin')]:
   changed=copy.deepcopy(self.doc);(changed if target=='doc' else changed['operations'][0])[field]=value
   with patch.object(m.json,'loads',return_value=changed),self.assertRaises(m.GovernanceReadError):m.definition()
if __name__=='__main__':unittest.main()
