import { build } from 'esbuild';
import assert from 'node:assert/strict';
import { test, beforeEach } from 'node:test';
import bcrypt from 'bcryptjs';

// Test fixtures only: no network, production credentials, or PostgreSQL writes.
const fixtureHash = await bcrypt.hash('fixture-password', 4);
let sessions, user, queries, failWrite, failRead, ambiguous;
beforeEach(() => {
  sessions = new Map(); queries = []; failWrite = false; failRead = false; ambiguous = false;
  user = { id: 'fixture-user', roles: 'fixture-role', status: 'active', password_hash: fixtureHash };
});
globalThis.__authQuery = async (sql, values) => {
  queries.push({sql, values});
  if (failRead) throw new Error('fixture-private-database-details');
  if (sql.startsWith('SELECT id, roles')) return {rows: user ? (ambiguous ? [user, {...user,id:'other-user'}] : [user]) : []};
  if (sql.startsWith('INSERT INTO auth_sessions')) {
    if (failWrite) throw new Error('fixture-write-failure');
    sessions.set(values[0], {userId: values[1], expired:false}); return {rows:[]};
  }
  if (sql.startsWith('SELECT u.id')) {
    assert.match(sql, /s.expires_at > NOW\(\)/);
    assert.match(sql, /LOWER\(u.status\) = 'active'/);
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
  assert.equal(queries[0].values[0],'fixture@example.invalid');
  assert.ok(!queries[0].sql.includes('fixture@example.invalid'));
});
