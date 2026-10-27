import {PostgresReceptionCallbackAccessPolicy} from '../cloudflare/workers/src/business-tasks/reception-callback-policy.ts';
import pin from '../tools/governance-production/production-pin.json' with {type:'json'};
import {createHash} from 'node:crypto';
import {VapiVerifiedCallIdentityService,VapiCallTaskIdentityBroker} from '../cloudflare/workers/src/business-tasks/vapi-call-identity.ts';
import assert from 'node:assert/strict';import pg from 'pg';import {readFile} from 'node:fs/promises';
import {createPostgresReceptionCallbackServices,createPostgresVapiCallbackApprovalHttpAdapter,createPostgresNativeVapiCallbackApprovalHost} from '../cloudflare/workers/src/business-tasks/reception-callback.ts';
import {PostgresVoiceTaskRepository} from '../cloudflare/workers/src/business-tasks/voice-tasks.ts';
const u=new URL(process.env.CALLBACK_TEST_DATABASE_URL??'');if(!['localhost','127.0.0.1'].includes(u.hostname)||u.username!=='callback_fixture'||u.pathname!=='/callback_test'||process.env.PRODUCTION_DATABASE_URL)throw Error('Named disposable callback database required');
const pool=new pg.Pool({connectionString:u.href,max:8});const actor={id:'alice',tenantId:'tenant-a'},sid='CA'+'a'.repeat(32);let allowed=true,duringPolicy=async()=>{};
const unused=()=>{throw Error('Unexpected atomic operation');},policy={async assert(a,action,state){if(!allowed||a.id!==actor.id||a.tenantId!==actor.tenantId||state.ownerId!==a.id||state.tenantId!==a.tenantId)throw Error('Denied');await duringPolicy(action);},assignee:unused};
const identity={actor,sessionId:'synthetic-authenticated-session',authentication:'otp',active:true,expiresAt:Date.now()+300000},identities={async current(callSid){return callSid===sid?structuredClone(identity):null;}};
const {callbacks,confirmations,tasks}=createPostgresReceptionCallbackServices({pool,policy,identities});const intents=new PostgresVoiceTaskRepository(pool);
const input=()=>({reason:'general',windowStartsAt:new Date(Date.now()+3600000).toISOString(),windowEndsAt:new Date(Date.now()+7200000).toISOString()});
const count=async id=>(await pool.query('SELECT count(*)::int AS n FROM communication_callback_requests WHERE intent_id=$1',[id])).rows[0].n;
async function prepare(){const args=input(),p=await tasks.propose(sid,'reception.callback.request',args);return {args,p};}
async function approve(p){const preview=await confirmations.preview(actor,p.intentId);await confirmations.approve(actor,p.intentId,preview.digest);}
let groups=0;
try{
 for(const file of ['20261023_communication_voice_tasks.sql','20261023_communication_voice_confirmations.sql','20261027_communication_callback_requests.sql'])await pool.query(await readFile('packages/database/migrations/'+file,'utf8'));
 await pool.query("CREATE TABLE tenants(id text PRIMARY KEY,status text NOT NULL);CREATE TABLE users(id text PRIMARY KEY,tenant_id text NOT NULL,status text NOT NULL);INSERT INTO tenants VALUES('tenant-a','active'),('tenant-b','active');INSERT INTO users VALUES('alice','tenant-a','active'),('bob','tenant-b','active'),('charlie','tenant-a','active')");
 await pool.query((await readFile('packages/database/migrations/20261023_communication_voice_otp.sql','utf8')).split('CREATE TABLE communication_voice_otp')[0]);await pool.query("INSERT INTO communication_voice_verified_contacts VALUES('tenant-a','alice','+14165550101',1,now(),NULL)");
 const a=await prepare();await assert.rejects(()=>tasks.execute(sid,a.p.intentId),e=>e.code==='VOICE_TASK_CONFIRMATION_REQUIRED');assert.equal(await count(a.p.intentId),0);await approve(a.p);await tasks.execute(sid,a.p.intentId);
 assert.deepEqual(await callbacks.read(actor,a.p.intentId),{intentId:a.p.intentId,status:'requested',...a.args});const saved=(await pool.query('SELECT user_id,tenant_id,contact_version::int AS version,status FROM communication_callback_requests WHERE intent_id=$1',[a.p.intentId])).rows[0];assert.deepEqual(saved,{user_id:'alice',tenant_id:'tenant-a',version:1,status:'requested'});await assert.rejects(()=>tasks.execute(sid,a.p.intentId));assert.equal(await count(a.p.intentId),1);await pool.query("UPDATE communication_voice_verified_contacts SET version=2 WHERE user_id='alice'");await assert.rejects(()=>callbacks.read(actor,a.p.intentId));await pool.query("UPDATE communication_voice_verified_contacts SET version=1 WHERE user_id='alice'");groups++;
 for(const other of [{id:'bob',tenantId:'tenant-b'},{id:'charlie',tenantId:'tenant-a'}])await assert.rejects(()=>callbacks.read(other,a.p.intentId));groups++;
 const b=await prepare();await approve(b.p);allowed=false;await assert.rejects(()=>tasks.execute(sid,b.p.intentId));assert.equal(await count(b.p.intentId),0);allowed=true;groups++;
 const c=await prepare();await approve(c.p);await pool.query("UPDATE communication_voice_verified_contacts SET revoked_at=now() WHERE user_id='alice'");await assert.rejects(()=>tasks.execute(sid,c.p.intentId),/outcome unknown/);assert.equal(await count(c.p.intentId),0);await pool.query("UPDATE communication_voice_verified_contacts SET revoked_at=NULL WHERE user_id='alice'");groups++;
 const d=await prepare();await approve(d.p);const outcomes=await Promise.allSettled([tasks.execute(sid,d.p.intentId),tasks.execute(sid,d.p.intentId)]);assert.equal(outcomes.filter(x=>x.status==='fulfilled').length,1);assert.equal(await count(d.p.intentId),1);groups++;
 const e=await prepare();await intents.claim(e.p.intentId,e.p.digest);await assert.rejects(()=>callbacks.requestCallback(actor,e.args,'voice-task:'+e.p.intentId));assert.equal(await count(e.p.intentId),0);groups++;
 const f=await prepare();await approve(f.p);const intent=await intents.read(f.p.intentId);assert.ok(await confirmations.consumeConfirmation({callSid:sid,intentId:f.p.intentId,digest:intent.digest,actor,sessionId:identity.sessionId}));await intents.claim(f.p.intentId,intent.digest);await Promise.all([callbacks.requestCallback(actor,f.args,'voice-task:'+f.p.intentId),callbacks.requestCallback(actor,f.args,'voice-task:'+f.p.intentId)]);assert.equal(await count(f.p.intentId),1);await assert.rejects(()=>callbacks.requestCallback(actor,{...f.args,reason:'appointment_help'},'voice-task:'+f.p.intentId));groups++;
 const stale=await prepare();await approve(stale.p);await pool.query('UPDATE communication_voice_confirmations SET approved_at=$2,expires_at=$3 WHERE intent_id=$1',[stale.p.intentId,Date.now()-120000,Date.now()-60000]);await assert.rejects(()=>tasks.execute(sid,stale.p.intentId),e=>e.code==='VOICE_TASK_CONFIRMATION_REQUIRED');assert.equal(await count(stale.p.intentId),0);groups++;
 const tampered=await prepare();await approve(tampered.p);const original=await intents.read(tampered.p.intentId);await confirmations.consumeConfirmation({callSid:sid,intentId:original.id,digest:original.digest,actor,sessionId:identity.sessionId});await intents.claim(original.id,original.digest);await pool.query("UPDATE communication_voice_tasks SET intent=jsonb_set(intent,'{args,reason}','\"appointment_help\"') WHERE id=$1",[original.id]);await assert.rejects(()=>callbacks.requestCallback(actor,{...tampered.args,reason:'appointment_help'},'voice-task:'+original.id));assert.equal(await count(original.id),0);groups++;
 const expiring=await prepare();await approve(expiring.p);const deadline=Date.now()+5000;await pool.query('UPDATE communication_voice_confirmations SET approved_at=$2,expires_at=$3 WHERE intent_id=$1',[expiring.p.intentId,deadline-60000,deadline]);let checks=0;duringPolicy=async action=>{if(action==='voice.task.execute'&&++checks===3)await new Promise(resolve=>setTimeout(resolve,Math.max(0,deadline-Date.now()+100)));};await assert.rejects(()=>tasks.execute(sid,expiring.p.intentId),/outcome unknown/);duringPolicy=async()=>{};assert.equal(await count(expiring.p.intentId),0);groups++;
 // Native app HTTP approval of a Vapi proof-bound intent, backed by actual
 // disposable PostgreSQL. Provider/proof/native session ports are test fixtures;
 // no production role, login, call or SMS is represented by this acceptance.
 const vapiCallId='11111111-1111-4111-8111-111111111111',proofId='22222222-2222-4222-8222-222222222222';
 let proofActive=true,nativeActor=actor,nativeAllowed=true;
 const proof={id:proofId,verifiedAt:Date.now()-1000,expiresAt:Date.now()+100000};
 const callIdentity=new VapiVerifiedCallIdentityService({run:unused,read:unused,inbox:unused},policy,{
  async current(id){
   if(id!==vapiCallId)return null;
   const r=(await pool.query("SELECT c.phone,c.version::int AS version FROM communication_voice_verified_contacts c JOIN users u ON u.id=c.user_id AND u.tenant_id=c.tenant_id JOIN tenants t ON t.id=c.tenant_id WHERE c.user_id=$1 AND c.tenant_id=$2 AND c.revoked_at IS NULL AND u.status='active' AND t.status='active'",[actor.id,actor.tenantId])).rows;
   return r.length===1?{actor,callId:id,callSid:sid,phone:r[0].phone,version:r[0].version}:null;
  },
  async proof(candidate){return proofActive&&candidate.phone==='+14165550101'&&candidate.version===1?{...proof}:null;}
 });
 const vapiServices=createPostgresReceptionCallbackServices({pool,policy,identities:new VapiCallTaskIdentityBroker(callIdentity,vapiCallId)});
 const app=createPostgresVapiCallbackApprovalHttpAdapter({pool,policy,identities:callIdentity,native:{origin:'https://app.example.invalid',maxRequestBytes:2048,
  async authenticate(){return {actor:nativeActor,sessionHash:'a'.repeat(64),expiresAt:Date.now()+60000};},
  async authorize(session,key){if(!nativeAllowed||!['task.preview','task.approve'].includes(key))throw new (await import('../packages/shared/src/communications/voice-native-http.mjs')).NativeVoiceHttpError(403);}
 }});
 const http=(key,body,authenticated=true)=>app.respond(new Request('https://app.example.invalid/v1/voice/tasks/'+key,{method:'POST',headers:{'content-type':'application/json',...(authenticated?{authorization:'Bearer native-fixture'}:{})},body:JSON.stringify(body)}));
 const approvals=async id=>(await pool.query('SELECT count(*)::int AS n FROM communication_voice_confirmations WHERE intent_id=$1',[id])).rows[0].n;
 const v=await vapiServices.tasks.propose(sid,'reception.callback.request',input());
 await assert.rejects(()=>vapiServices.tasks.execute(sid,v.intentId),e=>e.code==='VOICE_TASK_CONFIRMATION_REQUIRED');
 const display=await http('preview',{intentId:v.intentId});assert.equal(display.status,200);const shown=await display.json();assert.equal(shown.digest,v.digest);assert.equal(await approvals(v.intentId),0);
 assert.equal((await http('approve',{intentId:v.intentId,digest:shown.digest},false)).status,401);
 nativeActor={id:'charlie',tenantId:'tenant-a'};assert.equal((await http('preview',{intentId:v.intentId})).status,503);nativeActor=actor;
 assert.equal((await http('approve',{intentId:v.intentId,digest:'f'.repeat(64)})).status,503);assert.equal(await approvals(v.intentId),0);
 assert.equal((await http('approve',{intentId:v.intentId,digest:shown.digest})).status,200);assert.equal(await approvals(v.intentId),1);
 await vapiServices.tasks.execute(sid,v.intentId);assert.equal(await count(v.intentId),1);assert.equal((await callbacks.read(actor,v.intentId)).status,'requested');await assert.rejects(()=>vapiServices.tasks.execute(sid,v.intentId));assert.equal(await count(v.intentId),1);groups++;
 const revoked=await vapiServices.tasks.propose(sid,'reception.callback.request',input());assert.equal((await http('preview',{intentId:revoked.intentId})).status,200);proofActive=false;assert.equal((await http('approve',{intentId:revoked.intentId,digest:revoked.digest})).status,503);assert.equal(await approvals(revoked.intentId),0);proofActive=true;groups++;
 const denied=await vapiServices.tasks.propose(sid,'reception.callback.request',input());nativeAllowed=false;assert.equal((await http('approve',{intentId:denied.intentId,digest:denied.digest})).status,403);assert.equal(await approvals(denied.intentId),0);nativeAllowed=true;groups++;
 const changed=await vapiServices.tasks.propose(sid,'reception.callback.request',input());await pool.query("UPDATE communication_voice_tasks SET intent=jsonb_set(intent,'{summary}','\"changed\"') WHERE id=$1",[changed.intentId]);assert.equal((await http('preview',{intentId:changed.intentId})).status,503);assert.equal(await approvals(changed.intentId),0);groups++;
 // The concrete host and task policy now use real fixture auth_sessions and
 // registered API/screen metadata, rather than synthetic session/grant ports.
 if(!/^[a-z0-9_]+$/.test(pin.schema))throw Error('Invalid fixture authority');
 await pool.query(`CREATE SCHEMA "${pin.schema}";
 CREATE TABLE "${pin.schema}".govt_source_manifest(manifest_sha256 text);
 CREATE TABLE "${pin.schema}".govt_roles(id bigint,role_code text,active bigint);
 CREATE TABLE "${pin.schema}".govt_api_permissions(id bigint,role_id bigint,api_id bigint,permission_key text,can_access bigint);
 CREATE TABLE "${pin.schema}".govt_api_endpoints(id bigint,http_method text,route_path text,service_name text,auth_required bigint,permission_key text,endpoint_code text);
 CREATE TABLE "${pin.schema}".govt_screen_api_links(screen_id bigint,api_id bigint);
 CREATE TABLE "${pin.schema}".govt_screens(id bigint,active bigint);
 CREATE TABLE "${pin.schema}".govt_role_screen_permissions(role_id bigint,screen_id bigint,can_view bigint);
 ALTER TABLE users ADD COLUMN roles text NOT NULL DEFAULT 'patient';
 CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id text,created_at timestamptz,expires_at timestamptz);
 INSERT INTO "${pin.schema}".govt_roles VALUES(1,'patient',1);
 INSERT INTO "${pin.schema}".govt_api_permissions VALUES(1,1,101,'role_screen_permissions',1),(2,1,102,'role_screen_permissions',1);
 INSERT INTO "${pin.schema}".govt_api_endpoints VALUES(101,'POST','/v1/voice/tasks/preview','governance',1,'role_screen_permissions','TWILIO_TASK_PREVIEW'),(102,'POST','/v1/voice/tasks/approve','governance',1,'role_screen_permissions','TWILIO_TASK_APPROVE');
 INSERT INTO "${pin.schema}".govt_screen_api_links VALUES(331,101),(331,102);
 INSERT INTO "${pin.schema}".govt_screens VALUES(331,1);
 INSERT INTO "${pin.schema}".govt_role_screen_permissions VALUES(1,331,1)`);
 await pool.query(`INSERT INTO "${pin.schema}".govt_source_manifest VALUES($1)`,[pin.manifestSha256]);
 const nativeToken='n'.repeat(43),nativeHash=createHash('sha256').update(nativeToken).digest('hex');
 await pool.query("INSERT INTO auth_sessions VALUES($1,'alice',now(),now()+INTERVAL '5 minutes')",[nativeHash]);
 const realPolicy=new PostgresReceptionCallbackAccessPolicy(pool),realTasks=createPostgresReceptionCallbackServices({pool,policy:realPolicy,identities:new VapiCallTaskIdentityBroker(callIdentity,vapiCallId)});
 const realApp=createPostgresNativeVapiCallbackApprovalHost({pool,identities:callIdentity,origin:'https://app.example.invalid',maxRequestBytes:2048});
 const nativeHttp=(key,body,headers={})=>realApp.respond(new Request('https://app.example.invalid/v1/voice/tasks/'+key,{method:'POST',headers:{'content-type':'application/json',authorization:'Bearer '+nativeToken,...headers},body:JSON.stringify(body)}));
 const native=await realTasks.tasks.propose(sid,'reception.callback.request',input());
 assert.equal((await nativeHttp('preview',{intentId:native.intentId},{authorization:'Bearer nonexistent-session'})).status,401);
 assert.equal((await nativeHttp('preview',{intentId:native.intentId},{'x-tenant-id':'tenant-b'})).status,403);
 assert.equal((await nativeHttp('preview',{intentId:native.intentId})).status,200);assert.equal(await approvals(native.intentId),0);
 await pool.query(`UPDATE "${pin.schema}".govt_api_permissions SET can_access=0 WHERE api_id=102`);
 assert.equal((await nativeHttp('approve',{intentId:native.intentId,digest:native.digest})).status,403);assert.equal(await approvals(native.intentId),0);await assert.rejects(()=>realTasks.tasks.execute(sid,native.intentId));
 await pool.query(`UPDATE "${pin.schema}".govt_api_permissions SET can_access=1 WHERE api_id=102`);
 assert.equal((await nativeHttp('approve',{intentId:native.intentId,digest:native.digest})).status,200);await realTasks.tasks.execute(sid,native.intentId);assert.equal(await count(native.intentId),1);groups++;
 const loggedOut=await realTasks.tasks.propose(sid,'reception.callback.request',input());assert.equal((await nativeHttp('preview',{intentId:loggedOut.intentId})).status,200);await pool.query('DELETE FROM auth_sessions WHERE token_hash=$1',[nativeHash]);assert.equal((await nativeHttp('approve',{intentId:loggedOut.intentId,digest:loggedOut.digest})).status,401);assert.equal(await approvals(loggedOut.intentId),0);groups++;
 await pool.query(`UPDATE "${pin.schema}".govt_role_screen_permissions SET can_view=0`);await assert.rejects(()=>realTasks.tasks.propose(sid,'reception.callback.request',input()));groups++;
 await pool.query("CREATE FUNCTION reject_callback() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'fixture persistence failure'; END $$;CREATE TRIGGER fail_callback BEFORE INSERT ON communication_callback_requests FOR EACH ROW EXECUTE FUNCTION reject_callback()");const g=await prepare();await approve(g.p);await assert.rejects(()=>tasks.execute(sid,g.p.intentId),/outcome unknown/);assert.equal(await count(g.p.intentId),0);assert.equal((await intents.read(g.p.intentId)).status,'unknown');groups++;
 console.log('CALLBACK_POSTGRES_PASS '+JSON.stringify({groups,providerTraffic:false,productionWrites:false,claims:'native save/readback, Vapi stored-proof-to-app HTTP approval and execution, scoped read, revocation, duplicate execution, replay and rollback'}));
}finally{await pool.end();}
