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


const integerCases=[
 {service:'client',path:'/visits',field:'duration_minutes'},
 {service:'provider',path:'/visits',field:'duration_minutes'},
 {service:'provider',path:'/availability',field:'day_of_week'},
 {service:'provider',path:'/timesheet-items',field:'minutes'},
 ...['client','provider','self'].flatMap(name=>registry(name).flatMap(record=>Object.entries(record.types).filter(([,type])=>(Array.isArray(type)?type:[type]).includes('integer')).map(([field])=>({service:name==='self'?'auth':name,path:record.path,field,record}))))
];
assert.equal(integerCases.length,16);
const detailPaths=c=>c.record?.singleton?['']:['','/record'];
const nullable=c=>Array.isArray(c.record?.types[c.field])&&c.record.types[c.field].includes('null');
const withInteger=(c,value)=>fixture(c,(sql,rows)=>isData(sql)?[{...rows[0],[c.field]:value}]:undefined);
for(const [index,c] of integerCases.entries()) {
 test('batch '+(789+index*3)+' '+c.service+' '+c.path+' '+c.field+' rejects int4 overflow',async()=>{for(const value of [-2147483649,2147483648,-Number.MAX_SAFE_INTEGER,Number.MAX_SAFE_INTEGER])for(const suffix of detailPaths(c))await rejected(withInteger(c,value),suffix);});
 test('batch '+(790+index*3)+' '+c.service+' '+c.path+' '+c.field+' rejects untyped/fractional/nonfinite values',async()=>{let calls=0;for(const value of [undefined,'1',1.5,-1.5,NaN,Infinity,-Infinity,false,[],{valueOf(){calls++;return 1;}},...(nullable(c)?[]:[null])])for(const suffix of detailPaths(c))await rejected(withInteger(c,value),suffix);assert.equal(calls,0);});
 test('batch '+(791+index*3)+' '+c.service+' '+c.path+' '+c.field+' preserves signed bounds and declared nulls',async()=>{for(const value of [-2147483648,-1,0,2147483647,...(nullable(c)?[null]:[])])for(const suffix of detailPaths(c)) {
  const f=fixture(c,(sql,rows)=>isData(sql)?[Object.freeze(Object.assign(Object.create(null),{...rows[0],[c.field]:value}))]:undefined),r=await f.call(suffix);assert.equal(r.status,200,c.path+suffix);const body=await r.json(),row=c.record?.singleton||suffix?body[c.record?.item??(c.path==='/timesheet-items'?'item':c.path==='/availability'?'availability':'visit')]:body[c.record?.collection??(c.path==='/timesheet-items'?'items':c.path==='/availability'?'availability':'visits')][0];assert.equal(row[c.field],value);assert.ok(!JSON.stringify(body).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>/^(INSERT|UPDATE|DELETE|COMMIT)/.test(q.sql)));
 }});
}
const {validDatabaseInteger,validDatabaseIntegerSum}=await bundle('cloudflare/workers/src/database-integer-validation.ts');
test('batch 837 integer helper enforces signed PostgreSQL int4 without coercion',()=>{let calls=0;for(const value of [null,undefined,'1',1.5,NaN,Infinity,-2147483649,2147483648,{valueOf(){calls++;return 1;}}])assert.equal(validDatabaseInteger(value),false);assert.equal(calls,0);for(const value of [-2147483648,-1,0,2147483647])assert.equal(validDatabaseInteger(value),true);});
test('batch 838 integer sums enforce canonical int8 text and preserve exact large values',()=>{for(const value of [null,undefined,1,'',' 1','+1','01','-0','1.0','1e3','9223372036854775808','-9223372036854775809','9'.repeat(1000)])assert.equal(validDatabaseIntegerSum(value),false);for(const value of ['-9223372036854775808','-1','0','9007199254740993','9223372036854775807'])assert.equal(validDatabaseIntegerSum(value),true);});
const sums=[{service:'provider',path:'/visits',field:'durationMinutes'},{service:'provider',path:'/timesheet-items',field:'totalMinutes'}];
for(const c of sums) {
 test(c.path+' summary rejects malformed and overflowing bigint sums',async()=>{for(const value of ['9223372036854775808','-9223372036854775809','01','-0','+1','1e3','1.5',1,null,'9'.repeat(1000)])await rejected(withInteger(c,value),'/summary');});
 test(c.path+' summary preserves signed exact bigint totals and privacy',async()=>{for(const value of ['-9223372036854775808','-1','0','9007199254740993','9223372036854775807']){const f=withInteger(c,value),r=await f.call('/summary');assert.equal(r.status,200);const body=await r.json();assert.equal(body.groups[0][c.field],value);assert.ok(!JSON.stringify(body).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');}});
}
const availability=integerCases.find(c=>c.field==='day_of_week');
test('availability summary keys reject int4 overflow',async()=>{for(const value of [-2147483649,2147483648])await rejected(withInteger(availability,value),'/summary');});
test('availability summary keys preserve signed int4 bounds',async()=>{for(const value of [-2147483648,0,2147483647]){const f=withInteger(availability,value),r=await f.call('/summary');assert.equal(r.status,200);assert.deepEqual((await r.json()).groups,[{day_of_week:value,count:1}]);assert.equal(f.calls.at(-1).sql,'ROLLBACK');}});
test('integer validation preserves empty lists and missing records',async()=>{for(const c of integerCases.filter(c=>!c.record?.singleton)){const f=fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:0}]:isData(sql)?[]:undefined);const r=await f.call();assert.equal(r.status,200);assert.equal((await r.json()).pagination.total,0);assert.equal((await f.call('/record')).status,404);assert.equal(f.calls.at(-1).sql,'ROLLBACK');}});
