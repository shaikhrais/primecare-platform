"""Minimal standard TOTP generator for disposable deployed API fixtures."""
import base64,hashlib,hmac,struct
def totp(seed,counter):
    digest=hmac.new(base64.b32decode(seed),struct.pack('>Q',counter),hashlib.sha1).digest()
    offset=digest[-1]&15
    return str((struct.unpack('>I',digest[offset:offset+4])[0]&0x7fffffff)%1000000).zfill(6)
