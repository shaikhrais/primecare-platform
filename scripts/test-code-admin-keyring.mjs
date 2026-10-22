import test from 'node:test';
import assert from 'node:assert/strict';
import {activeMfaKeyId, sealCurrentMfaSeed, openStoredMfaSeed, rewrapMfaSeed, mfaStorageKey} from '../cloudflare/workers/src/security/mfa-keyring.mjs';
const owner = {id: 'synthetic-user', tenant_id: 'synthetic-tenant'};
const seed = new Uint8Array(20).fill(37);
const legacy = {MFA_ENCRYPTION_KEY: '11'.repeat(32)};
const transition = {...legacy, MFA_ENCRYPTION_KEY_V2: '22'.repeat(32), MFA_ACTIVE_KEY_ID: 'mfa-v2'};
test('existing v1 deployments remain readable with no configuration change', async () => {
  assert.equal(activeMfaKeyId(legacy), 'mfa-v1');
  const envelope = await sealCurrentMfaSeed(legacy, seed, owner);
  assert.equal(envelope.keyId, 'mfa-v1');
  assert.deepEqual(await openStoredMfaSeed(legacy, envelope, owner), seed);
});
test('dual-key transition reads legacy credentials and only seals new credentials with active v2', async () => {
  const envelope = await sealCurrentMfaSeed(legacy, seed, owner);
  assert.deepEqual(await openStoredMfaSeed(transition, envelope, owner), seed);
  assert.equal((await sealCurrentMfaSeed(transition, seed, owner)).keyId, 'mfa-v2');
});
test('verified rewrap preserves authenticator seed and supports a controlled rollback while both keys remain', async () => {
  const old = await sealCurrentMfaSeed(legacy, seed, owner);
  const next = await rewrapMfaSeed(transition, old, owner);
  assert.equal(next.keyId, 'mfa-v2');
  assert.deepEqual(await openStoredMfaSeed(transition, next, owner), seed);
  assert.notEqual(next.ciphertext, old.ciphertext);
  const rolledBack = await rewrapMfaSeed({...transition, MFA_ACTIVE_KEY_ID: 'mfa-v1'}, next, owner);
  assert.equal(rolledBack.keyId, 'mfa-v1');
  assert.deepEqual(await openStoredMfaSeed(legacy, rolledBack, owner), seed);
});
for (const id of ['unknown', '__proto__', 'MFA_ENCRYPTION_KEY', '', null]) {
  test('rejects unknown key selector ' + String(id), () => assert.throws(() => mfaStorageKey(transition, id)));
}
test('missing active key fails instead of falling back to legacy material', () => {
  assert.throws(() => activeMfaKeyId({...legacy, MFA_ACTIVE_KEY_ID: 'mfa-v2'}));
});
test('missing legacy key cannot decrypt old envelopes using the new key', async () => {
  const envelope = await sealCurrentMfaSeed(legacy, seed, owner);
  await assert.rejects(openStoredMfaSeed({MFA_ENCRYPTION_KEY_V2: transition.MFA_ENCRYPTION_KEY_V2}, envelope, owner));
});
test('rewrap rejects a different tenant or user and preserves original envelope', async () => {
  const envelope = await sealCurrentMfaSeed(legacy, seed, owner), before = JSON.stringify(envelope);
  await assert.rejects(rewrapMfaSeed(transition, envelope, {...owner, tenant_id: 'foreign'}));
  await assert.rejects(rewrapMfaSeed(transition, envelope, {...owner, id: 'foreign'}));
  assert.equal(JSON.stringify(envelope), before);
});
test('tampering with envelope key id does not select an alternate successful decryption path', async () => {
  const envelope = await sealCurrentMfaSeed(legacy, seed, owner);
  await assert.rejects(openStoredMfaSeed(transition, {...envelope, keyId: 'mfa-v2'}, owner));
});
