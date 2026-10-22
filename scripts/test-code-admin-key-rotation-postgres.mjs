import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {rotateMfaStorageBatch} from '../cloudflare/workers/src/security/mfa-key-rotation.mjs';
import {sealCurrentMfaSeed,openStoredMfaSeed} from '../cloudflare/workers/src/security/mfa-keyring.mjs';
import {generateMfaSeed} from '../cloudflare/workers/src/security/mfa-secret.mjs';
let db,client;
const schema='rotation_'+crypto.randomUUID().replaceAll('-','');
if(process.env.MFA_TEST_DATABASE_URL){const pg=await import('pg');client=new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL});await client.connect();db=client;await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);}
else{const {PGlite}=await import('@electric-sql/pglite');db=new PGlite();}
const multi=sql=>db.exec?db.exec(sql):db.query(sql);
const user={id:'11111111-1111-4111-8111-111111111111',tenant_id:'22222222-2222-4222-8222-222222222222'};
const original={MFA_ENCRYPTION_KEY:'a1'.repeat(32)},dual={...original,MFA_ENCRYPTION_KEY_V2:'b2'.repeat(32),MFA_ACTIVE_KEY_ID:'mfa-v2'};
const idType=process.env.MFA_TEST_ID_TYPE==='uuid'?'uuid':'text';
await multi(`CREATE TABLE users(id ${idType} PRIMARY KEY,tenant_id ${idType});CREATE TABLE auth_sessions(token_hash text);`);
await multi(readFileSync('packages/database/migrations/20261025_auth_mfa.sql','utf8'));
await multi(readFileSync('packages/database/migrations/20261026_auth_mfa_lifecycle.sql','utf8'));
after(async()=>{if(client){await db.query('DROP SCHEMA '+schema+' CASCADE');await db.end();}else await db.close();});
async function reset(){await multi('TRUNCATE auth_mfa_credentials,auth_mfa_replacement_challenges,auth_mfa_lifecycle_audit,users');await db.query('INSERT INTO users VALUES($1,$2)',[user.id,user.tenant_id]);const seed=generateMfaSeed(),envelope=await sealCurrentMfaSeed(original,seed,user);await db.query('INSERT INTO auth_mfa_credentials(user_id,tenant_id,envelope,enabled,last_counter) VALUES($1,$2,$3,true,42)',[user.id,user.tenant_id,JSON.stringify(envelope)]);return seed;}
async function credential(){return (await db.query('SELECT envelope,enabled,last_counter FROM auth_mfa_credentials')).rows[0];}
test('rotation preserves exact seed factor state and sessions, audits once, and supports rollback',async()=>{
 const seed=await reset();assert.deepEqual(await rotateMfaStorageBatch(db,dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'}),{rewrapped:1});
 let c=await credential();assert.equal(c.envelope.keyId,'mfa-v2');assert.equal(c.enabled,true);assert.equal(Number(c.last_counter),42);assert.deepEqual(await openStoredMfaSeed(dual,c.envelope,user),seed);
 assert.deepEqual(await rotateMfaStorageBatch(db,dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'}),{rewrapped:0});
 assert.equal(Number((await db.query('SELECT COUNT(*) AS n FROM auth_mfa_lifecycle_audit')).rows[0].n),1);
 assert.deepEqual(await rotateMfaStorageBatch(db,{...dual,MFA_ACTIVE_KEY_ID:'mfa-v1'},{fromKeyId:'mfa-v2',toKeyId:'mfa-v1'}),{rewrapped:1});
 c=await credential();assert.equal(c.envelope.keyId,'mfa-v1');assert.deepEqual(await openStoredMfaSeed(original,c.envelope,user),seed);
});
test('live replacement proof is deferred until expiry',async()=>{
 await reset();const c=await credential();
 await db.query("INSERT INTO auth_mfa_replacement_challenges(token_hash,user_id,tenant_id,password_version,original_envelope_hash,pending_envelope,proof_kind,expires_at) VALUES($1,$2,$3,'version','hash',$4,'current_factor',NOW()+INTERVAL '5 minutes')",['a'.repeat(64),user.id,user.tenant_id,JSON.stringify(c.envelope)]);
 assert.deepEqual(await rotateMfaStorageBatch(db,dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'}),{rewrapped:0});
 await db.query("UPDATE auth_mfa_replacement_challenges SET expires_at=NOW()-INTERVAL '1 second'");
 assert.deepEqual(await rotateMfaStorageBatch(db,dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'}),{rewrapped:1});
});
test('audit failure rolls back envelope rewrap and corrupt context fails closed',async()=>{
 await reset();const before=await credential();
 await multi("CREATE FUNCTION fail_rotation() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic rotation audit fault'; END $$; CREATE TRIGGER fail_rotation BEFORE INSERT ON auth_mfa_lifecycle_audit FOR EACH ROW EXECUTE FUNCTION fail_rotation();");
 await assert.rejects(rotateMfaStorageBatch(db,dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'}));assert.deepEqual(await credential(),before);
 await multi('DROP TRIGGER fail_rotation ON auth_mfa_lifecycle_audit;DROP FUNCTION fail_rotation();');
 await db.query("UPDATE auth_mfa_credentials SET envelope=jsonb_set(envelope,'{ciphertext}',to_jsonb('invalid'::text))");
 await assert.rejects(rotateMfaStorageBatch(db,dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'}));
 assert.equal(Number((await db.query('SELECT COUNT(*) AS n FROM auth_mfa_lifecycle_audit')).rows[0].n),0);
});
test('invalid scope or missing keys cannot start a migration',async()=>{
 await reset();const before=await credential();
 for(const [env,scope] of [[original,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'}],[dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v1'}],[dual,{fromKeyId:'unknown',toKeyId:'mfa-v2'}],[dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2',limit:51}]]) await assert.rejects(rotateMfaStorageBatch(db,env,scope));
 assert.deepEqual(await credential(),before);
});
test('parallel native rotation batches audit and rewrap each credential once',{skip:!client},async()=>{
 await reset();const pg=await import('pg');const peers=[new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL}),new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL})];
 try {
  for(const peer of peers){await peer.connect();await peer.query('SET search_path TO '+schema);}
  const results=await Promise.all(peers.map(peer=>rotateMfaStorageBatch(peer,dual,{fromKeyId:'mfa-v1',toKeyId:'mfa-v2'})));
  assert.equal(results.reduce((sum,r)=>sum+r.rewrapped,0),1);
  assert.equal(Number((await db.query('SELECT COUNT(*) AS n FROM auth_mfa_lifecycle_audit')).rows[0].n),1);
 }finally{await Promise.all(peers.map(peer=>peer.end()));}
});
