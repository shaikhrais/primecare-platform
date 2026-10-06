import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile,mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const catalog=JSON.parse(await readFile('cloudflare/workers/src/governance-api-registry.json','utf8'));
const dir=await mkdtemp(join(tmpdir(),'governance-batch-'));
const plugin={name:'fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__batchQuery(sql,values)}}',loader:'js'}));}};
await build({entryPoints:['cloudflare/workers/src/governance-api.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'batch.cjs'),plugins:[plugin]});
const {governanceApi,parseGovernanceQuery,serviceVerificationSummary}=createRequire(import.meta.url)(join(dir,'batch.cjs'));
const token='a'.repeat(43),env={SERVICE_NAME:'governance',DB_URL:'fixture'};
const call=(path,query='',role='ceo',headers={},method='GET',override={})=>{
 fixture(role);
 return governanceApi(new Request('https://fixture'+path+query,{method,headers:{authorization:'Bearer '+token,...headers}}),{...env,...override},path,{});
};
let queries=[];
function fixture(role='ceo',tenant='tenant-a') {
 queries=[];
 globalThis.__batchQuery=async(sql,values)=>{
  queries.push({sql,values});
  if(sql.includes('WHERE s.token_hash=$1'))return {rows:role?[{id:'actor',roles:role,tenant_id:tenant}]:[]};
  if(sql.includes('SELECT roles AS role')){assert.deepEqual(values,['tenant-a']);return {rows:[{role:'ceo',count:1},{role:'rmt',count:2}]};}
  if(sql.includes('COUNT(*)::int AS count FROM auth_sessions'))return {rows:[{count:2}]};
  if(sql.includes('FROM auth_account_audit')){assert.deepEqual(values,['tenant-a']);return {rows:[]};}
  if(sql.includes('FROM pg_attribute'))return {rows:[]};
  if(!sql.startsWith('BEGIN')&&sql!=='ROLLBACK')assert.fail('Unexpected query '+sql);
  return {rows:[]};
 };
}
test('registered APIs return bounded responses and precise evidence types',async()=>{
 assert.equal(catalog.bindings.length,15);
 for(const {path} of catalog.bindings) {
  const response=await call(path,'?limit=3');assert.equal(response.status,200,path);
  assert.equal(response.headers.get('cache-control'),'no-store');
  const body=await response.json();assert.ok(Array.isArray(body.data));assert.ok(body.data.length<=3);
  assert.equal(body.pagination.limit,3);assert.ok(Number.isInteger(body.pagination.total));
  assert.ok(body.source.catalogVersion);assert.ok(!JSON.stringify(body).includes('test_password'));
  assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>/^INSERT|^UPDATE|^DELETE/.test(q.sql)));
 }
});
test('every endpoint denies unauthenticated, invalid token and mutation requests',async()=>{
 for(const {path} of catalog.bindings) {
  assert.equal((await call(path,'','ceo',{authorization:''})).status,401);
  assert.equal((await call(path,'','ceo',{authorization:'Bearer malformed'})).status,401);
  assert.equal((await call(path,'','ceo',{},'POST')).status,405);
 }
});
test('expired sessions, absent tenant, mismatch and unauthorized roles fail closed',async()=>{
 for(const {path} of catalog.bindings) {
  assert.equal((await call(path,'',null)).status,401);
  assert.equal((await call(path,'','ceo',{'x-tenant-id':'tenant-b'})).status,403);
  assert.equal((await call(path,'','rmt')).status,403);
 }
 fixture('ceo',null);assert.equal((await governanceApi(new Request('https://fixture/page-progress',{headers:{authorization:'Bearer '+token}}),env,'/page-progress',{})).status,403);
});
test('authority is taken from existing permissions; reporting hierarchy adds no grants',async()=>{
 for(const binding of catalog.bindings.filter(b=>b.gate==='inventory'))assert.equal((await call(binding.path,'','governance')).status,200);
 assert.equal((await call('/organization-map','','governance')).status,403);
 const body=await (await call('/organization-map','?limit=100')).json();
 assert.ok(body.data.every(r=>r.inheritsPermissions===false));
 assert.equal(body.data.find(r=>r.role==='rmt').activeAccounts,2);
 assert.equal(body.data.find(r=>r.role==='ceo').supervisor,null);
 assert.equal(body.source.evidenceType,'approved_reporting_and_live_tenant_counts');
});
test('query parsing rejects duplicate, unknown, unbounded and malformed values',async()=>{
 for(const query of ['?limit=101','?limit=-1','?limit=0','?limit=1.5','?offset=100001','?offset=-1','?offset=1e3','?limit=1&limit=2','?unexpected=x','?search='+('a'.repeat(201)),'?search=%00']) {
  assert.equal(parseGovernanceQuery(new URL('https://fixture/'+query)),null,query);
  assert.equal((await call('/screen-health',query)).status,400,query);
 }
});
test('filtering and pagination preserve exact totals and deterministic boundaries',async()=>{
 const first=await (await call('/screen-health','?app=co&role=ceo&limit=2')).json();
 const second=await (await call('/screen-health','?app=co&role=ceo&limit=2&offset=2')).json();
 assert.ok(first.pagination.total>2);assert.equal(first.pagination.total,second.pagination.total);
 assert.ok(first.data.every(r=>r.app==='co'&&r.role==='ceo'));
 assert.ok(first.data.every(a=>second.data.every(b=>b.screen!==a.screen)));
 const empty=await (await call('/screen-health','?search=nonexistent-gibberish')).json();assert.equal(empty.pagination.total,0);assert.equal(empty.pagination.hasMore,false);
 const search=await (await call('/screen-health','?search=ceo_dashboard')).json();assert.ok(search.data.some(r=>r.screen==='ceo_dashboard'));
});
test('progress and pending tasks derive exact registered records rather than synthetic success',async()=>{
 const progress=await (await call('/page-progress','?limit=100')).json();
 assert.equal(progress.data.reduce((sum,r)=>sum+r.total,0),registry.screens.length);
 assert.equal(progress.data.reduce((sum,r)=>sum+r.productionReady,0),0);
 const tasks=await (await call('/pending-tasks','?limit=100')).json();
 assert.ok(tasks.pagination.total>registry.screens.length);assert.ok(tasks.data.every(r=>r.status==='pending'||r.status==='action_pending'));
 const contracts=await (await call('/api-contracts','?search=%2Fv1%2Fgovernance%2Fpage-progress&limit=100')).json();
 assert.equal(contracts.source.evidenceType,'registered_governance');
 assert.ok(contracts.data.some(c=>c.route==='/v1/governance/page-progress'));
 assert.ok(contracts.data.every(c=>'lastRecordedTest' in c&&'recordedHealth' in c&&!('healthy' in c)));
});
test('rate limits, database errors and unrelated services cannot expose private data',async()=>{
 const limited=await call('/page-progress','','ceo',{},'GET',{WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}});
 assert.equal(limited.status,429);assert.equal(limited.headers.get('retry-after'),'60');assert.equal(queries.length,0);
 fixture();globalThis.__batchQuery=async()=>{throw new Error('private database password');};
 const r=await governanceApi(new Request('https://fixture/page-progress',{headers:{authorization:'Bearer '+token}}),env,'/page-progress',{});
 assert.equal(r.status,503);assert.ok(!(await r.text()).includes('private'));
 assert.equal(await call('/page-progress','','ceo',{},'GET',{SERVICE_NAME:'client'}),null);
 assert.equal(await call('/does-not-exist'),null);
});

