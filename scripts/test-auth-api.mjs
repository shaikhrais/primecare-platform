import { build } from 'esbuild';
import assert from 'node:assert/strict';
import { test, beforeEach } from 'node:test';
import bcrypt from 'bcryptjs';

// Test fixtures only: no network, production credentials, or PostgreSQL writes.
const fixtureHash = await bcrypt.hash('fixture-password', 4);
let sessions, user, queries, failWrite, failRead, ambiguous, rateAttempts, changedBeforeInsert, createdOverride, creationRows, rateResult, configurationRows, configurationAuditRows, recoveryTenants;
beforeEach(() => {
  sessions = new Map(); queries = []; failWrite = false; failRead = false; ambiguous = false; rateAttempts=new Map(); changedBeforeInsert=false;createdOverride={};creationRows=1;
  rateResult=undefined;configurationRows=[];configurationAuditRows=[];recoveryTenants=[];
  user = { id: 'fixture-user', roles: 'fixture-role', tenant_id:'fixture-tenant', status: 'active', password_hash: fixtureHash };
});
globalThis.__authQuery = async (sql, values) => {
  queries.push({sql, values});
  if (failRead) throw new Error('fixture-private-database-details');
  if(sql.startsWith('INSERT INTO auth_rate_limits')) {
    if(rateResult!==undefined)return rateResult;
    const attempts=(rateAttempts.get(values[0])??0)+1;
    rateAttempts.set(values[0],attempts);return {rows:[{attempts,retry_after:60}]};
  }
  if(sql.startsWith('SELECT tenant_id FROM users'))return {rows:recoveryTenants};
  if(sql.includes('FROM tenant_mail_configuration'))return {rows:configurationRows};
  if(sql.includes('FROM tenant_configuration_audit'))return {rows:configurationAuditRows};
  if (['BEGIN','COMMIT','ROLLBACK'].includes(sql) || sql.startsWith('SELECT pg_advisory') || sql.startsWith('INSERT INTO auth_account_audit')) return {rows:[]};
  if (sql.startsWith('SELECT id FROM users')) return {rows:[]};
  if (sql.startsWith('INSERT INTO users')) return {rows:creationRows?[{id:values[4],email:values[0],tenant_id:values[1],roles:values[2],status:'active',...createdOverride}]:[]};
  if (sql.startsWith('SELECT id, roles')) return {rows: user ? (ambiguous ? [user, {...user,id:'other-user'}] : [user]) : []};
  if (sql.startsWith('INSERT INTO auth_sessions')) {
    if (failWrite) throw new Error('fixture-write-failure');
    if (changedBeforeInsert && sql.includes('FOR SHARE OF u')) return {rows:[]};
    sessions.set(values[0], {userId: values[1], expired:false}); return {rows:[{token_hash:values[0]}]};
  }
  if (sql.startsWith('SELECT u.id')) {
    assert.match(sql, /s.expires_at\s*>\s*NOW\(\)/);
    assert.match(sql, /LOWER\(u.status\)\s*=\s*'active'/);
    const session = sessions.get(values[0]);
    return {rows: session && !session.expired && user?.status === 'active' ? [user] : []};
  }
  if (sql.startsWith('DELETE FROM auth_sessions')) { sessions.delete(values[0]); return {rows:[]}; }
  throw new Error('Unexpected SQL in auth test');
};
const result = await build({entryPoints:['cloudflare/workers/src/auth.ts'],bundle:true,write:false,
  platform:'node',format:'esm',plugins:[{name:'fixture-db',setup(builder){
    builder.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));
    builder.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:
      'export class Client { async connect(){} async end(){} query(sql,values){return globalThis.__authQuery(sql,values)} }',loader:'js'}));
  }}]});
