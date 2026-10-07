import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
const registry=name=>JSON.parse(readFileSync('cloudflare/workers/src/'+name+'-records-registry.json','utf8'));
const plugin={name:'owned-result-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({loader:'js',contents:'export class Client {async connect(){} async end(){} query(s,v){return globalThis.__ownedResultQuery(s,v)}}'}));}};
async function bundle(path,plugins=[]){const r=await build({entryPoints:[path],plugins,bundle:true,write:false,platform:'node',format:'esm'});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {default:service}=await bundle('cloudflare/workers/src/service.ts',[plugin]),{default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const date='2026-01-01T12:00:00Z';
const basic=[
 {batch:639,service:'client',path:'/invoices'}, {batch:640,service:'client',path:'/payments'}, {batch:641,service:'client',path:'/invoices/invoice/payments'}, {batch:642,service:'client',path:'/booking-requests'}, {batch:643,service:'client',path:'/visits'}, {batch:644,service:'client',path:'/bookings'},
 {batch:645,service:'provider',path:'/documents'}, {batch:646,service:'provider',path:'/visits'}, {batch:647,service:'provider',path:'/availability'}, {batch:648,service:'provider',path:'/timesheet-items'},
];
const registered=[...registry('client').map((record,index)=>({batch:649+index,service:'client',path:record.path,record})),...registry('provider').filter(record=>!record.singleton).map((record,index)=>({batch:676+index,service:'provider',path:record.path,record}))];
const personal=[...registry('self').map(record=>({service:'auth',path:record.path,record})),...registry('provider').filter(record=>record.singleton).map(record=>({service:'provider',path:record.path,record}))];
const cases=[...basic,...registered];
const hasSummary=c=>!c.record||(c.service==='client'?c.record.summaryBatch>0:!!c.record.summaryField);
function fixture(c,change=()=>undefined) {
 const calls=[];
 const profile={id:'profile',full_name:'Fixture',city:null,province:null,postal_code:null,updated_at:date,bio:null,languages:'English',service_areas:'Hamilton',provider_type:'rmt',is_approved:true,skills:'Massage'};
 const row=c.record?Object.fromEntries(c.record.fields.map(field=>{
  const types=Array.isArray(c.record.types[field])?c.record.types[field]:[c.record.types[field]];
  return [field,types.includes('null')?null:c.record.dateFields.includes(field)?date:types.includes('integer')?1:types.includes('number')?1.5:types.includes('boolean')?false:field==='id'?'record':'fixture'];
 })):{id:'record',status:'pending',currency:'CAD',subtotal:'10.00',tax:'1.30',total:'11.30',amount:'11.30',created_at:date,updated_at:date,service_id:'service',requested_start_at:date,duration_minutes:60,priority:'normal',service_type:'massage',preferred_date:date,preferred_time:null,start_at:date,end_at:date,recurrence_rule:null,doc_type:'credential',expiry_date:null,verified_at:date,day_of_week:1,start_time:'09:00',end_time:'17:00',minutes:10};
 row.private='private-adapter-field';
 const group=c.record?{[c.record.summaryField??'status']:row[c.record.summaryField??'status'],count:1}:{status:'pending',count:1,day_of_week:1,durationMinutes:'60',totalMinutes:'10',currency:'CAD',invoiceCount:1,subtotal:'10.00',tax:'1.30',total:'11.30'};
 globalThis.__ownedResultQuery=async(sql,values)=>{
  calls.push({sql,values});let rows=[];
  if(sql.startsWith('SELECT u.id'))rows=[{id:'actor',tenant_id:'tenant',roles:'rmt'}];
  else if(sql.startsWith('SELECT id,full_name')||sql.startsWith('SELECT id FROM provider_profiles'))rows=[profile];
  else if(sql.startsWith('SELECT id FROM invoices'))rows=[{id:'invoice'}];
  else if(sql.startsWith('SELECT COUNT'))rows=[{count:1}];
  else if(sql.includes('GROUP BY'))rows=[group];
  else if(sql.startsWith('SELECT'))rows=[row];
  const replacement=change(sql,rows,values);return {rows:replacement===undefined?rows:replacement};
 };
 return {calls,async call(suffix='',query='',headers={}) {
  const path=c.path+suffix;
  const binding=c.service==='client'?'CLIENT':c.service==='provider'?'PROVIDER':'AUTH';
  const publicPath=c.service==='auth'?'/v1/auth'+path:'/v1/'+c.service+path;
  // Account-record routes use the gateway's existing /v1/auth prefix.
  return gateway.fetch(new Request('https://fixture'+publicPath+query,{headers:{authorization:'Bearer '+'A'.repeat(43),...headers}}),{[binding]:{fetch:r=>service.fetch(r,{SERVICE_NAME:c.service,DB_URL:'fixture'})}});
 }};
}
async function rejected(f,suffix='',query='') {
 const response=await f.call(suffix,query);assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);assert.ok(!(await response.text()).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(q.sql)));
}
const isData=sql=>sql.startsWith('SELECT')&&!sql.startsWith('SELECT u.id')&&!sql.startsWith('SELECT COUNT')&&!sql.startsWith('SELECT id,full_name')&&!sql.startsWith('SELECT id FROM provider_profiles')&&!sql.startsWith('SELECT id FROM invoices');
const paths=c=>c.record?.singleton?['']:['','/record',...(hasSummary(c)?['/summary']:[])];

const invalidTenants=[' ',' bad','tenant/other','tenant.other','tenant\nother','a'.repeat(201),1,false,{},[]];
const actorQuery=sql=>sql.startsWith('SELECT u.id');
async function malformedScopes(family) {
 for(const c of family)for(const suffix of paths(c))for(const tenant of invalidTenants) {
  const f=fixture(c,(sql,rows)=>actorQuery(sql)?[{...rows[0],tenant_id:tenant}]:undefined);await rejected(f,suffix);
  assert.ok(!f.calls.some(q=>q.sql.startsWith('SELECT')&&!actorQuery(q.sql)),'invalid authority must stop before owned SQL');
 }
}
async function deniedScopes(family) {
 for(const c of family)for(const suffix of paths(c)) {
  for(const tenant of [null,undefined,'']) {
   const f=fixture(c,(sql,rows)=>actorQuery(sql)?[{...rows[0],tenant_id:tenant}]:undefined);const r=await f.call(suffix);assert.equal(r.status,403);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql.startsWith('SELECT')&&!actorQuery(q.sql)));
  }
  const f=fixture(c);const r=await f.call(suffix,'',{'x-tenant-id':'other'});assert.equal(r.status,403);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql.startsWith('SELECT')&&!actorQuery(q.sql)));
 }
}
async function validScopes(family) {
 for(const c of family)for(const suffix of paths(c))for(const tenant of ['tenant-hq','123e4567-e89b-12d3-a456-426614174000']) {
  const f=fixture(c,(sql,rows)=>actorQuery(sql)?[Object.freeze(Object.assign(Object.create(null),{...rows[0],tenant_id:tenant}))]:undefined);const r=await f.call(suffix,'',{'x-tenant-id':tenant});assert.equal(r.status,200,c.path+suffix);assert.ok(!(await r.text()).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(f.calls.some(q=>q.sql.startsWith('SELECT')&&!actorQuery(q.sql)&&q.values?.includes(tenant)),'scope must reach parameterized ownership SQL');
 }
}
assert.equal(cases.length,50);
for(let batch=639;batch<=688;batch++) {
 const family=cases.filter(c=>c.batch===batch);assert.equal(family.length,1);
 test('batch '+batch+' malformed tenant authority stops before owned queries',()=>malformedScopes(family));
 test('batch '+batch+' absent and mismatched tenant scope retains denial',()=>deniedScopes(family));
 test('batch '+batch+' UUID/text tenant identities preserve owned reads',()=>validScopes(family));
}
test('personal records and provider singleton reject malformed tenant authority',()=>malformedScopes(personal));
test('personal records and provider singleton retain absent/mismatched tenant denial',()=>deniedScopes(personal));
test('personal records and provider singleton bind valid UUID/text tenant scope',()=>validScopes(personal));
const {scopedActor}=await bundle('cloudflare/workers/src/database-results.ts');
const {privilegedActor}=await bundle('cloudflare/workers/src/auth-projection.ts');
test('tenant identity boundaries share the account identifier grammar',()=>{for(const tenant_id of invalidTenants)assert.throws(()=>scopedActor([{id:'actor',tenant_id}]));for(const tenant_id of ['a','tenant-hq','a'.repeat(200)])assert.deepEqual(scopedActor([{id:'actor',tenant_id}]),{id:'actor',tenant_id});});
test('missing tenant values retain a null scope',()=>{for(const tenant_id of [null,undefined,''])assert.deepEqual(scopedActor([{id:'actor',tenant_id}]),{id:'actor',tenant_id:null});});
test('privileged actor validation rejects malformed tenant authority',()=>{for(const tenant_id of invalidTenants)assert.throws(()=>privilegedActor([{id:'actor',roles:'ceo',tenant_id}]));});
test('privileged actor validation preserves valid tenant claims',()=>{assert.equal(privilegedActor([{id:'actor',roles:'ceo',tenant_id:'tenant-hq'}]).tenant_id,'tenant-hq');});
for(const [kind,tenants,status] of [['malformed',invalidTenants,503],['missing',[null,undefined,''],403]])test('administrative readers preserve '+kind+' tenant authority boundaries',async()=>{
 for(const path of ['/admin/users','/admin/users/audit','/admin/users/creation-audit','/admin/users/target/sessions'])for(const tenant_id of tenants) {
  const calls=[];globalThis.__ownedResultQuery=async(sql)=>{calls.push(sql);return {rows:sql.startsWith('SELECT')?[{id:'actor',roles:'ceo',tenant_id}]:[]};};
  const r=await gateway.fetch(new Request('https://fixture/v1'+path,{headers:{authorization:'Bearer '+'A'.repeat(43)}}),{AUTH:{fetch:r=>service.fetch(r,{SERVICE_NAME:'auth',DB_URL:'fixture'})}});assert.equal(r.status,status,path);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(calls.at(-1),'ROLLBACK');assert.equal(calls.filter(sql=>sql.startsWith('SELECT')).length,1);
 }
});
