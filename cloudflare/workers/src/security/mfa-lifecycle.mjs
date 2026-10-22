import bcrypt from 'bcryptjs';
import {digest} from './mfa.mjs';
import {generateMfaSeed} from './mfa-secret.mjs';
import {activeMfaKeyId, openStoredMfaSeed, sealCurrentMfaSeed} from './mfa-keyring.mjs';
import {matchTotp} from './totp.mjs';
import {generateMfaRecoveryCodes, mfaRecoveryCodeHash, validMfaRecoveryCode} from './mfa-recovery-codes.mjs';

const denied = (status = 401) => ({status, body: {error: 'MFA security request denied'}});
const invalid = () => ({status: 400, body: {error: 'Invalid MFA security request'}});
const tokenShape = value => typeof value === 'string' && /^[A-Za-z0-9_-]{43}$/.test(value);
const codeShape = value => typeof value === 'string' && /^[0-9]{6}$/.test(value);
const passwordShape = value => typeof value === 'string' && value.length > 0 && new TextEncoder().encode(value).length <= 72;
const exact = (body, keys) => body && typeof body === 'object' && !Array.isArray(body) && Object.keys(body).sort().join(',') === [...keys].sort().join(',');
const localeValue = locale => ['en', 'fr', 'es'].includes(locale) ? locale : 'en';
const token = () => btoa(String.fromCharCode(...crypto.getRandomValues(new Uint8Array(32)))).replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
const one = result => {if (!Array.isArray(result.rows) || result.rows.length !== 1) throw Error('MFA lifecycle persistence failed'); return result.rows[0];};
const envelopeVersion = envelope => digest(JSON.stringify([envelope.version, envelope.keyId, envelope.iv, envelope.ciphertext]));

async function lockedUser(db, id) {
  const rows = (await db.query('SELECT id::text AS id,tenant_id::text AS tenant_id,email,roles,status,password_hash FROM users WHERE id::text=$1 FOR UPDATE', [id])).rows;
  if (rows.length !== 1) return null;
  const user = rows[0];
  if (typeof user.id !== 'string' || !user.id || typeof user.tenant_id !== 'string' || !user.tenant_id ||
      typeof user.password_hash !== 'string' || typeof user.email !== 'string' || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(user.email)) return null;
  return user;
}

async function lockedCredential(db, user) {
  const rows = (await db.query('SELECT envelope,enabled,last_counter,tenant_id FROM auth_mfa_credentials WHERE user_id=$1 FOR UPDATE', [user.id])).rows;
  if (rows.length !== 1 || rows[0].tenant_id !== user.tenant_id || rows[0].enabled !== true ||
      !Number.isSafeInteger(Number(rows[0].last_counter)) || Number(rows[0].last_counter) < -1) return null;
  return rows[0];
}

async function proofRate(db, userId) {
  const row = one(await db.query(`INSERT INTO auth_rate_limits(subject_hash,attempts,reset_at)
    VALUES($1,1,NOW()+INTERVAL '15 minutes') ON CONFLICT(subject_hash) DO UPDATE SET
    attempts=CASE WHEN auth_rate_limits.reset_at<=NOW() THEN 1 ELSE LEAST(auth_rate_limits.attempts+1,6) END,
    reset_at=CASE WHEN auth_rate_limits.reset_at<=NOW() THEN NOW()+INTERVAL '15 minutes' ELSE auth_rate_limits.reset_at END
    RETURNING attempts`, [await digest('mfa-lifecycle:' + userId)]));
  if (!Number.isInteger(row.attempts) || row.attempts < 1 || row.attempts > 6) throw Error('MFA rate result invalid');
  return row.attempts <= 5;
}

async function sessionLookup(db, sessionToken) {
  if (!tokenShape(sessionToken)) return null;
  const rows = (await db.query('SELECT user_id::text AS id FROM auth_sessions WHERE token_hash=$1 AND expires_at>NOW()', [await digest(sessionToken)])).rows;
  return rows.length === 1 && typeof rows[0].id === 'string' ? rows[0].id : null;
}

async function sessionCurrent(db, sessionToken, user) {
  return (await db.query('SELECT token_hash FROM auth_sessions WHERE token_hash=$1 AND user_id::text=$2 AND expires_at>NOW() FOR UPDATE', [await digest(sessionToken), user.id])).rows.length === 1;
}

async function freshFactor(db, env, user, password, code) {
  if (!await bcrypt.compare(password, user.password_hash)) return null;
  const credential = await lockedCredential(db, user);
  if (!credential) return null;
  const seed = await openStoredMfaSeed(env, credential.envelope, user);
  const counter = await matchTotp(seed, code, {seconds: Math.floor(Date.now() / 1000), lastAcceptedCounter: Number(credential.last_counter)});
  if (counter === null) return null;
  const stored = one(await db.query('UPDATE auth_mfa_credentials SET last_counter=$2 WHERE user_id=$1 AND last_counter<$2 RETURNING user_id', [user.id, counter]));
  if (stored.user_id !== user.id) throw Error('MFA counter update failed');
  return credential;
}

