// Native production query-plan diagnostic. Only disposable identities are
// inserted, inside one transaction that is always rolled back. No sessions,
// grants, governance rows, business commands or database defaults are changed.
import assert from 'node:assert/strict';import pg from 'pg';import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {nativePostgresOptions} from '../cloudflare/workers/src/business-tasks/native-postgres.ts';
import {PostgresRegisteredCommunicationEndpointPolicy} from '../cloudflare/workers/src/business-tasks/endpoint-policy.ts';
import {PostgresInternalCallEndpointPolicy} from '../cloudflare/workers/src/business-tasks/internal-call-endpoint-policy.ts';
import {createTenantRecord} from '../packages/shared/src/tenant-creation.mjs';
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8')),role=JSON.parse(await readFile('test-results/internal-calls/live-role.json','utf8')).role;
assert.match(role,/^[a-z][a-z0-9_]{0,79}$/);assert.ok(!['platform_admin','code_admin'].includes(role));
const phase=process.argv[2]??'--diagnostic';assert.ok(['--diagnostic','--before-index','--after-index'].includes(phase));
const db=new pg.Client(nativePostgresOptions(process.env.PRODUCTION_DATABASE_URL)),actor={id:crypto.randomUUID(),tenantId:crypto.randomUUID()},report={source:process.env.GITHUB_SHA,syntheticPrincipal:true,sessionIssued:false,governanceWrites:false,committedWrites:false,samples:[],passed:false};let connected=false,mode='default',grants,collect=true;
const summarize=node=>Object.fromEntries([...['Node Type','Relation Name','Index Name','Actual Rows','Actual Loops','Actual Total Time','Rows Removed by Filter','Shared Hit Blocks','Shared Read Blocks'].filter(k=>node[k]!==undefined).map(k=>[k,node[k]]),...(node.Plans?[['Plans',node.Plans.map(summarize)]]:[])]);
class Probe extends PostgresRegisteredCommunicationEndpointPolicy{authorize(identity=actor){return this.authorizeRegistered(identity,null,'POST','/v1/calls/command','INTERNAL_CALL_COMMAND');}}
try{
 await db.connect();connected=true;await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ');await db.query("SET LOCAL statement_timeout='10s'");
 await createTenantRecord(db,{id:actor.tenantId,slug:'call-profile-'+actor.tenantId,name:'Synthetic rollback-only call profile'});
 await db.query("INSERT INTO users(id,email,tenant_id,roles,status,password_hash,updated_at) VALUES($1,$2,$3,$4,'active','!unusable-profile-password',NOW())",[actor.id,'call-profile-'+actor.id+'@example.invalid',actor.tenantId,role]);
 report.columnTypes=(await db.query("SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND table_name=ANY($2) AND column_name=ANY($3) ORDER BY table_name,column_name",[pin.schema,['govt_roles','govt_api_permissions','govt_api_endpoints','govt_screen_api_links','govt_screens','govt_role_screen_permissions'],['id','role_id','api_id','screen_id','role_code','active','can_access','can_view']])).rows;
 // Savepoints adapt the policy's transaction boundaries to the enclosing
 // rollback-only fixture transaction; every authorization SQL query is real.
 const pool={async connect(){return {async query(sql,values){
  if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY')return db.query('SAVEPOINT endpoint_profile');
  if(sql==='ROLLBACK')return db.query('ROLLBACK TO SAVEPOINT endpoint_profile');
  if(collect&&sql.startsWith('SELECT DISTINCT')){
   const explained=(await db.query('EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON) '+sql,values)).rows[0]['QUERY PLAN'][0],result=await db.query(sql,values);
   const decision={allowed:result.rows.length>0,apis:[...new Set(result.rows.map(row=>row.api_id))].sort()};if(grants)assert.deepEqual(decision,grants);else grants=decision;
   report.samples.push({mode,planningMilliseconds:explained['Planning Time'],executionMilliseconds:explained['Execution Time'],jit:explained.JIT?{functions:explained.JIT.Functions,timing:explained.JIT.Timing}:null,plan:summarize(explained.Plan)});return result;
  }
  return db.query(sql,values);
 },release(){}};}};const policy=new Probe(pool),native=new PostgresInternalCallEndpointPolicy(pool),request=new Request('https://fixture.invalid/v1/calls/command',{method:'POST'});
 const setting=(await db.query('SHOW jit')).rows[0].jit;report.originalJit=['on','off'].includes(setting)?setting:'unknown';await policy.authorize();mode='jit-off';await db.query('SET LOCAL jit=off');await policy.authorize();
 if(report.originalJit==='on')await db.query('SET LOCAL jit=on');
 mode='native-scalars';await native.authorize(actor,'call.command',request);
 const candidate=report.samples.find(s=>s.mode==='native-scalars');
 const indexes=[],permissionIndexes=[];function visit(node,parent){const table=node['Relation Name']??parent;if(node['Index Name']){indexes.push(node['Index Name']);if(table==='govt_api_permissions')permissionIndexes.push(node['Index Name']);}for(const child of node.Plans??[])visit(child,table);}visit(candidate.plan);report.indexesUsed=[...new Set(indexes)];
 if(phase==='--after-index'){const verified=JSON.parse(await readFile('test-results/internal-calls/permission-index-verify.json','utf8'));assert.equal(verified.verified,true);assert.equal(verified.independentReadback,true);assert.ok(verified.reused.some(i=>i.table==='govt_api_permissions'));assert.ok(permissionIndexes.length>0,'Native permission lookup index must be used');report.permissionIndexUsed=true;assert.ok(candidate.executionMilliseconds<report.samples[0].executionMilliseconds,'Native query must improve execution time');}
 collect=false;
 for(const identity of [{...actor,tenantId:crypto.randomUUID()},{...actor,id:crypto.randomUUID()}]){await assert.rejects(policy.authorize(identity),/Forbidden/);await assert.rejects(native.authorize(identity,'call.command',request),/Forbidden/);}
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[actor.id]);await assert.rejects(policy.authorize(),/Forbidden/);await assert.rejects(native.authorize(actor,'call.command',request),/Forbidden/);
 report.sameNativeDecision=true;report.foreignTenantDenied=true;report.missingUserDenied=true;report.inactiveUserDenied=true;report.passed=true;
}catch(error){report.reason='native_profile_failed';if(/^[0-9A-Z]{5}$/.test(error?.code??''))report.sqlState=error.code;process.exitCode=1;
}finally{if(connected){await db.query('ROLLBACK');report.syntheticRollback=true;await db.end();}await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/permission-query-profile'+(phase==='--diagnostic'?'':phase.slice(1))+'.json',JSON.stringify(report,null,2)+'\n');console.log('CALL_PERMISSION_PROFILE '+JSON.stringify(report));}
