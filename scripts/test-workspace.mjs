import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile,mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const dir=await mkdtemp(join(tmpdir(),'primecare-workspace-'));
await build({entryPoints:['cloudflare/workers/src/workspace.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'workspace.cjs'),
  plugins:[{name:'database-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:`export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__workspaceQuery(sql,values)}}`,loader:'js'}));}}]});
const {workspace,visiblePages,pageAccess}=createRequire(import.meta.url)(join(dir,'workspace.cjs'));
const call=(method='GET',query='',headers={authorization:'Bearer '+'a'.repeat(43)})=>workspace(new Request('https://test/workspace'+query,{method,headers}),{SERVICE_NAME:'governance',DB_URL:'test'},'/workspace',{});
const fixture=(role='ceo',tenant='tenant-a')=>{
 const queries=[];
 globalThis.__workspaceQuery=async(sql,values)=>{
  queries.push({sql,values});
  if(sql.includes('WHERE s.token_hash=$1'))return {rows:role?[{id:'actor',roles:role,tenant_id:tenant}]:[]};
  if(sql.includes('SELECT roles AS role')){assert.deepEqual(values,['tenant-a']);return {rows:[{role:'ceo',count:1},{role:'rmt',count:2}]};}
  if(sql.includes('COUNT(*)::int AS count FROM auth_sessions'))return {rows:[{count:2}]};
  if(sql.includes('FROM auth_account_audit')){assert.deepEqual(values,['tenant-a']);return {rows:[]};}
  if(sql.includes('FROM pg_attribute'))return {rows:[]};
  if(sql.startsWith('SELECT COUNT(*)::int AS count FROM "'))return {rows:[{count:1}]};
  if(!sql.startsWith('BEGIN')&&sql!=='ROLLBACK')assert.fail('Unexpected query '+sql);
  return {rows:[]};
 };return queries;
};
test('every created page has a governed route, sections and grants; readiness is never invented',()=>{
 assert.equal(registry.screens.length,948);
 for(const s of registry.screens.filter(s=>s.renderer!=='account')){
  assert.ok(s.route.startsWith('/'),s.code);assert.ok(s.sections.length,s.code);
  assert.ok(s.grants.length,s.code);assert.equal(s.productionReady,false,s.code);
  assert.ok(s.blockers.length>0,s.code);assert.equal(s.lifecycle,'created');
 }
 const ceo=visiblePages('ceo');assert.ok(ceo.some(p=>p.code==='ceo_dashboard'));
 for(const page of registry.screens.filter(p=>p.code.startsWith('ceo_'))){assert.equal(page.role,'ceo');assert.equal(page.appCode,'co');assert.equal(pageAccess('guest',page.code),403);}
 for(const role of Object.keys(registry.landings))assert.ok(visiblePages(role).some(p=>p.route===registry.landings[role]),role);
});
test('mutations and unauthenticated calls fail before reading the database',async()=>{
 globalThis.__workspaceQuery=()=>assert.fail('Database touched');
 assert.equal((await call('POST')).status,405);
 assert.equal((await call('GET','',{})).status,401);
 assert.equal((await call('GET','',{authorization:'Bearer malformed'})).status,401);
});
test('expired or disabled sessions, missing tenant and cross-tenant headers fail closed',async()=>{
 fixture(null);assert.equal((await call()).status,401);
 fixture('ceo',null);assert.equal((await call()).status,403);
 fixture();assert.equal((await call('GET','',{'authorization':'Bearer '+'a'.repeat(43),'x-tenant-id':'tenant-b'})).status,403);
});
test('unknown and unauthorized screens return real errors',async()=>{
 fixture();assert.equal((await call('GET','?screen=does_not_exist')).status,404);
 fixture('rmt');assert.equal((await call('GET','?screen=ceo_dashboard')).status,403);
 assert.equal((await call('GET','?screen=../ceo_dashboard')).status,400);
});
test('CEO dashboard uses live tenant-scoped counts and never counts unscoped clinical tables',async()=>{
 const queries=fixture();const r=await call('GET','?screen=ceo_dashboard');assert.equal(r.status,200);
 const data=await r.json();assert.equal(data.overview.activeAccounts,3);assert.equal(data.overview.activeSessions,2);
 assert.ok(data.overview.metrics.every(m=>!m.available&&!('count' in m)));
 assert.ok(data.screens.every(p=>p.grants.some(g=>g.role==='ceo'&&g.view)));
 assert.ok(!queries.some(q=>/FROM "(clients|providers|visits|invoices|schedules)"/.test(q.sql)));
 assert.ok(queries.every(q=>!/^INSERT|^UPDATE|^DELETE/.test(q.sql)));
 assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!JSON.stringify(data).includes('test_password'));
});
test('staff cannot obtain organization totals or global page inventory',async()=>{
 const queries=fixture('rmt');const r=await call();const data=await r.json();
 assert.equal(r.status,200);assert.equal(data.overview.activeAccounts,1);assert.equal(data.overview.scope,'personal');
 assert.deepEqual(data.inventory.map(p=>p.code),data.screens.map(p=>p.code));assert.equal(data.overview.metrics.length,0);
 assert.ok(!queries.some(q=>q.sql.includes('SELECT roles AS role')||q.sql.includes('FROM pg_attribute')));
});
test('database errors are unavailable, never a successful fallback',async()=>{
 globalThis.__workspaceQuery=async()=>{throw new Error('private database password');};
 const r=await call();assert.equal(r.status,503);assert.ok(!(await r.text()).includes('private'));
});

test('authorized inventory includes reproducible page requirements and exact pending action details',async()=>{
 fixture();const data=await (await call()).json();
 const page=data.inventory.find(p=>p.code==='ceo_dashboard');
 assert.ok(page.requirements.acceptance_criteria);
 assert.ok(page.contracts.some(a=>a.route==='/v1/governance/workspace'));
 assert.ok(Array.isArray(page.pendingActions));
 fixture('rmt');const staff=await (await call()).json();
 assert.ok(staff.inventory.every(p=>staff.screens.some(s=>s.code===p.code)));
 assert.ok(!staff.inventory.some(p=>p.code==='ceo_dashboard'));
});

test('workspace rejects corrupt counts, groups and aggregate overflow',async()=>{for(const bad of ['2',null,true,-1,1.5,Infinity,Number.MAX_SAFE_INTEGER+1])for(const kind of ['accounts','sessions','metrics']){const queries=fixture();const base=globalThis.__workspaceQuery;globalThis.__workspaceQuery=async(sql,values)=>{const r=await base(sql,values);if(kind==='accounts'&&sql.includes('SELECT roles AS role'))r.rows[0].count=bad;if(kind==='sessions'&&sql.includes('COUNT(*)::int AS count FROM auth_sessions'))r.rows[0].count=bad;if(kind==='metrics'&&sql.includes('FROM pg_attribute'))r.rows=[{attname:'tenant_id'}];if(kind==='metrics'&&sql.startsWith('SELECT COUNT(*)::int AS count FROM "'))return {rows:[{count:bad}]};return r;};const response=await call();assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!(await response.text()).includes('Invalid workspace'));}
 for(const rows of [[{role:'ceo',count:1},{role:'ceo',count:2}],[{role:null,count:1}],[{role:'ceo',count:Number.MAX_SAFE_INTEGER},{role:'rmt',count:1}]]){fixture();const base=globalThis.__workspaceQuery;globalThis.__workspaceQuery=async(sql,values)=>sql.includes('SELECT roles AS role')?{rows}:base(sql,values);assert.equal((await call()).status,503);}});

test('workspace rejects unknown and duplicate query fields before database access',async()=>{globalThis.__workspaceQuery=()=>assert.fail('Database touched');for(const query of ['?screen=ceo_dashboard&screen=ceo_dashboard','?tenant=other','?limit=100','?screen=']){const r=await call('GET',query);assert.equal(r.status,400);assert.equal(r.headers.get('cache-control'),'no-store');}});