test('page blueprints expose registered layout, requirements, grants and complete schemas with exact screen filtering',async()=>{
 const expected=registry.screens.find(p=>p.code==='ceo_dashboard');
 const r=await call('/page-blueprints','?screen=ceo_dashboard&limit=100');assert.equal(r.status,200);const body=await r.json();
 assert.ok(body.data.length);assert.ok(body.data.every(p=>p.screen==='ceo_dashboard'));
 const page=body.data.find(p=>p.route===expected.route);assert.deepEqual(page.sections,expected.sections);assert.deepEqual(page.requirements,expected.requirements);assert.deepEqual(page.permissions,expected.grants);assert.deepEqual(page.apis,expected.contracts);
 assert.equal(page.elementBindingsVerified,false);assert.equal(page.bindingEvidence,'registered_only');assert.equal(page.productionReady,false);assert.equal(page.buildSteps.length,6);assert.equal(body.source.evidenceType,'registered_governance');
 assert.ok(page.apis.every(a=>'requestSchema' in a&&'responseSchema' in a));
 const missing=await (await call('/page-blueprints','?screen=does-not-exist')).json();assert.equal(missing.pagination.total,0);
 assert.equal((await call('/page-blueprints','?screen=a&screen=b')).status,400);
});

test('API execution inventory distinguishes declarations, blocks and recorded fixture scope',async()=>{const b=await (await call('/api-execution-status','?limit=100')).json();assert.ok(b.pagination.total>1000);for(const row of b.data){assert.ok(['blocked','unit_fixtures_recorded','verification_pending'].includes(row.verificationState));assert.equal(row.productionVerified,false);assert.equal(row.postgresVerified,false);assert.ok(Array.isArray(row.missingContractFields));assert.ok(Array.isArray(row.screens));}const blocked=await (await call('/api-execution-status','?search=%2Fapi%2Fclients&limit=100')).json();assert.equal(blocked.pagination.total,2);assert.ok(blocked.data.every(row=>row.verificationState==='blocked'));});
test('execution inventory filters linked screens, apps and roles with bounded paging',async()=>{for(const query of ['?screen=client_profile&limit=100','?app=cl&limit=1','?role=ceo&limit=1']){const b=await (await call('/api-execution-status',query)).json();assert.ok(b.pagination.total>0);const [key,value]=query.slice(1).split('&')[0].split('=');for(const row of b.data)assert.ok(row[key==='screen'?'screens':key==='app'?'apps':'roles'].includes(value));}assert.equal((await call('/api-execution-status','?screen=client_profile&screen=psw_profile')).status,400);});
test('execution inventory requires existing inventory authority and tenant matching',async()=>{assert.equal((await call('/api-execution-status','','patient')).status,403);assert.equal((await call('/api-execution-status','','ceo',{'x-tenant-id':'other'})).status,403);assert.equal((await call('/api-execution-status','','ceo',{},'POST')).status,405);});