const {auth} = await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
const env={DB_URL:'fixture:no-network',SERVICE_NAME:'auth'};
function request(path, method='GET', body, token) {
  return new Request('https://auth.test'+path,{method,headers:{'content-type':'application/json',
    ...(token?{authorization:'Bearer '+token}:{})},...(body===undefined?{}:{body:JSON.stringify(body)})});
}
const login=()=>auth(request('/login','POST',{email:'fixture@example.invalid',password:'fixture-password'}),env,'/login',{});
test('wrong current-password attempts survive rollback and throttle across sessions',async()=>{
 const first=(await (await login()).json()).token;
 const second=(await (await login()).json()).token;
 const input={currentPassword:'wrong-password',newPassword:'new-fixture-password'};
 for(let i=0;i<5;i++) assert.equal((await auth(request('/change-password','POST',input,i%2?first:second),env,'/change-password',{})).status,401);
 const before=queries.filter(q=>q.sql==='BEGIN').length;
 const blocked=await auth(request('/change-password','POST',input,second),env,'/change-password',{});
 assert.equal(blocked.status,429);assert.equal(blocked.headers.get('retry-after'),'60');
 assert.equal(blocked.headers.get('cache-control'),'no-store');
 assert.equal(queries.filter(q=>q.sql==='BEGIN').length,before);
 assert.equal(queries.filter(q=>q.sql==='ROLLBACK').length,5);
});
test('invalid sessions do not allocate mutation counters',async()=>{
 const response=await auth(request('/change-password','POST',{currentPassword:'wrong',newPassword:'new-fixture-password'},'A'.repeat(43)),env,'/change-password',{});
 assert.equal(response.status,401);assert.equal(rateAttempts.size,0);
});
test('forbidden account creation and management use independent user counters',async()=>{
 const {token}=await (await login()).json();
 for(const [path,input] of [
  ['/register',{email:'new@example.invalid',password:'new-fixture-password',role:'rmt'}],
  ['/admin/users',{id:'other-user',role:'rmt',status:'inactive'}],
 ]) {
  for(let i=0;i<10;i++) assert.equal((await auth(request(path,'POST',input,token),env,path,{})).status,403);
  assert.equal((await auth(request(path,'POST',input,token),env,path,{})).status,429);
 }
 assert.equal((await auth(request('/me','GET',undefined,token),env,'/me',{})).status,200);
 assert.equal((await auth(request('/logout','POST',{},token),env,'/logout',{})).status,200);
});
test('login cannot issue a session when credentials change before insertion',async()=>{
  changedBeforeInsert=true;
  const response=await login();
  assert.equal(response.status,401);
  assert.deepEqual(await response.json(),{error:'Invalid credentials'});
  assert.equal(response.headers.get('set-cookie'),null);
  assert.equal(sessions.size,0);
});
test('login rejects bcrypt suffix aliases exceeding 72 UTF-8 bytes',async()=>{
  for(const password of ['a'.repeat(72),'é'.repeat(36)]) {
    user.password_hash=await bcrypt.hash(password,4);
    const response=await auth(request('/login','POST',{email:'fixture@example.invalid',password:password+'x'}),env,'/login',{});
    assert.equal(response.status,401);
    assert.equal(response.headers.get('set-cookie'),null);
  }
  assert.equal(sessions.size,0);
});
for (const method of ['GET','POST']) {
 test(method+' session lookup validates identity, expiry, revocation and active status',async()=>{
  assert.equal((await auth(request('/me',method),env,'/me',{})).status,401);
  const {token}=await (await login()).json();
  const lookup=()=>auth(request('/me',method,undefined,token),env,'/me',{});
  const response=await lookup();
  assert.equal(response.status,200);
  assert.equal(response.headers.get('cache-control'),'no-store');
  assert.deepEqual(await response.json(),{userId:user.id,roles:user.roles,status:'authenticated'});
  const record=[...sessions.values()][0];record.expired=true;
  assert.equal((await lookup()).status,401);record.expired=false;
  user.status='inactive';assert.equal((await lookup()).status,401);user.status='active';
  sessions.clear();assert.equal((await lookup()).status,401);
 });
}
test('session lookup does not accept unsupported methods',async()=>{
 assert.equal(await auth(request('/me','PUT'),env,'/me',{}),null);
});
test('login stores a token hash and exposes only approved existing response fields',async()=>{
  const response=await login(); assert.equal(response.status,200);
  const data=await response.json();
  assert.equal(data.role,'fixture-role'); assert.equal(data.userId,'fixture-user');
  assert.match(data.token,/^[A-Za-z0-9_-]{43}$/);
  assert.equal(sessions.size,1); assert.ok(!sessions.has(data.token));
  assert.match([...sessions.keys()][0],/^[a-f0-9]{64}$/);
  assert.equal(data.password_hash,undefined);
  assert.match(response.headers.get('set-cookie'),/HttpOnly; Secure; SameSite=Lax/);
  assert.equal(response.headers.get('cache-control'),'no-store');
});
test('session can be read, revoked, and then rejected',async()=>{
  const {token}=await (await login()).json();
  assert.equal((await auth(request('/me','GET',undefined,token),env,'/me',{})).status,200);
  assert.equal((await auth(request('/logout','POST',{},token),env,'/logout',{})).status,200);
  assert.equal(sessions.size,0);
  assert.equal((await auth(request('/me','GET',undefined,token),env,'/me',{})).status,401);
});
test('expired session is rejected',async()=>{
  const {token}=await (await login()).json(); for(const entry of sessions.values()) entry.expired=true;
  assert.equal((await auth(request('/me','GET',undefined,token),env,'/me',{})).status,401);
});
test('wrong password, missing user, and inactive user share generic error',async()=>{
  for(const kind of ['wrong','inactive','missing']) {
    if(kind==='inactive') user.status='inactive'; if(kind==='missing') user=null;
    const response=await auth(request('/login','POST',{email:'fixture@example.invalid',password:'wrong'}),env,'/login',{});
    assert.equal(response.status,401); assert.deepEqual(await response.json(),{error:'Invalid credentials'});
  }
  assert.equal(sessions.size,0);
});
test('missing credentials do not query database',async()=>{
  assert.equal((await auth(request('/login','POST',{}),env,'/login',{})).status,400);
  assert.equal(queries.length,0);
});
test('missing session does not query database',async()=>{
  assert.equal((await auth(request('/me'),env,'/me',{})).status,401);
  assert.equal(queries.length,0);
});
test('failed session insert never returns successful authentication',async()=>{
  failWrite=true; const response=await login(); assert.equal(response.status,503);
  assert.deepEqual(await response.json(),{error:'Authentication service unavailable'});
  assert.equal(response.headers.get('cache-control'),'no-store'); assert.equal(sessions.size,0);
});
test('malformed JSON is rejected',async()=>{
  const response=await auth(new Request('https://auth.test/login',{method:'POST',body:'{' }),env,'/login',{});
  assert.equal(response.status,400); assert.equal(queries.length,0);
});
test('malformed bearer token cannot fall back to a valid cookie',async()=>{
  const {token}=await (await login()).json(); const before=queries.length;
  const response=await auth(new Request('https://auth.test/me',{headers:{authorization:'Basic invalid',cookie:'session_token='+token}}),env,'/me',{});
  assert.equal(response.status,401); assert.equal(queries.length,before);
});
test('cookie session works and duplicate cookies are rejected',async()=>{
  const {token}=await (await login()).json();
  const call=cookie=>auth(new Request('https://auth.test/me',{headers:{cookie}}),env,'/me',{});
  assert.equal((await call('session_token='+token)).status,200);
  const before=queries.length;
  assert.equal((await call(`session_token=${token}; session_token=${token}`)).status,401);
  assert.equal(queries.length,before);
});
test('bearer scheme is case insensitive',async()=>{
  const {token}=await (await login()).json();
  const response=await auth(new Request('https://auth.test/me',{headers:{authorization:'bearer '+token}}),env,'/me',{});
  assert.equal(response.status,200);
});
test('auth errors are not cacheable on direct Worker responses',async()=>{
  for(const [path,req] of [['/me',request('/me')],['/login',request('/login','POST',{})]]) {
    const response=await auth(req,env,path,{'cache-control':'public'});
    assert.equal(response.headers.get('cache-control'),'no-store');
  }
});
test('deactivated account cannot reuse an existing session',async()=>{
  const {token}=await (await login()).json(); user.status='inactive';
  assert.equal((await auth(request('/me','GET',undefined,token),env,'/me',{})).status,401);
});
test('inactive account is denied even with the correct password',async()=>{
  user.status='inactive'; assert.equal((await login()).status,401); assert.equal(sessions.size,0);
});
test('duplicate normalized emails fail closed without creating a session',async()=>{
  ambiguous=true; const response=await login();
  assert.equal(response.status,401); assert.deepEqual(await response.json(),{error:'Invalid credentials'});
  assert.equal(sessions.size,0);
});
test('database errors remain generic and non-cacheable',async()=>{
  failRead=true; const response=await login();
  assert.equal(response.status,503);
  assert.equal(response.headers.get('cache-control'),'no-store');
  assert.equal(JSON.stringify(await response.json()).includes('fixture-private'),false);
});
test('email normalization uses a bound SQL parameter',async()=>{
  await auth(request('/login','POST',{email:'  Fixture@Example.Invalid ',password:'fixture-password'}),env,'/login',{});
  const lookup=queries.find(q=>q.sql.startsWith('SELECT id, roles'));
  assert.equal(lookup.values[0],'fixture@example.invalid');
  assert.ok(!lookup.sql.includes('fixture@example.invalid'));
});
const newAccount={email:'new@example.invalid',password:'new-fixture-password',role:'rmt'};
test('public registration denied before database access',async()=>{
  assert.equal((await auth(request('/register','POST',newAccount),env,'/register',{})).status,401);
  assert.equal(queries.length,0);
});
test('CEO can create account only in backend-resolved tenant',async()=>{
  user.roles='ceo';const {token}=await (await login()).json();
  const response=await auth(request('/register','POST',newAccount,token),env,'/register',{});
  assert.equal(response.status,201);const data=await response.json();
  assert.equal(data.user.tenant_id,user.tenant_id);assert.equal(data.user.password_hash,undefined);
  assert.ok(queries.some(q=>q.sql.startsWith('INSERT INTO auth_account_audit')));
});
test('HR can create RMT but cannot create CEO or HR Director',async()=>{
  user.roles='hr_director';const {token}=await (await login()).json();
  assert.equal((await auth(request('/register','POST',newAccount,token),env,'/register',{})).status,201);
  for(const role of ['ceo','hr_director','governance','owner','shareholder'])
    assert.equal((await auth(request('/register','POST',{...newAccount,role},token),env,'/register',{})).status,403);
});
test('ordinary roles cannot create accounts',async()=>{
  const {token}=await (await login()).json();
  assert.equal((await auth(request('/register','POST',newAccount,token),env,'/register',{})).status,403);
});
test('tenant override rejected in header and body',async()=>{
  user.roles='ceo';const {token}=await (await login()).json();
  const req=request('/register','POST',newAccount,token);req.headers.set('x-tenant-id','other-tenant');
  assert.equal((await auth(req,env,'/register',{})).status,403);
  assert.equal((await auth(request('/register','POST',{...newAccount,tenant_id:'other'},token),env,'/register',{})).status,400);
});
test('login throttles at the configured limit and stores only hashed subject',async()=>{
  for(let i=0;i<10;i++) assert.equal((await login()).status,200);
  const response=await login(); assert.equal(response.status,429);
  assert.equal(response.headers.get('retry-after'),'60');
  assert.equal(response.headers.get('cache-control'),'no-store');
  for(const q of queries.filter(q=>q.sql.startsWith('INSERT INTO auth_rate_limits')))
    assert.match(q.values[0],/^[a-f0-9]{64}$/);
});
test('maintenance rejects missing sessions, ordinary roles and forged tenant headers',async()=>{
 assert.equal((await auth(request('/maintenance/configuration'),env,'/maintenance/configuration',{})).status,401);
 const {token}=await (await login()).json();
 assert.equal((await auth(request('/maintenance/configuration','GET',undefined,token),env,'/maintenance/configuration',{})).status,403);
 user.roles='maintenance';
 const forged=new Request('https://auth.test/maintenance/configuration',{headers:{authorization:'Bearer '+token,'x-tenant-id':'other-tenant'}});
 assert.equal((await auth(forged,env,'/maintenance/configuration',{})).status,403);
 assert.ok(!queries.some(q=>q.sql.includes('tenant_mail_configuration')));
});

