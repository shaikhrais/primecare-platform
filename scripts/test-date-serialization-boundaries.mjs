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
 {batch:489,service:'client',path:'/home/profile',fields:['updated_at']},
 {batch:490,service:'client',path:'/invoices',fields:['created_at','updated_at']},
 {batch:491,service:'client',path:'/payments',fields:['created_at','updated_at']},
 {batch:492,service:'client',path:'/invoices/invoice/payments',fields:['created_at','updated_at']},
 {batch:493,service:'client',path:'/booking-requests',fields:['preferred_date','created_at','updated_at']},
 {batch:494,service:'client',path:'/visits',fields:['requested_start_at','updated_at']},
 {batch:495,service:'client',path:'/bookings',fields:['start_at','end_at']},
 {batch:496,service:'provider',path:'/documents',fields:['expiry_date','verified_at','created_at','updated_at']},
 {batch:497,service:'provider',path:'/visits',fields:['requested_start_at','updated_at']},
 {batch:498,service:'provider',path:'/timesheet-items',fields:['created_at']},
];
const registered=[...registry('client').map((record,index)=>({batch:499+index,service:'client',path:record.path,record,fields:record.dateFields})),...registry('provider').filter(r=>!r.singleton).map((record,index)=>({batch:526+index,service:'provider',path:record.path,record,fields:record.dateFields}))];
const supplemental=[...registry('self').map(record=>({service:'auth',path:record.path,record,fields:record.dateFields})),...registry('provider').filter(r=>r.singleton).map(record=>({service:'provider',path:record.path,record,fields:record.dateFields}))];
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
const isProjection=(c,sql)=>c.path==='/home/profile'?sql.startsWith('SELECT id,full_name'):sql.startsWith('SELECT')&&!sql.startsWith('SELECT u.id')&&!sql.startsWith('SELECT COUNT')&&!sql.startsWith('SELECT id,full_name')&&!sql.startsWith('SELECT id FROM provider_profiles')&&!sql.startsWith('SELECT id FROM invoices')&&!sql.includes('GROUP BY');
const withValue=(c,field,value)=>fixture(c,(sql,rows)=>isProjection(c,sql)?rows.map(row=>({...row,[field]:value})):undefined);
const paths=c=>c.path==='/home/profile'||c.record?.singleton?['']:['','/record'];
function item(body){return Object.values(body).find(v=>v&&typeof v==='object'&&!('limit' in v));}
async function safeDates(family){
 for(const c of family)for(const field of c.fields)for(const suffix of paths(c)) {
  let calls=0;const value=new Date(date);
  for(const name of ['getTime','getUTCFullYear','toISOString','toJSON'])value[name]=()=>{calls++;return {private:'adapter-date-secret'};};
  const f=withValue(c,field,value),r=await f.call(suffix);assert.equal(r.status,200,c.path+suffix+' '+field);
  const body=await r.json(),record=item(body),row=Array.isArray(record)?record[0]:record;
  assert.equal(row[field],'2026-01-01T12:00:00.000Z',c.path+' '+field);assert.equal(typeof row[field],'string');assert.equal(calls,0);assert.ok(!JSON.stringify(body).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');
 }
}
async function invalidDates(family){
 for(const c of family)for(const field of c.fields)for(const suffix of paths(c))for(const value of [new Date(NaN),new Date('+010000-01-01T00:00:00Z')]) {
  value.getTime=()=>0;value.getUTCFullYear=()=>2026;value.toISOString=()=>date;value.toJSON=()=>date;
  const f=withValue(c,field,value),r=await f.call(suffix);assert.equal(r.status,503,c.path+suffix+' '+field);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(r.headers.get('set-cookie'),null);assert.ok(!(await r.text()).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(q.sql)));
 }
}
async function compatibleDates(family){
 for(const c of family)for(const field of c.fields) {
  const value=c.path==='/timesheet-items'?date:'2024-02-29T12:00:00.123456+05:30';const f=withValue(c,field,value),r=await f.call();assert.equal(r.status,200,c.path);const record=item(await r.json()),row=Array.isArray(record)?record[0]:record;assert.equal(row[field],c.path==='/timesheet-items'?'2026-01-01T12:00:00.000Z':value);
  const declared=c.record?.types[field],nullable=Array.isArray(declared)&&declared.includes('null')||c.path==='/documents'&&['expiry_date','verified_at'].includes(field);
  if(nullable){const r=await withValue(c,field,null).call();assert.equal(r.status,200);const record=item(await r.json()),row=Array.isArray(record)?record[0]:record;assert.equal(row[field],null);}
 }
}
assert.equal(cases.length,50);assert.equal(new Set(cases.map(c=>c.batch)).size,50);
for(let batch=489;batch<=538;batch++) {
 const family=cases.filter(c=>c.batch===batch);assert.equal(family.length,1);
 test('batch '+batch+' Date serialization ignores adapter-owned methods',()=>safeDates(family));
 test('batch '+batch+' invalid native Date values cannot override validation',()=>invalidDates(family));
 test('batch '+batch+' preserves precise strings and declared nullable dates',()=>compatibleDates(family));
}
test('personal records and provider singleton serialize checked timestamps',()=>safeDates(supplemental));
test('personal records and provider singleton reject disguised invalid dates',()=>invalidDates(supplemental));
test('personal records and provider singleton preserve string/null date contracts',()=>compatibleDates(supplemental));
const {accountTimestamp}=await bundle('cloudflare/workers/src/account-read-projection.ts');
test('account timestamps ignore Date subclass overrides',()=>{class AdapterDate extends Date {getTime(){throw Error('adapter');}getUTCFullYear(){return -1;}toISOString(){return 'private';}toJSON(){return {private:true};}}assert.equal(accountTimestamp(new AdapterDate(date)),'2026-01-01T12:00:00.000Z');});
test('native Date range and null contracts remain strict',()=>{assert.throws(()=>accountTimestamp(new Date(NaN)));assert.throws(()=>accountTimestamp(new Date('-000001-01-01T00:00:00Z')));assert.throws(()=>accountTimestamp(null));assert.equal(accountTimestamp(null,true),null);});
