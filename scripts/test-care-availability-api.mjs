// Sequential embedded PostgreSQL checks. No browser/login/concurrency claim.
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createRequire} from 'node:module';
import {readFile,writeFile,mkdtemp,mkdir} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join,resolve} from 'node:path';
import {createHash} from 'node:crypto';
import {build} from 'esbuild';
import {PGlite} from '@electric-sql/pglite';
const require=createRequire(import.meta.url),directory=await mkdtemp(join(tmpdir(),'care-api-fixture-'));
const database=new PGlite();
// All calls share one in-memory instance and run sequentially. Never use for concurrency tests.
globalThis.__careFixtureDatabase=database;
const adapter=join(directory,'adapter.cjs');
await writeFile(adapter,`exports.Client=class {async connect(){} async end(){} async query(sql,params){return params?.length?globalThis.__careFixtureDatabase.query(sql,params):((await globalThis.__careFixtureDatabase.exec(sql)).at(-1)||{rows:[]});}};`);
const bundle=join(directory,'care.cjs');
await build({entryPoints:['cloudflare/workers/src/care/service.ts'],bundle:true,platform:'node',format:'cjs',outfile:bundle,external:['pg']});
await writeFile(bundle,(await readFile(bundle,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(adapter)})`));
const {careDelivery}=require(bundle);
const contractFile=join(directory,'contract.cjs');await build({entryPoints:['packages/shared/src/care/contract.ts'],bundle:true,platform:'node',format:'cjs',outfile:contractFile});const contract=require(contractFile);
const hash=token=>createHash('sha256').update(token).digest('hex');
const db=new (require(adapter).Client)(),type='uuid',ids={},profiles={},tokens=new Map();
const uid=()=>crypto.randomUUID(),tenant=uid(),other=uid();
try{
  await db.query(`CREATE TABLE tenants(id ${type} PRIMARY KEY,status text);CREATE TABLE users(id ${type} PRIMARY KEY,tenant_id ${type} REFERENCES tenants(id),email text,roles text,status text);CREATE TABLE auth_sessions(user_id ${type} REFERENCES users(id),token_hash text,expires_at timestamptz);CREATE TABLE provider_profiles(id ${type} PRIMARY KEY,user_id ${type} UNIQUE REFERENCES users(id),tenant_id ${type} REFERENCES tenants(id),is_approved boolean,has_completed_induction boolean,is_locked_for_retraining boolean,full_name text,languages text,service_areas text,provider_type text,skills text,approved_at timestamptz,created_at timestamptz);CREATE TABLE client_profiles(id ${type} PRIMARY KEY,user_id ${type} REFERENCES users(id),tenant_id ${type} REFERENCES tenants(id),full_name text);CREATE TABLE services(id ${type} PRIMARY KEY,name text NOT NULL,tenant_id ${type} REFERENCES tenants(id),is_active boolean);CREATE TABLE visits(id ${type} PRIMARY KEY,service_id ${type} NOT NULL REFERENCES services(id),required_skills text NOT NULL,created_at timestamptz DEFAULT NOW(),service_address_line2 text,service_province text,service_lat double precision,service_lng double precision,client_notes text,coordinator_notes text,cancellation_reason text,tenant_id ${type} REFERENCES tenants(id),client_id ${type} REFERENCES client_profiles(id),assigned_provider_id ${type} REFERENCES provider_profiles(id),status text,requested_start_at timestamptz,duration_minutes integer,updated_at timestamptz DEFAULT NOW(),service_address_line1 text,service_city text,service_postal_code text)`);
  for(const file of ['20261017_care_delivery.sql','20261018_care_task_workflows.sql','20261019_care_staffing.sql','20261020_care_schedules_time.sql','20261021_care_handover_followups.sql','20261022_care_task_deadline_requests.sql','20261023_care_task_workload.sql','20261024_care_task_dependencies.sql']){const migration=await readFile('packages/database/migrations/'+file,'utf8');await db.query(migration);await db.query(migration);}
  await db.query("INSERT INTO tenants VALUES($1,'active'),($2,'active')",[tenant,other]);
  const roles={director:'clinical_director',supervisor:'rn_field_supervisor',rn:'rn',rpn:'rpn',psw:'psw',hsw:'hsw',psw2:'psw',unverified:'psw',newrn:'rn',newpsw:'psw',onboard_ui:'psw',scheduler:'scheduler',admin:'tenant_admin',owner:'owner',marketing:'growth_meta',global:'central_admin',foreign:'psw',client:'client'};
  for(const [key,role] of Object.entries(roles)){
   ids[key]=uid(key);await db.query("INSERT INTO users VALUES($1,$2,$3,$4,'active')",[ids[key],key==='foreign'?other:tenant,key+'@example.test',role]);const token=Buffer.from(crypto.getRandomValues(new Uint8Array(32))).toString('base64url');tokens.set(key,token);await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 day')",[ids[key],hash(token)]);
   if(!['newrn','newpsw','onboard_ui'].includes(key)&&(contract.registry.nurseRoles.includes(role)||contract.registry.supportRoles.includes(role))){profiles[key]=uid(key+'-profile');await db.query('INSERT INTO provider_profiles(id,user_id,tenant_id,is_approved,has_completed_induction,is_locked_for_retraining) VALUES($1,$2,$3,TRUE,TRUE,FALSE)',[profiles[key],ids[key],key==='foreign'?other:tenant]);}
  }

 const env={SERVICE_NAME:'governance',DB_URL:'postgres://embedded/isolated-synthetic'};
 const call=async(actor,body,status=200,key=crypto.randomUUID(),headers={})=>{
  const response=await careDelivery(new Request('http://test/care/staffing',{method:'POST',headers:{authorization:'Bearer '+tokens.get(actor),'content-type':'application/json','idempotency-key':key,...headers},body:JSON.stringify(body)}),env,'/care/staffing',{});
  const data=await response.json();assert.equal(response.status,status,JSON.stringify(data));return data;
 };
 const body={action:'availability',staffId:ids.psw,startsAt:new Date(Date.now()+3600000).toISOString(),endsAt:new Date(Date.now()+7200000).toISOString(),note:'Synthetic availability fixture'};
 let saved;
 await test('authenticated PSW availability persists with audit and duplicate receipt',async()=>{
  const key=crypto.randomUUID();saved=await call('psw',body);const second=await call('psw',{...body,note:'Synthetic replay'},200,key);assert.deepEqual(await call('psw',{...body,note:'Synthetic replay'},200,key),second);
  const rows=(await db.query('SELECT * FROM care_staff_windows WHERE id=$1',[saved.id])).rows;assert.equal(rows.length,1);assert.equal(rows[0].tenant_id,tenant);assert.equal(rows[0].staff_id,ids.psw);assert.equal(rows[0].status,'active');
  assert.equal((await db.query('SELECT * FROM care_staffing_events WHERE window_id=$1',[saved.id])).rows.length,1);
 });
 await test('role denial, foreign staff and forged tenant leave no writes',async()=>{
  const count=async()=>Number((await db.query('SELECT count(*) n FROM care_staff_windows')).rows[0].n),before=await count();
  await call('owner',body,403);await call('psw',{...body,staffId:ids.psw2},403);await call('psw',{...body,staffId:ids.foreign},400);await call('psw',body,400,undefined,{'x-tenant-id':other});assert.equal(await count(),before);
 });
 await test('fresh API read returns saved data and foreign tenant cannot withdraw it',async()=>{
  const response=await careDelivery(new Request('http://test/care?enable-semantics=true',{headers:{authorization:'Bearer '+tokens.get('psw')}}),env,'/care',{});
  // API query schema intentionally rejects the browser-only semantics parameter.
  assert.equal(response.status,400);
  const read=await careDelivery(new Request('http://test/care',{headers:{authorization:'Bearer '+tokens.get('psw')}}),env,'/care',{});
  const data=await read.json();assert.equal(read.status,200,JSON.stringify(data));assert.ok(data.staffing.records.some(w=>w.id===saved.id&&w.status==='active'));
  await call('foreign',{action:'withdraw',id:saved.id,version:1,note:'Synthetic foreign attempt'},404);
  assert.equal((await db.query('SELECT status FROM care_staff_windows WHERE id=$1',[saved.id])).rows[0].status,'active');
 });
 await test('audit insertion failure rolls back write and permits safe retry',async()=>{
  const key=crypto.randomUUID(),before=Number((await db.query('SELECT count(*) n FROM care_staff_windows')).rows[0].n);
  await db.query("CREATE FUNCTION fixture_reject_event() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Synthetic audit failure'; END $$; CREATE TRIGGER fixture_reject_event BEFORE INSERT ON care_staffing_events FOR EACH ROW EXECUTE FUNCTION fixture_reject_event()");
  try{await call('psw',body,503,key);assert.equal(Number((await db.query('SELECT count(*) n FROM care_staff_windows')).rows[0].n),before);assert.equal((await db.query('SELECT * FROM care_requests WHERE idempotency_key=$1',[key])).rows.length,0);}finally{await db.query('DROP TRIGGER fixture_reject_event ON care_staffing_events; DROP FUNCTION fixture_reject_event()');}
  await call('psw',body,200,key);assert.equal(Number((await db.query('SELECT count(*) n FROM care_staff_windows')).rows[0].n),before+1);
 });
 await test('invalid dates, expired session and changed replay cannot mutate records',async()=>{
  await call('psw',{...body,endsAt:body.startsAt},400);
  const key=crypto.randomUUID();await call('psw',body,200,key);await call('psw',{...body,note:'Different payload'},409,key);
  await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 hour' WHERE user_id=$1",[ids.psw]);await call('psw',body,401);
 });
}finally{await database.close();delete globalThis.__careFixtureDatabase;}
