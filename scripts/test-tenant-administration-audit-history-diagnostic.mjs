import assert from 'node:assert/strict';
import {test} from 'node:test';
import {createHash,randomUUID,randomBytes} from 'node:crypto';
import {readFile,writeFile,mkdir,mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join,resolve} from 'node:path';
import {createRequire} from 'node:module';
import {build} from 'esbuild';
import pg from 'pg';

// Diagnostic only: does not accept partial history, repair rows, or change authorization.
assert.equal(process.env.GITHUB_ACTIONS,'true','Run only in GitHub Actions');
assert.match(process.env.GITHUB_SHA??'',/^[a-f0-9]{40}$/);
if(process.env.PRODUCTION_DATABASE_URL||process.env.DATABASE_URL||process.env.DB_URL)throw Error('External database variables forbidden');
const connection=process.env.PLATFORM_TEST_DATABASE_URL,url=new URL(connection);
if(!['postgres:','postgresql:'].includes(url.protocol)||!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/platform_audit_history_test'||url.search||url.hash)throw Error('Disposable loopback fixture only');
const dir=await mkdtemp(join(tmpdir(),'audit-history-')),file=join(dir,'handler.cjs');
await build({entryPoints:['cloudflare/workers/src/platform-administration.ts'],bundle:true,platform:'node',format:'cjs',outfile:file,external:['pg']});
await writeFile(file,(await readFile(file,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(resolve('node_modules/pg'))})`));
const {platformAdministration}=createRequire(import.meta.url)(file);
const summary={sourceCommit:process.env.GITHUB_SHA,workflowId:'platform.review-administration-audit',diagnosticOnly:true,workflowAccepted:false,syntheticOnly:true,productionAccess:false,remainingMissing:['actor_identity_contract_and_projection','explicit_malformed_history_availability_contract'],results:[]};
const hash=value=>createHash('sha256').update(value).digest('hex');
for(const identity of ['uuid','text']){
 const db=new pg.Client({connectionString:connection});await db.connect();const schema='audit_history_'+randomUUID().replaceAll('-','');
 const result={identity,officialWriterShapeCount:10,officialWriterShapesPreserved:false,actorNotDisclosed:false,unknownStateRedacted:false,sparseHistoryNotInvented:false,unknownActionRejectedByDatabase:false,legacyWriterCases:[],schemaRemoved:false};summary.results.push(result);
 try{
  await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
  await db.query(`CREATE TABLE tenants(id ${identity} PRIMARY KEY,name text,slug text,status text,created_at timestamptz DEFAULT NOW());CREATE TABLE users(id ${identity} PRIMARY KEY,email text,tenant_id ${identity} REFERENCES tenants(id),roles text,status text,updated_at timestamptz DEFAULT NOW());CREATE TABLE auth_sessions(user_id ${identity} REFERENCES users(id),token_hash text,expires_at timestamptz)`);
  await db.query(await readFile('packages/database/migrations/20261011_platform_administration.sql','utf8'));
  const id=name=>identity==='uuid'?randomUUID():'synthetic-'+name,tenant=id('tenant'),actor=id('actor'),target=id('target'),token=randomBytes(32).toString('base64url');
  await db.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Synthetic audit history','synthetic-history','active')",[tenant]);
  await db.query("INSERT INTO users(id,email,tenant_id,roles,status) VALUES($1,'synthetic-admin@example.test',$3,'tenant_admin','active'),($2,'synthetic-staff@example.test',$3,'psw','active')",[actor,target,tenant]);
  await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour')",[actor,hash(token)]);
  const scoped=new URL(connection);scoped.searchParams.set('options',`-c search_path=${schema}`);const env={SERVICE_NAME:'governance',DB_URL:scoped.toString()};
  const call=(suffix='/audit',method='GET',body)=>platformAdministration(new Request('https://synthetic.test/v1/governance/platform/tenants/'+tenant+suffix,{method,headers:{authorization:'Bearer '+token,...(body?{'content-type':'application/json','idempotency-key':randomUUID()}:{})},...(body?{body:JSON.stringify(body)}:{})}),env,'/platform/tenants/'+tenant+suffix,{});
  const cases=[
   ['tenant_created',{}, {slug:'synthetic-history',name:'Synthetic history'}, {},{slug:'synthetic-history',name:'Synthetic history'}],
   ['account_created',{}, {role:'psw',status:'active'}, {},{role:'psw',status:'active'}],
   ['account_updated',{role:'psw',status:'active'}, {role:'rmt',status:'inactive'}, {role:'psw',status:'active'},{role:'rmt',status:'inactive'}],
   ['master_created',{}, {type:'location',code:'synthetic-site',label:'Synthetic location',status:'active',version:1}, {},{type:'location',code:'synthetic-site',label:'Synthetic location',status:'active',version:1}],
   ['master_updated',{label:'Synthetic before',status:'active',version:1}, {label:'Synthetic after',status:'inactive',version:2}, {label:'Synthetic before',status:'active',version:1},{label:'Synthetic after',status:'inactive',version:2}],
   // Exact sparse field shapes written by growth/provisioning.ts:29.
   ['tenant_created',{onboardingId:'HIDDEN_ONBOARDING',sourceTenantId:'HIDDEN_SOURCE'}, {tenantId:'HIDDEN_TENANT',userId:'HIDDEN_USER',role:'tenant_admin'}, {},{}],
   ['account_created',{onboardingId:'HIDDEN_ONBOARDING',sourceTenantId:'HIDDEN_SOURCE'}, {tenantId:'HIDDEN_TENANT',userId:'HIDDEN_USER',role:'tenant_admin'}, {},{role:'tenant_admin'}],
   // Existing demo writer shapes; synthetic literals only. Seeder is never invoked.
   ['tenant_created',{}, {slug:'demo-synthetic',name:'Synthetic demo',demo:true,seedVersion:'HIDDEN_SEED',demoDataset:{private:'HIDDEN_DATASET'}}, {},{slug:'demo-synthetic',name:'Synthetic demo'}],
   ['account_created',{}, {role:'caregiver',status:'active',demoLoginDisabled:true,demo:true,seedVersion:'HIDDEN_SEED'}, {},{role:'caregiver',status:'active'}],
   ['master_created',{}, {type:'location',code:'demo-site',label:'Synthetic demo site',status:'active',version:1,demo:true,seedVersion:'HIDDEN_SEED'}, {},{type:'location',code:'demo-site',label:'Synthetic demo site',status:'active',version:1}],
  ];
  const expected=[];
  for(let index=0;index<cases.length;index++){
   const [action,previous,current,safePrevious,safeCurrent]=cases[index],eventId=randomUUID(),stamp=new Date(Date.UTC(2026,0,1,0,0,index)).toISOString();
   await db.query('INSERT INTO platform_administration_audit(id,actor_id,tenant_id,target_id,action,previous_state,current_state,created_at) VALUES($1,$2,$3,$4,$5,$6,$7,$8)',[eventId,actor,tenant,String(target),action,JSON.stringify(previous),JSON.stringify(current),stamp]);
   expected.unshift({id:eventId,action,target_id:String(target),previous_state:safePrevious,current_state:safeCurrent,created_at:stamp});
  }
  const snapshot=()=>db.query('SELECT * FROM platform_administration_audit ORDER BY id').then(r=>JSON.stringify(r.rows));const original=await snapshot();
  await test(identity+' diagnostic: all official writer shapes preserve exact history, order and redaction',async()=>{
   const response=await call();assert.equal(response.status,200);const body=await response.json();assert.deepEqual(body,{events:expected});
   assert.equal(body.events.length,cases.length);assert.equal(JSON.stringify(body).includes('HIDDEN_'),false);assert.equal(body.events.every(e=>!Object.hasOwn(e,'actor_id')),true);
   const reload=await call();assert.equal(reload.status,200);assert.deepEqual(await reload.json(),body);assert.equal(await snapshot(),original);
   result.officialWriterShapesPreserved=true;result.actorNotDisclosed=true;result.unknownStateRedacted=true;result.sparseHistoryNotInvented=true;
  });
  await test(identity+' diagnostic: unknown action cannot enter the current official audit schema',async()=>{
   await assert.rejects(db.query("INSERT INTO platform_administration_audit(actor_id,tenant_id,target_id,action,previous_state,current_state) VALUES($1,$2,$3,'unknown_legacy_action','{}','{}')",[actor,tenant,String(target)]),error=>error.code==='23514');
   assert.equal(await snapshot(),original);result.unknownActionRejectedByDatabase=true;
  });
  // The actual authorized account-update writer copies previous status without validation.
  // Expose this availability risk as a diagnostic, not a pass for full audit acceptance.
  for(const [label,status]of [['unsupported_prior_status','failed'],['null_prior_status',null]])await test(identity+' diagnostic: official account writer can persist '+label+' that fails closed',async()=>{
   await db.query('UPDATE users SET roles=$1,status=$2 WHERE id=$3',['psw',status,target]);
   const mutation=await call('/accounts/'+target,'PATCH',{role:'rmt',status:'active'});assert.equal(mutation.status,200);
   const written=(await db.query('SELECT id,previous_state,current_state FROM platform_administration_audit WHERE NOT(id=ANY($1::uuid[]))',[expected.map(e=>e.id)])).rows;
   assert.equal(written.length,1);assert.deepEqual(written[0].previous_state,{role:'psw',status});assert.deepEqual(written[0].current_state,{role:'rmt',status:'active'});
   const poisoned=await call();assert.equal(poisoned.status,503);const errorBody=await poisoned.json();assert.equal(Object.hasOwn(errorBody,'events'),false);assert.equal(JSON.stringify(errorBody).includes('failed'),false);assert.equal(JSON.stringify(errorBody).includes(actor),false);
   result.legacyWriterCases.push({case:label,actualWriterAccepted:true,auditUnavailable:true,partialSuccessNotFaked:true,actorNotDisclosed:true});
   // Disposable diagnostic setup only, not a product repair or a production recommendation.
   await db.query('DELETE FROM platform_administration_audit WHERE id=$1',[written[0].id]);
   const restored=await call();assert.equal(restored.status,200);assert.deepEqual(await restored.json(),{events:expected});assert.equal(await snapshot(),original);
  });
 }finally{
  await db.query('SET search_path TO public');await db.query(`DROP SCHEMA IF EXISTS ${schema} CASCADE`);result.schemaRemoved=(await db.query('SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=$1',[schema])).rows[0].n===0;await db.end();
  await mkdir('test-results/tenant-administration-audit-history',{recursive:true});await writeFile('test-results/tenant-administration-audit-history/summary.json',JSON.stringify(summary,null,2)+'\n');
 }
}
