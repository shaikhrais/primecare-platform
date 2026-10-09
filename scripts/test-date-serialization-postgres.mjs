import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
import {assertOwnedPageBoundaries} from './owned-result-postgres-fixtures.mjs';

const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const require=createRequire(import.meta.url),pgPath=require.resolve('pg'),directory=await mkdtemp(join(tmpdir(),'date-serialization-pg-'));
// All queries use real PostgreSQL. Corrupt only returned timestamp objects;
// stored rows, ownership joins and read-only transactions remain real.
const plugin={name:'date-serialization-fault',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'date-fault'}));
 b.onLoad({filter:/.*/,namespace:'date-fault'},()=>({loader:'js',contents:
  'import pg from '+JSON.stringify(pgPath)+';export class Client extends pg.Client {async query(sql,values){const fixture=globalThis.__dateSerializationFixture;fixture.queries.push(sql);const result=await super.query(sql,values);if(!fixture.mode||!sql.includes("FROM "+fixture.table))return result;return {...result,rows:result.rows.map(row=>Object.fromEntries(Object.entries(row).map(([key,value])=>{if(!(value instanceof Date))return [key,value];const date=fixture.mode==="invalid"?new Date(NaN):fixture.mode==="range"?new Date("+010000-01-01T00:00:00Z"):new Date(Date.prototype.getTime.call(value));for(const name of ["getTime","getUTCFullYear","toISOString","toJSON"])date[name]=()=>{fixture.calls++;return name==="getTime"?0:name==="getUTCFullYear"?2026:name==="toISOString"?"2026-01-01T00:00:00Z":{private:"adapter-date-secret"};};return [key,date];})))};}}'}));
}};
await build({entryPoints:['cloudflare/workers/src/service.ts'],outfile:join(directory,'service.cjs'),bundle:true,platform:'node',format:'cjs',plugins:[plugin],external:[pgPath]});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:join(directory,'gateway.cjs'),bundle:true,platform:'node',format:'cjs'});
const service=require(join(directory,'service.cjs')).default,gateway=require(join(directory,'gateway.cjs')).default;
const db=new Client({connectionString:url.href});await db.connect();
const user=randomUUID(),tenant=randomUUID(),client=randomUUID(),provider=randomUUID(),token='P'.repeat(43),tables=[];let checks=0;
globalThis.__dateSerializationFixture={mode:null,table:null,queries:[],calls:0};
const call=(serviceName,path,query='')=>gateway.fetch(new Request('https://fixture/v1/'+serviceName+path+query,{headers:{authorization:'Bearer '+token}}),{[serviceName.toUpperCase()]:{fetch:r=>service.fetch(r,{DB_URL:url.href,SERVICE_NAME:serviceName})}});
const snapshot=async()=>Object.fromEntries(await Promise.all(tables.map(async table=>[table,(await db.query('SELECT * FROM '+table+' ORDER BY id')).rows])));
try {
 await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient,provider',$3,'unused','active')",[user,user+'@example.invalid',tenant]);
 await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[createHash('sha256').update(token).digest('hex'),user]);
 for(const [table,columns] of [
  ['client_profiles','id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,city TEXT,province TEXT,postal_code TEXT,updated_at TIMESTAMP'],
  ['provider_profiles','id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,bio TEXT,languages TEXT,service_areas TEXT,provider_type TEXT,is_approved BOOLEAN,skills TEXT'],
  ['invoices','id TEXT PRIMARY KEY,client_id TEXT,tenant_id TEXT,status TEXT,currency TEXT,subtotal NUMERIC,tax NUMERIC,total NUMERIC,created_at TIMESTAMP,updated_at TIMESTAMP'],
  ['provider_documents','id TEXT PRIMARY KEY,provider_id TEXT,doc_type TEXT,status TEXT,expiry_date TIMESTAMP,verified_at TIMESTAMP,created_at TIMESTAMP,updated_at TIMESTAMP'],
  ['app_notifications','id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,title TEXT,message TEXT,type TEXT,is_read BOOLEAN,created_at TIMESTAMP'],
 ]){await db.query('CREATE TABLE '+table+'('+columns+')');tables.push(table);}
 await db.query("INSERT INTO client_profiles VALUES($1,$2,$3,'Fixture',NULL,NULL,NULL,NOW())",[client,user,tenant]);
 await db.query("INSERT INTO provider_profiles VALUES($1,$2,$3,'Fixture',NULL,'English','Hamilton','provider',true,'Fixture')",[provider,user,tenant]);
 for(let i=0;i<3;i++) {
  await db.query("INSERT INTO invoices VALUES($1,$2,$3,$4,'CAD',10,1,11,NOW(),NOW())",[randomUUID(),client,tenant,i===0?'paid':'pending']);
  await db.query("INSERT INTO provider_documents VALUES($1,$2,'license','pending',NULL,NULL,NOW(),NOW())",[randomUUID(),provider]);
  await db.query("INSERT INTO app_notifications VALUES($1,$2,$3,'Fixture','Fixture','info',$4,NOW())",[randomUUID(),user,tenant,i===0]);
 }
 const before=await snapshot();
 for(const [name,path,collection,table,fields] of [['client','/invoices','invoices','invoices',['created_at','updated_at']],['provider','/documents','documents','provider_documents',['created_at','updated_at']],['auth','/me/notifications','notifications','app_notifications',['created_at']]]) {
  globalThis.__dateSerializationFixture={mode:null,table,queries:[],calls:0};
  const baseline=await call(name,path,'?limit=1');assert.equal(baseline.status,200);const expected=(await baseline.json())[collection][0];
  for(const suffix of ['', '/'+expected.id])for(const mode of ['valid','invalid','range']) {
   globalThis.__dateSerializationFixture={mode,table,queries:[],calls:0};
   const response=await call(name,path+suffix,suffix?'':'?limit=1');assert.equal(response.status,mode==='valid'?200:503,name+path+suffix+' '+mode);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
   const body=await response.json();assert.ok(!JSON.stringify(body).includes('private'));assert.equal(globalThis.__dateSerializationFixture.calls,0);
   assert.ok(globalThis.__dateSerializationFixture.queries.some(sql=>sql.startsWith('SELECT')&&sql.includes('FROM '+table)&&!sql.startsWith('SELECT COUNT')),'must reach timestamp query');
   assert.equal(globalThis.__dateSerializationFixture.queries.at(-1),'ROLLBACK');assert.ok(!globalThis.__dateSerializationFixture.queries.includes('COMMIT'));
   if(mode==='valid'){const row=suffix?body[Object.keys(body)[0]]:body[collection][0];for(const field of fields){assert.equal(typeof row[field],'string');assert.equal(row[field],expected[field]);}}
   assert.deepEqual(await snapshot(),before);checks++;
  }
  globalThis.__dateSerializationFixture={mode:null,table,queries:[],calls:0};
  checks+=await assertOwnedPageBoundaries((p,q)=>call(name,p,q),path,collection);
 }
 assert.deepEqual(await snapshot(),before);
 console.log(`Date serialization passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
} finally {
 globalThis.__dateSerializationFixture={mode:null,table:null,queries:[],calls:0};
 for(const table of tables.reverse())await db.query('DROP TABLE '+table);
 await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[user]);await db.query('DELETE FROM users WHERE id::text=$1',[user]);
 await db.end();await rm(directory,{recursive:true,force:true});delete globalThis.__dateSerializationFixture;
}