for (const path of ['/maintenance/configuration','/maintenance/configuration/test-email']) {
 test(path+' rejects oversized UTF-8 before database access',async()=>{
  const raw=JSON.stringify({value:'é'.repeat(25_000)});
  assert.ok(raw.length<50_000);
  const response=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43)},body:raw}),env,path,{});
  assert.equal(response.status,413);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(queries.length,0);
 });
 test(path+' bounds chunked bodies and cancels before later chunks',async()=>{
  let pulls=0,cancelled=false;
  const stream=new ReadableStream({pull(controller){pulls++;controller.enqueue(new Uint8Array(25_001));},cancel(){cancelled=true;}},{highWaterMark:0});
  const response=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43),'content-length':'1'},body:stream,duplex:'half'}),env,path,{});
  assert.equal(response.status,413);assert.equal(pulls,2);assert.equal(cancelled,true);assert.equal(queries.length,0);
 });
 test(path+' accepts exact byte boundary for JSON parsing and rejects one byte more',async()=>{
  for(const size of [50_000,50_001]) {
   queries=[];
   const raw='{"value":"'+'a'.repeat(size-12)+'"}';
   assert.equal(Buffer.byteLength(raw),size);
   const response=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43)},body:raw}),env,path,{});
   assert.equal(response.status,size===50_000?401:413);
   assert.equal(queries.length>0,size===50_000);
  }
 });
 test(path+' decodes UTF-8 split between chunks and rejects malformed JSON',async()=>{
  const bytes=new TextEncoder().encode('{"value":"é"}');let offset=0;
  const stream=new ReadableStream({pull(controller){if(offset===bytes.length){controller.close();return;}controller.enqueue(bytes.slice(offset,++offset));}},{highWaterMark:0});
  const response=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43)},body:stream,duplex:'half'}),env,path,{});
  assert.equal(response.status,401);assert.ok(queries.length>0);
  for(const raw of ['{','[]','null']) {
   queries=[];
   const invalid=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43)},body:raw}),env,path,{});
   assert.equal(invalid.status,400);assert.equal(queries.length,0);
  }
 });
 test(path+' rejects declared oversize without reading body',async()=>{
  let pulls=0;
  const stream=new ReadableStream({pull(){pulls++;}},{highWaterMark:0});
  const response=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43),'content-length':'50001'},body:stream,duplex:'half'}),env,path,{});
  assert.equal(response.status,413);assert.equal(pulls,0);assert.equal(queries.length,0);
 });
}

