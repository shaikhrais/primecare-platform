import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
import {build} from 'esbuild';
const cases=JSON.parse(readFileSync('docs/api/response-envelope-contract-batches-1001-1050.json')).changes;
const documents=readdirSync('docs/api').filter(p=>p.endsWith('.openapi.json')).map(name=>({name,spec:JSON.parse(readFileSync('docs/api/'+name))}));
const aliases=JSON.parse(readFileSync('scripts/governed-read-alias-definitions.json'));
const registries=Object.fromEntries(['client','provider','auth'].map(service=>[service,JSON.parse(readFileSync('cloudflare/workers/src/'+(service==='auth'?'self':service)+'-records-registry.json'))]));
const plugin={name:'envelope-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__envelopeQuery(sql,values)}}',loader:'js'}));}};
const handlers={};
for(const [service,file,exportName] of [['client','client-self','clientSelf'],['provider','provider-records','providerRecords'],['auth','self-records','selfRecords']]){
 const built=await build({entryPoints:['cloudflare/workers/src/'+file+'.ts'],bundle:true,write:false,platform:'node',format:'esm',plugins:[plugin]});
 handlers[service]=(await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64')))[exportName];
}
// A focused response-shape check, not a general JSON Schema implementation.
function shape(schema,value){
 if(schema.type==='object'){
  assert.ok(value!==null&&typeof value==='object'&&!Array.isArray(value));
  for(const key of schema.required??[])assert.ok(Object.hasOwn(value,key),'Missing '+key);
  if(schema.additionalProperties===false)for(const key of Object.keys(value))assert.ok(Object.hasOwn(schema.properties,key),'Unexpected '+key);
  for(const [key,nested] of Object.entries(schema.properties??{}))if(Object.hasOwn(value,key))shape(nested,value[key]);
 }else if(schema.type==='array'){assert.ok(Array.isArray(value));for(const item of value)shape(schema.items,item);}
}
function fixture(c,record,empty){
 const row=Object.fromEntries(record.fields.map(field=>{
  const types=Array.isArray(record.types[field])?record.types[field]:[record.types[field]];
  return [field,types.includes('null')?null:record.dateFields.includes(field)?'2026-01-01T12:00:00Z':types.includes('integer')?1:types.includes('number')?1.5:types.includes('boolean')?false:field==='id'?'record':'value'];
 }));
 for(const key of ['tenant_id','user_id','secret_token'])if(!record.fields.includes(key))row[key]='private-canary';
 globalThis.__envelopeQuery=async(sql,values)=>{
  if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY'||sql==='ROLLBACK')return {rows:[]};
  if(sql.startsWith('SELECT u.id'))return {rows:[{id:'user',tenant_id:'tenant'}]};
  if(sql.startsWith('SELECT id,full_name')||sql.startsWith('SELECT id FROM provider_profiles')){assert.deepEqual(values,['user','tenant']);return {rows:[{id:'profile'}]};}
  assert.ok(sql.includes(' FROM '+record.table),sql);assert.deepEqual(values.slice(0,2),[c.service==='auth'?'user':'profile','tenant']);
  if(sql.startsWith('SELECT COUNT'))return {rows:[{count:empty?0:1}]};
  if(sql.includes('id::text=$')&&!sql.includes('ORDER BY'))assert.equal(values.at(-1),'record');
  return {rows:empty?[]:[row]};
 };
}
for(const c of cases)test('batch '+c.batch+' '+c.service+c.path+' closed responses match actual owned reads',async()=>{
 const record=registries[c.service].find(r=>r.path===c.path);assert.ok(record&&!record.singleton);
 const root='/v1/'+c.service+c.path,compat=aliases.filter(a=>a.canonical===root).map(a=>'/v1/premium/'+a.name),seen=new Set(),contracts=[];
 for(const doc of documents)for(const [route,methods] of Object.entries(doc.spec.paths??{})){
  if(route!==root&&route!==root+'/{recordId}'&&!(doc.name==='governed-read-aliases.openapi.json'&&compat.includes(route)))continue;
  const schema=methods.get.responses['200'].content['application/json'].schema;
  assert.equal(schema.additionalProperties,false,route);assert.deepEqual([...schema.required].sort(),Object.keys(schema.properties).sort());
  if(schema.properties.pagination)assert.equal(schema.properties.pagination.additionalProperties,false,route);
  contracts.push({route,schema,detail:route.endsWith('/{recordId}')});seen.add(route);
 }
 for(const route of [root,root+'/{recordId}',...compat])assert.ok(seen.has(route),'Missing '+route);
 for(const detail of [false,true])for(const empty of detail?[false]:[false,true]){
  fixture(c,record,empty);const path=c.path+(detail?'/record':'');
  const response=await handlers[c.service](new Request('https://fixture'+path+(detail?'':'?limit=1'),{headers:{authorization:'Bearer '+'a'.repeat(43)}}),{SERVICE_NAME:c.service,DB_URL:'fixture'},path,{});
  assert.equal(response.status,200);assert.equal(response.headers.get('cache-control'),'no-store');const body=await response.json();
  assert.ok(!JSON.stringify(body).includes('private-canary'));assert.deepEqual(Object.keys(body).sort(),(detail?[record.item]:[record.collection,'pagination']).sort());
  for(const contract of contracts.filter(x=>x.detail===detail)){
   shape(contract.schema,body);assert.throws(()=>shape(contract.schema,{...body,secret_token:'leak'}));
   const missing={...body};delete missing[detail?record.item:record.collection];assert.throws(()=>shape(contract.schema,missing));
   if(!detail)assert.throws(()=>shape(contract.schema,{...body,pagination:{...body.pagination,tenant_id:'leak'}}));
  }
 }
});
