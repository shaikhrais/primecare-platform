import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
const queries=[];let actor,count,rowOverride;
const fixture=(role='ceo',tenant='tenant-a')=>{
 queries.length=0;count=3;rowOverride={};actor=role?{id:'actor',roles:role,tenant_id:tenant}:null;
 globalThis.__listQuery=async(sql,values)=>{
  queries.push({sql,values});
  if(sql.includes('WHERE s.token_hash=$1'))return {rows:actor?[actor]:[]};
  if(sql.startsWith('SELECT COUNT')){assert.equal(values[0],'tenant-a');assert.ok(sql.includes('tenant_id::text=$1'));return {rows:[{count}]};}
  if(sql.startsWith('SELECT id,email')){assert.equal(values[0],'tenant-a');assert.ok(!sql.includes('password'));return {rows:[{id:'actor',email:'actor@example.invalid',roles:'ceo',status:'active',updated_at:null,...rowOverride},{id:'target',email:'target@example.invalid',roles:'rmt',status:'active',updated_at:null}]};}
  assert.ok(sql.startsWith('BEGIN')||sql==='ROLLBACK',sql);return {rows:[]};
 };
};
const bundle=async(path,plugins=[])=>{
 const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});
 return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));
};
const plugin={name:'fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__listQuery(sql,values)}}',loader:'js'}));}};
const {auth}=await bundle('cloudflare/workers/src/auth.ts',[plugin]);
const {listAccounts}=await bundle('cloudflare/workers/src/account-management.ts');
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const token='a'.repeat(43),env={SERVICE_NAME:'auth',DB_URL:'fixture'};
const call=(query='',headers={},overrides={})=>auth(new Request('https://fixture/admin/users'+query,{headers:{authorization:'Bearer '+token,...headers}}),{...env,...overrides},'/admin/users',{});
test('CEO list exposes approved fields, self protection and deterministic pagination',async()=>{
 fixture();const response=await call('?limit=2');assert.equal(response.status,200);
 const data=await response.json();assert.equal(data.pagination.total,3);assert.equal(data.pagination.hasMore,true);
 assert.equal(data.users[0].canModify,false);assert.equal(data.users[1].canModify,true);
 assert.ok(data.assignableRoles.includes('rmt'));assert.ok(!JSON.stringify(data).includes('password'));
 assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');
});
test('session and tenant rejection prevent account queries',async()=>{
 for(const [role,tenant,headers,status] of [
  ['ceo','tenant-a',{authorization:''},401],[null,'tenant-a',{},401],['rmt','tenant-a',{},403],
  ['maintenance','tenant-a',{},403],['ceo',null,{},403],['ceo','tenant-a',{'x-tenant-id':'tenant-b'},403]]) {
  fixture(role,tenant);assert.equal((await call('',headers)).status,status);
  assert.ok(!queries.some(q=>q.sql.startsWith('SELECT COUNT')||q.sql.startsWith('SELECT id,email')));
 }
});
test('query limits, duplication and unapproved filters are rejected without reading users',async()=>{
 for(const query of ['?limit=101','?offset=-1','?limit=2&limit=3','?role=superadmin','?status=deleted','?search=%00','?password_hash=true']) {
  fixture();assert.equal((await call(query)).status,400,query);
  assert.ok(!queries.some(q=>q.sql.startsWith('SELECT COUNT')));
 }
});
test('search remains a literal parameter and never becomes SQL or a wildcard',async()=>{
 fixture();const response=await call('?search='+encodeURIComponent("%' OR 1=1 --_\\"));assert.equal(response.status,200);
 const count=queries.find(q=>q.sql.startsWith('SELECT COUNT'));
 assert.ok(!count.sql.includes('OR 1=1'));assert.ok(count.values[4].includes('\\%'));assert.ok(count.values[4].includes('\\_'));assert.ok(count.values[4].includes('\\\\'));
 assert.ok(count.sql.includes("ESCAPE E'\\\\'"));
});
test('rate limiting and DB failure produce genuine failures without sensitive details',async()=>{
 fixture();assert.equal((await call('',{},{WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}})).status,429);assert.equal(queries.length,0);
 fixture();globalThis.__listQuery=async()=>{throw Error('private connection secret');};
 const response=await call();assert.equal(response.status,503);assert.ok(!(await response.text()).includes('private'));
});
test('gateway GET account route preserves authorization and filters to the auth service',async()=>{
 const request=new Request('https://gateway/v1/admin/users?limit=7&search=test',{headers:{authorization:'Bearer '+token}});
 let forwarded;
 const response=await gateway.fetch(request,{AUTH:{fetch:async(r)=>{forwarded=r;return Response.json({users:[]});}}});
 assert.equal(response.status,200);assert.equal(new URL(forwarded.url).pathname,'/admin/users');
 assert.equal(new URL(forwarded.url).search,'?limit=7&search=test');assert.equal(forwarded.headers.get('authorization'),'Bearer '+token);
});

test('unsupported account methods return a method contract without accessing the database',async()=>{
 fixture();
 const r=await auth(new Request('https://fixture/admin/users',{method:'DELETE'}),env,'/admin/users',{});
 assert.equal(r.status,405);assert.equal(r.headers.get('allow'),'GET, POST');assert.equal(queries.length,0);
});

test("account list rejects malformed counts and rolls back",async()=>{for(const bad of ["3",null,true,-1,1.5,Infinity,Number.MAX_SAFE_INTEGER+1]){fixture();count=bad;const r=await call();assert.equal(r.status,503);assert.equal(queries.at(-1).sql,"ROLLBACK");assert.ok(!(await r.text()).includes("Invalid account count"));}});

test('account list drops unexpected adapter fields',async()=>{fixture();rowOverride={password_hash:'private-adapter-value',tenant_id:'private-adapter-value'};const r=await call();assert.equal(r.status,200);const data=await r.json();assert.deepEqual(Object.keys(data.users[0]).sort(),['id','email','roles','status','updated_at','canModify'].sort());assert.ok(!JSON.stringify(data).includes('private-adapter-value'));});
test('account list rejects corrupt projected fields without coercion',async()=>{for(const row of [{id:null},{id:{}},{email:{}},{roles:null},{status:42},{updated_at:undefined},{updated_at:'invalid'},{updated_at:new Date(NaN)},{updated_at:new Date('+010000-01-01T00:00:00Z')},{updated_at:'2026-02-30T00:00:00Z'}]){fixture();rowOverride=row;const r=await call();assert.equal(r.status,503);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');assert.deepEqual(await r.json(),{error:'Account list unavailable'});}});