// Batches 254–258: all JSON authentication mutations share the same byte bound.
for(const path of ['/login','/forgot-password','/reset-password','/change-password','/admin/users','/register']) {
 test(path+' rejects excessive multibyte JSON without database access',async()=>{
  const raw=JSON.stringify({value:'é'.repeat(25_000)});assert.ok(raw.length<50_000);
  const r=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43)},body:raw}),env,path,{});
  assert.equal(r.status,413);assert.equal(r.headers.get('cache-control'),'no-store');assert.deepEqual(await r.json(),{error:'Request too large'});assert.equal(queries.length,0);
 });
 test(path+' bounds understated streamed payloads and stops reading',async()=>{
  let pulls=0,cancelled=false;
  const body=new ReadableStream({pull(c){pulls++;c.enqueue(new Uint8Array(25_001));},cancel(){cancelled=true;}},{highWaterMark:0});
  const r=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43),'content-length':'1'},body,duplex:'half'}),env,path,{});
  assert.equal(r.status,413);assert.equal(pulls,2);assert.equal(cancelled,true);assert.equal(queries.length,0);
 });
 test(path+' rejects declared oversize before reading or querying',async()=>{
  let pulls=0;
  const body=new ReadableStream({pull(){pulls++;}},{highWaterMark:0});
  const r=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43),'content-length':'50001'},body,duplex:'half'}),env,path,{});
  assert.equal(r.status,413);assert.equal(pulls,0);assert.equal(queries.length,0);
 });
 test(path+' keeps malformed JSON rejection and session-first mutation validation',async()=>{
  const r=await auth(new Request('https://auth.test'+path,{method:'POST',headers:{authorization:'Bearer '+'A'.repeat(43)},body:'{'}),env,path,{});
  assert.equal(r.status,400);assert.equal(queries.length,0);
  if(['/change-password','/admin/users','/register'].includes(path)){
   const anonymous=await auth(new Request('https://auth.test'+path,{method:'POST',body:'x'.repeat(50_001)}),env,path,{});
   assert.equal(anonymous.status,401);assert.equal(queries.length,0);
  }
 });
}

