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
 {batch:539,service:'client',path:'/invoices'}, {batch:540,service:'client',path:'/payments'}, {batch:541,service:'client',path:'/invoices/invoice/payments'}, {batch:542,service:'client',path:'/booking-requests'}, {batch:543,service:'client',path:'/visits'}, {batch:544,service:'client',path:'/bookings'},
 {batch:545,service:'provider',path:'/documents'}, {batch:546,service:'provider',path:'/visits'}, {batch:547,service:'provider',path:'/availability'}, {batch:548,service:'provider',path:'/timesheet-items'},
];
const registered=[...registry('client').map((record,index)=>({batch:549+index,service:'client',path:record.path,record})),...registry('provider').filter(record=>!record.singleton).map((record,index)=>({batch:576+index,service:'provider',path:record.path,record}))];
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
 return {calls,async call(suffix='',query='') {
  const path=c.path+suffix;
  const binding=c.service==='client'?'CLIENT':c.service==='provider'?'PROVIDER':'AUTH';
  const publicPath=c.service==='auth'?'/v1/auth'+path:'/v1/'+c.service+path;
  // Account-record routes use the gateway's existing /v1/auth prefix.
  return gateway.fetch(new Request('https://fixture'+publicPath+query,{headers:{authorization:'Bearer '+'A'.repeat(43)}}),{[binding]:{fetch:r=>service.fetch(r,{SERVICE_NAME:c.service,DB_URL:'fixture'})}});
 }};
}
async function rejected(f,suffix='',query='') {
 const response=await f.call(suffix,query);assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);assert.ok(!(await response.text()).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(q.sql)));
}
const isData=sql=>sql.startsWith('SELECT')&&!sql.startsWith('SELECT u.id')&&!sql.startsWith('SELECT COUNT')&&!sql.startsWith('SELECT id,full_name')&&!sql.startsWith('SELECT id FROM provider_profiles')&&!sql.startsWith('SELECT id FROM invoices');
const paths=c=>c.record?.singleton?['']:['','/record',...(hasSummary(c)?['/summary']:[])];
async function entryFailures(family) {
 for(const c of family)for(const suffix of paths(c)) {
  let calls=0;
  const mutations=[()=>new Array(1),rows=>{const result=new Array(1);Object.setPrototypeOf(result,Object.assign(Object.create(Array.prototype),{0:rows[0]}));return result;},rows=>{const result=new Array(1);Object.defineProperty(result,'0',{get(){calls++;return rows[0];}});return result;}];
  for(const mutation of mutations){const f=fixture(c,(sql,rows)=>isData(sql)?mutation(rows):undefined);await rejected(f,suffix);assert.equal(calls,0);}
  if(!c.record?.singleton&&suffix!=='/record'){const f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?new Array(1):undefined);await rejected(f,suffix);}
 }
}
async function rowFailures(family) {
 for(const c of family)for(const suffix of paths(c)) {
  let calls=0;
  for(const mutation of [row=>Object.create(row),row=>{class AdapterRow{}return Object.assign(new AdapterRow(),row);},row=>Object.defineProperty({...row},'privateGetter',{get(){calls++;return 'private';}})]) {
   const f=fixture(c,(sql,rows)=>isData(sql)?[mutation(rows[0])]:undefined);await rejected(f,suffix);assert.equal(calls,0);
  }
 }
}
async function compatibleRows(family) {
 for(const c of family)for(const suffix of paths(c)) {
  for(const mutation of [row=>Object.assign(Object.create(null),row),row=>Object.freeze({...row})]) {
   let calls=0;const f=fixture(c,(sql,rows)=>{if(!isData(sql))return;const result=[mutation(rows[0])];result.map=()=>{calls++;throw Error('adapter map');};return Object.freeze(result);});
   const response=await f.call(suffix);assert.equal(response.status,200,c.path+suffix);assert.equal(calls,0);assert.ok(!JSON.stringify(await response.json()).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');
  }
 }
}
assert.equal(cases.length,50);assert.equal(new Set(cases.map(c=>c.batch)).size,50);
for(let batch=539;batch<=588;batch++) {
 const family=cases.filter(c=>c.batch===batch);assert.equal(family.length,1);
 test('batch '+batch+' rejects sparse/inherited/accessor array entries without invoking getters',()=>entryFailures(family));
 test('batch '+batch+' rejects prototype and accessor rows before projection',()=>rowFailures(family));
 test('batch '+batch+' supports dense frozen/null-prototype rows and ignores array map overrides',()=>compatibleRows(family));
}
test('personal records and provider singleton reject malformed entries',()=>entryFailures(personal));
test('personal records and provider singleton reject inherited/accessor rows',()=>rowFailures(personal));
test('personal records and provider singleton preserve valid dense data rows',()=>compatibleRows(personal));
const {resultRows,optionalRow,requiredRow,scopedActor}=await bundle('cloudflare/workers/src/database-results.ts');
test('maximum cardinality must be a nonnegative safe integer',()=>{for(const max of [-1,1.5,NaN,Infinity,'1',Number.MAX_SAFE_INTEGER+1])assert.throws(()=>resultRows([],max));assert.deepEqual(resultRows([],0),[]);});
test('sparse authority cannot be interpreted as a missing record',()=>{for(const fn of [optionalRow,requiredRow,scopedActor])assert.throws(()=>fn(new Array(1)));assert.equal(optionalRow([]),null);});
test('own authority fields are required before inherited actor data can be used',()=>{assert.throws(()=>scopedActor([Object.create({id:'actor',tenant_id:'tenant'})]));assert.deepEqual(scopedActor([Object.assign(Object.create(null),{id:'actor',tenant_id:'tenant'})]),{id:'actor',tenant_id:'tenant'});});
test('array subclasses cannot control result iteration',()=>{class Rows extends Array{map(){throw Error('adapter map');}}const row={id:'record'};const rows=new Rows(row);assert.equal(resultRows(rows,1)[0],row);});
