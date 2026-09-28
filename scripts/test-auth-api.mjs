import { build } from 'esbuild';
import assert from 'node:assert/strict';
import { test, beforeEach } from 'node:test';
import bcrypt from 'bcryptjs';

// Test fixtures only: no network, production credentials, or PostgreSQL writes.
const fixtureHash = await bcrypt.hash('fixture-password', 4);
let sessions, user, queries, failWrite, failRead, ambiguous, rateAttempts, changedBeforeInsert;
beforeEach(() => {
  sessions = new Map(); queries = []; failWrite = false; failRead = false; ambiguous = false; rateAttempts=new Map(); changedBeforeInsert=false;
  user = { id: 'fixture-user', roles: 'fixture-role', tenant_id:'fixture-tenant', status: 'active', password_hash: fixtureHash };
});
globalThis.__authQuery = async (sql, values) => {
  queries.push({sql, values});
  if (failRead) throw new Error('fixture-private-database-details');
  if(sql.startsWith('INSERT INTO auth_rate_limits')) {
    const attempts=(rateAttempts.get(values[0])??0)+1;
    rateAttempts.set(values[0],attempts);return {rows:[{attempts,retry_after:60}]};
  }
  if (['BEGIN','COMMIT','ROLLBACK'].includes(sql) || sql.startsWith('SELECT pg_advisory') || sql.startsWith('INSERT INTO auth_account_audit')) return {rows:[]};
  if (sql.startsWith('SELECT id FROM users')) return {rows:[]};
  if (sql.startsWith('INSERT INTO users')) return {rows:[{id:'created-fixture',email:values[0],tenant_id:values[1],roles:values[2],status:'active'}]};
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
