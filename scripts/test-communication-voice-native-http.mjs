import {test} from 'node:test';
import assert from 'node:assert/strict';
import {NativeVoiceHttpAdapter,NativeVoiceHttpError} from '../packages/shared/src/communications/voice-native-http.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
import {createPostgresNativeVoiceHttpAdapter} from '../cloudflare/workers/src/business-tasks/twilio-integration.ts';
import {createHash} from 'node:crypto';
const origin='https://app.example.invalid',hash='a'.repeat(64),actor={id:'alice',tenantId:'tenant-a'};
const nativeToken='f'.repeat(43);
const callSid='CA'+'b'.repeat(32),recordingSid='RE'+'c'.repeat(32),intentId='12345678-1234-4234-8234-123456789abc',digest='d'.repeat(64);
const extension={extension:'1002',tenantId:'tenant-a',userId:'bob',published:false,active:true,tenantActive:true,userActive:true,version:1};
const wav=new Uint8Array(16);wav.set(new TextEncoder().encode('RIFF'));wav.set(new TextEncoder().encode('WAVE'),8);
const commands=[['token','/v1/voice/token',{}],['extension.assign','/v1/voice/extensions/assign',{userId:'bob'}],['extension.publish','/v1/voice/extensions/publish',{userId:'bob',version:1,published:true}],['voicemail.read','/v1/voice/voicemail/read',{recordingSid}],['voicemail.audio','/v1/voice/voicemail/audio',{recordingSid}],['otp.start','/v1/voice/otp/start',{callSid,pairingCode:'12345678'}],['otp.check','/v1/voice/otp/check',{callSid,code:'123456'}],['task.preview','/v1/voice/tasks/preview',{intentId}],['task.approve','/v1/voice/tasks/approve',{intentId,digest}]];
function fixture(){
 const calls=[],grants=[];let current={actor:{...actor},sessionHash:hash,expiresAt:Date.now()+60000},denied=false,afterService=()=>{};
 const invoke=(key,result)=>async(...args)=>{calls.push({key,args});afterService();return structuredClone(result);};
 const services={tokens:{issue:invoke('token',{token:'fixture-sdk-token',identity:'fixture-identity',ttlSeconds:60})},extensions:{assign:invoke('extension.assign',extension),publish:invoke('extension.publish',{...extension,published:true,version:2})},voicemail:{read:invoke('voicemail.read',{recordingSid,callSid,extension:'1002'}),audio:invoke('voicemail.audio',{bytes:wav,contentType:'audio/wav'})},audio:{async download(){throw Error('Service owns download');}},otp:{start:invoke('otp.start',{verificationRequested:true}),check:invoke('otp.check',{verified:true})},confirmations:{preview:invoke('task.preview',{intentId,summary:'Exact request',digest,expiresAt:Date.now()+60000}),approve:invoke('task.approve',{approved:true,expiresAt:Date.now()+60000})}};
 const options={origin,maxRequestBytes:2048,maxAudioBytes:1024,async authenticate(){if(!current)throw new NativeVoiceHttpError(401);return current;},async authorize(session,key){grants.push(key);if(denied)throw new NativeVoiceHttpError(403);},services};
 return {options,services,calls,grants,adapter:new NativeVoiceHttpAdapter(options),logout(){current=null;},change(){current.actor.id='mallory';},deny(){denied=true;},after(fn){afterService=fn;}};
}
function request(path='/v1/voice/token',input={},options={}){return new Request(origin+path,{method:'POST',headers:{authorization:'Bearer '+nativeToken,'content-type':'application/json',...options.headers},body:JSON.stringify(input),...options});}
test('shared inherited native adapter dispatches all nine exact contracts with server identity',async()=>{
 for(const [key,path,body] of commands){const f=fixture();assert.ok(f.adapter instanceof BoundedBinaryAdapterBase);const r=await f.adapter.respond(request(path,body));assert.equal(r.status,200,key);assert.match(r.headers.get('cache-control'),/no-store/);assert.equal(f.calls.length,1);assert.equal(f.calls[0].key,key);assert.deepEqual(f.grants,[key,key,key]);
  const args=f.calls[0].args;if(['token','otp.start','otp.check'].includes(key))assert.equal(args[0],hash);else assert.deepEqual(args[0],actor);
  const tail={token:[],'extension.assign':['bob'],'extension.publish':['bob',1,true],'voicemail.read':[recordingSid],'voicemail.audio':[recordingSid],'otp.start':[callSid,'12345678'],'otp.check':[callSid,'123456'],'task.preview':[intentId],'task.approve':[intentId,digest]}[key];
  assert.deepEqual(args.slice(1,key==='voicemail.audio'?2:undefined),tail);
  if(key==='voicemail.audio'){assert.deepEqual(new Uint8Array(await r.arrayBuffer()),wav);assert.equal(r.headers.get('content-type'),'audio/wav');}else assert.equal(typeof await r.json(),'object');
 }
});
test('all native contracts reject actor, tenant, phone and session overrides before service I/O',async()=>{
 for(const [,path,body] of commands)for(const key of ['actor','tenantId','sessionHash','roles','phone','to']){const f=fixture();assert.equal((await f.adapter.respond(request(path,{...body,[key]:'forged'}))).status,400);assert.equal(f.calls.length,0);}
});
test('cookie-only, foreign origin, cross-site and endpoint denial cancel unread request bodies',async()=>{
 for(const mode of ['cookie','origin','site','denied']){let canceled=0;const f=fixture();if(mode==='denied')f.deny();const body=new ReadableStream({pull(){assert.fail('Rejected request was read');},cancel(){canceled++;}},{highWaterMark:0});
  const headers={'content-type':'application/json',authorization:'Bearer fixture',...(mode==='origin'?{origin:'https://other.invalid'}:{}),...(mode==='site'?{'sec-fetch-site':'cross-site'}:{})};if(mode==='cookie'){delete headers.authorization;headers.cookie='session=fixture';}
  const response=await f.adapter.respond(new Request(origin+'/v1/voice/token',{method:'POST',headers,body,duplex:'half'}));assert.equal(response.status,mode==='cookie'?401:403);assert.equal(canceled,1);assert.equal(body.locked,false);assert.equal(f.calls.length,0);
 }
});
test('provider routes, unexpected URL/query, methods and media cannot dispatch native services',async()=>{
 for(const [path,status] of [['/v1/twilio/voice/incoming',404],['/v1/voice/token?tenant=forged',400]]){const f=fixture();assert.equal((await f.adapter.respond(request(path))).status,status);assert.equal(f.calls.length,0);}
 const f=fixture();assert.equal((await f.adapter.respond(new Request(origin+'/v1/voice/token'))).status,405);assert.equal((await f.adapter.respond(new Request('https://other.invalid/v1/voice/token'))).status,404);
 assert.equal((await f.adapter.respond(request('/v1/voice/token',{}, {headers:{authorization:'Bearer fixture','content-type':'text/plain'}}))).status,415);assert.equal(f.calls.length,0);
});
test('bounded actual and declared sizes plus malformed JSON never invoke services',async()=>{
 for(const [body,declared] of [['x'.repeat(2049),null],['{}','2049'],['{}','1'],['{}','invalid'],['{',null],['null',null],['[]',null]]){const f=fixture();const headers={authorization:'Bearer fixture','content-type':'application/json',...(declared===null?{}:{'content-length':declared})};assert.equal((await f.adapter.respond(new Request(origin+'/v1/voice/token',{method:'POST',headers,body}))).status,400);assert.equal(f.calls.length,0);}
});
test('revocation while body reading blocks invocation after initial authorization',async()=>{
 for(const change of ['logout','change','deny']){const f=fixture();let sent=false;const body=new ReadableStream({pull(c){if(sent){c.close();return;}sent=true;f[change]();c.enqueue(new TextEncoder().encode('{}'));}},{highWaterMark:0});const response=await f.adapter.respond(new Request(origin+'/v1/voice/token',{method:'POST',headers:{authorization:'Bearer fixture','content-type':'application/json'},body,duplex:'half'}));assert.ok([401,403].includes(response.status));assert.equal(f.grants[0],'token');assert.equal(f.calls.length,0);}
});
test('revocation after service work suppresses private responses without resubmitting mutations',async()=>{
 for(const change of ['logout','change','deny']){const f=fixture();f.after(()=>f[change]());const response=await f.adapter.respond(request());assert.ok([401,403].includes(response.status));assert.equal(f.calls.length,1);assert.doesNotMatch(await response.text(),/fixture-sdk-token|sessionHash|alice/);}
});
test('malformed service responses and thrown private errors remain generic and never retry',async()=>{
 for(const result of [{token:'secret'}, {token:'secret',identity:'id',ttlSeconds:60,private:'secret'}]){const f=fixture();f.services.tokens.issue=async()=>result;const handler=new NativeVoiceHttpAdapter(f.options);assert.equal((await handler.respond(request())).status,503);}
 const f=fixture();let count=0;f.services.otp.start=async()=>{count++;throw Error('PRIVATE PROVIDER SECRET');};const response=await new NativeVoiceHttpAdapter(f.options).respond(request(commands[5][1],commands[5][2]));assert.equal(response.status,503);assert.doesNotMatch(await response.text(),/PRIVATE|PROVIDER|SECRET/);assert.equal(count,1);
});
test('host callbacks and service method references are captured before asynchronous use',async()=>{
 const f=fixture();f.options.authenticate=async()=>{throw Error('replaced');};f.services.tokens.issue=async()=>{throw Error('replaced');};assert.equal((await f.adapter.respond(request())).status,200);
});
test('invalid private audio is a generic server failure, never a caller error or unchecked stream',async()=>{
 for(const result of [{bytes:new Uint8Array(0),contentType:'audio/wav'}, {bytes:new Uint8Array(1025),contentType:'audio/wav'}, {bytes:new Uint8Array(16),contentType:'audio/wav'}, {bytes:wav,contentType:'text/html'}]){
  const f=fixture();f.services.voicemail.audio=async()=>result;const response=await new NativeVoiceHttpAdapter(f.options).respond(request(commands[4][1],commands[4][2]));assert.equal(response.status,503);assert.equal(response.headers.get('content-type'),'application/json');
 }
});
test('registered native response schemas reject a legacy six-digit assignment',async()=>{
 const f=fixture();f.services.extensions.assign=async()=>({...extension,extension:'100001'});
 const response=await new NativeVoiceHttpAdapter(f.options).respond(request(commands[1][1],commands[1][2]));assert.equal(response.status,503);assert.doesNotMatch(await response.text(),/100001/);
});
test('service JSON and audio buffers are owned before final authorization suspends',async()=>{
 for(const audio of [false,true]){const f=fixture();let reads=0;const bytes=wav.slice(),result={token:'original-token',identity:'original-user',ttlSeconds:60};
  f.services.tokens.issue=async()=>result;f.services.voicemail.audio=async()=>({bytes,contentType:'audio/wav'});
  const adapter=new NativeVoiceHttpAdapter({...f.options,async authenticate(){if(++reads===3){result.token='another-call-token';result.identity='another-user';bytes.fill(0);}return {actor,sessionHash:hash,expiresAt:Date.now()+60000};}});
  const response=await adapter.respond(audio?request(commands[4][1],commands[4][2]):request());assert.equal(response.status,200);
  if(audio)assert.deepEqual(new Uint8Array(await response.arrayBuffer()),wav);else assert.deepEqual(await response.json(),{token:'original-token',identity:'original-user',ttlSeconds:60});
 }
});
test('configuration requires current ports, secure origin and finite resource limits',()=>{
 for(const change of [{origin:'http://app.invalid'},{origin:origin+'/'},{maxRequestBytes:65537},{maxAudioBytes:11},{maxAudioBytes:33554433},{authenticate:null},{authorize:null},{services:{}},{appOrigins:['*']},{appOrigins:['http://app.invalid']},{appOrigins:[origin+'/path']}])assert.throws(()=>new NativeVoiceHttpAdapter({...fixture().options,...change}));
});
test('an explicitly configured portal origin is allowed without broadening to arbitrary cross-site callers',async()=>{
 const f=fixture(),appOrigins=['https://portal.example.invalid'];const adapter=new NativeVoiceHttpAdapter({...f.options,appOrigins});appOrigins.push('https://forged.invalid');
 const send=value=>adapter.respond(request('/v1/voice/token',{}, {headers:{authorization:'Bearer '+nativeToken,'content-type':'application/json',origin:value,'sec-fetch-site':'cross-site'}}));
 assert.equal((await send('https://portal.example.invalid')).status,200);assert.equal((await send('https://forged.invalid')).status,403);assert.equal((await send('null')).status,403);
});
test('native composition derives session hash and identity only through current PostgreSQL lookup',async()=>{
 const f=fixture(),queries=[],expected=createHash('sha256').update(nativeToken).digest('hex');
 const pool={async connect(){throw Error('Unused');},async query(sql,params){queries.push({sql,params});return {rows:[{id:expected,userId:actor.id,tenantId:actor.tenantId,expiresAt:String(Date.now()+60000)}]};}};
 const adapter=createPostgresNativeVoiceHttpAdapter({...f.options,pool,authenticate:async()=>{throw Error('Cannot replace native auth');}});
 assert.equal((await adapter.respond(request())).status,200);assert.equal(f.calls[0].args[0],expected);assert.equal(queries.length,3);
 for(const q of queries){assert.deepEqual(q.params,[expected]);assert.match(q.sql,/JOIN users/);assert.match(q.sql,/JOIN tenants/);assert.match(q.sql,/s\.expires_at>NOW\(\)/);assert.match(q.sql,/LOWER\(u\.status\)='active'/);assert.match(q.sql,/LOWER\(t\.status\)='active'/);assert.doesNotMatch(q.sql,new RegExp(nativeToken));}
});
test('native session disappearance and forged tenant header never expose token results',async()=>{
 for(const mode of ['missing','revoke','tenant']){const f=fixture();let reads=0;
  const pool={async connect(){throw Error('Unused');},async query(sql,params){reads++;return {rows:mode==='missing'||mode==='revoke'&&reads===3?[]:[{id:params[0],userId:actor.id,tenantId:actor.tenantId,expiresAt:String(Date.now()+60000)}]};}};
  const response=await createPostgresNativeVoiceHttpAdapter({...f.options,pool}).respond(request('/v1/voice/token',{},mode==='tenant'?{headers:{authorization:'Bearer '+nativeToken,'content-type':'application/json','x-tenant-id':'tenant-b'}}:{}));
  assert.equal(response.status,mode==='tenant'?403:401);assert.equal(f.calls.length,mode==='revoke'?1:0);assert.doesNotMatch(await response.text(),/fixture-sdk-token/);
 }
});
test('native HTTP token issuance reads current sessions and publication in disposable PostgreSQL',{skip:!process.env.TWILIO_SMS_TEST_DATABASE_URL},async()=>{
 if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden in native voice fixture');
 const {default:pg}=await import('pg');const {TwilioVoiceTokenService}=await import('../cloudflare/workers/src/business-tasks/twilio-token.ts');
 const {PostgresVoiceDirectory}=await import('../cloudflare/workers/src/business-tasks/voice-directory.ts');
 const schema='voice_http_'+crypto.randomUUID().replaceAll('-','');
 const admin=new pg.Pool({connectionString:process.env.TWILIO_SMS_TEST_DATABASE_URL});let pool;
 try{
  await admin.query('CREATE SCHEMA "'+schema+'"');pool=new pg.Pool({connectionString:process.env.TWILIO_SMS_TEST_DATABASE_URL,options:'-c search_path='+schema});
  await pool.query('CREATE TABLE tenants(id text PRIMARY KEY,status text);CREATE TABLE users(id text PRIMARY KEY,tenant_id text,status text);CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id text,expires_at timestamptz);CREATE TABLE communication_voice_extensions(extension text,tenant_id text,user_id text,published boolean,active boolean,version bigint)');
  await pool.query("INSERT INTO tenants VALUES('tenant-a','active');INSERT INTO users VALUES('alice','tenant-a','active');INSERT INTO communication_voice_extensions VALUES('1002','tenant-a','alice',true,true,1)");
  await pool.query("INSERT INTO auth_sessions VALUES($1,'alice',NOW()+interval '5 minutes')",[createHash('sha256').update(nativeToken).digest('hex')]);
  const f=fixture();let allowed=true;
  const tokens=new TwilioVoiceTokenService({run(){throw Error('Unused');},read(){throw Error('Unused');},inbox(){throw Error('Unused');}},{async assert(){if(!allowed)throw Error('Denied');},async assignee(){throw Error('Unused');}},new PostgresVoiceDirectory(pool),{accountSid:'AC'+'a'.repeat(32),apiKeySid:'SK'+'b'.repeat(32),apiKeySecret:'c'.repeat(32),applicationSid:'AP'+'d'.repeat(32),ttlSeconds:60});
  const adapter=createPostgresNativeVoiceHttpAdapter({...f.options,pool,services:{...f.services,tokens},async authorize(session,key){assert.deepEqual(session.actor,actor);assert.equal(key,'token');if(!allowed)throw new NativeVoiceHttpError(403);}});
  const response=await adapter.respond(request());assert.equal(response.status,200);const result=await response.json();assert.equal(result.ttlSeconds,60);assert.match(result.token,/^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$/);
  allowed=false;assert.equal((await adapter.respond(request())).status,403);allowed=true;
  await pool.query("UPDATE communication_voice_extensions SET published=false");assert.equal((await adapter.respond(request())).status,503);await pool.query("UPDATE communication_voice_extensions SET published=true");
  await pool.query("UPDATE tenants SET status='inactive'");assert.equal((await adapter.respond(request())).status,401);await pool.query("UPDATE tenants SET status='active'");
  await pool.query('DELETE FROM auth_sessions');assert.equal((await adapter.respond(request())).status,401);
 }finally{await pool?.end();try{await admin.query('DROP SCHEMA "'+schema+'" CASCADE');}finally{await admin.end();}}
});