test('login rejects malformed identity before session insert or cookie issuance',async()=>{
 for(const change of [{id:null},{id:{}},{roles:null},{roles:{}},{roles:''},{roles:'x'.repeat(201)}]) {
  user={id:'fixture-user',roles:'fixture-role',tenant_id:'fixture-tenant',status:'active',password_hash:fixtureHash,...change};queries=[];
  const r=await login();assert.equal(r.status,503);assert.equal(r.headers.get('set-cookie'),null);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT INTO auth_sessions')));assert.deepEqual(await r.json(),{error:'Authentication service unavailable'});
 }
});
test('login never coerces an object status into an active account',async()=>{user.status={toString:()=> 'active'};const r=await login();assert.equal(r.status,401);assert.equal(sessions.size,0);});
test('GET and POST session identity reject malformed claims without exposing them',async()=>{
 const token=(await (await login()).json()).token;
 for(const method of ['GET','POST'])for(const change of [{id:null},{id:{}},{roles:null},{roles:{}},{roles:''},{roles:'x'.repeat(201)}]) {
  user={id:'fixture-user',roles:'fixture-role',tenant_id:'fixture-tenant',status:'active',password_hash:fixtureHash,...change};
  const r=await auth(request('/me',method,undefined,token),env,'/me',{});assert.equal(r.status,503);assert.equal(r.headers.get('cache-control'),'no-store');assert.deepEqual(await r.json(),{error:'Authentication service unavailable'});
 }
});
test('account creation projects only approved returned fields',async()=>{user.roles='ceo';createdOverride={password_hash:'never-return-this',secret:'never-return-this'};const token=(await (await login()).json()).token;const r=await auth(request('/register','POST',{email:'new@example.invalid',password:'fixture-new-password',role:'rmt'},token),env,'/register',{});assert.equal(r.status,201);const data=await r.json();assert.deepEqual(Object.keys(data.user).sort(),['id','email','roles','status','tenant_id'].sort());assert.ok(!JSON.stringify(data).includes('never-return-this'));});
test('account creation rolls back malformed results before audit or success',async()=>{for(const change of [{id:'other-user'},{email:'other@example.invalid'},{roles:'ceo'},{status:'inactive'},{tenant_id:'other-tenant'},{email:null}]){user.roles='ceo';const token=(await (await login()).json()).token;createdOverride=change;queries=[];const r=await auth(request('/register','POST',{email:'new@example.invalid',password:'fixture-new-password',role:'rmt'},token),env,'/register',{});assert.equal(r.status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql.startsWith('INSERT INTO auth_account_audit')||q.sql==='COMMIT'));}});
test('account creation rejects missing returned rows before audit',async()=>{user.roles='ceo';const token=(await (await login()).json()).token;creationRows=0;queries=[];const r=await auth(request('/register','POST',{email:'new@example.invalid',password:'fixture-new-password',role:'rmt'},token),env,'/register',{});assert.equal(r.status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql.startsWith('INSERT INTO auth_account_audit')));});

