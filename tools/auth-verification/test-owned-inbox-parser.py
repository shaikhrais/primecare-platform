import unittest,json,base64
from email.message import EmailMessage
from owned_inbox import candidate_codes,OwnedInbox
class ParserTests(unittest.TestCase):
 def test_plain_and_stored_mime(self):
  code='A1B2C3D4E5F6';message=EmailMessage();message['Subject']='Synthetic recovery';message.set_content('Code: '+code)
  self.assertIn(code,candidate_codes(message.as_bytes()));self.assertIn(code,candidate_codes(json.dumps({'rawBase64':base64.b64encode(message.as_bytes()).decode()}).encode()))
 def test_malformed_record_is_not_executed(self):
  self.assertEqual(candidate_codes(b'{"rawBase64":"!!!invalid!!!"}'),set());self.assertEqual(candidate_codes(b'no reset code'),set())
 def test_prior_or_other_inbox_paths_are_refused(self):
  x=OwnedInbox.__new__(OwnedInbox);x.prefix='inbox/auth-test@15minutes-email.com/';x.baseline={x.prefix+'old'};x.api='/fixture'
  for key in [x.prefix+'old','inbox/another@example.invalid/new']:
   with self.assertRaises(RuntimeError):x.path(key)
  self.assertIn('new',x.path(x.prefix+'new'))
if __name__=='__main__':unittest.main()
