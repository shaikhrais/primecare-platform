import {auditFixture} from './auth-audit-fixtures.mjs';
import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
let actor,target,queries,failAudit,rateAttempts,count,rowOverride;
function fixture(role='ceo',found=true){actor=role?{id:'actor',roles:role,tenant_id:'tenant-a'}:null;target=found?{id:'target'}:null;queries=[];failAudit=false;rateAttempts=0;count=2;rowOverride={};
 globalThis.__adminQuery=async(sql,values)=>{
  queries.push({sql,values});
  if(sql.includes('WHERE s.token_hash=$1'))return {rows:actor?[actor]:[]};
  if(sql.startsWith('INSERT INTO auth_rate_limits'))return {rows:[{attempts:++rateAttempts,retry_after:60}]};
  if(sql.startsWith('SELECT id,email,roles,status,updated_at')){assert.deepEqual(values,['target','tenant-a']);return {rows:target?[{id:'target',email:'target@example.invalid',roles:'rmt',status:'active',updated_at:null,password_hash:'should-not-leak',tenant_id:'should-not-leak',...rowOverride}]:[]};}
  if(sql.startsWith('SELECT id,actor_user_id')&&sql.includes('FROM auth_account_audit'))return {rows:[{id:'creation',actorUserId:'actor',targetUserId:'target',created_at:'2026-01-01T00:00:00Z',secret:'should-not-leak',...rowOverride}]};
  if(sql.startsWith('SELECT id FROM users')){assert.deepEqual(values,['target','tenant-a']);return {rows:target?[target]:[]};}
  if(sql.startsWith('WITH revoked AS'))return {rows:[{count}]};
  if(sql.startsWith('INSERT INTO auth_management_audit')){if(failAudit)throw Error('private-audit-secret');return auditFixture(sql,values);}
  if(sql.startsWith('SELECT COUNT'))return {rows:[{count}]};
  if(sql.startsWith('SELECT created_at'))return {rows:[{created_at:'2026-01-01T00:00:00Z',expires_at:'2026-01-02T00:00:00Z',token_hash:'should-not-leak',...rowOverride}]};
  if(sql.startsWith('SELECT id,actor_user_id'))return {rows:[{id:'audit',actorUserId:'actor',targetUserId:'target',created_at:'2026-01-01T00:00:00Z',action:'sessions_revoked',previous:{role:'rmt',sessionCount:2,password:'should-not-leak'},current:{role:{private:'should-not-leak'},status:'inactive',sessionCount:0,key:'should-not-leak'},unexpected:'should-not-leak',...rowOverride}]};
  assert.ok(sql.startsWith('BEGIN')||['COMMIT','ROLLBACK'].includes(sql),sql);return {rows:[]};
 };
}
const bundle=async(path,plugins=[])=>{const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));};
const plugin={name:'fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__adminQuery(sql,values)}}',loader:'js'}));}};
const {auth}=await bundle('cloudflare/workers/src/auth.ts',[plugin]);
const {parseAccountAdminRequest}=await bundle('cloudflare/workers/src/account-admin.ts');
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const token='a'.repeat(43),env={SERVICE_NAME:'auth',DB_URL:'fixture'};
const call=(path='/admin/users/target/sessions',method='GET',query='',headers={},body)=>auth(new Request('https://fixture'+path+query,{method,headers:{authorization:'Bearer '+token,...headers},...(body===undefined?{}:{body})}),env,path,{});
test('session list is tenant scoped, bounded and excludes token hashes',async()=>{
 fixture();const r=await call();assert.equal(r.status,200);const data=await r.json();assert.equal(data.userId,'target');assert.equal(data.pagination.total,2);assert.ok(!JSON.stringify(data).includes('should-not-leak'));
 assert.ok(queries.find(q=>q.sql.startsWith('SELECT COUNT')).sql.includes('expires_at>NOW()'));assert.equal(queries.at(-1).sql,'ROLLBACK');assert.equal(r.headers.get('cache-control'),'no-store');
 fixture();assert.equal((await call(undefined,'GET','?includeExpired=true')).status,200);assert.ok(!queries.find(q=>q.sql.startsWith('SELECT COUNT')).sql.includes('expires_at>NOW()'));
});
test('revocation locks the target, deletes all sessions and commits an audit together',async()=>{
 fixture();const r=await call(undefined,'DELETE');assert.equal(r.status,200);assert.deepEqual(await r.json(),{userId:'target',revokedSessions:2});
 const lock=queries.find(q=>q.sql.startsWith('SELECT id FROM users'));assert.ok(lock.sql.endsWith('FOR UPDATE'));
 const deleted=queries.find(q=>q.sql.startsWith('WITH revoked AS'));assert.deepEqual(deleted.values,['target']);
 const audit=queries.find(q=>q.sql.startsWith('INSERT INTO auth_management_audit'));assert.deepEqual(audit.values.slice(0,3),['actor','target','tenant-a']);assert.equal(JSON.parse(audit.values[4]).action,'sessions_revoked');assert.equal(queries.at(-1).sql,'COMMIT');
});
test('failed audit rolls back the revocation without exposing backend details',async()=>{
 fixture();failAudit=true;const r=await call(undefined,'DELETE');assert.equal(r.status,503);assert.ok(!(await r.text()).includes('private'));assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'));
});
test('ordinary roles, expired sessions, tenant mismatch, missing targets and self revocation fail closed',async()=>{
 fixture('rmt');assert.equal((await call(undefined,'DELETE')).status,403);assert.ok(!queries.some(q=>q.sql.startsWith('SELECT id FROM users')));
 fixture(null);assert.equal((await call()).status,401);
 fixture();assert.equal((await call(undefined,'DELETE','',{'x-tenant-id':'tenant-b'})).status,403);assert.ok(!queries.some(q=>q.sql.startsWith('WITH revoked')));
 fixture('ceo',false);assert.equal((await call(undefined,'DELETE')).status,404);assert.ok(!queries.some(q=>q.sql.startsWith('WITH revoked')));
 fixture();assert.equal((await call('/admin/users/ACTOR/sessions','DELETE')).status,403);assert.ok(!queries.some(q=>q.sql.startsWith('SELECT id FROM users')));
});
test('audit history exposes only approved state fields and uses bound tenant/target filters',async()=>{
 fixture();const r=await call('/admin/users/audit','GET','?userId=target&limit=2');assert.equal(r.status,200);const body=await r.json();assert.ok(!JSON.stringify(body).includes('should-not-leak'));
 assert.deepEqual(body.events[0].previous,{role:'rmt',status:null,sessionCount:2});assert.equal(body.events[0].current.role,null);
 assert.deepEqual(queries.find(q=>q.sql.startsWith('SELECT COUNT')).values,['tenant-a','target']);
 assert.ok(queries.find(q=>q.sql.startsWith('SELECT id,actor_user_id')).sql.includes('ORDER BY created_at DESC,id DESC'));
});
test('strict routes, unsupported methods, malformed identifiers, duplicate fields and bodies are rejected',async()=>{
 for(const [path,method,query,body,status] of [
  ['/admin/users/target/sessions','POST','',undefined,405],['/admin/users/audit','DELETE','',undefined,405],
  ['/admin/users/%2F/sessions','GET','',undefined,400],['/admin/users/target/sessions','GET','?limit=101',undefined,400],
  ['/admin/users/target/sessions','GET','?limit=1&limit=2',undefined,400],['/admin/users/target/sessions','GET','?includeExpired=yes',undefined,400],
  ['/admin/users/target/sessions','DELETE','?tenant_id=other',undefined,400],['/admin/users/target/sessions','DELETE','','{}',400],
  ['/admin/users/audit','GET','?userId=../private',undefined,400]]) {
  fixture();assert.equal((await call(path,method,query,{},body)).status,status,path+query);assert.equal(queries.length,0);
 }
 assert.equal(parseAccountAdminRequest(new Request('https://fixture/unrelated'),'/unrelated'),null);
});
test('revocation attempts consume the existing mutation budget even after rollback',async()=>{
 fixture('rmt');for(let i=0;i<10;i++)assert.equal((await call(undefined,'DELETE')).status,403);
 const r=await call(undefined,'DELETE');assert.equal(r.status,429);assert.equal(r.headers.get('retry-after'),'60');
 assert.equal(rateAttempts,11);assert.ok(!queries.some(q=>q.sql.startsWith('WITH revoked')));
});
test('gateway forwards session and audit methods, credentials and query parameters',async()=>{
 for(const [path,method] of [['/v1/admin/users/target/sessions','GET'],['/v1/admin/users/target/sessions','DELETE'],['/v1/admin/users/audit','GET']]) {
  let forwarded;const r=await gateway.fetch(new Request('https://gateway'+path+'?limit=2',{method,headers:{authorization:'Bearer '+token}}),{AUTH:{fetch:async(req)=>{forwarded=req;return Response.json({ok:true});}}});
  assert.equal(r.status,200);assert.equal(new URL(forwarded.url).pathname,path.slice(3));assert.equal(new URL(forwarded.url).search,'?limit=2');assert.equal(forwarded.method,method);assert.equal(forwarded.headers.get('authorization'),'Bearer '+token);
 }
});

