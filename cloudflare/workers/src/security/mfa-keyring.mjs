import {openMfaSeed, sealMfaSeed} from './mfa-secret.mjs';

// Fixed binding names prevent untrusted envelope metadata selecting arbitrary
// environment secrets. Retain v1 while v2 is provisioned and migration runs.
const bindings = Object.freeze({'mfa-v1': 'MFA_ENCRYPTION_KEY', 'mfa-v2': 'MFA_ENCRYPTION_KEY_V2'});

export function mfaStorageKey(env, id) {
  if (!Object.hasOwn(bindings, id)) throw Error('MFA storage key unavailable');
  const hex = env[bindings[id]];
  if (typeof hex !== 'string' || !/^[a-f0-9]{64}$/.test(hex)) throw Error('MFA storage key unavailable');
  return Uint8Array.from(hex.match(/../g), value => parseInt(value, 16));
}

export function activeMfaKeyId(env) {
  const id = env.MFA_ACTIVE_KEY_ID ?? 'mfa-v1';
  mfaStorageKey(env, id); // Never fall back when an explicit active key is absent.
  return id;
}

function identity(user, keyId) {
  if (typeof user?.id !== 'string' || !user.id || typeof user?.tenant_id !== 'string' || !user.tenant_id) {
    throw Error('Invalid MFA storage identity');
  }
  return {userId: user.id, tenantId: user.tenant_id, keyId};
}

export async function sealCurrentMfaSeed(env, seed, user) {
  const id = activeMfaKeyId(env);
  return sealMfaSeed(seed, mfaStorageKey(env, id), identity(user, id));
}

export async function openStoredMfaSeed(env, envelope, user) {
  const id = envelope?.keyId;
  return openMfaSeed(envelope, mfaStorageKey(env, id), identity(user, id));
}

export async function rewrapMfaSeed(env, envelope, user) {
  const seed = await openStoredMfaSeed(env, envelope, user);
  const next = await sealCurrentMfaSeed(env, seed, user);
  const verified = await openStoredMfaSeed(env, next, user);
  if (verified.length !== seed.length || verified.some((v, i) => v !== seed[i])) throw Error('MFA rewrap verification failed');
  return next;
}