test('ambiguous session identity never returns the first adapter row',async()=>{const token=(await (await login()).json()).token;const original=globalThis.__authQuery;globalThis.__authQuery=async(sql,values)=>{const r=await original(sql,values);if(sql.startsWith('SELECT u.id'))r.rows=[...r.rows,...r.rows];return r;};const r=await auth(request('/me','GET',undefined,token),env,'/me',{});assert.equal(r.status,503);assert.deepEqual(await r.json(),{error:'Authentication service unavailable'});});

// Each public handler must stop at the malformed limiter response, before any
// transaction, credential write, session issuance, audit or email delivery.
for(const [path,input,authenticated] of [
 ['/login',{email:'fixture@example.invalid',password:'fixture-password'},false],
 ['/forgot-password',{email:'fixture@example.invalid'},false],
 ['/reset-password',{email:'fixture@example.invalid',code:'ABC123ABC123',newPassword:'new-fixture-password'},false],
 ['/change-password',{currentPassword:'fixture-password',newPassword:'new-fixture-password'},true],
 ['/admin/users',{id:'other-user',role:'rmt',status:'inactive'},true],
 ['/register',{email:'new@example.invalid',password:'new-fixture-password',role:'rmt'},true],
]) {
 test(path+' fails closed before protected work on invalid rate results',async()=>{
  user.roles='ceo';
  const token=authenticated?(await (await login()).json()).token:undefined;
  const sessionCount=sessions.size;
  const mailEnv={...env,EMAIL_FROM:'PrimeCare <test@example.com>',EMAIL:{send:async()=>assert.fail('must not send')}};
  for(const invalid of [
   {rows:[]},{rows:[{attempts:1,retry_after:60},{attempts:1,retry_after:60}]},
   {rows:[{attempts:'1',retry_after:60}]},{rows:[{attempts:0,retry_after:60}]},
   {rows:[{attempts:1,retry_after:0}]},{rows:[{attempts:1,retry_after:86400}]},
   {rows:[{attempts:1,retry_after:'60'}]},
  ]) {
   queries=[];rateResult=invalid;
   const response=await auth(request(path,'POST',input,token),mailEnv,path,{});
   assert.equal(response.status,503);
   assert.deepEqual(await response.json(),{error:'Authentication service unavailable'});
   assert.equal(response.headers.get('cache-control'),'no-store');
   assert.equal(response.headers.get('set-cookie'),null);
   assert.equal(response.headers.get('retry-after'),null);
   assert.ok(queries.at(-1).sql.startsWith('INSERT INTO auth_rate_limits'));
   assert.ok(!queries.some(q=>q.sql==='BEGIN'));
   assert.equal(sessions.size,sessionCount);
  }
 });
}

