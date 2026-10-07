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
 {batch:320,service:'client',path:'/invoices'},
 {batch:321,service:'client',path:'/payments'},
 {batch:321,service:'client',path:'/invoices/invoice/payments'},
 {batch:322,service:'client',path:'/booking-requests'},
 {batch:323,service:'client',path:'/visits'},
 {batch:324,service:'client',path:'/bookings'},
 {batch:327,service:'provider',path:'/documents'},
 {batch:328,service:'provider',path:'/visits'},
 {batch:329,service:'provider',path:'/availability'},
 {batch:332,summaryBatch:333,service:'provider',path:'/timesheet-items'},
];
const registered=[...registry('client').map(record=>({batch:325,service:'client',path:record.path,record})),...registry('provider').map(record=>({batch:330,service:'provider',path:record.path,record})),...registry('self').map(record=>({batch:331,service:'auth',path:record.path,record}))];
const cases=[...basic,...registered];
const hasSummary=c=>!c.record || (c.service==='client'?c.record.summaryBatch>0:!!c.record.summaryField);
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
 return {calls,async call(suffix='',query='') {
  const path=c.path+suffix;
  const binding=c.service==='client'?'CLIENT':c.service==='provider'?'PROVIDER':'AUTH';
  const publicPath=c.service==='auth'?'/v1/auth'+path:'/v1/'+c.service+path;
  // Account-record routes use the gateway's existing /v1/auth prefix.
  return gateway.fetch(new Request('https://fixture'+publicPath+query,{headers:{authorization:'Bearer '+'A'.repeat(43)}}),{[binding]:{fetch:r=>service.fetch(r,{SERVICE_NAME:c.service,DB_URL:'fixture'})}});
 }};
}
async function rejected(f,suffix='',query='') {
 const r=await f.call(suffix,query);assert.equal(r.status,503);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(r.headers.get('set-cookie'),null);assert.ok(!(await r.text()).includes('private-'));
 assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(c=>c.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(c.sql)));
}
const authority=[{batch:319,service:'client',path:'/home/profile'},{batch:326,service:'provider',path:'/profile'},registered.find(c=>c.batch===330),registered.find(c=>c.batch===331),basic.find(c=>c.batch===332)];
for(const c of authority) {
 test(c.batch+' owned actor requires a single string identity and uncoerced tenant',async()=>{
  for(const change of [rows=>[...rows,...rows],rows=>[{...rows[0],id:1}],rows=>[{...rows[0],id:' bad'}],rows=>[{...rows[0],tenant_id:1}],()=>[null],()=>null]) {
   const f=fixture(c,(sql,rows)=>sql.startsWith('SELECT u.id')?change(rows):undefined);await rejected(f);assert.ok(!f.calls.some(q=>q.sql.startsWith('SELECT COUNT')||q.sql.includes('FROM client_profiles')||q.sql.includes('FROM provider_profiles')));
  }
 });
 if(c.service!=='auth')test(c.batch+' profile identity is validated before any owned record query',async()=>{
  for(const change of [rows=>[...rows,...rows],rows=>[{...rows[0],id:1}],rows=>[{...rows[0],id:' bad'}],()=>[null]]) {
   const f=fixture(c,(sql,rows)=>sql.startsWith('SELECT id,full_name')||sql.startsWith('SELECT id FROM provider_profiles')?change(rows):undefined);await rejected(f);assert.ok(!f.calls.some(q=>q.sql.startsWith('SELECT COUNT')));
  }
 });
}
for(const batch of [320,321,322,323,324,325,327,328,329,330,331,332]) {
 const family=cases.filter(c=>c.batch===batch);
 test(batch+' all owned list pages reject excess or malformed adapter rows',async()=>{
  for(const c of family.filter(c=>!c.record?.singleton))for(const change of [rows=>[...rows,...rows],()=>null,()=>[null]]) {
   const f=fixture(c,(sql,rows)=>sql.includes('ORDER BY')&&!sql.includes('GROUP BY')?change(rows):undefined);await rejected(f,'','?limit=1');
  }
 });
 test(batch+' detail/singleton requires one row and requested record binding',async()=>{
  for(const c of family)for(const change of [rows=>[...rows,...rows],()=>[null],...(!c.record?.singleton?[rows=>[{...rows[0],id:'other'}]]:[])]) {
   const f=fixture(c,(sql,rows)=>sql.startsWith('SELECT')&&!sql.startsWith('SELECT u.id')&&!sql.startsWith('SELECT COUNT')&&!sql.includes('LIMIT 2')&& !sql.includes('ORDER BY')&&!sql.startsWith('SELECT id FROM invoices')?change(rows):c.record?.singleton&&sql.includes('LIMIT 2')&&!sql.startsWith('SELECT id FROM provider_profiles')?change(rows):undefined);
   await rejected(f,c.record?.singleton?'':'/record');
  }
 });
 test(batch+' list count rejects absent, duplicate and nonobject aggregate results',async()=>{
  for(const c of family.filter(c=>!c.record?.singleton))for(const rows of [[],[{count:1},{count:1}],[null],null]) {const f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?rows:undefined);await rejected(f);}
 });
}
for(const batch of [320,321,322,323,324,325,327,328,329,330,331,333])test(batch+' summary pages and counts enforce cardinality and requested bounds',async()=>{
 const family=batch===333?basic.filter(c=>c.summaryBatch===333):cases.filter(c=>c.batch===batch&&!c.record?.singleton&&hasSummary(c));
 for(const c of family) {
  for(const rows of [[],[{count:1},{count:1}],[null],null]) {const f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?rows:undefined);await rejected(f,'/summary');}
  for(const change of [rows=>[...rows,...rows],()=>null,()=>[null]]) {const f=fixture(c,(sql,rows)=>sql.includes('GROUP BY')&&!sql.startsWith('SELECT COUNT')?change(rows):undefined);await rejected(f,'/summary','?limit=1');}
 }
});
test('321 nested payments reject ambiguous or mismatched parent invoice before payment queries',async()=>{
 const c=basic.find(c=>c.path.includes('/invoices/'));
 for(const change of [rows=>[...rows,...rows],()=>[{id:'other'}],()=>[{id:1}]]) {const f=fixture(c,(sql,rows)=>sql.startsWith('SELECT id FROM invoices')?change(rows):undefined);await rejected(f);assert.ok(!f.calls.some(q=>q.sql.includes('FROM payments')));}
});
test('valid boundary pages, summaries, details, and missing records remain unchanged across registries',async()=>{
 for(const c of cases) {
  const paths=c.record?.singleton?['']:['','/record',...(hasSummary(c)?['/summary']:[])];
  for(const suffix of paths) {
   const f=fixture(c);const r=await f.call(suffix,suffix==='/record'||c.record?.singleton?'':'?limit=1');assert.equal(r.status,200,c.service+' '+c.path+suffix);assert.ok(!(await r.text()).includes('private-'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');
  }
 }
});

test('missing actors and profiles preserve existing denial before owned data reads',async()=>{
 for(const c of authority) {
  const missing=fixture(c,sql=>sql.startsWith('SELECT u.id')?[]:undefined);assert.equal((await missing.call()).status,401);
  assert.equal(missing.calls.at(-1).sql,'ROLLBACK');
  if(c.service!=='auth') {
   const noProfile=fixture(c,sql=>sql.startsWith('SELECT id,full_name')||sql.startsWith('SELECT id FROM provider_profiles')?[]:undefined);
   assert.equal((await noProfile.call()).status,404);assert.ok(!noProfile.calls.some(q=>q.sql.startsWith('SELECT COUNT')));
  }
 }
});
test('absent owned details and empty bounded pages retain 404 and zero totals',async()=>{
 for(const c of cases.filter(c=>!c.record?.singleton)) {
  const absent=fixture(c,sql=>sql.includes('id::text=$')&&!sql.startsWith('SELECT id FROM invoices')?[]:undefined);
  assert.equal((await absent.call('/record')).status,404,c.path);
  for(const suffix of ['',...(hasSummary(c)?['/summary']:[])]) {
   const empty=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:0}]:sql.includes('ORDER BY')?[]:undefined);
   const r=await empty.call(suffix,'?limit=1');assert.equal(r.status,200,c.path+suffix);const body=await r.json();assert.equal(body.pagination.total,0);assert.equal(body.pagination.hasMore,false);
   assert.ok(Object.values(body).some(value=>Array.isArray(value)&&value.length===0));assert.equal(empty.calls.at(-1).sql,'ROLLBACK');
  }
 }
});
