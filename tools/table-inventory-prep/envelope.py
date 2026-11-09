"""Authenticated envelope for inventory JSON. No network, key persistence or logging."""
import base64
import json
import os
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding, rsa
from cryptography.hazmat.primitives.ciphers.aead import AESGCM

DOMAIN = b'primecare-table-inventory-v1'

def seal(payload, recipient_pem):
    recipient = serialization.load_pem_public_key(recipient_pem)
    if not isinstance(recipient, rsa.RSAPublicKey) or recipient.key_size < 3072:
        raise ValueError('RSA recipient of at least 3072 bits required')
    key, nonce = AESGCM.generate_key(bit_length=256), os.urandom(12)
    encode = lambda b: base64.b64encode(b).decode('ascii')
    wrapped = recipient.encrypt(key, padding.OAEP(mgf=padding.MGF1(hashes.SHA256()), algorithm=hashes.SHA256(), label=DOMAIN))
    ciphertext = AESGCM(key).encrypt(nonce, payload, DOMAIN)
    return json.dumps({'version':1, 'wrapped_key':encode(wrapped), 'nonce':encode(nonce), 'ciphertext':encode(ciphertext)}, sort_keys=True).encode('ascii')

def unseal(envelope, private_key):
    data = json.loads(envelope)
    if data.get('version') != 1 or set(data) != {'version','wrapped_key','nonce','ciphertext'}:
        raise ValueError('Invalid envelope')
    decode = lambda k: base64.b64decode(data[k], validate=True)
    key = private_key.decrypt(decode('wrapped_key'), padding.OAEP(mgf=padding.MGF1(hashes.SHA256()), algorithm=hashes.SHA256(), label=DOMAIN))
    return AESGCM(key).decrypt(decode('nonce'), decode('ciphertext'), DOMAIN)
