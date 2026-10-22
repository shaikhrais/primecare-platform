import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import bcrypt from 'bcryptjs';
import {privilegedAccess} from '../cloudflare/workers/src/security/mfa-elevation.mjs';
import {digest} from '../cloudflare/workers/src/security/mfa.mjs';
import {sealCurrentMfaSeed} from '../cloudflare/workers/src/security/mfa-keyring.mjs';
import {totpAt} from '../cloudflare/workers/src/security/totp.mjs';
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden');
let db,client;
const schema='privilege_'+crypto.randomUUID().replaceAll('-','');
if(process.env.MFA_TEST_DATABASE_URL){const url=new URL(process.env.MFA_TEST_DATABASE_URL);if(!['localhost','127.0.0.1'].includes(url.hostname))throw Error('Disposable loopback PostgreSQL required');const pg=await import('pg');client=new pg.default.Client({connectionString:url.href});await client.connect();db=client;await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);}
else{const {PGlite}=await import('@electric-sql/pglite');db=new PGlite();}
const multi=sql=>db.exec?db.exec(sql):db.query(sql),type=process.env.MFA_TEST_ID_TYPE==='uuid'?'uuid':'text';
await multi(`CREATE TABLE tenants(id ${type} PRIMARY KEY,status text);CREATE TABLE users(id ${type} PRIMARY KEY,tenant_id ${type},email text,roles text,status text,password_hash text);CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id ${type},expires_at timestamptz);CREATE TABLE auth_rate_limits(subject_hash text PRIMARY KEY,attempts integer,reset_at timestamptz);`);
for(const file of ['20261025_auth_mfa.sql','20261026_auth_mfa_lifecycle.sql','20261027_auth_privileged_access.sql'])await multi(readFileSync('packages/database/migrations/'+file,'utf8'));
after(async()=>{if(client){await db.query('DROP SCHEMA '+schema+' CASCADE');await db.end();}else await db.close();});
const uid=n=>`${String(n).padStart(8,'0')}-1111-4111-8111-111111111111`;
const root={id:uid(1),tenant:uid(11),role:'code_admin',session:'a'.repeat(43)},admin={id:uid(2),tenant:uid(12),role:'tenant_admin',session:'b'.repeat(43)},foreign={id:uid(3),tenant:uid(13),role:'tenant_admin',session:'c'.repeat(43)},member={id:uid(4),tenant:admin.tenant,role:'rmt',session:'d'.repeat(43)};
const actors=[root,admin,foreign,member],env={MFA_ENCRYPTION_KEY:'a1'.repeat(32)},password='Synthetic support password!',hash=await bcrypt.hash(password,4),seed=new Uint8Array(20).fill(37),scope=['tenant_security_summary'];
async function reset(){
 await multi('TRUNCATE auth_tenant_support_requests,auth_privilege_elevations,auth_privileged_access_audit,auth_mfa_credentials,auth_mfa_audit,auth_rate_limits,auth_sessions,users,tenants');
 for(const tenant of new Set(actors.map(a=>a.tenant)))await db.query("INSERT INTO tenants VALUES($1,'active')",[tenant]);
 for(const actor of actors){await db.query("INSERT INTO users VALUES($1,$2,$3,$4,'active',$5)",[actor.id,actor.tenant,actor.id+'@example.invalid',actor.role,hash]);await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour')",[await digest(actor.session),actor.id]);}
 for(const actor of [root,admin])await db.query('INSERT INTO auth_mfa_credentials(user_id,tenant_id,envelope,enabled) VALUES($1,$2,$3,true)',[actor.id,actor.tenant,JSON.stringify(await sealCurrentMfaSeed(env,seed,{id:actor.id,tenant_id:actor.tenant}))]);
}
const call=(actor,body,operation,tenantHint=null)=>privilegedAccess(db,env,actor.session,body,operation,tenantHint);
const count=async(table)=>(await db.query('SELECT COUNT(*)::int AS n FROM '+table)).rows[0].n;
async function elevate(){const result=await call(root,{password,code:await totpAt(seed,Math.floor(Date.now()/1000)),reason:'Investigate tenant sign-in counts',scope,seconds:900},'elevate');assert.equal(result.status,200);return result.body;}
async function request(elevated){const result=await call(root,{elevationId:elevated.elevationId,tenantId:admin.tenant,ticket:'SYN-123',reason:'Investigate tenant sign-in counts',scope,seconds:900},'requestSupport');assert.equal(result.status,200);return result.body;}
async function approved(){const e=await elevate(),r=await request(e);assert.equal((await call(admin,{requestId:r.requestId,password},'approveSupport')).status,200);return {e,r};}
test('fresh proof creates scoped hashed-session elevation without granting a role or new session',async()=>{
 await reset();const e=await elevate();assert.deepEqual(Object.keys(e).sort(),['elevationId','expiresAt','scope','status']);assert.equal(e.status,'elevated');assert.deepEqual(e.scope,scope);
 const stored=(await db.query('SELECT * FROM auth_privilege_elevations')).rows[0];assert.equal(stored.session_hash,await digest(root.session));assert.equal(JSON.stringify(stored).includes(root.session),false);assert.ok(stored.expires_at-stored.created_at<=900000);
 assert.equal(await count('auth_sessions'),4);assert.equal((await db.query('SELECT roles FROM users WHERE id=$1',[root.id])).rows[0].roles,'code_admin');assert.equal(await count('auth_privileged_access_audit'),1);
 const counter=Number((await db.query('SELECT last_counter FROM auth_mfa_credentials WHERE user_id=$1',[root.id])).rows[0].last_counter);
 const replay=await call(root,{password,code:await totpAt(seed,counter*30),reason:'Investigate tenant sign-in counts',scope,seconds:900},'elevate');assert.equal(replay.status,401);assert.equal(await count('auth_privilege_elevations'),1);
});
test('tenant approval is explicit scoped and bounded; summary returns only the approved tenant aggregate',async()=>{
 await reset();const e=await elevate(),r=await request(e);assert.ok(new Date(r.expiresAt)<=new Date(e.expiresAt));
 assert.equal((await call(root,{requestId:r.requestId},'summary')).status,403);
 const list=await call(admin,{},'listSupport');assert.equal(list.body.requests.length,1);assert.equal((await call(foreign,{},'listSupport')).body.requests.length,0);
 assert.equal((await call(foreign,{requestId:r.requestId,password},'approveSupport')).status,403);assert.equal((await call(root,{requestId:r.requestId,password},'approveSupport')).status,403);
 assert.equal((await call(admin,{requestId:r.requestId,password},'approveSupport')).status,200);
 const result=await call(root,{requestId:r.requestId},'summary');assert.deepEqual(result,{status:200,body:{tenantId:admin.tenant,activeAccounts:2,activeSessions:2,enrolledAuthenticators:1}});
 const actions=(await db.query('SELECT action FROM auth_privileged_access_audit ORDER BY created_at,id')).rows.map(x=>x.action);assert.equal(actions.filter(x=>x==='security_summary_read').length,1);
 assert.equal((await call(root,{requestId:r.requestId},'summary',foreign.tenant)).status,403);
});
test('different actor or another session of the same actor cannot transfer a grant',async()=>{
 await reset();const {e,r}=await approved();const other={...root,session:'x'.repeat(43)};await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour')",[await digest(other.session),root.id]);
 for(const actor of [other,admin,member,foreign])assert.equal((await call(actor,{requestId:r.requestId},'summary')).status,403);
 assert.equal((await call(other,{elevationId:e.elevationId,tenantId:foreign.tenant,ticket:'SYN-2',reason:'Investigate tenant sign-in counts',scope,seconds:900},'requestSupport')).status,403);
 assert.equal((await call(other,{elevationId:e.elevationId},'revokeElevation')).status,403);
});
test('tenant or requester revocation and elevation revocation deny subsequent use',async()=>{
 for(const by of ['tenant','requester','elevation']){
  await reset();const {e,r}=await approved();
  const revoked=by==='elevation'?await call(root,{elevationId:e.elevationId},'revokeElevation'):await call(by==='tenant'?admin:root,{requestId:r.requestId,password},'revokeSupport');
  assert.equal(revoked.status,200);assert.equal((await call(root,{requestId:r.requestId},'summary')).status,403);
  assert.equal((await call(foreign,{requestId:r.requestId,password},'revokeSupport')).status,403);
 }
});
test('expiry changed role tenant disabled actor or tenant and revoked session invalidate capability use',async()=>{
 for(const sql of ["UPDATE auth_privilege_elevations SET created_at=NOW()-INTERVAL '16 minutes',expires_at=NOW()-INTERVAL '2 minutes'",`UPDATE users SET roles='rmt' WHERE id='${root.id}'`,`UPDATE users SET tenant_id='${foreign.tenant}' WHERE id='${root.id}'`,`UPDATE users SET status='inactive' WHERE id='${root.id}'`,`UPDATE tenants SET status='inactive' WHERE id='${admin.tenant}'`,`UPDATE tenants SET status='inactive' WHERE id='${root.tenant}'`,`DELETE FROM auth_sessions WHERE user_id='${root.id}'`,`UPDATE users SET roles='rmt' WHERE id='${admin.id}'`]){
  await reset();const {r}=await approved();await db.query(sql);assert.ok([401,403].includes((await call(root,{requestId:r.requestId},'summary')).status));
 }
});
test('fresh tenant password is required for approval and failure audits cannot grant access',async()=>{
 await reset();const e=await elevate(),r=await request(e);
 assert.equal((await call(admin,{requestId:r.requestId,password:'wrong'},'approveSupport')).status,401);
 assert.equal((await db.query('SELECT state FROM auth_tenant_support_requests')).rows[0].state,'pending');assert.equal((await call(root,{requestId:r.requestId},'summary')).status,403);
 assert.equal((await db.query("SELECT COUNT(*)::int AS n FROM auth_privileged_access_audit WHERE action='proof_failed'")).rows[0].n,1);
});
test('audit fault rolls back factor consumption and elevation creation; summary audit fault returns no data',async()=>{
 await reset();await multi("CREATE FUNCTION fail_privilege() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic audit fault'; END $$;CREATE TRIGGER fail_privilege BEFORE INSERT ON auth_privileged_access_audit FOR EACH ROW EXECUTE FUNCTION fail_privilege();");
 await assert.rejects(call(root,{password,code:await totpAt(seed,Math.floor(Date.now()/1000)),reason:'Investigate tenant sign-in counts',scope,seconds:900},'elevate'));assert.equal(await count('auth_privilege_elevations'),0);assert.equal(Number((await db.query('SELECT last_counter FROM auth_mfa_credentials WHERE user_id=$1',[root.id])).rows[0].last_counter),-1);
 await multi('DROP TRIGGER fail_privilege ON auth_privileged_access_audit;');const {r}=await approved();
 await multi('CREATE TRIGGER fail_privilege BEFORE INSERT ON auth_privileged_access_audit FOR EACH ROW EXECUTE FUNCTION fail_privilege();');
 await assert.rejects(call(root,{requestId:r.requestId},'summary'));assert.equal((await db.query('SELECT state FROM auth_tenant_support_requests')).rows[0].state,'approved');
 await multi('DROP TRIGGER fail_privilege ON auth_privileged_access_audit;DROP FUNCTION fail_privilege();');
});
test('malformed scope duration and actor-shaped extras fail before granting any capability',async()=>{
 await reset();const body={password,code:await totpAt(seed,Math.floor(Date.now()/1000)),reason:'Investigate tenant sign-in counts',scope,seconds:900};
 for(const variant of [{...body,seconds:901},{...body,scope:['clinical_records']},{...body,userId:root.id},{...body,reason:'short'},{...body,password:'x'.repeat(73)}])assert.equal((await call(root,variant,'elevate')).status,400);
 assert.equal(await count('auth_privilege_elevations'),0);
 for(let i=0;i<5;i++)assert.equal((await call(root,{...body,password:'wrong'},'elevate')).status,401);
 assert.equal((await call(root,body,'elevate')).status,429);assert.equal(await count('auth_privilege_elevations'),0);
});
test('parallel native fresh-factor elevation requests produce one grant',{skip:!client},async()=>{
 await reset();const pg=await import('pg');const peers=[new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL}),new pg.default.Client({connectionString:process.env.MFA_TEST_DATABASE_URL})];
 try{for(const peer of peers){await peer.connect();await peer.query('SET search_path TO '+schema);}const body={password,code:await totpAt(seed,Math.floor(Date.now()/1000)),reason:'Investigate tenant sign-in counts',scope,seconds:900};const results=await Promise.all(peers.map(peer=>privilegedAccess(peer,env,root.session,body,'elevate')));assert.deepEqual(results.map(r=>r.status).sort(),[200,401]);assert.equal(await count('auth_privilege_elevations'),1);}finally{await Promise.all(peers.map(peer=>peer.end()));}
});
test('approval audit failure preserves pending request and missing MFA key cannot create elevation',async()=>{
 await reset();const e=await elevate(),r=await request(e);
 await multi("CREATE FUNCTION fail_approval() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic approval audit fault'; END $$;CREATE TRIGGER fail_approval BEFORE INSERT ON auth_privileged_access_audit FOR EACH ROW EXECUTE FUNCTION fail_approval();");
 await assert.rejects(call(admin,{requestId:r.requestId,password},'approveSupport'));
 assert.equal((await db.query('SELECT state FROM auth_tenant_support_requests')).rows[0].state,'pending');
 await multi('DROP TRIGGER fail_approval ON auth_privileged_access_audit;DROP FUNCTION fail_approval();');
 assert.equal((await call(root,{requestId:r.requestId},'summary')).status,403);
 await reset();await assert.rejects(privilegedAccess(db,{},root.session,{password,code:await totpAt(seed,Math.floor(Date.now()/1000)),reason:'Investigate tenant sign-in counts',scope,seconds:900},'elevate'));
 assert.equal(await count('auth_privilege_elevations'),0);assert.equal(await count('auth_sessions'),4);
});
