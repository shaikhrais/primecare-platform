import test, {after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import pg from 'pg';
import bcrypt from 'bcryptjs';
import {manageMfaLifecycle, recoverMfaLifecycle, confirmMfaReplacement} from '../cloudflare/workers/src/security/mfa-lifecycle.mjs';
import {beginMfa, digest} from '../cloudflare/workers/src/security/mfa.mjs';
import {sealCurrentMfaSeed} from '../cloudflare/workers/src/security/mfa-keyring.mjs';
import {totpAt} from '../cloudflare/workers/src/security/totp.mjs';
if (!process.env.MFA_TEST_DATABASE_URL) throw Error('Disposable native PostgreSQL required');
const db = new pg.Client({connectionString: process.env.MFA_TEST_DATABASE_URL}); await db.connect();
const schema = 'mfa_recovery_' + crypto.randomUUID().replaceAll('-', '');
await db.query('CREATE SCHEMA ' + schema); await db.query('SET search_path TO ' + schema);
const type = process.env.MFA_TEST_ID_TYPE === 'uuid' ? 'uuid' : 'text';
await db.query(`CREATE TABLE users(id ${type} PRIMARY KEY,tenant_id ${type},email text,roles text,status text,password_hash text,updated_at timestamptz DEFAULT NOW());
  CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id ${type},expires_at timestamptz);
  CREATE TABLE auth_rate_limits(subject_hash text PRIMARY KEY,attempts integer NOT NULL,reset_at timestamptz NOT NULL);`);
for (const file of ['20261025_auth_mfa.sql', '20261026_auth_mfa_lifecycle.sql']) await db.query(readFileSync('packages/database/migrations/' + file, 'utf8'));
const realNow = Date.now; let clock = realNow(); Date.now = () => clock;
const env = {MFA_ENCRYPTION_KEY: '11'.repeat(32)};
const password = 'Synthetic lifecycle password!';
const user = {id:'11111111-1111-4111-8111-111111111111',tenant_id:'22222222-2222-4222-8222-222222222222',email:'lifecycle@example.invalid',roles:'code_admin',status:'active',password_hash:await bcrypt.hash(password, 4)};
const seed = new Uint8Array(20).fill(37), session = 's'.repeat(43);
after(async () => {Date.now = realNow; await db.query('DROP SCHEMA ' + schema + ' CASCADE'); await db.end();});
async function reset() {
  clock = realNow();
  await db.query('TRUNCATE auth_mfa_recovery_codes,auth_mfa_replacement_challenges,auth_mfa_lifecycle_audit,auth_mfa_notification_outbox,auth_mfa_audit,auth_mfa_challenges,auth_mfa_credentials,auth_sessions,auth_rate_limits,users');
  await db.query('INSERT INTO users(id,tenant_id,email,roles,status,password_hash) VALUES($1,$2,$3,$4,$5,$6)', Object.values(user));
  await db.query('INSERT INTO auth_mfa_credentials(user_id,tenant_id,envelope,enabled) VALUES($1,$2,$3,true)', [user.id,user.tenant_id,JSON.stringify(await sealCurrentMfaSeed(env,seed,user))]);
  await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')", [await digest(session),user.id]);
}
async function count(table) {return (await db.query('SELECT COUNT(*)::int AS n FROM ' + table)).rows[0].n;}
async function code() {return totpAt(seed,Math.floor(Date.now()/1000));}
function decode32(value) {let n=0,bits=0,bytes=[];for(const char of value){n=(n<<5)|'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'.indexOf(char);bits+=5;if(bits>=8){bits-=8;bytes.push((n>>>bits)&255);}}return new Uint8Array(bytes);}
async function replacementCode(start) {return totpAt(decode32(start.body.setupKey),Math.floor(Date.now()/1000));}
async function codes() {return manageMfaLifecycle(db,env,session,{password,code:await code()},'codes','fr',user.tenant_id);}
async function recovery() {
  const issued = await codes(); assert.equal(issued.status,200);
  const login = await beginMfa(db,env,user);
  const started = await recoverMfaLifecycle(db,env,{challenge:login.body.challenge,recoveryCode:issued.body.recoveryCodes[0]},'fr');
  assert.equal(started.status,200);return {issued,login,started};
}
test('fresh self proof issues ten hashed codes and queues a secret-free notification atomically', async () => {
  await reset();const result=await codes();assert.equal(result.status,200);assert.equal(result.body.recoveryCodes.length,10);
  assert.equal(await count('auth_mfa_recovery_codes'),10);assert.equal(await count('auth_mfa_lifecycle_audit'),1);assert.equal(await count('auth_mfa_notification_outbox'),1);
  const records=JSON.stringify((await db.query('SELECT * FROM auth_mfa_recovery_codes')).rows);
  for(const saved of result.body.recoveryCodes)assert.equal(records.includes(saved),false);
  const notice=(await db.query('SELECT * FROM auth_mfa_notification_outbox')).rows[0];assert.equal(notice.locale,'fr');assert.equal(notice.state,'pending');
  assert.equal(JSON.stringify(notice).includes(password),false);assert.equal(JSON.stringify(notice).includes(session),false);
  assert.equal(await count('auth_sessions'),1);
});
test('reissuing saved codes invalidates the entire old generation', async () => {
  await reset();const first=await codes();clock+=30000;const second=await codes();assert.equal(second.status,200);
  assert.equal(await count('auth_mfa_recovery_codes'),10);
  const login=await beginMfa(db,env,user);
  assert.equal((await recoverMfaLifecycle(db,env,{challenge:login.body.challenge,recoveryCode:first.body.recoveryCodes[0]})).status,401);
  assert.equal((await recoverMfaLifecycle(db,env,{challenge:login.body.challenge,recoveryCode:second.body.recoveryCodes[0]})).status,200);
});
test('saved-code recovery grants only a replacement challenge until the new factor is confirmed', async () => {
  await reset();const before=JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope);
  const {started}=await recovery();assert.equal(started.body.status,'mfa_replacement_required');assert.equal(started.body.token,undefined);
  assert.equal(await count('auth_sessions'),1);assert.equal(JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope),before);
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_mfa_recovery_codes WHERE consumed_at IS NOT NULL')).rows[0].n,1);
  const finish=await confirmMfaReplacement(db,env,{challenge:started.body.challenge,code:await replacementCode(started)},'fr');
  assert.equal(finish.status,200);assert.equal(finish.body.userId,user.id);assert.equal(finish.body.role,'code_admin');
  assert.equal(await count('auth_sessions'),1);assert.equal(await count('auth_mfa_recovery_codes'),0);assert.equal(await count('auth_mfa_replacement_challenges'),0);
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE token_hash=$1',[await digest(session)])).rows[0].n,0);
  assert.equal((await db.query('SELECT token_hash FROM auth_sessions')).rows[0].token_hash,await digest(finish.body.token));
  assert.equal((await confirmMfaReplacement(db,env,{challenge:started.body.challenge,code:await replacementCode(started)})).status,401);
});
test('cancelled replacement leaves the existing factor and session working', async () => {
  await reset();const before=JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope);
  const start=await manageMfaLifecycle(db,env,session,{password,code:await code()},'replace');assert.equal(start.status,200);
  assert.equal(JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope),before);
  assert.equal(await count('auth_sessions'),1);assert.equal(await count('auth_mfa_replacement_challenges'),1);
  clock+=30000;assert.equal((await codes()).status,200);
});
test('wrong password lower role mismatched tenant and expired session cannot manage factors', async () => {
  for(const kind of ['password','role','tenant','session']) {
    await reset();if(kind==='role')await db.query("UPDATE users SET roles='tenant_admin'");if(kind==='session')await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second'");
    const response=await manageMfaLifecycle(db,env,session,{password:kind==='password'?'wrong':password,code:await code()},'codes','en',kind==='tenant'?'foreign':null);
    assert.equal(response.status,['role','tenant'].includes(kind)?403:401);assert.equal(await count('auth_mfa_recovery_codes'),0);
    assert.equal(Number((await db.query('SELECT last_counter FROM auth_mfa_credentials')).rows[0].last_counter),-1);
  }
});
test('failed proof attempts survive rollback and throttle further management requests', async () => {
  await reset();for(let i=0;i<5;i++)assert.equal((await manageMfaLifecycle(db,env,session,{password:'wrong',code:await code()},'codes')).status,401);
  assert.equal((await codes()).status,429);assert.equal(await count('auth_mfa_recovery_codes'),0);
  await db.query("UPDATE auth_rate_limits SET reset_at=NOW()-INTERVAL '1 second'");assert.equal((await codes()).status,200);
});
test('expired stale-password changed-role disabled and cross-tenant replacement proofs fail closed', async () => {
  for(const sql of ["UPDATE auth_mfa_replacement_challenges SET expires_at=NOW()-INTERVAL '1 second'","UPDATE users SET password_hash='changed'","UPDATE users SET roles='rmt'","UPDATE users SET status='inactive'","UPDATE users SET tenant_id='33333333-3333-4333-8333-333333333333'"]) {
    await reset();const {started}=await recovery();const before=JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope);
    await db.query(sql);assert.equal((await confirmMfaReplacement(db,env,{challenge:started.body.challenge,code:await replacementCode(started)})).status,401);
    assert.equal(JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope),before);assert.equal(await count('auth_sessions'),1);
  }
});
test('five invalid saved-code attempts exhaust the password-verified challenge', async () => {
  await reset();const issued=await codes(),login=await beginMfa(db,env,user);
  const wrong='A'.repeat(26);assert.equal(issued.body.recoveryCodes.includes(wrong),false);
  for(let i=0;i<5;i++)assert.equal((await recoverMfaLifecycle(db,env,{challenge:login.body.challenge,recoveryCode:wrong})).status,401);
  assert.equal((await recoverMfaLifecycle(db,env,{challenge:login.body.challenge,recoveryCode:issued.body.recoveryCodes[0]})).status,401);
  assert.equal(await count('auth_mfa_replacement_challenges'),0);assert.equal(await count('auth_sessions'),1);
});
test('audit or outbox faults roll back issuance and factor-counter consumption', async () => {
  for(const table of ['auth_mfa_lifecycle_audit','auth_mfa_notification_outbox']) {
    await reset();await db.query(`CREATE FUNCTION reject_lifecycle_write() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic write fault'; END $$; CREATE TRIGGER reject_write BEFORE INSERT ON ${table} FOR EACH ROW EXECUTE FUNCTION reject_lifecycle_write();`);
    try {await assert.rejects(codes());assert.equal(await count('auth_mfa_recovery_codes'),0);assert.equal(await count('auth_mfa_lifecycle_audit'),0);assert.equal(await count('auth_mfa_notification_outbox'),0);assert.equal(Number((await db.query('SELECT last_counter FROM auth_mfa_credentials')).rows[0].last_counter),-1);}
    finally {await db.query(`DROP TRIGGER reject_write ON ${table}; DROP FUNCTION reject_lifecycle_write();`);}
    assert.equal((await codes()).status,200);
  }
});
test('replacement audit failure preserves old factor sessions and challenge for a safe retry', async () => {
  await reset();const {started}=await recovery(),before=JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope);
  await db.query("CREATE FUNCTION reject_replacement_audit() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF NEW.action='authenticator_replaced' THEN RAISE EXCEPTION 'synthetic audit fault'; END IF; RETURN NEW; END $$; CREATE TRIGGER reject_replacement BEFORE INSERT ON auth_mfa_lifecycle_audit FOR EACH ROW EXECUTE FUNCTION reject_replacement_audit();");
  try {await assert.rejects(confirmMfaReplacement(db,env,{challenge:started.body.challenge,code:await replacementCode(started)}));assert.equal(await count('auth_sessions'),1);assert.equal(await count('auth_mfa_replacement_challenges'),1);assert.equal(JSON.stringify((await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0].envelope),before);}
  finally {await db.query('DROP TRIGGER reject_replacement ON auth_mfa_lifecycle_audit; DROP FUNCTION reject_replacement_audit();');}
  assert.equal((await confirmMfaReplacement(db,env,{challenge:started.body.challenge,code:await replacementCode(started)})).status,200);
});
test('concurrent saved-code recovery consumes one code and yields exactly one limited challenge', async () => {
  await reset();const issued=await codes(),login=await beginMfa(db,env,user),clients=[new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL}),new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL})];
  try {for(const client of clients){await client.connect();await client.query('SET search_path TO '+schema);}const result=await Promise.all(clients.map(client=>recoverMfaLifecycle(client,env,{challenge:login.body.challenge,recoveryCode:issued.body.recoveryCodes[0]})));assert.deepEqual(result.map(r=>r.status).sort(),[200,401]);assert.equal(await count('auth_mfa_replacement_challenges'),1);assert.equal(await count('auth_sessions'),1);}
  finally {await Promise.all(clients.map(c=>c.end()));}
});
test('concurrent replacement confirmation issues one new session and denies replay', async () => {
  await reset();const {started}=await recovery(),valid=await replacementCode(started),clients=[new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL}),new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL})];
  try {for(const client of clients){await client.connect();await client.query('SET search_path TO '+schema);}const result=await Promise.all(clients.map(client=>confirmMfaReplacement(client,env,{challenge:started.body.challenge,code:valid})));assert.deepEqual(result.map(r=>r.status).sort(),[200,401]);assert.equal(await count('auth_sessions'),1);assert.equal(await count('auth_mfa_replacement_challenges'),0);}
  finally {await Promise.all(clients.map(c=>c.end()));}
});
test('extra actor fields and malformed requests cannot redirect recovery or replacement', async () => {
  await reset();assert.equal((await manageMfaLifecycle(db,env,session,{password,code:await code(),userId:'foreign'},'codes')).status,400);
  assert.equal((await recoverMfaLifecycle(db,env,{challenge:'a'.repeat(43),recoveryCode:'A'.repeat(26),tenantId:'foreign'})).status,400);
  assert.equal((await confirmMfaReplacement(db,env,{challenge:'a'.repeat(43),code:'123456',userId:'foreign'})).status,400);
  assert.equal(await count('auth_mfa_recovery_codes'),0);assert.equal(await count('auth_mfa_replacement_challenges'),0);
});