test('account detail projects approved fields only and binds the target and tenant',async()=>{
 fixture();const r=await call('/admin/users/target');assert.equal(r.status,200);const body=await r.json();
 assert.deepEqual(body.user,{id:'target',email:'target@example.invalid',roles:'rmt',status:'active',updated_at:null,canModify:true});assert.ok(body.assignableRoles.includes('rmt'));assert.ok(!JSON.stringify(body).includes('should-not-leak'));
 assert.equal(queries.at(-1).sql,'ROLLBACK');assert.equal(r.headers.get('cache-control'),'no-store');
 fixture();actor.id='TARGET';assert.equal((await (await call('/admin/users/target')).json()).user.canModify,false);
});
test('account detail rejects unauthorized actors and absent tenant targets',async()=>{
 fixture('rmt');assert.equal((await call('/admin/users/target')).status,403);
 fixture(null);assert.equal((await call('/admin/users/target')).status,401);
 fixture('ceo',false);assert.equal((await call('/admin/users/target')).status,404);
 fixture();assert.equal((await call('/admin/users/target','GET','',{'x-tenant-id':'foreign'})).status,403);
 fixture();assert.equal((await auth(new Request('https://fixture/admin/users/target',{headers:{cookie:'session_token='+token}}),env,'/admin/users/target',{})).status,401);
});
test('creation history is bounded, tenant scoped and exposes only persisted creation events',async()=>{
 fixture();const r=await call('/admin/users/creation-audit','GET','?userId=target&limit=1&offset=1');assert.equal(r.status,200);const body=await r.json();
 assert.deepEqual(body.events[0],{id:'creation',actorUserId:'actor',targetUserId:'target',created_at:'2026-01-01T00:00:00Z',action:'account_created'});
 const q=queries.find(q=>q.sql.includes('FROM auth_account_audit')&&!q.sql.startsWith('SELECT COUNT'));assert.deepEqual(q.values,['tenant-a','target',1,1]);assert.ok(q.sql.includes("action='account_created'"));assert.ok(q.sql.includes('ORDER BY created_at DESC,id DESC'));assert.equal(body.pagination.total,2);
});
test('detail and creation history reject methods and invalid queries before accessing the database',async()=>{
 for(const [path,method,query] of [['/admin/users/target','POST',''],['/admin/users/creation-audit','DELETE',''],['/admin/users/%2F','GET',''],['/admin/users/target','GET','?limit=1'],['/admin/users/creation-audit','GET','?userId='],['/admin/users/audit','GET','?userId='],['/admin/users/creation-audit','GET','?limit=2&limit=3']]){
  fixture();const r=await call(path,method,query);assert.equal(r.status,method==='GET'?400:405);assert.equal(queries.length,0);if(method!=='GET')assert.equal(r.headers.get('allow'),'GET');
 }
});
test('gateway forwards new account read routes and source limits apply before database reads',async()=>{
 for(const path of ['/v1/admin/users/target','/v1/admin/users/creation-audit']){
  let forwarded;const r=await gateway.fetch(new Request('https://gateway'+path+'?userId=target'),{AUTH:{fetch:async req=>{forwarded=req;return Response.json({ok:true});}}});assert.equal(r.status,200);assert.equal(new URL(forwarded.url).pathname,path.slice(3));assert.equal(new URL(forwarded.url).search,'?userId=target');
 }
 fixture();const limited=await auth(new Request('https://fixture/admin/users/target',{headers:{authorization:'Bearer '+token}}),{...env,WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}},'/admin/users/target',{});assert.equal(limited.status,429);assert.equal(queries.length,0);
});

