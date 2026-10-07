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
 {batch:389,service:'client',path:'/invoices'}, {batch:390,service:'client',path:'/payments'}, {batch:391,service:'client',path:'/invoices/invoice/payments'}, {batch:392,service:'client',path:'/booking-requests'}, {batch:393,service:'client',path:'/visits'}, {batch:394,service:'client',path:'/bookings'},
 {batch:395,service:'provider',path:'/documents'}, {batch:396,service:'provider',path:'/visits'}, {batch:397,service:'provider',path:'/availability'}, {batch:398,service:'provider',path:'/timesheet-items'},
];
const providerFamilies={426:['/conversation-threads'],427:['/timesheets'],428:['/availability-overrides'],429:['/mileage-logs'],430:['/payouts'],431:['/performance-reviews'],432:['/visit-check-events','/fleet-status'],433:['/visit-matches','/shift-assignment-records'],434:['/handover-records','/authored-visit-note-records','/authored-checklist-records','/training-assignment-records']};
const registered=[...registry('client').map((record,index)=>({batch:399+index,service:'client',path:record.path,record})),...registry('provider').map(record=>({batch:Number(Object.keys(providerFamilies).find(b=>providerFamilies[b].includes(record.path))),service:'provider',path:record.path,record})),...registry('self').map((record,index)=>({batch:index<10?435:index<21?436:index<28?437:438,service:'auth',path:record.path,record})).filter(c=>c.record.fields.includes('id'))];
const cases=[...basic,...registered];
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
async function rejected(f) {
 const response=await f.call();assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);assert.ok(!(await response.text()).includes('private'));
 assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(q.sql)));
}
const isRecord=(sql)=>sql.startsWith('SELECT')&&!sql.startsWith('SELECT u.id')&&!sql.startsWith('SELECT COUNT')&&!sql.startsWith('SELECT id,full_name')&&!sql.startsWith('SELECT id FROM provider_profiles')&&!sql.startsWith('SELECT id FROM invoices')&&!sql.includes('GROUP BY');
for(let batch=389;batch<=438;batch++) {
 const family=cases.filter(c=>c.batch===batch);assert.ok(family.length,'Unmapped batch '+batch);
 test('batch '+batch+' record identities reject malformed values before serialization',async()=>{
  for(const c of family)for(const id of ['',1,null,' bad','x'.repeat(201),{}]){const f=fixture(c,(sql,rows)=>isRecord(sql)?rows.map(r=>({...r,id})):undefined);await rejected(f);}
 });
 test('batch '+batch+' record pages reject duplicate IDs within the requested limit',async()=>{
  for(const c of family){const f=fixture(c,(sql,rows)=>isRecord(sql)?[rows[0],{...rows[0]}]:undefined);await rejected(f);}
 });
 test('batch '+batch+' valid distinct IDs and empty pages retain declared responses',async()=>{
  for(const c of family){let f=fixture(c,(sql,rows)=>isRecord(sql)&&!c.record?.singleton?[rows[0],{...rows[0],id:'another-record'}]:undefined);let r=await f.call();assert.equal(r.status,200);let body=await r.json();assert.ok(!JSON.stringify(body).includes('private'));if(!c.record?.singleton)assert.equal(body[c.record?.collection??(c.path==='/invoices'?'invoices':c.path.includes('/payments')?'payments':c.path==='/booking-requests'?'requests':c.path==='/visits'?'visits':c.path==='/bookings'?'bookings':c.path==='/documents'?'documents':c.path==='/availability'?'availability':'items')].length,2);
   f=fixture(c,(sql)=>isRecord(sql)?[]:sql.startsWith('SELECT COUNT')?[{count:0}]:undefined);r=await f.call();assert.equal(r.status,c.record?.singleton?404:200);assert.equal(f.calls.at(-1).sql,'ROLLBACK');
  }
 });
}
const {recordRows}=await bundle('cloudflare/workers/src/database-results.ts');
test('record rows preserve distinct case-sensitive text identities and return original rows',()=>{const rows=[{id:'a',secret:'unused'},{id:'A'}];assert.deepEqual(recordRows(rows,2),rows);assert.equal(recordRows(rows,2)[0],rows[0]);});
test('record rows enforce page bounds and shape before identity inspection',()=>{for(const rows of [null,[null],[[]],[{id:'one'},{id:'two'}]])assert.throws(()=>recordRows(rows,1));assert.deepEqual(recordRows([],25),[]);});
