import base64
import json
import unittest
from email.message import EmailMessage
from security_notice_inbox import matches_notice, SecurityNoticeInbox
from owned_inbox import RECIPIENT

class NoticeTests(unittest.TestCase):
    def setUp(self):
        self.copy = {'notifySubject':'Avis de sécurité', 'notifyMessage':'Paramètres modifiés.',
                     'notifyBody':'{{message}} Contactez {{support}}.', 'supportContact':'votre administrateur'}
    def record(self, sender='noreply@15minutes-email.com', recipient=RECIPIENT, body='Paramètres modifiés. Contactez votre administrateur.'):
        m=EmailMessage();m['From']=sender;m['To']=recipient;m['Subject']=self.copy['notifySubject'];m.set_content(body)
        return json.dumps({'rawBase64':base64.b64encode(m.as_bytes()).decode()}).encode()
    def test_localized_mime_matches(self):
        self.assertTrue(matches_notice(self.record(),self.copy))
    def test_wrong_sender_recipient_or_content_fails(self):
        for args in [{'sender':'other@example.invalid'},{'recipient':'other@example.invalid'},{'body':'Unrelated mail'}]:
            self.assertFalse(matches_notice(self.record(**args),self.copy))
    def test_malformed_records_fail_closed(self):
        for data in [b'bad',b'{}',b'{"rawBase64":"!!!"}']:
            self.assertFalse(matches_notice(data,self.copy))
    def test_incomplete_batch_never_deleted(self):
        inbox=SecurityNoticeInbox.__new__(SecurityNoticeInbox);inbox.matched={'fixture':'hash'}
        inbox.call=lambda *a: self.fail('Incomplete batch must not call Cloudflare')
        self.assertIn('preserved',inbox.cleanup())
    def test_changed_record_never_deleted(self):
        inbox=SecurityNoticeInbox.__new__(SecurityNoticeInbox);inbox.matched={str(i):'old' for i in range(5)}
        inbox.path=lambda x:x;calls=[]
        inbox.call=lambda *a:(calls.append(a) or (200,b'changed'))
        with self.assertRaises(RuntimeError):inbox.cleanup()
        self.assertTrue(all(len(x)==1 for x in calls))

if __name__=='__main__':unittest.main()
