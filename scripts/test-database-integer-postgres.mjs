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
const require=createRequire(import.meta.url),pgPath=require.resolve('pg'),directory=await mkdtemp(join(tmpdir(),'database-integer-pg-'));
// Preserve real ownership SQL; only returned integer values are changed.
const plugin={name:'database-integer-fault',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'reference-fault'}));
 b.onLoad({filter:/.*/,namespace:'reference-fault'},()=>({loader:'js',contents:
  'import pg from '+JSON.stringify(pgPath)+';export class Client extends pg.Client {async query(sql,values){const f=globalThis.__databaseIntegerFault;f.queries.push(sql);const result=await super.query(sql,values);if(f.mode===null||!sql.startsWith("SELECT")||sql.startsWith("SELECT COUNT")||!sql.includes("FROM "+f.table)||!result.rows.length)return result;return {...result,rows:result.rows.map(row=>{const changed={...row,[f.field]:f.value,unselected_id:" bad-private"};return f.mode==="compatible"?Object.freeze(Object.assign(Object.create(null),changed)):changed;})};}}'}));
}};
await build({entryPoints:['cloudflare/workers/src/service.ts'],outfile:join(directory,'service.cjs'),bundle:true,platform:'node',format:'cjs',plugins:[plugin],external:[pgPath]});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:join(directory,'gateway.cjs'),bundle:true,platform:'node',format:'cjs'});
const service=require(join(directory,'service.cjs')).default,gateway=require(join(directory,'gateway.cjs')).default;
const registries=Object.fromEntries(await Promise.all(['client','provider','self'].map(async name=>[name,JSON.parse(await readFile('cloudflare/workers/src/'+name+'-records-registry.json','utf8'))])));
const records=['client','provider','self'].flatMap(name=>registries[name].filter(r=>Object.values(r.types).some(t=>(Array.isArray(t)?t:[t]).includes('integer'))).map(r=>({...r,service:name==='self'?'auth':name})));
const db=new Client({connectionString:url.href});await db.connect();
const users=[randomUUID(),randomUUID()],clients=[randomUUID(),randomUUID()],providers=[randomUUID(),randomUUID()],tenant=randomUUID(),reference=randomUUID(),token='T'.repeat(43),created=[];let checks=0;
globalThis.__databaseIntegerFault={mode:null,queries:[]};
const call=(name,path,headers={})=>gateway.fetch(new Request('https://fixture/v1/'+name+path,{headers:{authorization:'Bearer '+token,...headers}}),{[name.toUpperCase()]:{fetch:r=>service.fetch(r,{DB_URL:url.href,SERVICE_NAME:name})}});
const snapshot=async()=>Object.fromEntries(await Promise.all([...created,'users','auth_sessions'].map(async table=>[table,(await db.query('SELECT * FROM '+table+' ORDER BY '+(table==='auth_sessions'?'token_hash':'id'))).rows])));
try {
 for(const user of users)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient,provider',$3,'unused','active')",[user,user+'@example.invalid',tenant]);
 await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[createHash('sha256').update(token).digest('hex'),users[0]]);
 for(const [table,columns] of [
  ['client_profiles','id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,city TEXT,province TEXT,postal_code TEXT,updated_at TIMESTAMP'],
  ['provider_profiles','id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,bio TEXT,languages TEXT,service_areas TEXT,provider_type TEXT,is_approved BOOLEAN,skills TEXT'],
  ['provider_availability','id TEXT PRIMARY KEY,provider_id TEXT,tenant_id TEXT,day_of_week INTEGER,start_time TEXT,end_time TEXT,private_payload TEXT'],
  ['visits','id TEXT PRIMARY KEY,service_id TEXT,requested_start_at TIMESTAMP,duration_minutes INTEGER,status TEXT,priority TEXT,updated_at TIMESTAMP,client_id TEXT,assigned_provider_id TEXT,tenant_id TEXT,private_payload TEXT'],
 ]){await db.query('CREATE TABLE '+table+'('+columns+')');created.push(table);}
 for(let i=0;i<2;i++) {
  await db.query("INSERT INTO client_profiles VALUES($1,$2,$3,'Fixture',NULL,NULL,NULL,NOW())",[clients[i],users[i],tenant]);
  await db.query("INSERT INTO provider_profiles VALUES($1,$2,$3,'Fixture',NULL,'English','Hamilton','provider',true,'Fixture')",[providers[i],users[i],tenant]);
 }
 for(let i=0;i<2;i++)await db.query("INSERT INTO provider_availability VALUES($1,$2,$3,-2147483648,'09:00','17:00','private-payload')",[randomUUID(),providers[i],tenant]);
 const visitIds=[randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<3;i++)await db.query("INSERT INTO visits VALUES($1,$2,NOW(),-2147483648,'pending','normal',NOW(),$3,$4,$5,'private-payload')",[visitIds[i],reference,clients[i===2?1:0],providers[i===2?1:0],tenant]);
 const families=[{service:'client',path:'/visits',table:'visits',field:'duration_minutes',collection:'visits',item:'visit',ids:visitIds},{service:'provider',path:'/visits',table:'visits',field:'duration_minutes',collection:'visits',item:'visit',ids:visitIds},{service:'provider',path:'/availability',table:'provider_availability',field:'day_of_week',collection:'availability',item:'availability',ids:[]}];
 families[2].ids=(await db.query('SELECT id FROM provider_availability ORDER BY provider_id=$1 DESC',[providers[0]])).rows.map(r=>r.id);
 for(const record of records) {
  const owner=record.service==='client'?'client_id':record.service==='provider'?'provider_id':'user_id';
  const columns=record.fields.map(field=>{const type=record.types[field],base=Array.isArray(type)?type[0]:type;return field+' '+(record.dateFields.includes(field)?'TIMESTAMP':base==='integer'?'INTEGER':base==='number'?'DOUBLE PRECISION':base==='boolean'?'BOOLEAN':'TEXT');});
  await db.query('CREATE TABLE '+record.table+'('+columns.join(',')+','+owner+' TEXT,tenant_id TEXT,private_payload TEXT)');created.push(record.table);
  const ids=[randomUUID(),randomUUID(),randomUUID()];
  for(let i=0;i<3;i++) {
   if(record.singleton&&i===1)continue;
   const values=record.fields.map(field=>{const type=record.types[field],base=Array.isArray(type)?type[0]:type;return field==='id'?ids[i]:field===record.field?reference:record.dateFields.includes(field)?'2026-01-01T12:00:00Z':base==='integer'?-2147483648:base==='number'?1.5:base==='boolean'?false:'fixture';});
   values.push((record.service==='client'?clients:record.service==='provider'?providers:users)[i===2?1:0],tenant,'private-payload');
   await db.query('INSERT INTO '+record.table+'('+[...record.fields,owner,'tenant_id','private_payload'].join(',')+') VALUES('+values.map((_,j)=>'$'+(j+1)).join(',')+')',values);
  }
  for(const [field,type] of Object.entries(record.types))if((Array.isArray(type)?type:[type]).includes('integer'))families.push({...record,field,ids});
 }
 await db.query('CREATE TABLE timesheet_items(id TEXT PRIMARY KEY,timesheet_id TEXT,minutes INTEGER,created_at TIMESTAMP,private_payload TEXT)');created.push('timesheet_items');
 const sheets=families.find(f=>f.table==='timesheets'),itemIds=[randomUUID(),randomUUID(),randomUUID()];
 for(let i=0;i<3;i++)await db.query("INSERT INTO timesheet_items VALUES($1,$2,-2147483648,NOW(),'private-payload')",[itemIds[i],sheets.ids[i]]);
 families.push({service:'provider',path:'/timesheet-items',table:'timesheet_items',field:'minutes',collection:'items',item:'item',ids:itemIds});
 const sum=await db.query('SELECT SUM(value)::text AS total,pg_typeof(SUM(value))::text AS type FROM (VALUES (2147483647::int),(2147483647::int)) v(value)');assert.deepEqual(sum.rows,[{total:'4294967294',type:'bigint'}]);
 const before=await snapshot();
 async function check(family,suffix,mode,value,status){
  globalThis.__databaseIntegerFault={mode,value,table:family.table,field:family.field,queries:[]};
  const response=await call(family.service,family.path+suffix);assert.equal(response.status,status,family.path+suffix+' '+String(value));assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
  const body=await response.json();assert.ok(!JSON.stringify(body).includes('private'));assert.ok(!JSON.stringify(body).includes('unused'));
  if(status===200&&mode!==null){const rows=suffix==='/summary'?body.groups:family.singleton||suffix?[body[family.item]]:body[family.collection];assert.ok(rows.length);for(const row of rows)assert.equal(row[family.field],value);}
  assert.equal(globalThis.__databaseIntegerFault.queries.at(-1),'ROLLBACK');assert.ok(!globalThis.__databaseIntegerFault.queries.some(sql=>/^(COMMIT|UPDATE|INSERT|DELETE)/.test(sql)));assert.deepEqual(await snapshot(),before);checks++;
 }
 assert.equal(families.length,16);
 for(const family of families)for(const suffix of family.singleton?['']:['','/'+family.ids[0]]) {
  const nullable=Array.isArray(family.types?.[family.field])&&family.types[family.field].includes('null');
  await check(family,suffix,null,undefined,200);
  for(const value of [-2147483649,2147483648,Number.MAX_SAFE_INTEGER,1.5,'1',undefined,false])await check(family,suffix,'fault',value,503);
  await check(family,suffix,'fault',null,nullable?200:503);
  for(const value of [-2147483648,-1,0,2147483647])await check(family,suffix,'compatible',value,200);
 }
 for(const family of [{service:'provider',path:'/visits',table:'visits',field:'durationMinutes'},{service:'provider',path:'/timesheet-items',table:'timesheet_items',field:'totalMinutes'}]){
  await check(family,'/summary',null,undefined,200);
  for(const value of ['9223372036854775808','-9223372036854775809','01','-0','+1','1e3',1,null])await check(family,'/summary','fault',value,503);
  for(const value of ['-9223372036854775808','-1','0','9007199254740993','9223372036854775807'])await check(family,'/summary','compatible',value,200);
 }
 const availability=families.find(f=>f.table==='provider_availability');
 for(const value of [-2147483649,2147483648])await check(availability,'/summary','fault',value,503);
 for(const value of [-2147483648,0,2147483647])await check(availability,'/summary','compatible',value,200);
 for(const family of families) {
  globalThis.__databaseIntegerFault={mode:null,queries:[]};
  if(!family.singleton){assert.equal((await call(family.service,family.path+'/'+family.ids.at(-1))).status,404);checks++;}
  assert.equal((await call(family.service,family.path,{'x-tenant-id':randomUUID()})).status,403);checks++;
 }
 assert.deepEqual(await snapshot(),before);console.log(`Database integer validation passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} identities).`);
} finally {
 for(const table of created.reverse())await db.query('DROP TABLE '+table);
 for(const user of users){await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[user]);await db.query('DELETE FROM users WHERE id::text=$1',[user]);}
 await db.end();await rm(directory,{recursive:true,force:true});delete globalThis.__databaseIntegerFault;
}
