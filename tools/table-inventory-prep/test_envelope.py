import json
import unittest
from pathlib import Path
from cryptography.exceptions import InvalidTag
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from envelope import seal, unseal

class EnvelopeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.private = rsa.generate_private_key(public_exponent=65537,key_size=3072)
        cls.public = cls.private.public_key().public_bytes(serialization.Encoding.PEM, serialization.PublicFormat.SubjectPublicKeyInfo)
    def test_roundtrip_and_ciphertext_artifact(self):
        payload=b'{"tables":[{"schema":"synthetic","table":"fixture_only","count":7}]}'
        encrypted=seal(payload,self.public)
        self.assertEqual(unseal(encrypted,self.private),payload)
        self.assertNotIn(b'fixture_only',encrypted)
        self.assertNotEqual(seal(payload,self.public),encrypted)
        Path('synthetic-envelope.json').write_bytes(encrypted)
    def test_tamper_rejected(self):
        data=json.loads(seal(b'fixture',self.public))
        data['ciphertext']=('A' if data['ciphertext'][0]!='A' else 'B')+data['ciphertext'][1:]
        with self.assertRaises(InvalidTag): unseal(json.dumps(data),self.private)
    def test_wrong_recipient_rejected(self):
        other=rsa.generate_private_key(public_exponent=65537,key_size=3072)
        with self.assertRaises(ValueError): unseal(seal(b'fixture',self.public),other)
    def test_weak_recipient_rejected(self):
        key=rsa.generate_private_key(public_exponent=65537,key_size=2048)
        public=key.public_key().public_bytes(serialization.Encoding.PEM,serialization.PublicFormat.SubjectPublicKeyInfo)
        with self.assertRaises(ValueError): seal(b'fixture',public)
if __name__=='__main__': unittest.main()
