import assert from 'node:assert/strict';
import pg from 'pg';
import {build} from 'esbuild';
import {readFile,writeFile,mkdir,mkdtemp} from 'node:fs/promises';
import {createHash,randomBytes,randomUUID} from 'node:crypto';
import {createRequire} from 'node:module';
import {join,resolve} from 'node:path';
import {tmpdir} from 'node:os';
assert.equal(process.env.GITHUB_ACTIONS,'true');assert.match(process.env.GITHUB_SHA??'',/^[a-f0-9]{40}$/);
const version=process.env.ROLLING_VERSION;assert.ok(['live','safe','partial','boundary'].includes(version));
const dir=process.env.ROLLING_FIXTURE_DIR;assert.ok(dir&&dir.startsWith(process.env.RUNNER_TEMP+'/'));
if(process.env.PRODUCTION_DATABASE_URL||process.env.DATABASE_URL||process.env.DB_URL)throw Error('Only disposable connection permitted');
const connection=process.env.PLATFORM_TEST_DATABASE_URL,u=new URL(connection);assert.ok(['postgres:','postgresql:'].includes(u.protocol)&&['127.0.0.1','localhost'].includes(u.hostname)&&u.pathname==='/platform_audit_rolling_test'&&!u.search&&!u.hash);
const buildDir=await mkdtemp(join(tmpdir(),'audit-rolling-')),file=join(buildDir,'handler.cjs');await build({entryPoints:['cloudflare/workers/src/platform-administration.ts'],bundle:true,platform:'node',format:'cjs',outfile:file,external:['pg']});await writeFile(file,(await readFile(file,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(resolve('node_modules/pg'))})`));const {platformAdministration}=createRequire(import.meta.url)(file);
const db=new pg.Client({connectionString:connection});await db.connect();const schema='rolling_'+randomUUID().replaceAll('-',''),responses=[],summary={sourceCommit:process.env.GITHUB_SHA,version,diagnosticOnly:true,workflowAccepted:false,syntheticOnly:true,productionAccess:false,cases:[]};
try{
 await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema};CREATE TABLE tenants(id text PRIMARY KEY,name text,slug text,status text,created_at timestamptz DEFAULT NOW());CREATE TABLE users(id text PRIMARY KEY,tenant_id text REFERENCES tenants(id),roles text,status text);CREATE TABLE auth_sessions(user_id text REFERENCES users(id),token_hash text,expires_at timestamptz)`);await db.query(await readFile('packages/database/migrations/20261011_platform_administration.sql','utf8'));
 const token=randomBytes(32).toString('base64url');await db.query("INSERT INTO tenants VALUES('synthetic-tenant','Synthetic tenant','synthetic-tenant','active',NOW());INSERT INTO users VALUES('synthetic-actor','synthetic-tenant','tenant_admin','active')");await db.query("INSERT INTO auth_sessions VALUES('synthetic-actor',$1,NOW()+INTERVAL '1 hour')",[createHash('sha256').update(token).digest('hex')]);
 const scoped=new URL(connection);scoped.searchParams.set('options',`-c search_path=${schema}`);const env={SERVICE_NAME:'governance',DB_URL:scoped.toString()},path='/platform/tenants/synthetic-tenant/audit';
 const call=()=>platformAdministration(new Request('https://synthetic.test'+path,{headers:{authorization:'Bearer '+token}}),env,path,{});
 const cases=[['valid',{role:'psw',status:'active'},{role:'rmt',status:'active'}],['legacy_null',{role:'psw',status:null},{role:'rmt',status:'active'}],['legacy_unsupported',{role:'psw',status:'failed'},{role:'rmt',status:'active'}],['malformed_current',{role:'psw',status:'active'},{role:'rmt',status:{hidden:'RAW_CANARY'}}],['nested_forged_marker',{role:'psw',unavailable_details:['previous_state.status'],private:'RAW_CANARY'},{role:'rmt',status:'active'}]];
 for(const [name,previous,current]of cases){
  await db.query('DELETE FROM platform_administration_audit');await db.query("INSERT INTO platform_administration_audit(id,actor_id,tenant_id,target_id,action,previous_state,current_state,created_at) VALUES($1,'synthetic-actor','synthetic-tenant','synthetic-target','account_updated',$2,$3,'2026-01-01T00:00:00Z')",[randomUUID(),JSON.stringify(previous),JSON.stringify(current)]);
  const before=JSON.stringify((await db.query('SELECT * FROM platform_administration_audit')).rows),response=await call(),body=await response.json();assert.equal(JSON.stringify((await db.query('SELECT * FROM platform_administration_audit')).rows),before);
  const expected=version==='live'?200:name==='malformed_current'||version==='safe'&&name.startsWith('legacy_')?503:200;assert.equal(response.status,expected);assert.equal(JSON.stringify(body).includes('synthetic-actor'),false);
  const marker=body.events?.[0]?.unavailable_details?.[0]==='previous_state.status';assert.equal(marker,['partial','boundary'].includes(version)&&name.startsWith('legacy_'));if(response.status!==200)assert.equal(Object.hasOwn(body,'events'),false);
  // These exact synthetic responses remain runner-local, never uploaded as artifacts.
  responses.push({name,status:response.status,body});summary.cases.push({case:name,status:response.status,markerPresent:marker,actorNotDisclosed:true,historyUnchanged:true});
 }
 const selected=(await db.query('SELECT id,action,target_id,previous_state,current_state,created_at FROM platform_administration_audit')).rows[0];assert.equal(Object.hasOwn(selected,'unavailable_details'),false);summary.databaseSelectCannotSupplyTopLevelMarker=true;
 if(version==='partial'){
  const built=await build({entryPoints:['packages/shared/src/platform-administration-audit.ts'],bundle:true,write:false,platform:'node',format:'esm'}),{projectAdministrationAuditHistory:project}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
  const raw={id:'synthetic-event',action:'account_updated',target_id:'synthetic-target',created_at:'2026-01-01T00:00:00.000Z',previous_state:{role:'psw'},current_state:{role:'rmt',status:'active'},unavailable_details:['previous_state.status']};
  const accepted=project(raw);assert.deepEqual(accepted.unavailable_details,['previous_state.status']);summary.forgedNormalizedObjectAcceptedBySharedProjector=true;summary.rawDatabaseAndNormalizedResponseTrustBoundarySeparated=false;
 }
 if(version==='boundary'){
  const built=await build({entryPoints:['packages/shared/src/platform-administration-audit.ts'],bundle:true,write:false,platform:'node',format:'esm'});
  const {projectAdministrationAuditHistoryRow:projectRow,parseAdministrationAuditHistoryResponse:parseResponse}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
  const normalized=responses.find(({name})=>name==='legacy_null').body.events[0];
  const original=responses.find(({name})=>name==='valid').body.events[0];
  assert.deepEqual(projectRow(original),original);
  assert.deepEqual(parseResponse(normalized),normalized);
  assert.throws(()=>projectRow(normalized),/^Error: Invalid administration audit projection$/);
  summary.knownNormalizedResponseAccepted=true;
  summary.rawDatabaseAndNormalizedResponseTrustBoundarySeparated=true;
 }
 await mkdir(dir,{recursive:true});await writeFile(join(dir,version+'-responses.json'),JSON.stringify(responses),{mode:0o600});
}finally{
 await db.query('SET search_path TO public');await db.query(`DROP SCHEMA IF EXISTS ${schema} CASCADE`);summary.schemaRemoved=(await db.query('SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=$1',[schema])).rows[0].n===0;await db.end();await mkdir('test-results/tenant-audit-rolling',{recursive:true});await writeFile('test-results/tenant-audit-rolling/api-'+version+'.json',JSON.stringify(summary,null,2)+'\n');
}