async function audit(db, user, action) {
  const id = crypto.randomUUID();
  if (one(await db.query('INSERT INTO auth_mfa_lifecycle_audit(id,user_id,tenant_id,action) VALUES($1,$2,$3,$4) RETURNING id', [id, user.id, user.tenant_id, action])).id !== id) throw Error('MFA audit failed');
}

async function notification(db, user, event, locale) {
  const id = crypto.randomUUID();
  if (one(await db.query('INSERT INTO auth_mfa_notification_outbox(id,user_id,tenant_id,recipient,event,locale) VALUES($1,$2,$3,$4,$5,$6) RETURNING id', [id, user.id, user.tenant_id, user.email, event, localeValue(locale)])).id !== id) throw Error('MFA notification queue failed');
}

async function replacement(db, env, user, credential, proofKind) {
  const challenge = token(), seed = generateMfaSeed(), pending = await sealCurrentMfaSeed(env, seed, user);
  await db.query('DELETE FROM auth_mfa_replacement_challenges WHERE user_id=$1', [user.id]);
  const hash = await digest(challenge);
  if (one(await db.query(`INSERT INTO auth_mfa_replacement_challenges
    (token_hash,user_id,tenant_id,password_version,original_envelope_hash,pending_envelope,proof_kind,expires_at)
    VALUES($1,$2,$3,$4,$5,$6,$7,NOW()+INTERVAL '5 minutes') RETURNING token_hash`,
    [hash, user.id, user.tenant_id, await digest(user.password_hash), await envelopeVersion(credential.envelope), JSON.stringify(pending), proofKind])).token_hash !== hash) throw Error('MFA replacement storage failed');
  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'; let setupKey = '', value = 0, bits = 0;
  for (const byte of seed) {value = (value << 8) | byte; bits += 8; while (bits >= 5) {bits -= 5; setupKey += alphabet[(value >>> bits) & 31];}}
  return {status: 200, body: {status: 'mfa_replacement_required', challenge, setupKey}};
}

export async function manageMfaLifecycle(db, env, sessionToken, body, action, locale = 'en', tenantHint = null) {
  if (!['codes', 'replace'].includes(action) || !exact(body, ['password', 'code']) || !passwordShape(body.password) || !codeShape(body.code)) return invalid();
  const {password, code} = body;
  const userId = await sessionLookup(db, sessionToken);
  if (!userId) return denied();
  if (!await proofRate(db, userId)) return denied(429);
  activeMfaKeyId(env);
  await db.query('BEGIN');
  try {
    const user = await lockedUser(db, userId);
    if (!user || user.status !== 'active' || !await sessionCurrent(db, sessionToken, user)) {await db.query('ROLLBACK'); return denied();}
    if (user.roles !== 'code_admin' || (tenantHint !== null && tenantHint !== user.tenant_id)) {await db.query('ROLLBACK'); return denied(403);}
    const credential = await freshFactor(db, env, user, password, code);
    if (!credential) {await db.query('ROLLBACK'); return denied();}
    let response;
    if (action === 'codes') {
      const generated = await generateMfaRecoveryCodes(user);
      await db.query('DELETE FROM auth_mfa_recovery_codes WHERE user_id=$1', [user.id]);
      for (const record of generated.records) {
        const stored = one(await db.query('INSERT INTO auth_mfa_recovery_codes(code_hash,user_id,tenant_id,generation) VALUES($1,$2,$3,$4) RETURNING code_hash', [record.code_hash, user.id, user.tenant_id, generated.generation]));
        if (stored.code_hash !== record.code_hash) throw Error('Recovery-code storage failed');
      }
      await audit(db, user, 'recovery_codes_issued');
      await notification(db, user, 'recovery_codes_issued', locale);
      response = {status: 200, body: {status: 'recovery_codes_issued', recoveryCodes: generated.codes}};
    } else {
      response = await replacement(db, env, user, credential, 'current_factor');
      await audit(db, user, 'authenticator_replacement_started');
    }
    await db.query('COMMIT'); return response;
  } catch (error) {await db.query('ROLLBACK'); throw error;}
}

