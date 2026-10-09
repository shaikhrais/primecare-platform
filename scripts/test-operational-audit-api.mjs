import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
const records=JSON.parse(readFileSync('cloudflare/workers/src/self-records-registry.json','utf8')).filter(r=>r.summaryBatch>=96&&r.summaryBatch<=97);
assert.deepEqual(records.map(r=>r.summaryBatch).sort(),[96,97]);
const plugin={name:'fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(s,v){return globalThis.__operationalAuditQuery(s,v)}}',loader:'js'}));}};
async function bundle(path,plugins=[]){const result=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));}
const {selfRecords}=await bundle('cloudflare/workers/src/self-records.ts',[plugin]);
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const {default:service}=await bundle('cloudflare/workers/src/service.ts',[plugin]);
const token='s'.repeat(43),env={SERVICE_NAME:'auth',DB_URL:'fixture'};
let actor,groups,total,queries,failure;
function fixture(record){
 actor={id:'actor-user',tenant_id:'actor-tenant'};groups=[{status:'COMPLETED',count:1},{status:'PENDING',count:2}];total=2;queries=[];failure=false;
 globalThis.__operationalAuditQuery=async(sql,values)=>{
  queries.push({sql,values});if(failure)throw Error('private-password-and-clinical-data');
  if(sql.startsWith('SELECT u.id'))return {rows:actor?[actor]:[]};
  if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY'||sql==='ROLLBACK')return {rows:[]};
  assert.ok(sql.includes('FROM '+record.table+' WHERE '+record.ownerField+'::text=$1 AND tenant_id::text=$2'));
  assert.deepEqual(values.slice(0,2),['actor-user','actor-tenant']);
  assert.ok(sql.includes('GROUP BY status'));
  // Summary SQL never selects the record contents, IDs or a profile owner.
  assert.ok(!sql.includes('provider_id::text=$1'));
  if(sql.startsWith('SELECT COUNT(*)'))return {rows:[{count:total}]};
  assert.ok(sql.startsWith('SELECT status,COUNT(*)::int AS count'));
  assert.ok(sql.includes('ORDER BY status NULLS LAST LIMIT $3 OFFSET $4'));
  return {rows:groups.slice(values[3],values[3]+values[2])};
 };
}
const call=(r,query='',headers={},method='GET',extra={})=>selfRecords(new Request('https://fixture'+r.path+'/summary'+query,{method,headers:{authorization:'Bearer '+token,...headers}}),{...env,...extra},r.path+'/summary',{});
for(const record of records){
 test(record.path+' summary binds actor and tenant in a read-only snapshot',async()=>{fixture(record);const response=await call(record,'?limit=1&offset=1');assert.equal(response.status,200);assert.equal(response.headers.get('cache-control'),'no-store');assert.deepEqual(await response.json(),{groups:[{status:'PENDING',count:2}],pagination:{limit:1,offset:1,total:2,hasMore:false}});assert.equal(queries[0].sql,'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');assert.equal(queries.at(-1).sql,'ROLLBACK');});
 test(record.path+' summary preserves nullable stored statuses and rejects unexpected nulls',async()=>{fixture(record);groups=[{status:null,count:3}];total=1;const response=await call(record);const nullable=record.types.status.includes('null');assert.equal(response.status,nullable?200:503);if(nullable)assert.deepEqual((await response.json()).groups,groups);});
 test(record.path+' summary handles empty and out-of-range group pages',async()=>{fixture(record);groups=[];total=0;assert.deepEqual(await (await call(record)).json(),{groups:[],pagination:{limit:25,offset:0,total:0,hasMore:false}});fixture(record);const body=await (await call(record,'?offset=100000')).json();assert.deepEqual(body.groups,[]);assert.equal(body.pagination.total,2);assert.equal(body.pagination.hasMore,false);});
 test(record.path+' summary requires active bearer and matching non-null tenant',async()=>{fixture(record);assert.equal((await call(record,'',{authorization:''})).status,401);assert.equal(queries.length,0);fixture(record);actor=null;assert.equal((await call(record)).status,401);fixture(record);actor.tenant_id=null;assert.equal((await call(record)).status,403);fixture(record);assert.equal((await call(record,'',{'x-tenant-id':'foreign'})).status,403);});
 test(record.path+' summary rejects owner filters, malformed paging and writes before queries',async()=>{for(const query of ['?userId=foreign','?tenant_id=foreign','?role=ceo','?status=PENDING','?limit=0','?limit=101','?offset=100001','?offset=-1','?limit=1&limit=2']){fixture(record);assert.equal((await call(record,query)).status,400);assert.equal(queries.length,0);}for(const method of ['POST','PUT','PATCH','DELETE']){fixture(record);assert.equal((await call(record,'',{},method)).status,405);assert.equal(queries.length,0);}});
 test(record.path+' summary rejects malformed group values and counts',async()=>{for(const group of [{count:1},{status:4,count:1},{status:'PENDING',count:-1},{status:'PENDING',count:1.5},{status:'PENDING',count:Number.MAX_SAFE_INTEGER+1}]){fixture(record);groups=[group];assert.equal((await call(record)).status,503);}for(const count of [-1,NaN,Infinity]){fixture(record);total=count;assert.equal((await call(record)).status,503);}});
 test(record.path+' summary throttles and sanitizes database failures',async()=>{fixture(record);const response=await call(record,'',{},'GET',{WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}});assert.equal(response.status,429);assert.equal(response.headers.get('retry-after'),'60');assert.equal(queries.length,0);fixture(record);failure=true;const failed=await call(record);assert.equal(failed.status,503);assert.ok(!(await failed.text()).includes('private'));});
 test(record.path+' summary forwards through the API gateway with bearer unchanged',async()=>{fixture(record);let forwarded;const response=await gateway.fetch(new Request('https://gateway/v1/auth'+record.path+'/summary',{headers:{authorization:'Bearer '+token}}),{AUTH:{fetch:async request=>{forwarded=request;return service.fetch(request,env);}}});assert.equal(response.status,200);assert.equal(new URL(forwarded.url).pathname,record.path+'/summary');assert.equal(forwarded.headers.get('authorization'),'Bearer '+token);});
}
const bootstrap=JSON.parse(readFileSync('cloudflare/workers/src/self-records-registry.json','utf8')).find(r=>r.listBatch===100);
assert.deepEqual(bootstrap.fields,['created_at']);assert.equal(bootstrap.singleton,true);
let bootstrapRows;
function bootstrapFixture(){
 actor={id:'actor-user',tenant_id:'actor-tenant'};queries=[];bootstrapRows=[{created_at:'2026-01-01T12:00:00Z',user_id:'private-user',tenant_id:'private-tenant',source:'protected_workflow'}];
 globalThis.__operationalAuditQuery=async(sql,values)=>{
  queries.push({sql,values});if(sql.startsWith('SELECT u.id'))return {rows:actor?[actor]:[]};
  if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY'||sql==='ROLLBACK')return {rows:[]};
  assert.equal(sql,'SELECT created_at FROM auth_bootstrap_audit WHERE user_id::text=$1 AND tenant_id::text=$2 LIMIT 2');assert.deepEqual(values,['actor-user','actor-tenant']);return {rows:bootstrapRows};
 };
}
const bootstrapCall=(query='',headers={},method='GET',extra={})=>selfRecords(new Request('https://fixture'+bootstrap.path+query,{method,headers:{authorization:'Bearer '+token,...headers}}),{...env,...extra},bootstrap.path,{});
test('bootstrap record projects the historical creation timestamp only',async()=>{bootstrapFixture();const response=await bootstrapCall();assert.equal(response.status,200);assert.equal(response.headers.get('cache-control'),'no-store');assert.deepEqual(await response.json(),{bootstrap:{created_at:'2026-01-01T12:00:00Z'}});assert.equal(queries[0].sql,'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');assert.equal(queries.at(-1).sql,'ROLLBACK');});
test('bootstrap record absence is 404 and duplicate/malformed data is unavailable',async()=>{bootstrapFixture();bootstrapRows=[];assert.equal((await bootstrapCall()).status,404);bootstrapFixture();bootstrapRows.push(bootstrapRows[0]);assert.equal((await bootstrapCall()).status,503);for(const row of [{},{created_at:null},{created_at:'invalid-date'}]){bootstrapFixture();bootstrapRows=[row];assert.equal((await bootstrapCall()).status,503);}});
test('bootstrap record requires an active bearer and matching non-null tenant',async()=>{bootstrapFixture();assert.equal((await bootstrapCall('',{authorization:''})).status,401);assert.equal(queries.length,0);bootstrapFixture();actor=null;assert.equal((await bootstrapCall()).status,401);bootstrapFixture();actor.tenant_id=null;assert.equal((await bootstrapCall()).status,403);bootstrapFixture();assert.equal((await bootstrapCall('',{'x-tenant-id':'foreign'})).status,403);});
test('bootstrap record rejects filters and writes before querying',async()=>{for(const query of ['?user_id=foreign','?tenant_id=foreign','?role=ceo','?limit=1','?offset=1']){bootstrapFixture();assert.equal((await bootstrapCall(query)).status,400);assert.equal(queries.length,0);}for(const method of ['POST','PUT','PATCH','DELETE']){bootstrapFixture();assert.equal((await bootstrapCall('',{},method)).status,405);assert.equal(queries.length,0);}});
test('bootstrap record throttles and sanitizes failures',async()=>{bootstrapFixture();const response=await bootstrapCall('',{},'GET',{WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}});assert.equal(response.status,429);assert.equal(queries.length,0);bootstrapFixture();globalThis.__operationalAuditQuery=async()=>{throw Error('private credential')};const failed=await bootstrapCall();assert.equal(failed.status,503);assert.ok(!(await failed.text()).includes('private'));});
test('bootstrap record gateway forwards only the registered singleton route',async()=>{bootstrapFixture();let forwarded;const response=await gateway.fetch(new Request('https://gateway/v1/auth'+bootstrap.path,{headers:{authorization:'Bearer '+token}}),{AUTH:{fetch:async request=>{forwarded=request;return service.fetch(request,env);}}});assert.equal(response.status,200);assert.equal(new URL(forwarded.url).pathname,bootstrap.path);assert.equal(forwarded.headers.get('authorization'),'Bearer '+token);assert.equal(await selfRecords(new Request('https://fixture'+bootstrap.path+'/extra'),env,bootstrap.path+'/extra',{}),null);});
