import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
const registry=name=>JSON.parse(readFileSync('cloudflare/workers/src/'+name+'-records-registry.json','utf8'));
const plugin={name:'owned-result-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({loader:'js',contents:'export class Client {async connect(){} async end(){} query(s,v){return globalThis.__ownedResultQuery(s,v)}}'}));}};
async function bundle(path,plugins=[]){const r=await build({entryPoints:[path],plugins,bundle:true,write:false,platform:'node',format:'esm'});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {default:service}=await bundle('cloudflare/workers/src/service.ts',[plugin]),{default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const date='2026-01-01T12:00:00Z';
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

const referenceCases=[
 {start:739,service:'client',path:'/visits',field:'service_id'},
 {start:746,service:'provider',path:'/visits',field:'service_id'},
 ...[['client','/service-authorizations','service_id',753],['client','/waitlist','service_id',760],['provider','/timesheets','week_id',767],['self','/me/survey-submissions','survey_id',774],['self','/me/group-memberships','group_id',781]].map(([name,path,field,start])=>({start,service:name==='self'?'auth':name,path,field,record:registry(name).find(r=>r.path===path)}))
];
const nullable=c=>Array.isArray(c.record?.types[c.field])&&c.record.types[c.field].includes('null');
const withReference=(c,value)=>fixture(c,(sql,rows)=>isData(sql)?[{...rows[0],[c.field]:value}]:undefined);
const descriptions=['empty reference','padded reference','invalid characters','untyped and missing reference','UUID reference projection','text and null boundaries','compatible rows and shared references'];
for(const c of referenceCases)for(let index=0;index<7;index++)test('batch '+(c.start+index)+' '+c.service+' '+c.path+' '+descriptions[index],async()=>{
 if(index<4){
  let calls=0;const object={toString(){calls++;return 'reference';},valueOf(){calls++;return 'reference';}};
  const values=index===0?['']:index===1?[' reference','reference ']:index===2?['ref/other','ref.other','ref\nother','référence','a'.repeat(201)]:[undefined,1,false,[],object,...(nullable(c)?[]:[null])];
  for(const value of values)for(const suffix of ['', '/record'])await rejected(withReference(c,value),suffix);assert.equal(calls,0);return;
 }
 if(index===4||index===5){
  const values=index===4?['123e4567-e89b-12d3-a456-426614174000']:['r','reference-hq_01','a'.repeat(200),...(nullable(c)?[null]:[])];
  for(const value of values)for(const suffix of ['', '/record']) {
   const f=withReference(c,value),response=await f.call(suffix);assert.equal(response.status,200);const body=await response.json(),row=suffix?body[c.record?.item??'visit']:body[c.record?.collection??'visits'][0];assert.equal(row[c.field],value);assert.ok(!JSON.stringify(body).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>/^(INSERT|UPDATE|DELETE|COMMIT)/.test(q.sql)));
  }
  return;
 }
 for(const suffix of ['', '/record']) {
  const f=fixture(c,(sql,rows)=>isData(sql)?[Object.freeze(Object.assign(Object.create(null),{...rows[0],[c.field]:'reference'}))]:undefined);assert.equal((await f.call(suffix)).status,200);assert.equal(f.calls.at(-1).sql,'ROLLBACK');
 }
 const f=fixture(c,(sql,rows)=>sql.startsWith('SELECT COUNT')?[{count:2}]:isData(sql)?[{...rows[0],[c.field]:'shared-reference'},{...rows[0],id:'other-record',[c.field]:'shared-reference'}]:undefined);const response=await f.call();assert.equal(response.status,200);const body=await response.json();assert.equal(body[c.record?.collection??'visits'].length,2);assert.equal(body.pagination.total,2);assert.ok(!JSON.stringify(body).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');
});
const {projectReferenceId}=await bundle('cloudflare/workers/src/reference-read-projection.ts');
test('batch 788 reference helper rejects coercion and preserves explicit nullable semantics',()=>{let calls=0;for(const value of ['',null,undefined,1,false,' bad','bad/other','a'.repeat(201),{toString(){calls++;return 'reference';}}])assert.throws(()=>projectReferenceId(value));assert.equal(calls,0);assert.equal(projectReferenceId(null,true),null);assert.equal(projectReferenceId('reference',true),'reference');for(const value of ['r','a'.repeat(200),'123e4567-e89b-12d3-a456-426614174000'])assert.equal(projectReferenceId(value),value);});
const survey=referenceCases.find(c=>c.field==='survey_id');
test('survey summary groups reject malformed reference keys',async()=>{for(const value of ['', ' bad', 'survey/other','a'.repeat(201),1,null])await rejected(withReference(survey,value),'/summary');});
test('survey summary groups preserve UUID/text references and privacy',async()=>{for(const value of ['survey-hq','123e4567-e89b-12d3-a456-426614174000']){const f=withReference(survey,value),r=await f.call('/summary');assert.equal(r.status,200);const b=await r.json();assert.deepEqual(b.groups,[{survey_id:value,count:1}]);assert.ok(!JSON.stringify(b).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');}});
test('reference validation preserves empty lists and missing details',async()=>{for(const c of referenceCases){const f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:0}]:isData(sql)?[]:undefined);const list=await f.call();assert.equal(list.status,200);const body=await list.json();assert.deepEqual(body[c.record?.collection??'visits'],[]);assert.equal((await f.call('/record')).status,404);assert.equal(f.calls.at(-1).sql,'ROLLBACK');}});
