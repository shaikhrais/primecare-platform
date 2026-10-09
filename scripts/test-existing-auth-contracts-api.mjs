import {auditFixture} from './auth-audit-fixtures.mjs';
import {build} from 'esbuild';
import {test,beforeEach} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import bcrypt from 'bcryptjs';

const spec=JSON.parse(readFileSync('docs/api/existing-auth-batches-242-247.openapi.json'));
const bundle=async(path,plugins=[])=>{const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));};
const plugin={name:'auth-contract-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({loader:'js',contents:'export class Client {async connect(){} async end(){} query(sql,values){return globalThis.__contractQuery(sql,values)}}'}));}};
const {auth}=await bundle('cloudflare/workers/src/auth.ts',[plugin]);
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const token='a'.repeat(43),password='fixture-old-password',hash=await bcrypt.hash(password,4);
let actor,queries,duplicate,targetExists,revoked,passwordResult;
beforeEach(()=>{
 actor={id:'actor',roles:'ceo',tenant_id:'tenant-a',password_hash:hash};queries=[];duplicate=false;targetExists=true;revoked=false;passwordResult=null;
 globalThis.__contractQuery=async(sql,values=[])=>{
  queries.push({sql,values});
  const audit=auditFixture(sql,values);if(audit)return audit;
  if(sql.includes('WHERE s.token_hash'))return {rows:actor&&!revoked?[actor]:[]};
  if(sql.startsWith('INSERT INTO auth_rate_limits'))return {rows:[{attempts:1,retry_after:60}]};
  if(sql.startsWith('SELECT id FROM users'))return {rows:duplicate?[{id:'existing'}]:[]};
  if(sql.startsWith('INSERT INTO users'))return {rows:[{id:values[4],email:values[0],tenant_id:values[1],roles:values[2],status:'active'}]};
  if(sql.startsWith('SELECT id,roles,status')){assert.deepEqual(values,['target','tenant-a']);return {rows:targetExists?[{id:'target',roles:'rn',status:'active'}]:[]};}
  if(sql.startsWith('UPDATE users SET roles')){assert.deepEqual(values,['rmt','inactive','target','tenant-a']);return {rows:[{id:'target',email:'target@example.invalid',roles:values[0],status:values[1],tenant_id:values[3]}]};}
  if(sql.startsWith('DELETE FROM auth_sessions')){if(values[0]==='actor')revoked=true;return {rows:[]};}
  if(sql.startsWith('UPDATE users SET password_hash'))return {rows:passwordResult?passwordResult(values):[{id:values[1],password_hash:values[0]}]};
  if(sql.startsWith('DELETE FROM auth_password_resets')||sql.startsWith('INSERT INTO auth_')||sql.startsWith('SELECT pg_advisory')||['BEGIN','COMMIT','ROLLBACK'].includes(sql))return {rows:[]};
  throw Error('Unexpected fixture query: '+sql);
 };
});
const env={DB_URL:'fixture:no-network',SERVICE_NAME:'auth'};
async function call(route,method='POST',body,headers={authorization:'Bearer '+token}){
 return gateway.fetch(new Request('https://gateway.test'+route,{method,headers:{'content-type':'application/json',...headers},...(body===undefined?{}:{body:JSON.stringify(body)})}),{AUTH:{fetch:r=>auth(r,env,new URL(r.url).pathname,{})}});
}
const creation={email:'  NEW@EXAMPLE.INVALID ',password:'fixture-created-password',role:'rmt'};
const management={id:'target',role:'rmt',status:'inactive'};
for(const method of ['GET','POST'])for(const credential of ['bearer','cookie'])test(method+' session identity through gateway with '+credential,async()=>{
 const headers=credential==='bearer'?{authorization:'Bearer '+token}:{cookie:'session_token='+token};
 const response=await call('/v1/auth/me?userId=another',method,method==='POST'?{userId:'another',roles:'admin'}:undefined,headers);
 assert.equal(response.status,200);assert.deepEqual(await response.json(),{userId:'actor',roles:'ceo',status:'authenticated'});assert.equal(response.headers.get('cache-control'),'no-store');
 assert.equal(queries.length,1);assert.match(queries[0].sql,/expires_at > NOW\(\)/);assert.match(queries[0].sql,/LOWER\(u.status\) = 'active'/);
 assert.equal(spec.paths['/v1/auth/me'][method.toLowerCase()].security.length,2);
});
for(const method of ['GET','POST'])test(method+' identity rejects malformed bearer without cookie fallback',async()=>{
 assert.equal((await call('/v1/auth/me',method,undefined,{authorization:'Bearer broken',cookie:'session_token='+token})).status,401);assert.equal(queries.length,0);
});
test('revoked identity is rejected by the gateway handler',async()=>{actor=null;assert.equal((await call('/v1/auth/me','GET')).status,401);});
for(const route of ['/v1/auth/register','/v1/admin/users','/v1/user/change-password'])test(route+' denies ambient cookie mutation',async()=>{
 assert.equal((await call(route,'POST',{}, {cookie:'session_token='+token})).status,401);assert.equal(queries.length,0);
 assert.deepEqual(spec.paths[route].post.security,[{bearerAuth:[]}]);
});
test('creation binds normalized email and actor tenant, audits and hides password',async()=>{
 const response=await call('/v1/auth/register','POST',creation);assert.equal(response.status,201);const data=await response.json();
 assert.equal(data.user.email,'new@example.invalid');assert.equal(data.user.tenant_id,'tenant-a');assert.ok(!JSON.stringify(data).includes('password'));
 assert.ok(queries.some(q=>q.sql.includes('account_created')));assert.equal(queries.at(-1).sql,'COMMIT');
 const inserted=queries.find(q=>q.sql.startsWith('INSERT INTO users'));assert.ok(await bcrypt.compare(creation.password,inserted.values[3]));
 assert.deepEqual(Object.keys(data.user).sort(),spec.paths['/v1/auth/register'].post.responses['201'].content['application/json'].schema.properties.user.required.toSorted());
});
for(const [label,setup,headers,status] of [
 ['role denied',()=>{actor.roles='rmt';},undefined,403],['HR cannot assign CEO',()=>{actor.roles='hr_director';creation.role='ceo';},undefined,403],
 ['no tenant',()=>{actor.tenant_id=null;},undefined,403],['cross tenant',()=>{}, {authorization:'Bearer '+token,'x-tenant-id':'tenant-b'},403],['duplicate email',()=>{duplicate=true;},undefined,409]
])test('creation '+label,async()=>{const saved=creation.role;try{setup();assert.equal((await call('/v1/auth/register','POST',creation,headers)).status,status);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT INTO users')));assert.equal(queries.at(-1).sql,'ROLLBACK');}finally{creation.role=saved;}});
test('creation rejects mass assignment before accessing database',async()=>{assert.equal((await call('/v1/auth/register','POST',{...creation,tenant_id:'other'})).status,400);assert.equal(queries.length,0);});
test('CEO management scopes target, revokes target sessions and audits',async()=>{
 const response=await call('/v1/admin/users','POST',management);assert.equal(response.status,200);assert.equal((await response.json()).user.tenant_id,'tenant-a');
 assert.ok(queries.some(q=>q.sql.startsWith('DELETE FROM auth_sessions')&&q.values[0]==='target'));assert.ok(queries.some(q=>q.sql.startsWith('INSERT INTO auth_management_audit')));assert.equal(queries.at(-1).sql,'COMMIT');
});
for(const [label,setup,input,status] of [['non CEO',()=>{actor.roles='hr_director';},management,403],['self',()=>{}, {...management,id:'actor'},403],['missing target',()=>{targetExists=false;},management,404]])test('management denies '+label,async()=>{setup();assert.equal((await call('/v1/admin/users','POST',input)).status,status);assert.ok(!queries.some(q=>q.sql.startsWith('UPDATE users')));assert.equal(queries.at(-1).sql,'ROLLBACK');});
test('password change commits revocation of sessions and resets, clears cookie',async()=>{
 const response=await call('/v1/user/change-password','POST',{currentPassword:password,newPassword:'fixture-new-password'});assert.equal(response.status,200);assert.deepEqual(await response.json(),{status:'password_changed',reauthenticationRequired:true});
 assert.ok(response.headers.get('set-cookie').includes('Max-Age=0'));assert.ok(queries.some(q=>q.sql.startsWith('DELETE FROM auth_password_resets')));assert.equal(queries.at(-1).sql,'COMMIT');
 assert.equal((await call('/v1/auth/me','GET')).status,401);
});
test('wrong current password rolls back and retains session',async()=>{
 assert.equal((await call('/v1/user/change-password','POST',{currentPassword:'wrong',newPassword:'fixture-new-password'})).status,401);
 assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql.startsWith('UPDATE users')));assert.equal((await call('/v1/auth/me','GET')).status,200);
});
test('contracts retain current policy roles and describe byte/code-unit password bounds',()=>{
 const policy=JSON.parse(readFileSync('cloudflare/workers/src/account-policy.json'));
 assert.deepEqual(spec.paths['/v1/admin/users'].post.requestBody.content['application/json'].schema.properties.role.enum,policy.ceo);
 assert.ok(spec.paths['/v1/auth/register'].post.requestBody.content['application/json'].schema.properties.role.enum.includes('maintenance'));
 assert.match(spec.paths['/v1/user/change-password'].post.requestBody.content['application/json'].schema.properties.newPassword.description,/72 UTF-8 bytes/);
});

test('invalid own-password write results return sanitized 503 and roll back without revocation',async()=>{
 for(const result of [()=>[],v=>[{id:'other',password_hash:v[0]}],()=>[{id:'actor',password_hash:'private-hash'}],v=>[{id:1,password_hash:v[0]}],v=>[{id:'actor',password_hash:v[0]},{id:'actor',password_hash:v[0]}]]) {
  queries=[];passwordResult=result;
  const response=await call('/v1/user/change-password','POST',{currentPassword:password,newPassword:'fixture-new-password'});
  assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
  assert.deepEqual(await response.json(),{error:'Authentication service unavailable'});
  assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql.startsWith('DELETE FROM auth_sessions')||q.sql.startsWith('INSERT INTO auth_password_audit')||q.sql==='COMMIT'));
  assert.equal((await call('/v1/auth/me','GET')).status,200);
 }
});

