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
 {batch:368,service:'client',path:'/invoices'},
 {batch:369,service:'client',path:'/payments'},
 {batch:369,service:'client',path:'/invoices/invoice/payments'},
 {batch:370,service:'client',path:'/booking-requests'},
 {batch:371,service:'client',path:'/visits'},
 {batch:372,service:'client',path:'/bookings'},
 {batch:373,service:'provider',path:'/documents'},
 {batch:374,service:'provider',path:'/visits'},
 {batch:375,service:'provider',path:'/availability'},
 {batch:376,service:'provider',path:'/timesheet-items'},
];
const families={
 377:['/consents','/service-authorizations','/waitlist'],378:['/feedback','/care-feedback'],379:['/conversation-threads','/family-links'],380:['/alert-records','/insurance-claim-records','/prescription-records'],381:['/care-plan-records','/assessment-records','/medication-reconciliation-records'],382:['/shift-log-records','/adl-records','/vital-observation-records','/behavior-observation-records','/nutrition-observation-records','/mobility-observation-records','/infection-checklist-records','/progress-note-records','/care-follow-up-records'],383:['/family-notification-records','/purchase-order-records','/patient-vital-records','/medication-administration-records'],
 384:['/conversation-threads','/timesheets','/availability-overrides'],385:['/mileage-logs','/payouts','/performance-reviews'],386:['/visit-check-events','/visit-matches','/training-assignment-records'],
 387:['/me/notifications','/me/activities','/me/wellness-pulses','/me/device-events','/me/health-ids','/me/survey-submissions','/me/shift-logs','/me/daily-entry-records','/me/assigned-task-records','/me/audit-signoff-records','/me/reported-incident-records'],388:['/me/medication-reconciliation-records','/me/technical-audit-records','/me/authored-care-plan-records','/me/authored-review-records','/me/reviewed-timesheet-records','/me/telehealth-records','/me/authored-post-records','/me/ledger-event-records'],
};
const registered=['client','provider','self'].flatMap(name=>registry(name).filter(r=>r.summaryField&&(name!=='client'||r.summaryBatch>0)).map(record=>{
 const low=name==='client'?377:name==='provider'?384:387,high=name==='client'?383:name==='provider'?386:388;
 const batch=Number(Object.keys(families).find(b=>Number(b)>=low&&Number(b)<=high&&families[b].includes(record.path)));assert.ok(batch,'Unmapped registered summary '+record.path);
 return {batch,service:name==='self'?'auth':name,path:record.path,record};
}));
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
 const response=await f.call('/summary');assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);assert.ok(!(await response.text()).includes('private'));
 assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(q.sql)));
}
for(const c of cases) {
 test('batch '+c.batch+' '+c.service+c.path+' rejects duplicate group keys and zero source counts',async()=>{
  for(const mutation of [rows=>[rows[0],{...rows[0]}],rows=>[{...rows[0],[c.path==='/invoices'?'invoiceCount':'count']:0}]]) {
   const f=fixture(c,(sql,rows)=>sql.includes('GROUP BY')&&!sql.startsWith('SELECT COUNT')?mutation(rows):undefined);await rejected(f);
  }
 });
 test('batch '+c.batch+' '+c.service+c.path+' retains safe valid and empty summaries',async()=>{
  let f=fixture(c),response=await f.call('/summary');assert.equal(response.status,200);const body=await response.json();assert.equal(body.groups.length,1);assert.ok(!JSON.stringify(body).includes('private'));
  f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:0}]:sql.includes('GROUP BY')?[]:undefined);response=await f.call('/summary');assert.equal(response.status,200);assert.deepEqual((await response.json()).groups,[]);assert.equal(f.calls.at(-1).sql,'ROLLBACK');
 });
}
const {summaryRows}=await bundle('cloudflare/workers/src/summary-results.ts');
for(const key of [undefined,{},[],NaN,Infinity])test('summary key rejects '+String(key),()=>assert.throws(()=>summaryRows([{key,count:1}],25,['key'])));
for(const count of [0,-1,1.5,'1',null,true,Number.MAX_SAFE_INTEGER+1])test('summary count rejects '+JSON.stringify(count),()=>assert.throws(()=>summaryRows([{key:null,count}],25,['key'])));
test('summary typed keys retain nullable, boolean, number and string distinctions',()=>{const rows=[null,false,true,0,1,'0','1',''].map(key=>({key,count:1}));assert.deepEqual(summaryRows(rows,25,['key']),rows);for(const key of [null,false,0,'0'])assert.throws(()=>summaryRows([{key,count:1},{key,count:2}],25,['key']));});
test('invoice summary compound keys preserve currency and status pairs',()=>{const rows=[{currency:'CAD',status:'paid',invoiceCount:1},{currency:'USD',status:'paid',invoiceCount:2},{currency:'CAD',status:'pending',invoiceCount:1},{currency:null,status:null,invoiceCount:1}];assert.deepEqual(summaryRows(rows,25,['currency','status'],'invoiceCount'),rows);assert.throws(()=>summaryRows([...rows,{...rows[3]}],25,['currency','status'],'invoiceCount'));});