test('organization map rejects corrupt and duplicate role counts',async()=>{for(const rows of [...['2',null,true,-1,1.5,Infinity,Number.MAX_SAFE_INTEGER+1].map(count=>[{role:'ceo',count}]),[{role:'ceo',count:1},{role:'ceo',count:2}],[{role:null,count:1}]]){fixture();const base=globalThis.__batchQuery;globalThis.__batchQuery=async(sql,values)=>sql.includes('SELECT roles AS role')?{rows}:base(sql,values);const r=await governanceApi(new Request('https://fixture/organization-map',{headers:{authorization:'Bearer '+token}}),env,'/organization-map',{});assert.equal(r.status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.equal(r.headers.get('cache-control'),'no-store');assert.ok(!(await r.text()).includes('Invalid workspace'));}});

test('service status preserves all declarations without assigning Prisma labels to a service',async()=>{const inventory=JSON.parse(await readFile('cloudflare/workers/src/api-execution-inventory.json','utf8'));const rows=serviceVerificationSummary(inventory.data);assert.equal(rows.length,13);assert.equal(rows.filter(r=>r.gatewayBound).length,12);assert.equal(rows.reduce((sum,r)=>sum+r.declaredOperations,0),inventory.data.length);assert.ok(rows.find(r=>r.service==='unassigned').unmappedServiceLabels.includes('PRISMA'));assert.ok(rows.every(r=>r.productionVerified===false&&r.postgresVerified===false));const r=await call('/api-service-status','?limit=100');assert.equal(r.status,200);assert.deepEqual((await r.json()).data,rows);});
test('service status filters operation rows before aggregation and pages group rows',async()=>{const r=await call('/api-service-status','?search=no-such-operation-unique&limit=100');const body=await r.json();assert.equal(body.pagination.total,13);assert.ok(body.data.every(r=>r.declaredOperations===0));const page=await (await call('/api-service-status','?offset=12&limit=1')).json();assert.equal(page.data[0].service,'unassigned');assert.equal(page.pagination.hasMore,false);});


test('page progress filters source screens before aggregating application groups',async()=>{
 for(const query of ['?role=ceo&limit=100','?screen=ceo_dashboard&limit=100','?app=co&role=ceo&limit=100','?search=ceo_dashboard&limit=100']) {
  const source=await (await call('/screen-health',query)).json();
  const progress=await (await call('/page-progress',query)).json();
  assert.ok(source.data.length>0,query);
  assert.equal(progress.data.reduce((sum,row)=>sum+row.total,0),source.pagination.total,query);
  for(const row of progress.data){const screens=source.data.filter(screen=>screen.app===row.app);assert.equal(row.total,screens.length);assert.equal(row.pagesWithBlockers,screens.filter(screen=>screen.blockers.length).length);}
 }
 const missing=await (await call('/page-progress','?screen=missing-screen-unique')).json();assert.deepEqual(missing.data,[]);assert.equal(missing.pagination.total,0);
 const full=await (await call('/page-progress','?role=ceo&limit=100')).json();
 const page=await (await call('/page-progress','?role=ceo&limit=1&offset=1')).json();assert.deepEqual(page.data,full.data.slice(1,2));assert.equal(page.pagination.total,full.pagination.total);assert.equal(page.pagination.hasMore,2<full.pagination.total);
});


test('role coverage scopes granted pages before counting and retains zero-coverage roles',async()=>{
 for(const scope of ['?app=co&role=ceo&limit=100','?screen=ceo_dashboard&role=ceo&limit=100','?app=co&screen=ceo_dashboard&role=ceo&limit=100']) {
  const response=await call('/role-coverage',scope);assert.equal(response.status,200);const body=await response.json();assert.equal(body.pagination.total,1);
  const query=new URL('https://fixture/'+scope).searchParams;
  const expected=registry.screens.filter(page=>page.grants.some(grant=>grant.role==='ceo'&&grant.view)&&(!query.get('app')||page.appCode===query.get('app'))&&(!query.get('screen')||page.code===query.get('screen')));
  assert.ok(expected.length>0);assert.equal(body.data[0].authorizedPages,expected.length);assert.equal(body.data[0].landingAuthorized,expected.some(page=>page.route===body.data[0].landing));
 }
 const empty=await (await call('/role-coverage','?app=no-such-app&role=ceo')).json();assert.equal(empty.pagination.total,1);assert.equal(empty.data[0].authorizedPages,0);assert.equal(empty.data[0].landingAuthorized,false);
 const all=await (await call('/role-coverage','?screen=ceo_dashboard&limit=100')).json();assert.equal(all.pagination.total,catalog.roles.length);assert.ok(all.data.some(row=>row.authorizedPages===0));
});
