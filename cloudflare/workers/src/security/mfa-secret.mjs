// Server-only storage primitive. Never return this envelope, its key or decrypted
// seed through an API. Enrollment/credential lifecycle is intentionally separate.
const encoder = new TextEncoder();
function context(value) {
  if (!value || !['tenantId','userId','keyId'].every(k => typeof value[k] === 'string' && value[k].length > 0 && value[k].length <= 200)) throw Error('Invalid MFA storage context');
  return encoder.encode(JSON.stringify(['primecare-mfa-totp',1,value.tenantId,value.userId,value.keyId]));
}
function hex(bytes) {return [...bytes].map(b=>b.toString(16).padStart(2,'0')).join('');}
function unhex(value, length) {
  if (typeof value !== 'string' || value.length !== length * 2 || !/^[a-f0-9]+$/.test(value)) throw Error('Invalid MFA encrypted data');
  return Uint8Array.from(value.match(/../g),b=>parseInt(b,16));
}
async function keyFor(rawKey, usage) {
  if (!(rawKey instanceof Uint8Array) || rawKey.length !== 32) throw Error('Invalid MFA storage key');
  return crypto.subtle.importKey('raw',rawKey,'AES-GCM',false,[usage]);
}
export function generateMfaSeed() {return crypto.getRandomValues(new Uint8Array(20));}
export async function sealMfaSeed(seed, rawKey, identity) {
  const additionalData = context(identity);
  if (!(seed instanceof Uint8Array) || seed.length !== 20) throw Error('Invalid MFA seed');
  const key = await keyFor(rawKey,'encrypt');
  const iv = crypto.getRandomValues(new Uint8Array(12));
  const ciphertext = await crypto.subtle.encrypt({name:'AES-GCM',iv,additionalData,tagLength:128},key,seed);
  return {version:1,keyId:identity.keyId,iv:hex(iv),ciphertext:hex(new Uint8Array(ciphertext))};
}
export async function openMfaSeed(envelope, rawKey, identity) {
  try {
    const additionalData = context(identity);
    if (!envelope || Object.keys(envelope).sort().join(',') !== 'ciphertext,iv,keyId,version' || envelope.version !== 1 || envelope.keyId !== identity.keyId) throw Error();
    const iv = unhex(envelope.iv,12);
    const ciphertext = unhex(envelope.ciphertext,36); // 20-byte seed + 16-byte tag
    const key = await keyFor(rawKey,'decrypt');
    return new Uint8Array(await crypto.subtle.decrypt({name:'AES-GCM',iv,additionalData,tagLength:128},key,ciphertext));
  } catch {throw Error('MFA secret unavailable');}
}
