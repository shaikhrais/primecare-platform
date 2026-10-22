import test, {after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import pg from 'pg';
if (!process.env.MFA_TEST_DATABASE_URL) throw Error('Disposable native PostgreSQL is required');
const db = new pg.Client({connectionString: process.env.MFA_TEST_DATABASE_URL});
await db.connect();
const schema = 'mfa_lifecycle_' + crypto.randomUUID().replaceAll('-', '');
await db.query('CREATE SCHEMA ' + schema);
await db.query('SET search_path TO ' + schema);
const migration = readFileSync('packages/database/migrations/20261026_auth_mfa_lifecycle.sql', 'utf8');
after(async () => {await db.query('DROP SCHEMA ' + schema + ' CASCADE'); await db.end();});
test('native migration rolls back without leaving partial lifecycle tables', async () => {
  await db.query('BEGIN'); await db.query(migration); await db.query('ROLLBACK');
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM information_schema.tables WHERE table_schema=$1', [schema])).rows[0].n, 0);
});
test('native migration applies idempotently and rejects invalid proof attempts and kinds', async () => {
  await db.query(migration); await db.query(migration);
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM information_schema.tables WHERE table_schema=$1', [schema])).rows[0].n, 4);
  for (const [attempts, kind] of [[6, 'current_factor'], [-1, 'current_factor'], [0, 'administrator_bypass']]) {
    await assert.rejects(db.query(`INSERT INTO auth_mfa_replacement_challenges
      (token_hash,user_id,tenant_id,password_version,original_envelope_hash,pending_envelope,proof_kind,attempts,expires_at)
      VALUES($1,'synthetic-user','synthetic-tenant','password-version','envelope-hash','{}',$2,$3,NOW()+INTERVAL '5 minutes')`,
      ['a'.repeat(64), kind, attempts]));
  }
});
test('saved-code storage requires canonical hashes and exposes no plaintext-code column', async () => {
  await assert.rejects(db.query("INSERT INTO auth_mfa_recovery_codes(code_hash,user_id,tenant_id,generation) VALUES('plaintext-code','u','t','g')"));
  const columns = (await db.query("SELECT column_name FROM information_schema.columns WHERE table_schema=$1 AND table_name='auth_mfa_recovery_codes'", [schema])).rows.map(r => r.column_name);
  assert.deepEqual(columns.sort(), ['code_hash','consumed_at','created_at','generation','tenant_id','user_id']);
});
test('notification queue enforces bounded states events and supported locales', async () => {
  for (const [event, locale, state] of [['unknown','en','pending'],['recovery_codes_issued','unknown','pending'],['recovery_codes_issued','en','discarded']]) {
    await assert.rejects(db.query(`INSERT INTO auth_mfa_notification_outbox(id,user_id,tenant_id,recipient,event,locale,state)
      VALUES($1,'u','t','synthetic@example.invalid',$2,$3,$4)`, [crypto.randomUUID(), event, locale, state]));
  }
});
