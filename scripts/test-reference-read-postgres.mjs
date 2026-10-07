import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp,readFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const require=createRequire(import.meta.url),pgPath=require.resolve('pg'),directory=await mkdtemp(join(tmpdir(),'reference-read-pg-'));
// Preserve real ownership SQL; only returned reference values are changed.
const plugin={name:'reference-read-fault',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'reference-fault'}));
 b.onLoad({filter:/.*/,namespace:'reference-fault'},()=>({loader:'js',contents:
  'import pg from '+JSON.stringify(pgPath)+';export class Client extends pg.Client {async query(sql,values){const f=globalThis.__referenceReadFault;f.queries.push(sql);const result=await super.query(sql,values);if(f.mode===null||!sql.startsWith("SELECT")||sql.startsWith("SELECT COUNT")||!sql.includes("FROM "+f.table)||!result.rows.length)return result;return {...result,rows:result.rows.map(row=>{const changed={...row,[f.field]:f.value,unselected_id:" bad-private"};return f.mode==="compatible"?Object.freeze(Object.assign(Object.create(null),changed)):changed;})};}}'}));
}};
await build({entryPoints:['cloudflare/workers/src/service.ts'],outfile:join(directory,'service.cjs'),bundle:true,platform:'node',format:'cjs',plugins:[plugin],external:[pgPath]});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:join(directory,'gateway.cjs'),bundle:true,platform:'node',format:'cjs'});
const service=require(join(directory,'service.cjs')).default,gateway=require(join(directory,'gateway.cjs')).default;
const registries=Object.fromEntries(await Promise.all(['client','provider','self'].map(async name=>[name,JSON.parse(await readFile('cloudflare/workers/src/'+name+'-records-registry.json','utf8'))])));
const records=[...registries.client.filter(r=>r.fields.includes('service_id')).map(r=>({...r,service:'client',field:'service_id'})),...registries.provider.filter(r=>r.fields.includes('week_id')).map(r=>({...r,service:'provider',field:'week_id'})),...registries.self.filter(r=>r.fields.some(f=>['survey_id','group_id'].includes(f))).map(r=>({...r,service:'auth',field:r.fields.includes('survey_id')?'survey_id':'group_id'}))];
const db=new Client({connectionString:url.href});await db.connect();
const users=[randomUUID(),randomUUID()],clients=[randomUUID(),randomUUID()],providers=[randomUUID(),randomUUID()],tenant=randomUUID(),reference=randomUUID(),token='T'.repeat(43),created=[];let checks=0;
globalThis.__referenceReadFault={mode:null,queries:[]};
const call=(name,path,headers={})=>gateway.fetch(new Request('https://fixture/v1/'+name+path,{headers:{authorization:'Bearer '+token,...headers}}),{[name.toUpperCase()]:{fetch:r=>service.fetch(r,{DB_URL:url.href,SERVICE_NAME:name})}});
const snapshot=async()=>Object.fromEntries(await Promise.all([...created,'users','auth_sessions'].map(async table=>[table,(await db.query('SELECT * FROM '+table+' ORDER BY '+(table==='auth_sessions'?'token_hash':'id'))).rows])));
try {
 for(const user of users)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient,provider',$3,'unused','active')",[user,user+'@example.invalid',tenant]);
 await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[createHash('sha256').update(token).digest('hex'),users[0]]);
 for(const [table,columns] of [
  ['client_profiles','id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,city TEXT,province TEXT,postal_code TEXT,updated_at TIMESTAMP'],
  ['provider_profiles','id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,bio TEXT,languages TEXT,service_areas TEXT,provider_type TEXT,is_approved BOOLEAN,skills TEXT'],
  ['visits','id TEXT PRIMARY KEY,service_id TEXT,requested_start_at TIMESTAMP,duration_minutes INTEGER,status TEXT,priority TEXT,updated_at TIMESTAMP,client_id TEXT,assigned_provider_id TEXT,tenant_id TEXT,private_payload TEXT'],
 ]){await db.query('CREATE TABLE '+table+'('+columns+')');created.push(table);}
 for(let i=0;i<2;i++) {
  await db.query("INSERT INTO client_profiles VALUES($1,$2,$3,'Fixture',NULL,NULL,NULL,NOW())",[clients[i],users[i],tenant]);
  await db.query("INSERT INTO provider_profiles VALUES($1,$2,$3,'Fixture',NULL,'English','Hamilton','provider',true,'Fixture')",[providers[i],users[i],tenant]);
 }
 const visitIds=[randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<3;i++)await db.query("INSERT INTO visits VALUES($1,$2,NOW(),60,'pending','normal',NOW(),$3,$4,$5,'private-payload')",[visitIds[i],reference,clients[i===2?1:0],providers[i===2?1:0],tenant]);
 const families=[{service:'client',path:'/visits',table:'visits',field:'service_id',collection:'visits',item:'visit',ids:visitIds},{service:'provider',path:'/visits',table:'visits',field:'service_id',collection:'visits',item:'visit',ids:visitIds}];
 for(const record of records) {
  const owner=record.service==='client'?'client_id':record.service==='provider'?'provider_id':'user_id';
  const columns=record.fields.map(field=>{const type=record.types[field],base=Array.isArray(type)?type[0]:type;return field+' '+(record.dateFields.includes(field)?'TIMESTAMP':base==='integer'?'INTEGER':base==='number'?'DOUBLE PRECISION':base==='boolean'?'BOOLEAN':'TEXT');});
  await db.query('CREATE TABLE '+record.table+'('+columns.join(',')+','+owner+' TEXT,tenant_id TEXT,private_payload TEXT)');created.push(record.table);
  const ids=[randomUUID(),randomUUID(),randomUUID()];
  for(let i=0;i<3;i++) {
   const values=record.fields.map(field=>{const type=record.types[field],base=Array.isArray(type)?type[0]:type;return field==='id'?ids[i]:field===record.field?reference:record.dateFields.includes(field)?'2026-01-01T12:00:00Z':base==='integer'?5:base==='number'?1.5:base==='boolean'?false:'fixture';});
   values.push((record.service==='client'?clients:record.service==='provider'?providers:users)[i===2?1:0],tenant,'private-payload');
   await db.query('INSERT INTO '+record.table+'('+[...record.fields,owner,'tenant_id','private_payload'].join(',')+') VALUES('+values.map((_,j)=>'$'+(j+1)).join(',')+')',values);
  }
  families.push({...record,ids});
 }
 const before=await snapshot();
 for(const family of families)for(const suffix of ['', '/'+family.ids[0],...(family.field==='survey_id'?['/summary']:[])]) {
  const nullable=Array.isArray(family.types?.[family.field])&&family.types[family.field].includes('null');
  for(const [mode,value,status] of [[null,reference,200],...['',' bad','bad/other','bad.other','bad\nother','a'.repeat(201),1,undefined].map(value=>['fault',value,503]),['fault',null,nullable?200:503],['fault',randomUUID(),200],['fault','reference-hq_01',200],['fault','a'.repeat(200),200],['compatible','reference-hq',200]]) {
   globalThis.__referenceReadFault={mode,value,table:family.table,field:family.field,queries:[]};
   const response=await call(family.service,family.path+suffix);assert.equal(response.status,status,family.path+suffix+' '+String(value));assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
   const body=await response.json();assert.ok(!JSON.stringify(body).includes('private'));assert.ok(!JSON.stringify(body).includes('unused'));
   if(status===200){const rows=suffix==='/summary'?body.groups:suffix?[body[family.item]]:body[family.collection];assert.ok(rows.length);for(const row of rows)assert.equal(row[family.field],value);if(!suffix){assert.equal(rows.length,2);assert.equal(body.pagination.total,2);}}
   assert.equal(globalThis.__referenceReadFault.queries.at(-1),'ROLLBACK');assert.ok(!globalThis.__referenceReadFault.queries.some(sql=>/^(COMMIT|UPDATE|INSERT|DELETE)/.test(sql)));assert.deepEqual(await snapshot(),before);checks++;
  }
 }
 for(const family of families) {
  globalThis.__referenceReadFault={mode:null,queries:[]};assert.equal((await call(family.service,family.path+'/'+family.ids[2])).status,404);checks++;
  assert.equal((await call(family.service,family.path,{'x-tenant-id':randomUUID()})).status,403);checks++;
 }
 assert.deepEqual(await snapshot(),before);console.log(`Reference read validation passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} identities).`);
} finally {
 for(const table of created.reverse())await db.query('DROP TABLE '+table);
 for(const user of users){await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[user]);await db.query('DELETE FROM users WHERE id::text=$1',[user]);}
 await db.end();await rm(directory,{recursive:true,force:true});delete globalThis.__referenceReadFault;
}
