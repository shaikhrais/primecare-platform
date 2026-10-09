import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
import {build} from 'esbuild';
const cases=JSON.parse(readFileSync('docs/api/timestamp-contract-batches-1101-1150.json')).changes;
const documents=readdirSync('docs/api').filter(p=>p.endsWith('.openapi.json')).map(name=>({name,spec:JSON.parse(readFileSync('docs/api/'+name))}));
const aliases=JSON.parse(readFileSync('scripts/governed-read-alias-definitions.json'));
const registries=Object.fromEntries(['client','provider','auth'].map(service=>[service,JSON.parse(readFileSync('cloudflare/workers/src/'+(service==='auth'?'self':service)+'-records-registry.json'))]));
const plugin={name:'envelope-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__envelopeQuery(sql,values)}}',loader:'js'}));}};
const handlers={};
for(const [service,file,exportName] of [['client','client-self','clientSelf'],['provider','provider-records','providerRecords'],['auth','self-records','selfRecords']]){
 const built=await build({entryPoints:['cloudflare/workers/src/'+file+'.ts'],bundle:true,write:false,platform:'node',format:'esm',plugins:[plugin]});
 handlers[service]=(await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64')))[exportName];
}
const pattern=String.raw`^\d{4}-\d{2}-\d{2}T(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d(?:\.\d+)?(?:Z|[+-](?:[01]\d|2[0-3]):[0-5]\d)$`;
function fields(schema,name,result=[]){if(!schema||typeof schema!=='object')return result;if(schema.properties?.[name])result.push(schema.properties[name]);for(const value of Object.values(schema))if(value&&typeof value==='object')fields(value,name,result);return result;}
function fixture(c,record,input){
 const row=Object.fromEntries(record.fields.map(field=>{
  const types=Array.isArray(record.types[field])?record.types[field]:[record.types[field]];
  return [field,types.includes('null')?null:record.dateFields.includes(field)?'2026-01-01T12:00:00Z':types.includes('integer')?1:types.includes('number')?1.5:types.includes('boolean')?false:field==='id'?'record':'value'];
 }));
 row[c.field]=input;
 for(const key of ['tenant_id','user_id','secret_token'])if(!record.fields.includes(key))row[key]='private-canary';
 globalThis.__envelopeQuery=async(sql,values)=>{
  if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY'||sql==='ROLLBACK')return {rows:[]};
  if(sql.startsWith('SELECT u.id'))return {rows:[{id:'user',tenant_id:'tenant'}]};
  if(sql.startsWith('SELECT id,full_name')||sql.startsWith('SELECT id FROM provider_profiles')){assert.deepEqual(values,['user','tenant']);return {rows:[{id:'profile'}]};}
  assert.ok(sql.includes(' FROM '+record.table),sql);assert.deepEqual(values.slice(0,2),[c.service==='auth'?'user':'profile','tenant']);
  if(sql.startsWith('SELECT COUNT'))return {rows:[{count:1}]};
  if(sql.includes('id::text=$')&&!sql.includes('ORDER BY'))assert.equal(values.at(-1),'record');
  return {rows:[row]};
 };
}
for(const c of cases)test('batch '+c.batch+' '+c.service+c.path+' '+c.field+' timestamp contract matches actual projection',async()=>{
 const record=registries[c.service].find(r=>r.path===c.path);assert.ok(record.dateFields.includes(c.field));
 const root='/v1/'+c.service+c.path,compat=aliases.filter(a=>a.canonical===root).map(a=>'/v1/premium/'+a.name),seen=new Set();
 for(const doc of documents)for(const [route,methods] of Object.entries(doc.spec.paths??{})){
  if(route!==root&&route!==root+'/{recordId}'&&!(doc.name==='governed-read-aliases.openapi.json'&&compat.includes(route)))continue;
  const properties=fields(methods.get.responses['200'].content['application/json'].schema,c.field);assert.ok(properties.length);
  for(const p of properties){assert.deepEqual(p.type,record.types[c.field]);assert.equal(p.format,'date-time');assert.equal(p.minLength,20);assert.equal(p.pattern,pattern);}
  seen.add(route);
 }
 for(const route of [root,root+'/{recordId}',...compat])assert.ok(seen.has(route),'Missing '+route);
 const nullable=Array.isArray(record.types[c.field])&&record.types[c.field].includes('null');
 const good=['2026-01-01T12:00:00Z','2026-01-01T12:00:00.123456+05:30',new Date('2026-01-01T12:00:00Z'),...(nullable?[null]:[])];
 for(const detail of [false,true])for(const input of good){
  fixture(c,record,input);const path=c.path+(detail?'/record':'');
  const response=await handlers[c.service](new Request('https://fixture'+path+(detail?'':'?limit=1'),{headers:{authorization:'Bearer '+'a'.repeat(43)}}),{SERVICE_NAME:c.service,DB_URL:'fixture'},path,{});
  assert.equal(response.status,200);const body=await response.json();assert.ok(!JSON.stringify(body).includes('private-canary'));
  const value=(detail?body[record.item]:body[record.collection][0])[c.field];assert.equal(value,input instanceof Date?input.toISOString():input);
  if(value!==null){assert.ok(value.length>=20);assert.match(value,new RegExp(pattern));}
 }
 for(const input of ['2026-01-01','2026-01-01t12:00:00z','2026-01-01T24:00:00Z','2026-01-01T12:00:60Z','2026-01-01T12:00:00+24:00','2026-02-30T12:00:00Z',new Date(NaN),...(nullable?[]:[null])]){
  fixture(c,record,input);const response=await handlers[c.service](new Request('https://fixture'+c.path+'?limit=1',{headers:{authorization:'Bearer '+'a'.repeat(43)}}),{SERVICE_NAME:c.service,DB_URL:'fixture'},c.path,{});assert.equal(response.status,503);
  if(typeof input==='string'&&!input.startsWith('2026-02-30'))assert.ok(!new RegExp(pattern).test(input));
 }
});
