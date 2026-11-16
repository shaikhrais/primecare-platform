import {test} from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import {build} from 'esbuild';
import {mkdtemp,readFile,writeFile,mkdir} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join,resolve} from 'node:path';
import {createRequire} from 'node:module';
import {createHash,randomUUID,randomBytes} from 'node:crypto';

// This diagnostic probe is deliberately GitHub-only, disposable and credential isolated.
if(process.env.GITHUB_ACTIONS!=='true')throw Error('Run this diagnostic only in GitHub Actions');
const connection=process.env.PLATFORM_TEST_DATABASE_URL;
if(!connection||process.env.PRODUCTION_DATABASE_URL||process.env.DATABASE_URL||process.env.DB_URL)throw Error('Only the disposable fixture connection is permitted');
const url=new URL(connection);
if(!['postgres:','postgresql:'].includes(url.protocol)||!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/platform_audit_test'||url.search||url.hash)throw Error('Disposable loopback platform_audit_test only');
const commit=process.env.GITHUB_SHA;
if(!/^[a-f0-9]{40}$/.test(commit??''))throw Error('Exact GitHub source SHA required');
const dir=await mkdtemp(join(tmpdir(),'tenant-admin-audit-')),file=join(dir,'handler.cjs');
await build({entryPoints:['cloudflare/workers/src/platform-administration.ts'],bundle:true,platform:'node',format:'cjs',outfile:file,external:['pg']});
await writeFile(file,(await readFile(file,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(resolve('node_modules/pg'))})`));
const {platformAdministration}=createRequire(import.meta.url)(file),summary={sourceCommit:commit,workflowId:'platform.review-administration-audit',candidateScope:'tenant_admin_safe_state_without_actor',diagnosticOnly:false,workflowAccepted:false,workflowStatus:'missing',syntheticOnly:true,productionAccess:false,results:[]};
const hash=value=>createHash('sha256').update(value).digest('hex');
for(const identity of ['uuid','text']){
 const db=new pg.Client({connectionString:connection});await db.connect();const schema='audit_acceptance_'+randomUUID().replaceAll('-','');
 try{
  await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
  await db.query(`CREATE TABLE tenants(id ${identity} PRIMARY KEY,name text,slug text,status text,created_at timestamptz DEFAULT NOW());CREATE TABLE users(id ${identity} PRIMARY KEY,tenant_id ${identity} REFERENCES tenants(id),roles text,status text);CREATE TABLE auth_sessions(user_id ${identity} REFERENCES users(id),token_hash text,expires_at timestamptz)`);
  await db.query(await readFile('packages/database/migrations/20261011_platform_administration.sql','utf8'));
  const ident=name=>identity==='uuid'?randomUUID():'synthetic-'+name;
  const tenant=ident('tenant'),other=ident('other'),actor=ident('actor'),staff=ident('staff'),stranger=ident('stranger'),target=ident('target'),codeAdmin=ident('code-admin');
  for(const [id,name]of [[tenant,'Synthetic own tenant'],[other,'Synthetic other tenant']])await db.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,$2,$3,'active')",[id,name,String(id)]);
  const tokens=new Map();
  for(const [id,tid,role]of [[actor,tenant,'tenant_admin'],[staff,tenant,'psw'],[stranger,other,'tenant_admin'],[codeAdmin,tenant,'code_admin']]){
   const token=randomBytes(32).toString('base64url');tokens.set(id,token);
   await db.query("INSERT INTO users VALUES($1,$2,$3,'active')",[id,tid,role]);await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour')",[id,hash(token)]);
  }
  const expected=[];
  for(let i=0;i<103;i++){
   const id=randomUUID(),before={role:'psw',status:'active'},after={role:'psw',status:i%2?'inactive':'active'};
   // Unknown state is a harmless canary, never a credential or a real audit record.
   if(i===102){before.unregisteredAuditField='SYNTHETIC_UNAPPROVED_FIELD';after.unregisteredAuditField='SYNTHETIC_UNAPPROVED_FIELD';}
   await db.query("INSERT INTO platform_administration_audit(id,actor_id,tenant_id,target_id,action,previous_state,current_state,created_at) VALUES($1,$2,$3,$4,'account_updated',$5,$6,'2026-01-01T00:00:00Z'::timestamptz+($7::int/2)*INTERVAL '1 second')",[id,actor,tenant,target,JSON.stringify(before),JSON.stringify(after),i]);expected.push(id);
  }
  await db.query("INSERT INTO platform_administration_audit(actor_id,tenant_id,target_id,action,previous_state,current_state) VALUES($1,$2,'synthetic-foreign-target','account_updated','{}','{\"role\":\"psw\",\"status\":\"inactive\"}')",[stranger,other]);
  const demoEvent=randomUUID();await db.query("INSERT INTO platform_administration_audit(id,actor_id,tenant_id,target_id,action,previous_state,current_state) VALUES($1,$2,$3,$4,'tenant_created','{}',$5)",[demoEvent,codeAdmin,tenant,String(tenant),JSON.stringify({slug:'synthetic-care',name:'Synthetic care',demoDataset:{version:'approved-code-admin-demo-v1',synthetic:true}})]);
  const databaseUrl=new URL(connection);databaseUrl.searchParams.set('options',`-c search_path=${schema}`);const env={SERVICE_NAME:'governance',DB_URL:databaseUrl.toString()};
  const call=(who=actor,tid=tenant,{suffix='/audit',method='GET',extra={},body}={})=>{
   const path='/platform/tenants/'+tid+suffix;
   return platformAdministration(new Request('https://fixture.invalid'+path,{method,headers:{authorization:'Bearer '+(tokens.get(who)||'invalid'),...extra},...(body===undefined?{}:{body:JSON.stringify(body)})}),env,path.split('?')[0],{});
  };
  const state=async()=>({audit:(await db.query('SELECT COUNT(*)::int AS n FROM platform_administration_audit')).rows[0].n,requests:(await db.query('SELECT COUNT(*)::int AS n FROM platform_administration_requests')).rows[0].n,rates:(await db.query('SELECT COUNT(*)::int AS n FROM platform_administration_rate')).rows[0].n});
  const before=await state();let response;
  await test('diagnostic '+identity+' existing audit path is tenant scoped, read-only and rejects overrides',async()=>{
   const root=await platformAdministration(new Request('https://fixture.invalid/platform',{headers:{authorization:'Bearer '+tokens.get(actor)}}),env,'/platform',{});assert.equal(root.status,200);const capabilities=await root.json();assert.equal(capabilities.role,'tenant_admin');assert.equal(capabilities.scope,'tenant');assert.equal(capabilities.canCreateTenant,false);assert.deepEqual(capabilities.tenants.map(t=>t.id),[tenant]);
   assert.equal((await call('missing')).status,401);assert.equal((await call(staff)).status,403);assert.equal((await call(stranger)).status,403);
   assert.equal((await call(actor,other)).status,403);assert.equal((await call(actor,tenant,{extra:{'x-tenant-id':other}})).status,400);
   assert.equal((await call(actor,tenant,{suffix:'/audit?tenantId='+other})).status,400);assert.equal((await call(actor,tenant,{method:'DELETE'})).status,405);
   const read=await call();assert.equal(read.status,200);assert.equal(read.headers.get('cache-control'),'no-store');response=await read.json();assert.equal(Array.isArray(response.events),true);
   assert.equal(response.events.some(e=>e.target_id==='synthetic-foreign-target'),false);assert.deepEqual(await state(),before);
  });
  if(!response)continue;
  await test('diagnostic '+identity+' existing audit ordering and reload match authoritative scoped SQL',async()=>{
   const rows=(await db.query('SELECT id::text,action,target_id,previous_state,current_state,created_at FROM platform_administration_audit WHERE tenant_id=$1 ORDER BY created_at DESC,id DESC LIMIT 100',[tenant])).rows;
   assert.equal(response.events.length,100);assert.deepEqual(response.events.map(e=>e.id),rows.map(e=>e.id));assert.equal(new Set(response.events.map(e=>e.id)).size,100);
   // Compare only declared historical fields. No audit row is printed or exported.
   for(let i=0;i<rows.length;i++){assert.equal(response.events[i].action,rows[i].action);assert.equal(response.events[i].target_id,rows[i].target_id);for(const field of ['role','status']){assert.equal(response.events[i].previous_state?.[field],rows[i].previous_state[field]);assert.equal(response.events[i].current_state?.[field],rows[i].current_state[field]);}assert.equal(response.events[i].created_at,rows[i].created_at.toISOString());}
   const reload=await call();assert.equal(reload.status,200);assert.deepEqual((await reload.json()).events,response.events);assert.deepEqual(await state(),before);
  });
  const actorProjected=response.events.every(e=>e.actor_id===actor),unknownStateRedacted=!JSON.stringify(response.events).includes('SYNTHETIC_UNAPPROVED_FIELD');
  summary.results.push({identity,returnedCount:response.events.length,actorIdentityProjected:actorProjected,unknownStateRedacted});
  // Open contract gaps are observations, not accepted behavior or passing workflow acceptance.
  summary.results.at(-1).remainingMissing=[...(!actorProjected?['actor_identity_contract_and_projection']:[]),...(!unknownStateRedacted?['safe_before_after_allowlist']:[])];
  await test(identity+' tenant-admin projection removes arbitrary state without adding actor fields',()=>{
   assert.equal(unknownStateRedacted,true);assert.equal(response.events.every(e=>!Object.hasOwn(e,'actor_id')),true);
   for(const event of response.events)assert.deepEqual(Object.keys(event).sort(),['action','created_at','current_state','id','previous_state','target_id']);
   const demo=response.events.find(e=>e.id===demoEvent);assert.ok(demo);assert.deepEqual(demo.current_state,{slug:'synthetic-care',name:'Synthetic care'});assert.deepEqual(demo.previous_state,{});
  });
  await test(identity+' legacy code-admin demo consumer retains its exact existing state',async()=>{
   const raw=await call(codeAdmin);assert.equal(raw.status,200);const legacy=(await raw.json()).events.find(e=>e.id===demoEvent);assert.ok(legacy);assert.equal(legacy.current_state.demoDataset.version,'approved-code-admin-demo-v1');assert.equal(legacy.current_state.demoDataset.synthetic,true);assert.deepEqual(await state(),before);
  });
  await test(identity+' malformed known historical fields fail closed for tenant-admin without leaking values',async()=>{
   const saved=(await db.query("SELECT id,current_state FROM platform_administration_audit WHERE tenant_id=$1 AND action='account_updated' ORDER BY created_at DESC,id DESC LIMIT 1",[tenant])).rows[0];
   try{await db.query('UPDATE platform_administration_audit SET current_state=$1 WHERE id=$2',[JSON.stringify({role:'psw',status:{unapproved:'SYNTHETIC_BAD_STATE'}}),saved.id]);const failed=await call();assert.equal(failed.status,503);assert.equal((await failed.text()).includes('SYNTHETIC_BAD_STATE'),false);}finally{await db.query('UPDATE platform_administration_audit SET current_state=$1 WHERE id=$2',[JSON.stringify(saved.current_state),saved.id]);}
   const reloaded=await call();assert.equal(reloaded.status,200);assert.deepEqual((await reloaded.json()).events,response.events);assert.deepEqual(await state(),before);
  });
  await test('diagnostic '+identity+' inactive session or tenant cannot retain the historical read',async()=>{
   await db.query("UPDATE users SET status='inactive' WHERE id=$1",[actor]);assert.equal((await call()).status,401);await db.query("UPDATE users SET status='active' WHERE id=$1",[actor]);
   await db.query("UPDATE tenants SET status='inactive' WHERE id=$1",[tenant]);assert.equal((await call()).status,403);assert.deepEqual(await state(),before);
  });
 }finally{
  await db.query('SET search_path TO public');await db.query(`DROP SCHEMA IF EXISTS ${schema} CASCADE`);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=$1',[schema])).rows[0].n,0);await db.end();
 }
}
await mkdir('test-results/tenant-administration-audit',{recursive:true});await writeFile('test-results/tenant-administration-audit/safe-api-summary.json',JSON.stringify(summary,null,2)+'\n');
