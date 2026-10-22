const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
const encoder = new TextEncoder();
function validIdentity(user, generation) {
  if (!user || !['id', 'tenant_id'].every(k => typeof user[k] === 'string' && user[k].length > 0 && user[k].length <= 200) ||
      typeof generation !== 'string' || !/^[a-f0-9-]{36}$/.test(generation)) throw Error('Invalid recovery-code context');
}
export function validMfaRecoveryCode(code) {return typeof code === 'string' && /^[A-Z2-7]{26}$/.test(code);}
function base32(bytes) {
  let value = 0, bits = 0, output = '';
  for (const byte of bytes) {
    value = (value << 8) | byte; bits += 8;
    while (bits >= 5) {bits -= 5; output += alphabet[(value >>> bits) & 31];}
  }
  if (bits) output += alphabet[(value << (5 - bits)) & 31];
  return output;
}
export async function mfaRecoveryCodeHash(user, generation, code) {
  validIdentity(user, generation);
  if (!validMfaRecoveryCode(code)) throw Error('Invalid recovery code');
  const context = JSON.stringify(['primecare-mfa-recovery', 1, user.tenant_id, user.id, generation, code]);
  return [...new Uint8Array(await crypto.subtle.digest('SHA-256', encoder.encode(context)))].map(v => v.toString(16).padStart(2, '0')).join('');
}
export async function generateMfaRecoveryCodes(user) {
  const generation = crypto.randomUUID(); validIdentity(user, generation);
  const codes = Array.from({length: 10}, () => base32(crypto.getRandomValues(new Uint8Array(16))));
  if (new Set(codes).size !== 10) throw Error('Recovery code generation failed');
  const records = await Promise.all(codes.map(async code => ({
    code_hash: await mfaRecoveryCodeHash(user, generation, code),
    user_id: user.id, tenant_id: user.tenant_id, generation,
  })));
  return {generation, codes, records};
}
