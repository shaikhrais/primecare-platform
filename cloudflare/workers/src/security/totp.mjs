/** RFC 6238 primitive. Callers must rate-limit attempts and atomically persist the
 * returned counter before granting access. This module alone does not enable MFA. */
export async function totpAt(secret, seconds, {digits = 6, algorithm = 'SHA-1'} = {}) {
  if (!(secret instanceof Uint8Array) || secret.length < 20) throw new Error('Invalid TOTP secret');
  if (!Number.isSafeInteger(seconds) || seconds < 0) throw new Error('Invalid TOTP time');
  if (![6, 8].includes(digits) || !['SHA-1', 'SHA-256', 'SHA-512'].includes(algorithm)) throw new Error('Invalid TOTP parameters');
  const counter = Math.floor(seconds / 30);
  const bytes = new Uint8Array(8);
  new DataView(bytes.buffer).setBigUint64(0, BigInt(counter));
  const key = await crypto.subtle.importKey('raw', secret, {name: 'HMAC', hash: algorithm}, false, ['sign']);
  const hash = new Uint8Array(await crypto.subtle.sign('HMAC', key, bytes));
  const offset = hash[hash.length - 1] & 15;
  const binary = new DataView(hash.buffer).getUint32(offset) & 0x7fffffff;
  return String(binary % (10 ** digits)).padStart(digits, '0');
}

/** Accept only current/previous time step. Persist counter with a conditional
 * UPDATE (stored_counter < counter); concurrent callers must not both succeed. */
export async function matchTotp(secret, code, {seconds, lastAcceptedCounter = -1} = {}) {
  if (!Number.isSafeInteger(seconds) || seconds < 0 || !Number.isSafeInteger(lastAcceptedCounter) || lastAcceptedCounter < -1) throw new Error('Invalid TOTP verification state');
  if (typeof code !== 'string' || !/^[0-9]{6}$/.test(code)) return null;
  const current = Math.floor(seconds / 30);
  let match = null;
  for (const counter of [current, current - 1]) {
    if (counter < 0 || counter <= lastAcceptedCounter) continue;
    const expected = await totpAt(secret, counter * 30);
    let difference = 0;
    for (let i = 0; i < 6; i++) difference |= expected.charCodeAt(i) ^ code.charCodeAt(i);
    if (difference === 0 && match === null) match = counter;
  }
  return match;
}
