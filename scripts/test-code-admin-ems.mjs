import {test} from 'node:test';import assert from 'node:assert/strict';
import {build} from 'esbuild';import {mkdtemp,readFile} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const definition=JSON.parse(await readFile('packages/shared/src/endpoint-management/contract.json','utf8')),pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
const dir=await mkdtemp(join(tmpdir(),'code-admin-ems-'));
const plugin={name:'db-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__emsQuery(sql,values)}}',loader:'js'}));}};
await build({entryPoints:['cloudflare/workers/src/code-admin-ems.ts','cloudflare/workers/src/code-admin-ems-policy.ts'],bundle:true,platform:'node',format:'cjs',outdir:dir,plugins:[plugin]});
const {codeAdminEms}=createRequire(import.meta.url)(join(dir,'code-admin-ems.js'));const {emsPermissionQuery}=createRequire(import.meta.url)(join(dir,'code-admin-ems-policy.js'));
const token='a'.repeat(43),env={SERVICE_NAME:'governance',DB_URL:'fixture'};
let queries=[],role='code_admin',grant=true,manifest=true,tenant='control-tenant',actor=true;
function reset(){queries=[];role='code_admin';grant=true;manifest=true;tenant='control-tenant';actor=true;globalThis.__emsQuery=async(sql,values)=>{
 queries.push({sql,values});
 if(sql.includes('WHERE s.token_hash=$1'))return {rows:actor?[{id:'admin',roles:role,tenant_id:tenant}]:[]};
 if(sql.includes('SELECT manifest_sha256'))return {rows:[{manifest_sha256:manifest?pin.manifestSha256:'mismatch'}]};
 if(sql.includes('SELECT DISTINCT')){assert.equal(values[0],'admin');assert.equal(values[1],tenant);assert.equal(values[2],definition.screenCode);assert.equal(values[3],definition.route);assert.match(values[5],/^\/v1\/governance\/platform\/ems\//);return {rows:grant?[{role_id:'72',screen_id:'2000',api_id:'3000'}]:[]};}
 if(sql.includes('govt_api_endpoints'))return {rows:definition.operations.map((op,i)=>({id:String(3000+i),route_path:op.path,http_method:'GET',endpoint_code:op.code,service_name:'governance',auth_required:'1',permission_key:'role_screen_permissions',implementation_status:'implemented',request_schema:'{"type":"object"}',response_schema:'{"type":"object"}'}))};
 assert.ok(sql.startsWith('BEGIN')||sql==='ROLLBACK',sql);return {rows:[]};
};}
const call=(name='summary',{query='',method='GET',headers={},extra={}}={})=>codeAdminEms(new Request('https://fixture/platform/ems/'+name+query,{method,headers:{authorization:'Bearer '+token,...headers}}),{...env,...extra},'/platform/ems/'+name,{});
test('all six read contracts require native Code Admin plus exact registered grants',async()=>{
 assert.equal(definition.operations.length,6);
 for(const op of definition.operations){reset();const response=await call(op.name);assert.equal(response.status,200,op.name);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(queries.every(q=>!/^INSERT|UPDATE|DELETE/.test(q.sql)));
  reset();grant=false;assert.equal((await call(op.name)).status,403);
  for(const deniedRole of ['tenant_admin','platform_admin','central_admin','ceo','governance','psw']){reset();role=deniedRole;assert.equal((await call(op.name)).status,403);assert.ok(!queries.some(q=>q.sql.includes('SELECT DISTINCT')));}
 }
});
test('missing sessions, tenant overrides, unknown query fields, duplicate fields and writes fail closed',async()=>{
 reset();assert.equal((await call('summary',{headers:{authorization:''}})).status,401);assert.equal(queries.length,0);
 reset();actor=false;assert.equal((await call()).status,401);
 reset();tenant=null;assert.equal((await call()).status,403);
 for(const options of [{query:'?limit=1'},{headers:{'x-tenant-id':'other'}}]){reset();assert.equal((await call('summary',options)).status,400);assert.equal(queries.length,0);}
 for(const query of ['?limit=101','?limit=1&limit=2','?tenant=other']){reset();assert.equal((await call('endpoints',{query})).status,400);}
 for(const method of ['POST','PATCH','DELETE']){reset();const response=await call('summary',{method});assert.equal(response.status,405);assert.equal(response.headers.get('allow'),'GET');assert.equal(queries.length,0);}
 reset();assert.equal((await call('unknown')).status,404);
});
test('summary is reconciled catalog evidence and paged endpoints do not imply production readiness',async()=>{
 reset();const data=await (await call()).json();assert.ok(data.declarations>0);assert.ok(data.uniqueOperations<=data.declarations);assert.equal(Object.values(data.readiness).reduce((a,b)=>a+b,0),data.declarations);assert.equal(data.readiness.ready??0,0);const emsRows=await (await call('endpoints',{query:'?search=/platform/ems/&limit=100'})).json();assert.equal(emsRows.data.length,6);assert.ok(emsRows.data.every(row=>row.registrationSource==='live_ems_metadata'));
 const page=await (await call('endpoints',{query:'?limit=2&offset=1'})).json();assert.equal(page.data.length,2);assert.equal(page.pagination.offset,1);assert.ok(page.data.every(row=>row.productionVerified===false));
 const services=await (await call('services',{query:'?limit=100'})).json();assert.equal(services.data.reduce((n,row)=>n+row.declaredOperations,0),data.declarations);
 const maintenance=await (await call('maintenance')).json();assert.equal(maintenance.trafficEnforced,false);
});
test('capacity and traffic stay unknown without evidence and provider failures never leak credentials',async()=>{
 reset();assert.equal((await (await call('capacity')).json()).status,'unmeasured');assert.equal((await (await call('traffic')).json()).status,'not_configured');
 const original=globalThis.fetch;let requests=0;globalThis.fetch=async()=>{requests++;return new Response('private-provider-error',{status:403});};
 try{const extra={ENDPOINT_ANALYTICS_READER_ROLE:'code_admin',ENDPOINT_ANALYTICS_READER_TENANT_ID:'other',ENDPOINT_ANALYTICS_ACCOUNT_ID:'a'.repeat(32),ENDPOINT_ANALYTICS_READ_TOKEN:'private-token'};
  assert.equal((await (await call('traffic',{extra})).json()).status,'not_configured');assert.equal(requests,0);
  extra.ENDPOINT_ANALYTICS_READER_TENANT_ID=tenant;const result=await (await call('traffic',{extra})).json();assert.equal(result.status,'unavailable');assert.ok(!JSON.stringify(result).includes('private'));
 }finally{globalThis.fetch=original;}
 assert.equal((await (await call('capacity',{extra:{ENDPOINT_CAPACITY_EVIDENCE:'invalid'}})).json()).status,'unavailable');
});
test('manifest drift, invalid grant projections and source limiter failures cannot expose EMS data',async()=>{
 reset();manifest=false;assert.equal((await call()).status,503);
 reset();const before=globalThis.__emsQuery;globalThis.__emsQuery=async(sql,args)=>sql.includes('SELECT DISTINCT')?{rows:[{role_id:'bad',screen_id:'1',api_id:'1'}]}:before(sql,args);assert.equal((await call()).status,403);
 reset();const response=await call('summary',{extra:{WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}}});assert.equal(response.status,429);assert.equal(queries.length,0);
});
test('permission query binds role, tenant, screen route, both apps, API code and exact method/path',()=>{
 const statement=emsPermissionQuery({id:'admin',tenantId:'control-tenant'},'GET',definition.operations[0].path);
 assert.deepEqual(statement.values,['admin','control-tenant',definition.screenCode,definition.route,'GET',definition.operations[0].path,definition.operations[0].code]);
 for(const fragment of ["u.roles::text='code_admin'","'go'","'gv'","auth_required","can_view","can_access",'COUNT(*)'])assert.ok(statement.text.includes(fragment),fragment);
 assert.throws(()=>emsPermissionQuery({id:'admin',tenantId:'control-tenant'},'POST',definition.operations[0].path));
});