test("account administration rejects malformed counts without commit or audit",async()=>{for(const [path,method] of [["/admin/users/target/sessions","GET"],["/admin/users/target/sessions","DELETE"],["/admin/users/audit","GET"],["/admin/users/creation-audit","GET"]])for(const bad of ["2",null,true,-1,1.5,Infinity,Number.MAX_SAFE_INTEGER+1]){fixture();count=bad;const r=await call(path,method);assert.equal(r.status,503);assert.equal(queries.at(-1).sql,"ROLLBACK");assert.ok(!queries.some(q=>q.sql==="COMMIT"||q.sql.startsWith("INSERT INTO auth_management_audit")));assert.ok(!(await r.text()).includes("Invalid account count"));}});

for(const [name,path,invalid] of [
 ['account detail','/admin/users/target',[{id:null},{id:{}},{email:{}},{roles:{}},{status:42},{updated_at:undefined},{updated_at:'invalid'}]],
 ['session dates','/admin/users/target/sessions',[{created_at:null},{created_at:42},{expires_at:'invalid'},{expires_at:new Date(NaN)},{expires_at:new Date('+010000-01-01T00:00:00Z')},{created_at:'2026-02-30T00:00:00Z'}]],
 ['management audit','/admin/users/audit',[{id:null},{actorUserId:{}},{targetUserId:42},{created_at:null},{created_at:'invalid'},{action:'unexpected'}]],
 ['creation audit','/admin/users/creation-audit',[{id:null},{actorUserId:{}},{targetUserId:42},{created_at:null},{created_at:'invalid'}]]
]) {
 test(name+' rejects corrupt projected rows with sanitized rollback',async()=>{for(const row of invalid){fixture();rowOverride=row;const r=await call(path);assert.equal(r.status,503,JSON.stringify(row));assert.equal(queries.at(-1).sql,'ROLLBACK');assert.equal(r.headers.get('cache-control'),'no-store');assert.deepEqual(await r.json(),{error:'Authentication service unavailable'});}});
}
test('account detail retains registered nullable role and status fields',async()=>{fixture();rowOverride={roles:null,status:null};const r=await call('/admin/users/target');assert.equal(r.status,200);const data=await r.json();assert.equal(data.user.roles,null);assert.equal(data.user.status,null);});
test('PostgreSQL Date instances serialize to contract timestamps for all admin reads',async()=>{for(const path of ['/admin/users/target','/admin/users/target/sessions','/admin/users/audit','/admin/users/creation-audit']){fixture();const date=new Date('2026-01-01T00:00:00Z');rowOverride={updated_at:date,created_at:date,expires_at:date};const r=await call(path);assert.equal(r.status,200);assert.ok((await r.text()).includes(date.toISOString()));}});

for(const mode of ['missing','duplicate','identity','tenant','previous','current','timestamp'])test('batch 358–359 revocation audit '+mode,async()=>{fixture();const base=globalThis.__adminQuery;globalThis.__adminQuery=async(sql,v)=>{const r=await base(sql,v);if(sql.startsWith('INSERT INTO auth_management_audit')){if(mode==='missing')r.rows=[];else if(mode==='duplicate')r.rows.push({...r.rows[0]});else if(mode==='identity')r.rows[0].target_user_id='foreign';else if(mode==='tenant')r.rows[0].tenant_id='foreign';else if(mode==='previous')r.rows[0].previous_state.sessionCount=99;else if(mode==='current')r.rows[0].new_state.sessionCount=1;else r.rows[0].created_at='private-invalid-date';}return r;};const r=await call('/admin/users/target/sessions','DELETE');assert.equal(r.status,503);assert.equal(r.headers.get('set-cookie'),null);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'));});
