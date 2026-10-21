import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {beginMfa,finishMfa,digest} from '../cloudflare/workers/src/security/mfa.mjs';
import {openMfaSeed} from '../cloudflare/workers/src/security/mfa-secret.mjs';
import {totpAt} from '../cloudflare/workers/src/security/totp.mjs';
const env={MFA_ENCRYPTION_KEY:'a1'.repeat(32)},user={id:'11111111-1111-4111-8111-111111111111',tenant_id:'22222222-2222-4222-8222-222222222222',roles:'code_admin',status:'mfa_pending',password_hash:'synthetic-password-version'};
let db,client,schema='mfa_'+crypto.randomUUID().replaceAll('-','');
if(process.env.MFA_TEST_DATABASE_URL){const pg=await import('pg');client=new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL});await client.connect();db=client;await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);}
else {const {PGlite}=await import('@electric-sql/pglite');db=new PGlite();}
const idType=process.env.MFA_TEST_ID_TYPE==='uuid'?'uuid':'text';
await db.exec?.('SELECT 1');
const multi=sql=>db.exec?db.exec(sql):db.query(sql);
await multi(`CREATE TABLE users(id ${idType} PRIMARY KEY,tenant_id ${idType},roles text,status text,password_hash text,updated_at timestamptz DEFAULT NOW());CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id ${idType},expires_at timestamptz);`);
await multi(readFileSync('packages/database/migrations/20261025_auth_mfa.sql','utf8'));
after(async()=>{if(client){await client.query('DROP SCHEMA '+schema+' CASCADE');await client.end();}else await db.close();});
async function reset(){await multi('TRUNCATE auth_mfa_audit,auth_mfa_challenges,auth_mfa_credentials,auth_sessions,users');await db.query('INSERT INTO users(id,tenant_id,roles,status,password_hash) VALUES($1,$2,$3,$4,$5)',Object.values(user));}
async function code(){const r=(await db.query('SELECT envelope FROM auth_mfa_credentials')).rows[0];const seed=await openMfaSeed(r.envelope,Uint8Array.from(env.MFA_ENCRYPTION_KEY.match(/../g),x=>parseInt(x,16)),{tenantId:user.tenant_id,userId:user.id,keyId:'mfa-v1'});return totpAt(seed,Math.floor(Date.now()/1000));}
async function count(table){return Number((await db.query('SELECT COUNT(*) AS n FROM '+table)).rows[0].n);}
test('enrollment grants no session until valid factor; activates pending user and persists audit',async()=>{
 await reset();const started=await beginMfa(db,env,user);assert.equal(started.body.status,'mfa_required');assert.equal(started.body.purpose,'enroll');assert.match(started.body.setupKey,/^[A-Z2-7]{32}$/);assert.equal(started.body.token,undefined);assert.equal(await count('auth_sessions'),0);
 const finish=await finishMfa(db,env,{challenge:started.body.challenge,code:await code()});assert.equal(finish.status,200);assert.match(finish.body.token,/^[A-Za-z0-9_-]{43}$/);assert.equal(await count('auth_sessions'),1);assert.equal((await db.query('SELECT status FROM users')).rows[0].status,'active');assert.equal(await count('auth_mfa_challenges'),0);
 assert.equal((await db.query('SELECT token_hash FROM auth_sessions')).rows[0].token_hash,await digest(finish.body.token));
 assert.deepEqual((await db.query('SELECT action FROM auth_mfa_audit ORDER BY created_at')).rows.map(x=>x.action),['mfa_enrollment_started','mfa_enrolled']);
 assert.equal((await finishMfa(db,env,{challenge:started.body.challenge,code:await code()})).status,401);
 const next=await beginMfa(db,env,user);assert.equal(next.body.purpose,'verify');assert.equal(next.body.setupKey,undefined);assert.equal((await finishMfa(db,env,{challenge:next.body.challenge,code:await code()})).status,401);
});
test('five wrong codes exhaust challenge and retries remain exhausted even with valid factor',async()=>{
 await reset();const start=await beginMfa(db,env,user),valid=await code(),wrong=valid==='000000'?'000001':'000000';for(let i=0;i<5;i++)assert.equal((await finishMfa(db,env,{challenge:start.body.challenge,code:wrong})).status,401);
 assert.equal((await finishMfa(db,env,{challenge:start.body.challenge,code:valid})).status,401);assert.equal(await count('auth_sessions'),0);assert.equal((await db.query('SELECT attempts FROM auth_mfa_challenges')).rows[0].attempts,5);
});
test('expired, stale-password, changed-role, disabled and cross-tenant challenges fail closed',async()=>{
 for(const change of ["UPDATE auth_mfa_challenges SET expires_at=NOW()-INTERVAL '1 second'","UPDATE users SET password_hash='changed'","UPDATE users SET roles='rmt'","UPDATE users SET status='inactive'",`UPDATE users SET tenant_id='33333333-3333-4333-8333-333333333333'`]){
  await reset();const start=await beginMfa(db,env,user),valid=await code();await db.query(change);assert.equal((await finishMfa(db,env,{challenge:start.body.challenge,code:valid})).status,401);assert.equal(await count('auth_sessions'),0);
 }
});
test('missing encryption key and malformed requests never create sessions or credentials',async()=>{
 await reset();await assert.rejects(beginMfa(db,{},user));assert.equal(await count('auth_mfa_credentials'),0);
 for(const body of [{},null,{challenge:'x'.repeat(43),code:'123456',tenantId:'other'},{challenge:'x'.repeat(43),code:123456},{challenge:'x'.repeat(43),code:'123456\n'}])assert.equal((await finishMfa(db,env,body)).status,400);
 assert.equal(await count('auth_sessions'),0);
});
test('audit failure rolls back seed consumption, activation, challenge deletion and session issuance',async()=>{
 await reset();const start=await beginMfa(db,env,user),valid=await code();await multi("CREATE FUNCTION reject_mfa_audit() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic audit fault'; END $$; CREATE TRIGGER reject_mfa_audit BEFORE INSERT ON auth_mfa_audit FOR EACH ROW EXECUTE FUNCTION reject_mfa_audit();");
 await assert.rejects(finishMfa(db,env,{challenge:start.body.challenge,code:valid}));assert.equal(await count('auth_sessions'),0);assert.equal(await count('auth_mfa_challenges'),1);assert.equal((await db.query('SELECT enabled FROM auth_mfa_credentials')).rows[0].enabled,false);assert.equal((await db.query('SELECT status FROM users')).rows[0].status,'mfa_pending');await multi('DROP TRIGGER reject_mfa_audit ON auth_mfa_audit;DROP FUNCTION reject_mfa_audit();');
 assert.equal((await finishMfa(db,env,{challenge:start.body.challenge,code:valid})).status,200);
});
test('new password exchange invalidates older challenge and user has no session before verification',async()=>{
 await reset();const a=await beginMfa(db,env,user),b=await beginMfa(db,env,user);assert.notEqual(a.body.challenge,b.body.challenge);assert.equal((await finishMfa(db,env,{challenge:a.body.challenge,code:await code()})).status,401);assert.equal(await count('auth_sessions'),0);
});
test('concurrent native requests consume the challenge and issue exactly one session',{skip:!client},async()=>{
 await reset();const start=await beginMfa(db,env,user),valid=await code();const pg=await import('pg');const clients=[new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL}),new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL})];
 try{for(const c of clients){await c.connect();await c.query('SET search_path TO '+schema);}const results=await Promise.all(clients.map(c=>finishMfa(c,env,{challenge:start.body.challenge,code:valid})));assert.deepEqual(results.map(x=>x.status).sort(),[200,401]);assert.equal(await count('auth_sessions'),1);assert.equal((await db.query("SELECT COUNT(*) AS n FROM auth_mfa_audit WHERE action='mfa_enrolled'")).rows[0].n,'1');}finally{await Promise.all(clients.map(c=>c.end()));}
});
