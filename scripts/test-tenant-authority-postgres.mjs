import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';

const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const require=createRequire(import.meta.url),pgPath=require.resolve('pg'),directory=await mkdtemp(join(tmpdir(),'tenant-authority-pg-'));
// Execute real ownership SQL and alter only returned actor scope values.
const plugin={name:'tenant-authority-fault',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'tenant-fault'}));
 b.onLoad({filter:/.*/,namespace:'tenant-fault'},()=>({loader:'js',contents:
  'import pg from '+JSON.stringify(pgPath)+';export class Client extends pg.Client {async query(sql,values){const f=globalThis.__tenantAuthorityFixture;f.queries.push({sql,values});const result=await super.query(sql,values);if(!sql.startsWith("SELECT u.id")||!result.rows.length||f.mode===null)return result;const row={...result.rows[0]};if(f.mode==="valid")return {...result,rows:[Object.freeze(Object.assign(Object.create(null),row))]};row.tenant_id=f.tenant;return {...result,rows:[row]};}}'}));
}};
await build({entryPoints:['cloudflare/workers/src/service.ts'],outfile:join(directory,'service.cjs'),bundle:true,platform:'node',format:'cjs',plugins:[plugin],external:[pgPath]});
await build({entryPoints:['cloudflare/workers/src/gateway.ts'],outfile:join(directory,'gateway.cjs'),bundle:true,platform:'node',format:'cjs'});
const service=require(join(directory,'service.cjs')).default,gateway=require(join(directory,'gateway.cjs')).default;
const db=new Client({connectionString:url.href});await db.connect();
const user=randomUUID(),tenant=randomUUID(),client=randomUUID(),provider=randomUUID(),token='R'.repeat(43),tables=[];let checks=0;
globalThis.__tenantAuthorityFixture={mode:null,queries:[]};
const call=(serviceName,path,headers={})=>gateway.fetch(new Request('https://fixture/v1/'+serviceName+path,{headers:{authorization:'Bearer '+token,...headers}}),{[serviceName.toUpperCase()]:{fetch:r=>service.fetch(r,{DB_URL:url.href,SERVICE_NAME:serviceName})}});
const snapshot=async()=>Object.fromEntries(await Promise.all([...tables,'users','auth_sessions','auth_account_audit','auth_management_audit'].map(async table=>[table,(await db.query('SELECT * FROM '+table+' ORDER BY '+(table==='auth_sessions'?'token_hash':'id'))).rows])));
try {
 await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'ceo',$3,'unused','active')",[user,user+'@example.invalid',tenant]);
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
 for(const [name,path] of [['client','/invoices'],['client','/invoices/summary'],['provider','/documents'],['provider','/documents/summary'],['auth','/me/notifications'],['auth','/admin/users?search='+user],['auth','/admin/users/audit?userId='+user],['auth','/user/sessions']]) {
  for(const [mode,scope,status] of [[null,tenant,200],['valid',tenant,200],...[' ',' bad','tenant/other','tenant.other','tenant\nother','a'.repeat(201),1,false,{}].map(scope=>['fault',scope,503]),...['',null,undefined].map(scope=>['fault',scope,403])]) {
   globalThis.__tenantAuthorityFixture={mode,tenant:scope,queries:[]};
   const response=await call(name,path,{'x-tenant-id':tenant});assert.equal(response.status,status,name+path+' '+String(scope));assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('set-cookie'),null);assert.ok(!(await response.text()).includes('private'));
   const queries=globalThis.__tenantAuthorityFixture.queries;assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>/^(COMMIT|INSERT|UPDATE|DELETE)/.test(q.sql)));
   if(status!==200)assert.equal(queries.filter(q=>q.sql.startsWith('SELECT')).length,1,'invalid scope stops before owned SQL');
   else assert.ok(queries.some(q=>q.sql.startsWith('SELECT')&&!q.sql.startsWith('SELECT u.id')&&q.values?.includes(path==='/user/sessions'?user:tenant)),'valid scope must bind the ownership SQL');
   assert.deepEqual(await snapshot(),before);checks++;
  }
  globalThis.__tenantAuthorityFixture={mode:null,queries:[]};assert.equal((await call(name,path,{'x-tenant-id':randomUUID()})).status,403);assert.equal(globalThis.__tenantAuthorityFixture.queries.filter(q=>q.sql.startsWith('SELECT')).length,1);assert.equal(globalThis.__tenantAuthorityFixture.queries.at(-1).sql,'ROLLBACK');checks++;
 }
 assert.deepEqual(await snapshot(),before);
 console.log(`Tenant authority validation passed ${checks} real PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
} finally {
 globalThis.__tenantAuthorityFixture={mode:null,queries:[]};
 for(const table of tables.reverse())await db.query('DROP TABLE '+table);
 await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[user]);await db.query('DELETE FROM users WHERE id::text=$1',[user]);
 await db.end();await rm(directory,{recursive:true,force:true});delete globalThis.__tenantAuthorityFixture;
}