for(const [path,body,table] of [['/v1/auth/register',creation,'auth_account_audit'],['/v1/admin/users',management,'auth_management_audit'],['/v1/user/change-password',{currentPassword:password,newPassword:'fixture-new-password'},'auth_password_audit']])for(const mode of ['missing','duplicate','identity','timestamp','payload'])test('batch 360–362 confirmed audit '+path+' '+mode,async()=>{const base=globalThis.__contractQuery;globalThis.__contractQuery=async(sql,v)=>{const r=await base(sql,v);if(sql.startsWith('INSERT INTO '+table)){if(mode==='missing')r.rows=[];else if(mode==='duplicate')r.rows.push({...r.rows[0]});else if(mode==='identity')r.rows[0][table==='auth_password_audit'?'user_id':'target_user_id']='foreign';else if(mode==='timestamp')r.rows[0].created_at='private-corrupt-date';else if(table==='auth_management_audit')r.rows[0].new_state.status='active';else r.rows[0].action='foreign';}return r;};const r=await call(path,'POST',body);assert.equal(r.status,503);assert.equal(r.headers.get('set-cookie'),null);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'));assert.ok(!(await r.text()).includes('private'));});
for(const rows of [null,[null],[{},{}]])test('batch 363 account duplicate probe validates shape '+JSON.stringify(rows),async()=>{const base=globalThis.__contractQuery;globalThis.__contractQuery=async(sql,v)=>sql.startsWith('SELECT id FROM users')?{rows}:base(sql,v);const r=await call('/v1/auth/register','POST',creation);assert.equal(r.status,503);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT INTO users')));assert.equal(queries.at(-1).sql,'ROLLBACK');});