test('maintenance configuration rejects malformed persisted metadata, templates and audits with rollback',async()=>{
 user.roles='maintenance';user.email='fixture@example.invalid';const {token}=await (await login()).json();
 const valid={sender:'mail@example.invalid',templates:{},revision:1,updated_at:new Date('2026-01-01T00:00:00Z')};
 for(const [rows,audit] of [
  [[{...valid,revision:'1'}],[]],[[{...valid,revision:0}],[]],[[{...valid,updated_at:'infinity'}],[]],
  [[{...valid,sender:'private-invalid-address'}],[]],[[{...valid,templates:{private:{}}}],[]],
  [[valid,valid],[]],[[valid],[{action:'private-invalid-action',created_at:valid.updated_at}]],
  [[valid],[{action:'email_configuration_changed',created_at:'infinity'}]],
 ]){
  configurationRows=rows;configurationAuditRows=audit;queries=[];
  const response=await auth(request('/maintenance/configuration','GET',undefined,token),env,'/maintenance/configuration',{});
  assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'Authentication service unavailable'});
  assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');
  assert.ok(!queries.some(q=>q.sql==='COMMIT'||q.sql.startsWith('INSERT')));
 }
});
test('corrupt stored recovery configuration stops before rate counters and email delivery',async()=>{
 recoveryTenants=[{tenant_id:user.tenant_id}];configurationRows=[{sender:'private-invalid-address',templates:{}}];queries=[];
 const mailEnv={...env,EMAIL_FROM:'mail@example.invalid',EMAIL:{send:async()=>assert.fail('must not send')}};
 const response=await auth(request('/forgot-password','POST',{email:'fixture@example.invalid'}),mailEnv,'/forgot-password',{});
 assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'Authentication service unavailable'});
 assert.equal(response.headers.get('cache-control'),'no-store');assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
});
