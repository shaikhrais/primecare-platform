"""Observe localized lifecycle notices in the owned QA inbox; never emit MIME.

This proves batch-level inbox receipt, not a unique outbox-id/message-id mapping:
the current transport does not persist that mapping. Existing mail is preserved.
"""
import base64
import hashlib
import json
import time
from email import policy
from email.parser import BytesParser
from pathlib import Path
from owned_inbox import OwnedInbox, RECIPIENT


def matches_notice(data, copy):
    try:
        envelope = json.loads(data)
        raw = base64.b64decode(envelope['rawBase64'], validate=True)
        message = BytesParser(policy=policy.default).parsebytes(raw)
        if str(message['Subject']) != copy['notifySubject']:
            return False
        from email.utils import getaddresses
        if getaddresses(message.get_all('From', [])) != [('', 'noreply@15minutes-email.com')]:
            # A display name is allowed, but the exact sole sender is required.
            senders = getaddresses(message.get_all('From', []))
            if len(senders) != 1 or senders[0][1].lower() != 'noreply@15minutes-email.com':
                return False
        recipients = getaddresses(message.get_all('To', []))
        if len(recipients) != 1 or recipients[0][1].lower() != RECIPIENT:
            return False
        expected = copy['notifyBody'].replace('{{message}}', copy['notifyMessage']).replace('{{support}}', copy['supportContact'])
        return any(part.get_content_type() == 'text/plain' and part.get_content().strip() == expected
                   for part in message.walk() if not part.is_multipart())
    except (ValueError, KeyError, TypeError, UnicodeError):
        return False


class SecurityNoticeInbox(OwnedInbox):
    def __init__(self, locale):
        self.copy = json.loads(Path('packages/shared/src/auth-lifecycle.json').read_text())['locales'][locale]
        self.locale = locale
        self.matched = {}
        super().__init__()

    def verify(self, db, user, wait):
        deadline = time.monotonic() + 420
        while time.monotonic() < deadline:
            rows = db.execute('SELECT event,locale,state,recipient FROM auth_mfa_notification_outbox WHERE user_id=%s', (user,)).fetchall()
            if len(rows) != 5 or any(row[1] != self.locale or row[3] != RECIPIENT for row in rows):
                raise RuntimeError('Unexpected synthetic lifecycle notice batch')
            for key in sorted(self.keys() - self.baseline):
                if key in self.matched:
                    continue
                status, data = self.call(self.path(key))
                if status == 404:
                    continue
                if status != 200:
                    raise RuntimeError('QA notice inbox read failed')
                if matches_notice(data, self.copy):
                    self.matched[key] = hashlib.sha256(data).hexdigest()
            if len(self.matched) > 5:
                raise RuntimeError('Ambiguous QA notice batch; preserve messages')
            if len(self.matched) == 5 and all(row[2] == 'sent' for row in rows):
                return {'received': 5, 'locale': self.locale, 'transportAcknowledged': 5,
                        'contentMatched': True, 'correlation': 'isolated-inbox-batch',
                        'perEventMessageIdVerified': False,
                        'recordSha256': sorted(self.matched.values())}
            wait(5000)
        raise RuntimeError('Five localized security notices not received within seven minutes')

    def cleanup(self):
        # Only an unambiguous complete batch may be removed. On failure preserve
        # evidence rather than guessing which message belongs to this fixture.
        if len(self.matched) != 5:
            return 'Incomplete or ambiguous notice batch preserved'
        for key, digest in self.matched.items():
            status, data = self.call(self.path(key))
            if status != 200 or hashlib.sha256(data).hexdigest() != digest:
                raise RuntimeError('QA notice changed; preserve it')
        for key in self.matched:
            status, _ = self.call(self.path(key), 'DELETE')
            if status not in (200, 204):
                raise RuntimeError('QA notice cleanup failed')
        return 'Five new content-matched hash-guarded QA notices removed; prior mail preserved'
