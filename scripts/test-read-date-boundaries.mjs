import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readFileSync} from 'node:fs';
const registry=name=>JSON.parse(readFileSync('cloudflare/workers/src/'+name+'-records-registry.json','utf8'));
const plugin={name:'date-row-fixture',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'dates'}));
 b.onLoad({filter:/.*/,namespace:'dates'},()=>({loader:'js',contents:'export class Client {async connect(){} async end(){} query(s,v){return globalThis.__dateQuery(s,v)}}'}));
}};
const built=await build({entryPoints:['cloudflare/workers/src/service.ts'],bundle:true,write:false,platform:'node',format:'esm',plugins:[plugin]});
const {default:service}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const good='2026-01-01T12:00:00Z';
const invalid=['2026-02-30T12:00:00Z','2026-01-01','2026-01-01T24:00:00Z','infinity',new Date(NaN),new Date('+010000-01-01T00:00:00Z'),new Date('-000001-01-01T00:00:00Z'),false,1,undefined];
const cases=[
 {batch:284,service:'client',path:'/home/profile',field:'updated_at'},
 {batch:285,service:'client',path:'/invoices',field:'created_at'},
 {batch:286,service:'client',path:'/payments',field:'updated_at'},
 {batch:287,service:'client',path:'/visits',field:'requested_start_at'},
 {batch:288,service:'client',path:'/bookings',field:'end_at'},
 {batch:289,service:'client',path:'/booking-requests',field:'preferred_date'},
 {batch:291,service:'provider',path:'/documents',field:'verified_at',nullable:true},
 {batch:291,service:'provider',path:'/visits',field:'updated_at'},
 ...[['client',290],['provider',292],['self',293]].flatMap(([name,batch])=>registry(name).filter(r=>r.dateFields.length).map(record=>({batch,service:name==='self'?'auth':name,path:record.path,field:record.dateFields[0],record,nullable:Array.isArray(record.types[record.dateFields[0]])&&record.types[record.dateFields[0]].includes('null')}))),
];
function fixture(c,value){
 const queries=[];
 const profile={id:'profile',full_name:'Fixture',city:null,province:null,postal_code:null,updated_at:good};
 const row=c.record?Object.fromEntries(c.record.fields.map(field=>{
  const types=Array.isArray(c.record.types[field])?c.record.types[field]:[c.record.types[field]];
  const val=types.includes('null')?null:c.record.dateFields.includes(field)?good:types.includes('integer')?1:types.includes('number')?1.5:types.includes('boolean')?false:field==='id'?'record':'fixture';
  return [field,val];
 })):{id:'record',full_name:'Fixture',city:null,province:null,postal_code:null,updated_at:good,created_at:good,
  status:'pending',currency:'CAD',subtotal:'10.00',tax:'1.30',total:'11.30',amount:'11.30',
  service_id:'service',requested_start_at:good,duration_minutes:60,priority:'normal',
  service_type:'massage',preferred_date:good,preferred_time:null,start_at:good,end_at:good,recurrence_rule:null,
  doc_type:'credential',expiry_date:null,verified_at:good};
 row[c.field]=value;row.private='private-adapter-field';
 if(c.path==='/home/profile')profile.updated_at=value;
 globalThis.__dateQuery=async(sql,values)=>{
  queries.push({sql,values});
  if(sql.startsWith('BEGIN')||sql==='ROLLBACK')return {rows:[]};
  if(sql.startsWith('SELECT u.id'))return {rows:[{id:'actor',tenant_id:'tenant',roles:'ceo'}]};
  if(sql.startsWith('SELECT id,full_name'))return {rows:[profile]};
  if(sql.startsWith('SELECT id FROM provider_profiles'))return {rows:[{id:'profile'}]};
  if(sql.startsWith('SELECT id FROM invoices'))return {rows:[{id:'record'}]};
  if(sql.startsWith('SELECT COUNT'))return {rows:[{count:1}]};
  assert.ok(sql.startsWith('SELECT'),sql);return {rows:[row]};
 };
 return queries;
}
async function call(c,detail=false){
 const path=c.path+(detail?'/record':'');
 return service.fetch(new Request('https://fixture'+path,{headers:{authorization:'Bearer '+'A'.repeat(43)}}),{SERVICE_NAME:c.service,DB_URL:'fixture'});
}
for(const batch of [284,285,286,287,288,289,290,291,292,293]){
 const family=cases.filter(c=>c.batch===batch);
 test('batch '+batch+' rejects malformed dates in owned list/detail projections with sanitized rollback',async()=>{
  for(const c of family)for(const detail of c.path==='/home/profile'||c.record?.singleton?[false]:[false,true])for(const value of invalid){
   const queries=fixture(c,value);const response=await call(c,detail);
   assert.equal(response.status,503,c.path+' '+c.field);assert.equal(response.headers.get('cache-control'),'no-store');
   assert.ok(!(await response.text()).includes('private-'));assert.equal(queries.at(-1).sql,'ROLLBACK');
  }
 });
 test('batch '+batch+' preserves valid RFC3339/Date values and registered nullable dates',async()=>{
  for(const c of family){
   for(const value of [good,'2024-02-29T12:00:00.123456+05:30',new Date(good)]){
    fixture(c,value);const response=await call(c);assert.equal(response.status,200,c.path);
    assert.ok(!JSON.stringify(await response.json()).includes('private-'));
   }
   if(c.nullable){fixture(c,null);assert.equal((await call(c)).status,200,c.path+' nullable date');}
  }
 });
}
