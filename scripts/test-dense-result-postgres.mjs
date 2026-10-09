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
const require=createRequire(import.meta.url),pgPath=require.resolve('pg'),directory=await mkdtemp(join(tmpdir(),'dense-result-pg-'));
// Real SQL, ownership joins and read-only transactions are retained. Only
// returned adapter arrays/rows are malformed; no stored data is changed.
const plugin={name:'dense-result-fault',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'dense-fault'}));
 b.onLoad({filter:/.*/,namespace:'dense-fault'},()=>({loader:'js',contents:
  'import pg from '+JSON.stringify(pgPath)+';export class Client extends pg.Client {async query(sql,values){const f=globalThis.__denseResultFixture;f.queries.push(sql);const result=await super.query(sql,values);if(!f.mode||sql.startsWith("SELECT COUNT")||!sql.includes("FROM "+f.table))return result;let rows;if(f.mode==="sparse")rows=new Array(1);if(f.mode==="inherited-entry"){rows=new Array(1);Object.setPrototypeOf(rows,Object.assign(Object.create(Array.prototype),{0:result.rows[0]}));}if(f.mode==="getter-entry"){rows=new Array(1);Object.defineProperty(rows,"0",{get(){f.calls++;return result.rows[0];}});}if(f.mode==="prototype")rows=[Object.create(result.rows[0])];if(f.mode==="getter-row")rows=[Object.defineProperty({...result.rows[0]},"privateGetter",{get(){f.calls++;return "private";}})];if(f.mode==="valid"){rows=result.rows.map(row=>Object.freeze(Object.assign(Object.create(null),row)));rows.map=()=>{f.calls++;throw Error("adapter map");};Object.freeze(rows);}return {...result,rows};}}'}));
}};
await build({entryPoints:['cloudflare/workers/src/service.ts'],outfile:join(directory,'service.cjs'),bundle:true,platform:'node',format:'cjs',plugins:[plugin],external:[pgPath]});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:join(directory,'gateway.cjs'),bundle:true,platform:'node',format:'cjs'});
const service=require(join(directory,'service.cjs')).default,gateway=require(join(directory,'gateway.cjs')).default;
const db=new Client({connectionString:url.href});await db.connect();
const user=randomUUID(),tenant=randomUUID(),client=randomUUID(),provider=randomUUID(),token='P'.repeat(43),tables=[];let checks=0;
globalThis.__denseResultFixture={mode:null,table:null,queries:[],calls:0};
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
 for(const [name,path,collection,table] of [['client','/invoices','invoices','invoices'],['provider','/documents','documents','provider_documents'],['auth','/me/notifications','notifications','app_notifications']]) {
  globalThis.__denseResultFixture={mode:null,table,queries:[],calls:0};
  const baseline=await call(name,path,'?limit=1');assert.equal(baseline.status,200);const expected=(await baseline.json())[collection][0];
  for(const suffix of ['', '/'+expected.id])for(const mode of ['sparse','inherited-entry','getter-entry','prototype','getter-row','valid']) {
   globalThis.__denseResultFixture={mode,table,queries:[],calls:0};
   const response=await call(name,path+suffix,suffix?'':'?limit=1');assert.equal(response.status,mode==='valid'?200:503,name+path+suffix+' '+mode);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);
   const body=await response.json();assert.ok(!JSON.stringify(body).includes('private'));assert.equal(globalThis.__denseResultFixture.calls,0);
   assert.ok(globalThis.__denseResultFixture.queries.some(sql=>sql.startsWith('SELECT')&&sql.includes('FROM '+table)&&!sql.startsWith('SELECT COUNT')),'must reach data query');
   assert.equal(globalThis.__denseResultFixture.queries.at(-1),'ROLLBACK');assert.ok(!globalThis.__denseResultFixture.queries.includes('COMMIT'));
   if(mode==='valid'){const row=suffix?body[Object.keys(body)[0]]:body[collection][0];assert.deepEqual(row,expected);}
   assert.deepEqual(await snapshot(),before);checks++;
  }
  globalThis.__denseResultFixture={mode:null,table,queries:[],calls:0};
  checks+=await assertOwnedPageBoundaries((p,q)=>call(name,p,q),path,collection);
 }
 assert.deepEqual(await snapshot(),before);
 console.log(`Dense result validation passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
} finally {
 globalThis.__denseResultFixture={mode:null,table:null,queries:[],calls:0};
 for(const table of tables.reverse())await db.query('DROP TABLE '+table);
 await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[user]);await db.query('DELETE FROM users WHERE id::text=$1',[user]);
 await db.end();await rm(directory,{recursive:true,force:true});delete globalThis.__denseResultFixture;
}
