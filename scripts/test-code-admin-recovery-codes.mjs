import test from 'node:test';
import assert from 'node:assert/strict';
import {generateMfaRecoveryCodes, mfaRecoveryCodeHash, validMfaRecoveryCode} from '../cloudflare/workers/src/security/mfa-recovery-codes.mjs';
const user = {id: 'synthetic-user', tenant_id: 'synthetic-tenant'};
test('generates ten independent 128-bit saved codes and persists only context-bound hashes', async () => {
  const result = await generateMfaRecoveryCodes(user);
  assert.equal(result.codes.length, 10);assert.equal(new Set(result.codes).size, 10);
  for (let i = 0; i < 10; i++) {
    assert.equal(validMfaRecoveryCode(result.codes[i]), true);
    assert.match(result.records[i].code_hash, /^[a-f0-9]{64}$/);
    assert.equal(result.records[i].code_hash, await mfaRecoveryCodeHash(user, result.generation, result.codes[i]));
    assert.equal(JSON.stringify(result.records).includes(result.codes[i]), false);
  }
});
test('the same saved code does not transfer to another user tenant or generation', async () => {
  const result = await generateMfaRecoveryCodes(user), code = result.codes[0], hash = result.records[0].code_hash;
  assert.notEqual(await mfaRecoveryCodeHash({...user, id: 'foreign'}, result.generation, code), hash);
  assert.notEqual(await mfaRecoveryCodeHash({...user, tenant_id: 'foreign'}, result.generation, code), hash);
  assert.notEqual(await mfaRecoveryCodeHash(user, crypto.randomUUID(), code), hash);
});
test('new generations replace rather than reproduce previous saved material', async () => {
  const first = await generateMfaRecoveryCodes(user), second = await generateMfaRecoveryCodes(user);
  assert.notEqual(first.generation, second.generation);
  assert.equal(second.codes.some(code => first.codes.includes(code)), false);
});
for (const code of ['', 'A'.repeat(25), 'A'.repeat(27), 'a'.repeat(26), '0'.repeat(26), '1'.repeat(26), null, ['A'.repeat(26)]]) {
  test('rejects malformed saved code ' + JSON.stringify(code), async () => {
    assert.equal(validMfaRecoveryCode(code), false);
    await assert.rejects(mfaRecoveryCodeHash(user, crypto.randomUUID(), code));
  });
}
test('missing identity cannot create transferable saved codes', async () => {
  await assert.rejects(generateMfaRecoveryCodes({id: '', tenant_id: 'tenant'}));
  await assert.rejects(generateMfaRecoveryCodes({id: 'user'}));
});