export async function recoverMfaLifecycle(db, env, body, locale = 'en') {
  if (!exact(body, ['challenge', 'recoveryCode']) || !tokenShape(body.challenge) || !validMfaRecoveryCode(body.recoveryCode)) return invalid();
  const hash = await digest(body.challenge), savedCode = body.recoveryCode;
  const found = (await db.query('SELECT user_id FROM auth_mfa_challenges WHERE token_hash=$1', [hash])).rows;
  if (found.length !== 1) return denied();
  activeMfaKeyId(env);
  await db.query('BEGIN');
  try {
    const user = await lockedUser(db, found[0].user_id);
    const rows = (await db.query('SELECT *,expires_at>NOW() AS fresh FROM auth_mfa_challenges WHERE token_hash=$1 FOR UPDATE', [hash])).rows;
    const challenge = rows[0];
    if (!user || user.status !== 'active' || user.roles !== 'code_admin' || rows.length !== 1 || challenge.fresh !== true ||
        challenge.attempts >= 5 || challenge.purpose !== 'verify' || challenge.role !== user.roles || challenge.tenant_id !== user.tenant_id ||
        challenge.password_version !== await digest(user.password_hash)) {await db.query('ROLLBACK'); return denied();}
    const credential = await lockedCredential(db, user);
    if (!credential) {await db.query('ROLLBACK'); return denied();}
    const generations = (await db.query('SELECT DISTINCT generation FROM auth_mfa_recovery_codes WHERE user_id=$1 AND tenant_id=$2', [user.id, user.tenant_id])).rows;
    const codeHash = generations.length === 1 ? await mfaRecoveryCodeHash(user, generations[0].generation, savedCode) : null;
    const consumed = codeHash ? (await db.query('UPDATE auth_mfa_recovery_codes SET consumed_at=NOW() WHERE code_hash=$1 AND user_id=$2 AND tenant_id=$3 AND consumed_at IS NULL RETURNING code_hash', [codeHash, user.id, user.tenant_id])).rows : [];
    if (consumed.length !== 1) {
      one(await db.query('UPDATE auth_mfa_challenges SET attempts=attempts+1 WHERE token_hash=$1 AND attempts<5 RETURNING attempts', [hash]));
      const id = crypto.randomUUID();
      if (one(await db.query("INSERT INTO auth_mfa_audit(id,user_id,tenant_id,action) VALUES($1,$2,$3,'mfa_verification_failed') RETURNING id", [id, user.id, user.tenant_id])).id !== id) throw Error('MFA failure audit failed');
      await db.query('COMMIT'); return denied();
    }
    if (one(await db.query('DELETE FROM auth_mfa_challenges WHERE token_hash=$1 RETURNING token_hash', [hash])).token_hash !== hash) throw Error('Recovery challenge consumption failed');
    const response = await replacement(db, env, user, credential, 'recovery_code');
    await audit(db, user, 'authenticator_recovery_started');
    await notification(db, user, 'authenticator_recovery_started', locale);
    await db.query('COMMIT'); return response;
  } catch (error) {await db.query('ROLLBACK'); throw error;}
}

export async function confirmMfaReplacement(db, env, body, locale = 'en') {
  if (!exact(body, ['challenge', 'code']) || !tokenShape(body.challenge) || !codeShape(body.code)) return invalid();
  const hash = await digest(body.challenge), code = body.code;
  const found = (await db.query('SELECT user_id FROM auth_mfa_replacement_challenges WHERE token_hash=$1', [hash])).rows;
  if (found.length !== 1) return denied();
  activeMfaKeyId(env);
  await db.query('BEGIN');
  try {
    const user = await lockedUser(db, found[0].user_id);
    const rows = (await db.query('SELECT *,expires_at>NOW() AS fresh FROM auth_mfa_replacement_challenges WHERE token_hash=$1 FOR UPDATE', [hash])).rows;
    const pending = rows[0];
    if (!user || user.status !== 'active' || user.roles !== 'code_admin' || rows.length !== 1 || pending.fresh !== true || pending.attempts >= 5 ||
        pending.tenant_id !== user.tenant_id || pending.password_version !== await digest(user.password_hash)) {await db.query('ROLLBACK'); return denied();}
    const credential = await lockedCredential(db, user);
    if (!credential || await envelopeVersion(credential.envelope) !== pending.original_envelope_hash) {await db.query('ROLLBACK'); return denied();}
    const seed = await openStoredMfaSeed(env, pending.pending_envelope, user);
    const counter = await matchTotp(seed, code, {seconds: Math.floor(Date.now() / 1000), lastAcceptedCounter: -1});
    if (counter === null) {
      one(await db.query('UPDATE auth_mfa_replacement_challenges SET attempts=attempts+1 WHERE token_hash=$1 AND attempts<5 RETURNING attempts', [hash]));
      await db.query('COMMIT'); return denied();
    }
    if (one(await db.query('UPDATE auth_mfa_credentials SET envelope=$2,last_counter=$3,enabled_at=NOW() WHERE user_id=$1 AND enabled=true RETURNING user_id', [user.id, JSON.stringify(pending.pending_envelope), counter])).user_id !== user.id) throw Error('Replacement credential update failed');
    await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1', [user.id]);
    await db.query('DELETE FROM auth_mfa_challenges WHERE user_id=$1', [user.id]);
    await db.query('DELETE FROM auth_mfa_replacement_challenges WHERE user_id=$1', [user.id]);
    await db.query('DELETE FROM auth_mfa_recovery_codes WHERE user_id=$1', [user.id]);
    await audit(db, user, 'authenticator_replaced');
    await notification(db, user, 'authenticator_replaced', locale);
    const issued = token(), issuedHash = await digest(issued);
    if (one(await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) SELECT $1,id,NOW()+INTERVAL '12 hours' FROM users WHERE id::text=$2 AND status='active' RETURNING token_hash", [issuedHash, user.id])).token_hash !== issuedHash) throw Error('Replacement session storage failed');
    await db.query('COMMIT');
    return {status: 200, body: {status: 'authenticated', token: issued, userId: user.id, role: user.roles}};
  } catch (error) {await db.query('ROLLBACK'); throw error;}
}
