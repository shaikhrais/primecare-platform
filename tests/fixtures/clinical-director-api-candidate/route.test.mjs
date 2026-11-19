// Real gateway + ServiceWorker + session adapter + SQL, using disposable PGlite only.
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createRequire} from 'node:module';
import {readFile,mkdtemp,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {build} from 'esbuild';
if (['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DB_URL'].some(key=>Object.hasOwn(process.env,key))) throw Error('Isolated fixtures only');
const require=createRequire(import.meta.url);
const {PGlite}=require(process.env.PGLITE_FIXTURE_MODULE);
const temp=await mkdtemp(join(tmpdir(),'clinical-route-'));
const root=fileURLToPath(new URL('../../../',import.meta.url));
const bundle=async(entry,name,plugins=[])=>{
 const outfile=join(temp,name+'.cjs');await build({entryPoints:[join(root,entry)],outfile,bundle:true,platform:'node',format:'cjs',packages:'external',plugins});return require(outfile);
};
const pg={name:'isolated-pg',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:`export class Client {async connect(){} async end(){} async query(sql,args){globalThis.clinicalQueries.push([sql,args]);const result=await globalThis.clinicalFixture.query(sql,args);if(sql.startsWith('BEGIN'))globalThis.clinicalReadModes.push((await globalThis.clinicalFixture.query('SHOW transaction_read_only')).rows[0].transaction_read_only);return result;}}`,loader:'js'}));}};
try {
 const {ServiceWorker}=await bundle('cloudflare/workers/src/service.ts','service',[pg]);
 const {GatewayWorker}=await bundle('cloudflare/workers/src/gateway.ts','gateway');
 const db=new PGlite();globalThis.clinicalFixture=db;globalThis.clinicalQueries=[];globalThis.clinicalReadModes=[];
 const token=id=>id.repeat(43),hash=t=>createHash('sha256').update(t).digest('hex');
 await db.exec(`CREATE TABLE tenants(id text PRIMARY KEY,status text);
 CREATE TABLE users(id text PRIMARY KEY,tenant_id text,roles text,status text);
 CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id text,expires_at timestamptz);
 INSERT INTO tenants VALUES('a','active'),('b','active');
 INSERT INTO users VALUES('director','a','clinical_director','active'),('foreign','b','clinical_director','active'),('admin','a','tenant_admin','active'),('empty','a','clinical_director','active');`);
 for(const [t,id] of [['a','director'],['b','foreign'],['c','admin'],['d','empty']])await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+interval '1 day')",[hash(token(t)),id]);
 await db.exec(await readFile(new URL('./migration-review.sql',import.meta.url),'utf8'));
 const worker=new ServiceWorker(),gateway=new GatewayWorker(),env={SERVICE_NAME:'governance',DB_URL:'fixture-only'};
 let calls=0;
 const bindings={GOVERNANCE:{fetch:r=>{calls++;return worker.fetch(r,env);}}};
 await test('OpenAPI contract matches sanitized gateway dependency failure',async()=>{
   const doc=JSON.parse(await readFile(new URL('./api-only-contract.openapi.json',import.meta.url),'utf8'));
   const spec=doc.paths['/v1/clinical/dashboard'].get.responses;
   assert.deepEqual(Object.keys(spec).sort(),['200','400','401','403','405','429','503']);
   const request=new Request('https://fixture.test/v1/clinical/dashboard');
   const broken={GOVERNANCE:{fetch:async()=>{throw Error('private fixture detail');}}};
   const r=await gateway.fetch(request,broken);
   assert.equal(r.status,503);
   assert.equal(r.headers.get('cache-control'),spec['503'].headers['Cache-Control'].schema.enum[0]);
   assert.deepEqual(await r.json(),spec['503'].content['application/json'].examples.unavailable.value);
 });
 const call=(t='a',suffix='',options={})=>gateway.fetch(new Request('https://fixture.test/v1/clinical/dashboard'+suffix,{...options,headers:{...(t?{authorization:'Bearer '+token(t)}:{}),...options.headers}}),bindings);
 await test('real route: empty authority gives no scope, never zero metrics',async()=>{const r=await call();assert.equal(r.status,403);assert.deepEqual(await r.json(),{error:'no_scope'});assert.equal(r.headers.get('cache-control'),'no-store');});
 await db.exec(`INSERT INTO clinical_verified_branches VALUES('a','east','fixture',NOW()-interval '1 day',NULL),('b','east','fixture',NOW()-interval '1 day',NULL);
 INSERT INTO clinical_branch_director_grants VALUES('a','east','director',NOW()-interval '1 day',NOW()+interval '1 day',NULL);`);
 await test('counts distinct branches only for current actor and tenant, including duplicate effective rows',async()=>{
 assert.deepEqual(await (await call()).json(),{assignedVerifiedBranchCount:1});
 assert.deepEqual(await (await call('b')).json(),{error:'no_scope'});
 assert.deepEqual(await (await call('d')).json(),{error:'no_scope'});
 await db.exec("INSERT INTO clinical_verified_branches VALUES('a','west','fixture',NOW()-interval '1 day',NULL); INSERT INTO clinical_branch_director_grants VALUES('a','west','director',NOW()-interval '1 day',NOW()+interval '1 day',NULL),('a','east','director',NOW()-interval '3 days',NOW()-interval '1 day',NOW()-interval '2 days'),('b','east','foreign',NOW()-interval '1 day',NOW()+interval '1 day',NULL),('a','west','empty',NOW()-interval '1 day',NOW()+interval '1 day',NULL)");
 const definition=(await db.query("SELECT pg_get_viewdef('clinical_branch_director_effective_scope'::regclass,true) AS sql")).rows[0].sql.trim().replace(/;$/,'');
 await db.exec('CREATE OR REPLACE VIEW clinical_branch_director_effective_scope AS '+definition+' UNION ALL '+definition);
 try {
  assert.deepEqual(await (await call()).json(),{assignedVerifiedBranchCount:2});
  assert.deepEqual(await (await call('b')).json(),{assignedVerifiedBranchCount:1});
  assert.deepEqual(await (await call('d')).json(),{assignedVerifiedBranchCount:1});
  const q=globalThis.clinicalQueries.find(([sql])=>sql.includes('COUNT(DISTINCT branch_id)'));
  assert.match(q[0],/tenant_id=\$1 AND director_user_id=\$2/);assert.deepEqual(q[1],['a','director']);
 } finally {
  await db.exec('CREATE OR REPLACE VIEW clinical_branch_director_effective_scope AS '+definition);
  await db.exec("DELETE FROM clinical_branch_director_grants WHERE branch_id='west' OR revoked_at IS NOT NULL OR director_user_id IN ('foreign','empty'); DELETE FROM clinical_verified_branches WHERE branch_id='west'");
 }
 });
 await test('session, role, input and method gates',async()=>{
 assert.equal((await call(null)).status,401);assert.equal((await call('z')).status,401);assert.equal((await call('c')).status,403);
 for(const suffix of ['?tenant=b','?branch=east','?userId=foreign','?from=2020-01-01','?status=pending','?windowHours=24'])assert.equal((await call('a',suffix)).status,400);
 assert.equal((await call('a','',{headers:{'x-tenant-id':'a'}})).status,400);
 for(const path of ['/v1/governance/v1/clinical/dashboard','/api/governance/v1/clinical/dashboard','/v1/clinical/dashboard-dup-1'])assert.equal((await gateway.fetch(new Request('https://fixture.test'+path,{headers:{authorization:'Bearer '+token('a')}}),bindings)).status,404);
 const before=calls;assert.equal((await call('a','',{method:'POST'})).status,405);assert.equal(calls,before);
 assert.equal((await worker.fetch(new Request('https://fixture.test/v1/clinical/dashboard'),{...env,SERVICE_NAME:'client'})).status,404);
 });
 await test('configured source limiter denies before database reads',async()=>{
 const before=globalThis.clinicalQueries.length;
 env.WORKSPACE_SOURCE_LIMIT={limit:async()=>({success:false})};const r=await call();assert.equal(r.status,429);assert.equal(r.headers.get('retry-after'),'60');assert.equal(globalThis.clinicalQueries.length,before);
 env.WORKSPACE_SOURCE_LIMIT={limit:async()=>({success:'yes'})};assert.equal((await call()).status,503);assert.equal(globalThis.clinicalQueries.length,before);delete env.WORKSPACE_SOURCE_LIMIT;
 });
 await test('scope changes take effect on next request',async()=>{
 for(const [change,undo,status] of [
 ["UPDATE clinical_branch_director_grants SET granted_at=NOW()+interval '1 hour'","UPDATE clinical_branch_director_grants SET granted_at=NOW()-interval '1 day'",403],
 ["UPDATE clinical_branch_director_grants SET revoked_at=NOW()","UPDATE clinical_branch_director_grants SET revoked_at=NULL",403],
 ["UPDATE clinical_verified_branches SET retired_at=NOW()","UPDATE clinical_verified_branches SET retired_at=NULL",403],
 ["UPDATE clinical_verified_branches SET verified_at=NOW()+interval '1 day'","UPDATE clinical_verified_branches SET verified_at=NOW()-interval '1 day'",403],
 ["UPDATE clinical_branch_director_grants SET expires_at=NOW()-interval '1 hour'","UPDATE clinical_branch_director_grants SET expires_at=NOW()+interval '1 day'",403],
 ["UPDATE users SET tenant_id='b' WHERE id='director'","UPDATE users SET tenant_id='a' WHERE id='director'",403],
 ["UPDATE users SET roles='tenant_admin' WHERE id='director'","UPDATE users SET roles='clinical_director' WHERE id='director'",403],
 ["UPDATE users SET status='inactive' WHERE id='director'","UPDATE users SET status='active' WHERE id='director'",401],
 ["UPDATE tenants SET status='inactive' WHERE id='a'","UPDATE tenants SET status='active' WHERE id='a'",401],
 ["UPDATE auth_sessions SET expires_at=NOW()-interval '1 hour'","UPDATE auth_sessions SET expires_at=NOW()+interval '1 day'",401]
 ]) {await db.exec(change);assert.equal((await call()).status,status,change);await db.exec(undo);assert.deepEqual(await (await call()).json(),{assignedVerifiedBranchCount:1});}
 });
 await test('scope database permission denied is unavailable without details',async()=>{
 await db.exec('CREATE ROLE clinical_read_fixture; GRANT USAGE ON SCHEMA public TO clinical_read_fixture; GRANT SELECT ON users,tenants,auth_sessions TO clinical_read_fixture; SET ROLE clinical_read_fixture');
 const r=await call();assert.equal(r.status,503);assert.deepEqual(await r.json(),{error:'unavailable'});await db.exec('RESET ROLE');
 });
 await test('minimum column grants suffice without underlying authority-table access (fixture only)',async()=>{
 await db.exec('REVOKE ALL ON users,tenants,auth_sessions FROM clinical_read_fixture; GRANT SELECT(id,tenant_id,roles,status) ON users TO clinical_read_fixture; GRANT SELECT(id,status) ON tenants TO clinical_read_fixture; GRANT SELECT(token_hash,user_id,expires_at) ON auth_sessions TO clinical_read_fixture; GRANT SELECT(tenant_id,director_user_id,branch_id) ON clinical_branch_director_effective_scope TO clinical_read_fixture; SET ROLE clinical_read_fixture');
 try {
  const results=await db.exec(await readFile(new URL('./runtime-read-preflight.sql',import.meta.url),'utf8'));
  const checks=Object.assign({},...results.flatMap(result=>result.rows));
  assert.deepEqual(checks,{public_schema_usage:true,not_superuser_or_bypassrls:true,minimum_read_columns_available:true,authority_tables_exist:true,no_clinical_write_privileges:true,scope_is_view:true,reviewed_owner_rights_view_mode:true,runtime_cannot_assume_scope_owner:true,empty_scope_query_compiles:true});
  const r=await call();assert.equal(r.status,200);assert.deepEqual(await r.json(),{assignedVerifiedBranchCount:1});
  assert.equal((await call('b')).status,403);
 } finally {await db.exec('RESET ROLE');}
 });
 await test('missing view is unavailable; request handler performs no writes',async()=>{await db.exec('DROP VIEW clinical_branch_director_effective_scope');const r=await call();assert.equal(r.status,503);assert.deepEqual(await r.json(),{error:'unavailable'});assert.ok(globalThis.clinicalQueries.every(([q])=>/^(SELECT|BEGIN|ROLLBACK)/.test(q)));assert.ok(globalThis.clinicalQueries.every(([q])=>! /\bbookings\b/i.test(q)));assert.ok(globalThis.clinicalReadModes.length>0);assert.ok(globalThis.clinicalReadModes.every(mode=>mode==='on'));});
 await db.close();
} finally {await rm(temp,{recursive:true,force:true});delete globalThis.clinicalFixture;delete globalThis.clinicalQueries;delete globalThis.clinicalReadModes;}
