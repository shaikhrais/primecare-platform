import {test} from 'node:test';import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {build} from 'esbuild';
import {createRequire} from 'node:module';
import {mkdtemp,writeFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
const bundle=await build({entryPoints:['cloudflare/workers/src/business-tasks/voice-contact-worker.ts'],bundle:true,write:false,platform:'node',format:'cjs'});
const dir=await mkdtemp(join(tmpdir(),'primecare-contact-')),file=join(dir,'host.cjs');await writeFile(file,bundle.outputFiles[0].text);const {VoiceContactEnrollmentWorker,nativeContactPostgresOptions,nativeContactFailureCategory}=createRequire(import.meta.url)(file);await rm(dir,{recursive:true,force:true});
import {isPlatformOwnContactEndpoint} from '../cloudflare/workers/src/business-tasks/endpoint-policy.ts';
import {PostgresVoiceContactAccessPolicy} from '../cloudflare/workers/src/business-tasks/voice-contact-native-policy.ts';
import {NativeVoiceContactHttpAdapter,NativeVoiceHttpAdapter} from '../packages/shared/src/communications/voice-native-http.mjs';
import {TwilioVerifyFetchClient} from '../packages/shared/src/communications/twilio-verify-fetch.mjs';
import {createTwilioContactEnrollmentClient} from '../packages/shared/src/communications/twilio-verify.mjs';
const origin='https://native.example.invalid',gateway='https://gateway.example.invalid',hash='a'.repeat(64),actor={id:'alice',tenantId:'tenant-a'},source='b'.repeat(40),account='AC'+'a'.repeat(32),key='SK'+'b'.repeat(32),secret='c'.repeat(32),service='VA'+'d'.repeat(32),verification='VE'+'e'.repeat(32);
const env=()=>({DB_URL:'server-only',VOICE_CONTACT_ORIGIN:origin,VOICE_GATEWAY_ORIGIN:gateway,VOICE_CONTACT_SOURCE:source,TWILIO_ACCOUNT_SID:account,TWILIO_API_KEY_SID:key,TWILIO_API_KEY_SECRET:secret,TWILIO_VERIFY_SERVICE_SID:service,VOICE_CONTACT_LIMIT:{async limit(){return {success:true};}}});
const request=(path='/v1/voice/contact/status',body={},headers={})=>new Request(origin+path,{method:'POST',headers:{authorization:'Bearer '+'n'.repeat(43),'content-type':'application/json','cf-connecting-ip':'192.0.2.1',...headers},body:JSON.stringify(body)});
function native(){let opened=0,closed=0,provider=0;const worker=new VoiceContactEnrollmentWorker({openPool(){opened++;return {async query(){return {rows:[]};},async connect(){throw Error('No grants expected');},async end(){closed++;}};},async providerFetch(){provider++;throw Error('No provider work');}});return {worker,get opened(){return opened;},get closed(){return closed;},get provider(){return provider;}};}
test('contact-only boundary inherits native transport and exposes no legacy call or AI services',async()=>{
 const session={actor,sessionHash:hash,expiresAt:Date.now()+60000},seen=[];
 const adapter=new NativeVoiceContactHttpAdapter({origin,maxRequestBytes:2048,authenticate:async()=>session,authorize:async(_,key)=>seen.push(key),service:{async status(h){assert.equal(h,hash);return {verified:false,enrollmentAllowed:true};},async start(){throw Error('unused');},async check(){throw Error('unused');}}});
 assert.ok(adapter instanceof NativeVoiceHttpAdapter);assert.equal((await adapter.respond(request())).status,200);assert.deepEqual(seen,['contact.status','contact.status','contact.status']);
 for(const path of ['/v1/voice/token','/v1/voice/otp/start','/v1/voice/tasks/approve','/v1/vapi/voice/tasks'])assert.equal((await adapter.respond(request(path))).status,404);
});
test('native host cancels rejected bodies before opening database or provider connections',async()=>{
 for(const [mode,status] of [['cookie',401],['origin',403],['query',400],['method',405],['path',404]]){
  const f=native();let canceled=0;const h={'content-type':'application/json','cf-connecting-ip':'192.0.2.1',...(mode==='cookie'?{cookie:'session_token='+'n'.repeat(43)}:{authorization:'Bearer '+'n'.repeat(43)}),...(mode==='origin'?{origin:'https://foreign.invalid'}:{})};
  const body=new ReadableStream({pull(){assert.fail('Rejected body read');},cancel(){canceled++;}},{highWaterMark:0});const r=await f.worker.fetch(new Request(origin+(mode==='path'?'/v1/voice/token':'/v1/voice/contact/status')+(mode==='query'?'?actor=forged':''),{method:mode==='method'?'PUT':'POST',headers:h,body,duplex:'half'}),env());
  assert.equal(r.status,status,mode);assert.equal(canceled,1);assert.equal(f.opened,0);assert.equal(f.provider,0);
 }
});
test('native host checks both rate scopes, closes per-request pool and rejects an absent real session',async()=>{
 const f=native(),e=env(),keys=[];e.VOICE_CONTACT_LIMIT.limit=async({key})=>{keys.push(key);return {success:true};};const r=await f.worker.fetch(request(),e);assert.equal(r.status,401);assert.equal(r.headers.get('x-primecare-voice-contact-source'),source);assert.match(r.headers.get('cache-control'),/no-store/);assert.equal(f.opened,1);assert.equal(f.closed,1);assert.equal(f.provider,0);assert.equal(keys.length,2);assert.ok(keys.some(k=>k.startsWith('source:'))&&keys.some(k=>k.startsWith('session:')));
});
test('missing or exhausted native rate binding fails closed before database and provider work',async()=>{
 for(const mode of ['missing','denied']){const f=native(),e=env();if(mode==='missing')e.VOICE_CONTACT_LIMIT=undefined;else e.VOICE_CONTACT_LIMIT.limit=async()=>({success:false});assert.equal((await f.worker.fetch(request(),e)).status,mode==='missing'?503:429);assert.equal(f.opened,0);assert.equal(f.provider,0);}
});
test('database errors stay generic and still release the request pool',async()=>{
 let closed=0;const f=new VoiceContactEnrollmentWorker({openPool(){return {async query(){throw Error('PRIVATE DATABASE URL');},async connect(){throw Error('unused');},async end(){closed++;}};}});const r=await f.fetch(request(),env());assert.equal(r.status,503);assert.doesNotMatch(await r.text(),/PRIVATE|DATABASE|URL/);assert.equal(closed,1);
});
test('service policy enforces exact own-contact actions plus registered API/screen rights',async()=>{
 const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));const queries=[];let denied=false;
 const policy=new PostgresVoiceContactAccessPolicy({async connect(){return {async query(sql,args){queries.push({sql,args});return {rows:sql.startsWith('SELECT manifest')?[{manifest_sha256:pin.manifestSha256}]:sql.startsWith('SELECT DISTINCT')&&!denied?[{role_id:'1',screen_id:'234',api_id:'16535'}]:[]};},release(){}};}});
 const state={id:'voice-contact:alice',tenantId:actor.tenantId,ownerId:'alice',kind:'voice_contact',version:1};
 for(const key of ['status','start','check'])await policy.assert(actor,'voice.contact.'+key,state);
 assert.deepEqual(queries.filter(q=>q.sql.startsWith('SELECT DISTINCT')).map(q=>q.args[2]),['16535','16536','16537']);
 for(const [action,s] of [['voice.contact.start',{...state,ownerId:'other'}],['voice.task.execute',state]])await assert.rejects(policy.assert(actor,action,s));
 denied=true;await assert.rejects(policy.assert(actor,'voice.contact.start',state));await assert.rejects(policy.assignee());
});
function provider(transport){return createTwilioContactEnrollmentClient({accountSid:account,apiKeySid:key,apiKeySecret:secret,serviceSid:service,phone:'+14165550101',purpose:'first-time-contact-enrollment',httpClient:new TwilioVerifyFetchClient({serviceSid:service,apiKeySid:key,apiKeySecret:secret,fetch:transport})});}
test('official SDK works through bounded fixed-service fetch for exact SMS and code forms',async()=>{
 const calls=[];const port=provider(async(url,options)=>{calls.push({url,options});const checking=url.endsWith('/VerificationCheck');assert.equal(options.method,'POST');assert.equal(options.redirect,'manual');assert.equal(options.headers.authorization,'Basic '+btoa(key+':'+secret));assert.deepEqual(Object.fromEntries(new URLSearchParams(options.body)),checking?{Code:'123456',VerificationSid:verification}:{To:'+14165550101',Channel:'sms'});return Response.json({sid:verification,account_sid:account,service_sid:service,to:'+14165550101',channel:'sms',status:checking?'approved':'pending'},{status:checking?200:201});});
 assert.deepEqual(await port.start(),{verificationSid:verification,status:'pending'});assert.deepEqual(await port.check(verification,'123456'),{approved:true});assert.equal(calls.length,2);
});
test('Verify fetch rejects arbitrary destinations, form fields, redirects, oversized and private error responses without retry',async()=>{
 let count=0;const client=new TwilioVerifyFetchClient({serviceSid:service,apiKeySid:key,apiKeySecret:secret,async fetch(){count++;return Response.json({});}});
 const options={method:'post',username:key,password:secret,uri:'https://verify.twilio.com/v2/Services/'+service+'/Verifications',data:{To:'+14165550101',Channel:'sms'}};
 for(const altered of [{...options,uri:'https://foreign.invalid'},{...options,data:{...options.data,CustomCode:'123456'}},{...options,password:'wrong'},{...options,method:'get'}])await assert.rejects(client.request(altered));assert.equal(count,0);
 for(const response of [()=>new Response('PRIVATE PROVIDER',{status:500}),()=>new Response(null,{status:302}),()=>Response.json({large:'x'.repeat(17000)}),()=>new Response('{}',{headers:{'content-type':'text/plain'}})]){let attempts=0;const port=provider(async()=>{attempts++;return response();});await assert.rejects(port.start(),/outcome unknown/);assert.equal(attempts,1);}
});
test('native host uses real PostgreSQL session and current grants through SDK fetch, then saves and independently rereads the exact own phone',{skip:!process.env.WORKFLOW_TEST_DATABASE_URL},async()=>{
 const dbUrl=new URL(process.env.WORKFLOW_TEST_DATABASE_URL);if(!['localhost','127.0.0.1'].includes(dbUrl.hostname)||dbUrl.pathname!=='/voice_identity_schema_test'||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Disposable native database required');
 const {default:pg}=await import('pg'),{createHash}=await import('node:crypto');const db=new pg.Pool({connectionString:dbUrl.href,max:4});
 try{
  const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json')),schema='"'+pin.schema+'"';
  await db.query('ALTER TABLE public.users ADD COLUMN roles text');await db.query('CREATE SCHEMA '+schema);
  for(const [table,columns] of Object.entries({[pin.manifestTable]:'manifest_sha256 text',govt_roles:'id bigint,role_code text,active bigint',govt_api_permissions:'id bigint,api_id bigint,role_id bigint,can_access bigint,permission_key text',govt_api_endpoints:'id bigint,http_method text,route_path text,service_name text,auth_required bigint,permission_key text,endpoint_code text',govt_screen_api_links:'screen_id bigint,api_id bigint',govt_screens:'id bigint,active bigint',govt_role_screen_permissions:'role_id bigint,screen_id bigint,can_view bigint'}))await db.query('CREATE TABLE '+schema+'."'+table+'"('+columns+')');
  await db.query('INSERT INTO '+schema+'."'+pin.manifestTable+'" VALUES($1)',[pin.manifestSha256]);
  await db.query(`INSERT INTO ${schema}.govt_roles VALUES(9001,'host_role',1);INSERT INTO ${schema}.govt_screens VALUES(234,1);INSERT INTO ${schema}.govt_role_screen_permissions VALUES(9001,234,1)`);
  for(const [i,action] of ['status','start','check'].entries()){const id=16535+i;await db.query(`INSERT INTO ${schema}.govt_api_endpoints VALUES($1,'POST',$2,'governance',1,'role_screen_permissions',$3)`,[id,'/v1/voice/contact/'+action,'VOICE_CONTACT_'+action.toUpperCase()]);await db.query(`INSERT INTO ${schema}.govt_api_permissions VALUES($1,$1,9001,1,'role_screen_permissions')`,[id]);await db.query(`INSERT INTO ${schema}.govt_screen_api_links VALUES(234,$1)`,[id]);}
  const token='h'.repeat(43),sessionHash=createHash('sha256').update(token).digest('hex');await db.query("INSERT INTO public.tenants VALUES('host-tenant','active');INSERT INTO public.users(id,tenant_id,status,roles) VALUES('host-user','host-tenant','active','host_role')");await db.query("INSERT INTO public.auth_sessions(token_hash,user_id,expires_at) VALUES($1,'host-user',now()+INTERVAL '1 hour')",[sessionHash]);
  let closed=0,sends=0,checks=0,requests=0;const host=new VoiceContactEnrollmentWorker({openPool:()=>({query:db.query.bind(db),connect:db.connect.bind(db),async end(){closed++;}}),async providerFetch(url,options){assert.equal(options.headers.authorization,'Basic '+btoa(key+':'+secret));const checking=url.endsWith('/VerificationCheck');if(checking)checks++;else sends++;return Response.json({sid:verification,account_sid:account,service_sid:service,to:'+14165550101',channel:'sms',status:checking?'approved':'pending'},{status:checking?200:201});}});
  const post=(action,input={})=>{requests++;return host.fetch(request('/v1/voice/contact/'+action,input,{authorization:'Bearer '+token}),env());};
  // A Code Administrator receives no implicit clinical screen access. Only
  // explicit platform view + exact contact links + three API grants may work.
  await db.query(`INSERT INTO ${schema}.govt_roles VALUES(9002,'code_admin',1);INSERT INTO ${schema}.govt_screens VALUES(1269,1);INSERT INTO ${schema}.govt_role_screen_permissions VALUES(9002,1269,1)`);
  for(const id of [16535,16536,16537]){
   await db.query(`INSERT INTO ${schema}.govt_screen_api_links VALUES(1269,$1)`,[id]);
   await db.query(`INSERT INTO ${schema}.govt_api_permissions VALUES($1,$2,9002,1,'role_screen_permissions')`,[id+100,id]);
  }
  await db.query("UPDATE public.users SET roles='code_admin' WHERE id='host-user'");
  assert.deepEqual(await (await post('status')).json(),{verified:false,enrollmentAllowed:true});
  await db.query(`UPDATE ${schema}.govt_api_permissions SET can_access=0 WHERE role_id=9002 AND api_id=16536`);
  assert.equal((await post('start',{phone:'+14165550101',requestId:crypto.randomUUID()})).status,403);assert.equal(sends,0);
  await db.query(`UPDATE ${schema}.govt_api_permissions SET can_access=1 WHERE role_id=9002 AND api_id=16536`);
  await db.query(`UPDATE ${schema}.govt_role_screen_permissions SET can_view=0 WHERE role_id=9002`);
  assert.equal((await post('status')).status,403);
  await db.query(`UPDATE ${schema}.govt_role_screen_permissions SET can_view=1 WHERE role_id=9002`);
  await db.query("UPDATE public.users SET roles='host_role' WHERE id='host-user'");
  assert.deepEqual(await (await post('status')).json(),{verified:false,enrollmentAllowed:true});const requestId=crypto.randomUUID(),sent=await post('start',{phone:'+14165550101',requestId});assert.equal(sent.status,200);const challenge=await sent.json();assert.equal(sends,1);
  assert.deepEqual(await (await post('start',{phone:'+14165550101',requestId})).json(),challenge);assert.equal(sends,1);
  await db.query(`UPDATE ${schema}.govt_api_permissions SET can_access=0 WHERE api_id=16537`);assert.equal((await post('check',{challengeId:challenge.challengeId,code:'123456'})).status,403);assert.equal(checks,0);await db.query(`UPDATE ${schema}.govt_api_permissions SET can_access=1 WHERE api_id=16537`);
  assert.deepEqual(await (await post('check',{challengeId:challenge.challengeId,code:'123456'})).json(),{verified:true});assert.equal(checks,1);
  assert.deepEqual((await db.query("SELECT tenant_id,user_id,phone,version::int AS version FROM public.communication_voice_verified_contacts WHERE user_id='host-user'")).rows,[{tenant_id:'host-tenant',user_id:'host-user',phone:'+14165550101',version:1}]);
  await db.query(`UPDATE ${schema}.govt_role_screen_permissions SET can_view=0`);assert.equal((await post('status')).status,403);await db.query(`UPDATE ${schema}.govt_role_screen_permissions SET can_view=1`);assert.deepEqual(await (await post('status')).json(),{verified:true,enrollmentAllowed:false});
  await db.query('DELETE FROM public.auth_sessions WHERE token_hash=$1',[sessionHash]);assert.equal((await post('status')).status,401);assert.equal(sends,1);assert.equal(checks,1);assert.equal(closed,requests);
 }finally{await db.end();}
});

test('native PostgreSQL URL cannot redirect the database or weaken certificate verification',()=>{
 const options=nativeContactPostgresOptions('postgres://fixture:private@pooled.db.prisma.io/postgres?ssl=false&sslmode=no-verify');assert.equal(options.host,'pooled.db.prisma.io');assert.equal(options.database,'postgres');assert.deepEqual(options.ssl,{rejectUnauthorized:true});assert.equal('connectionString' in options,false);assert.equal('statement_timeout' in options,false);assert.equal(options.query_timeout,10000);
 for(const url of ['postgres://fixture:private@foreign.invalid/postgres','postgres://fixture:private@db.prisma.io/postgres','postgres://fixture:private@pooled.db.prisma.io/other'])assert.throws(()=>nativeContactPostgresOptions(url),/Pinned/);
});

test('operational failure categories never expose private exception text or connection details',()=>{
 assert.equal(nativeContactFailureCategory({code:'42703',message:'PRIVATE COLUMN'}),'postgres_42703');assert.equal(nativeContactFailureCategory(new Error('Dynamic require of node:tls')),'runtime_module');assert.equal(nativeContactFailureCategory(new Error('PRIVATE PASSWORD AND DATABASE URL')),'host_unavailable');
});

test('platform administration is an eligible host only for exact own-contact contracts, never messaging, OTP or AI tasks',()=>{
 for(const [i,action] of ['status','start','check'].entries()){
  const path='/v1/voice/contact/'+action,code='VOICE_CONTACT_'+action.toUpperCase();
  for(const id of [null,16535+i])assert.equal(isPlatformOwnContactEndpoint(id,'POST',path,code),true);
  for(const args of [[710,'POST',path,code],[null,'GET',path,code],[null,'POST',path,null],[null,'POST',path,code+'X'],[null,'POST',path+'/',code]])assert.equal(isPlatformOwnContactEndpoint(...args),false);
 }
 for(const path of ['/v1/messages','/v1/voice/otp/start','/v1/vapi/voice/tasks'])assert.equal(isPlatformOwnContactEndpoint(null,'POST',path,'VOICE_CONTACT_START'),false);
});
