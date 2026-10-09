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
 {batch:439,service:'client',path:'/invoices'}, {batch:440,service:'client',path:'/payments'}, {batch:441,service:'client',path:'/invoices/invoice/payments'}, {batch:442,service:'client',path:'/booking-requests'}, {batch:443,service:'client',path:'/visits'}, {batch:444,service:'client',path:'/bookings'},
 {batch:445,service:'provider',path:'/documents'}, {batch:446,service:'provider',path:'/visits'}, {batch:447,service:'provider',path:'/availability'}, {batch:448,service:'provider',path:'/timesheet-items'},
];
const registered=[...registry('client').map((record,index)=>({batch:449+index,service:'client',path:record.path,record})),...registry('provider').filter(record=>!record.singleton).map((record,index)=>({batch:476+index,service:'provider',path:record.path,record}))];
const personal=registry('self').filter(record=>!record.singleton).map(record=>({service:'auth',path:record.path,record}));
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
 const response=await f.call(suffix,query);assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);assert.ok(!(await response.text()).includes('private'));
 assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(q.sql)));
}
const isPage=sql=>sql.includes('ORDER BY')&&!sql.startsWith('SELECT COUNT');
function twoRows(c,rows,summary){return [rows[0],{...rows[0],...(summary?{[c.path==='/invoices'?'currency':c.record?.summaryField??(c.path==='/availability'?'day_of_week':'status')]:c.path==='/availability'?2:c.record?.types[c.record.summaryField]==='boolean'?true:'another'}:{id:'another-record'})}];}
async function totalContradictions(family){
 for(const c of family)for(const suffix of ['',...(hasSummary(c)?['/summary']:[])]) {
  let f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:0}]:undefined);await rejected(f,suffix);
  f=fixture(c,(sql,rows)=>isPage(sql)?twoRows(c,rows,suffix!== ''):undefined);await rejected(f,suffix,'?limit=25');
 }
}
async function offsetContradictions(family){
 for(const c of family)for(const suffix of ['',...(hasSummary(c)?['/summary']:[])])for(const offset of [1,2,100000])await rejected(fixture(c),suffix,'?limit=1&offset='+offset);
}
async function validPages(family){
 for(const c of family)for(const suffix of ['',...(hasSummary(c)?['/summary']:[])]) {
  let f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:2}]:undefined),r=await f.call(suffix,'?limit=1&offset=1');assert.equal(r.status,200);let body=await r.json();assert.deepEqual(body.pagination,{limit:1,offset:1,total:2,hasMore:false});assert.ok(!JSON.stringify(body).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');
  for(const offset of [0,1,100000]){f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:0}]:isPage(sql)?[]:undefined);r=await f.call(suffix,'?offset='+offset);assert.equal(r.status,200);body=await r.json();assert.equal(body.pagination.total,0);assert.equal(body.pagination.hasMore,false);assert.ok(Object.values(body).some(v=>Array.isArray(v)&&v.length===0));}
  f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:1}]:isPage(sql)?[]:undefined);r=await f.call(suffix,'?offset=1');assert.equal(r.status,200);assert.equal((await r.json()).pagination.hasMore,false);
 }
}
assert.equal(cases.length,50);assert.equal(new Set(cases.map(c=>c.batch)).size,50);
for(let batch=439;batch<=488;batch++) {
 const family=cases.filter(c=>c.batch===batch);assert.equal(family.length,1,'Unmapped batch '+batch);
 test('batch '+batch+' rejects pages that exceed their total',()=>totalContradictions(family));
 test('batch '+batch+' rejects nonempty pages at or beyond total offset',()=>offsetContradictions(family));
 test('batch '+batch+' retains final pages, empty pages and exhausted offsets',()=>validPages(family));
}
test('personal lists and summaries reject understated totals',()=>totalContradictions(personal));
test('personal lists and summaries reject rows beyond their offset',()=>offsetContradictions(personal));
test('personal lists and summaries preserve valid pagination',()=>validPages(personal));
const {pageRows}=await bundle('cloudflare/workers/src/database-results.ts');
test('pagination bounds reject untyped and unsafe values',()=>{for(const args of [[0,0,1],[101,0,1],[1,-1,1],[1,100001,1],[1,0,-1],[1,0,1.5],[1,0,'1'],[1,0,Number.MAX_SAFE_INTEGER+1],[NaN,0,1],[1,Infinity,1]])assert.throws(()=>pageRows([], ...args));});
test('page limits and snapshot remainder both bound returned rows',()=>{assert.throws(()=>pageRows([{id:'a'},{id:'b'}],1,0,2));assert.throws(()=>pageRows([{id:'a'}],25,1,1));assert.throws(()=>pageRows([null],25,0,1));});
test('partial pages and maximum safe totals preserve existing semantics',()=>{const rows=[{id:'a'}];assert.deepEqual(pageRows(rows,25,0,2),rows);assert.equal(pageRows(rows,100,100000,Number.MAX_SAFE_INTEGER)[0],rows[0]);assert.deepEqual(pageRows([],25,100000,0),[]);});
