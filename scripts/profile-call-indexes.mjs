// Read-only production EXPLAINs. No identities, SQL parameters or content logged.
import pg from 'pg';import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {nativePostgresOptions} from '../cloudflare/workers/src/business-tasks/native-postgres.ts';
import {nativeCallPermissionQuery} from '../cloudflare/workers/src/business-tasks/internal-call-endpoint-policy.ts';
import contextQuery from '../packages/shared/src/communications/internal-call-context-query.mjs';
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8')),source=await readFile('cloudflare/workers/src/business-tasks/internal-call-application.ts','utf8'),directorySource=await readFile('cloudflare/workers/src/business-tasks/voice-directory.ts','utf8'),db=new pg.Client(nativePostgresOptions(process.env.PRODUCTION_DATABASE_URL));
const report={source:process.env.GITHUB_SHA,readOnly:true,committedWrites:false,permissionChanges:false,indexesAdded:[],tables:[],samples:[],passed:false};let connected=false;
const summarize=node=>Object.fromEntries([...['Node Type','Relation Name','Index Name','Actual Rows','Actual Loops','Actual Total Time','Rows Removed by Filter','Shared Hit Blocks','Shared Read Blocks'].filter(k=>node[k]!==undefined).map(k=>[k,node[k]]),...(node.Plans?[['Plans',node.Plans.map(summarize)]]:[])]);
async function sample(name,text,values){const started=performance.now(),p=(await db.query('EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON) '+text,values)).rows[0]['QUERY PLAN'][0];report.samples.push({name,roundTripMilliseconds:Math.round(performance.now()-started),planningMilliseconds:p['Planning Time'],executionMilliseconds:p['Execution Time'],plan:summarize(p.Plan)});}
try{
 await db.connect();connected=true;await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='10s';SET LOCAL lock_timeout='3s'");
 const manifest=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`)).rows;if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256||pin.sqliteFallback!==false)throw Error('Pinned manifest required');
 for(const table of ['users','tenants','auth_sessions','business_work_aggregates','business_work_commands','business_work_events','communication_voice_extensions']){
  const rows=(await db.query('SELECT count(*)::text AS n FROM public.'+table)).rows[0].n;
  const indexes=(await db.query(`SELECT c.relname AS name,i.indisvalid AS valid,i.indisready AS ready,i.indisunique AS unique,am.amname AS method,ARRAY(SELECT a.attname::text FROM unnest(i.indkey) WITH ORDINALITY k(n,pos) JOIN pg_attribute a ON a.attrelid=i.indrelid AND a.attnum=k.n ORDER BY k.pos) AS columns,(i.indpred IS NOT NULL) AS partial,(i.indexprs IS NOT NULL) AS expression FROM pg_index i JOIN pg_class c ON c.oid=i.indexrelid JOIN pg_am am ON am.oid=c.relam WHERE i.indrelid=to_regclass($1) ORDER BY c.relname`,['public.'+table])).rows;
  report.tables.push({table,rows,indexes});
 }
 const principal=(await db.query("SELECT u.id::text AS id,u.tenant_id::text AS tenant_id FROM public.users u JOIN public.tenants t ON t.id=u.tenant_id WHERE LOWER(u.status)='active' AND LOWER(t.status)='active' ORDER BY u.id LIMIT 1")).rows[0];
 if(!principal)throw Error('Active diagnostic principal required');const actor={id:principal.id,tenantId:principal.tenant_id};
 const record=(await db.query("SELECT id FROM public.business_work_aggregates WHERE tenant_id=$1 AND id LIKE 'internal-call:%' AND state->'members' ? $2 LIMIT 1",[actor.tenantId,actor.id])).rows[0]?.id??'internal-call:missing-index-diagnostic';
 const selects=[...source.matchAll(/this\.pool\.query\(`(SELECT[^`]+)`/g)].map(m=>m[1]);if(selects.length!==3)throw Error('Exact current call SQL required');
 await sample('directory',selects[0],[actor.tenantId,actor.id,null]);await sample('inbox',selects[1],[actor.tenantId,actor.id,Date.now()]);await sample('busy-check',selects[2],[actor.tenantId,actor.id,'missing-index-diagnostic',Date.now()]);
 const select=directorySource.match(/const select=`([^`]+)`;/)?.[1];if(!select)throw Error('Exact native directory SQL required');
 await sample('extension-owner',select+' WHERE v.tenant_id=$1 AND v.user_id=$2 LIMIT 2',[actor.tenantId,actor.id]);await sample('extension-number',select+' WHERE v.extension=$1 LIMIT 2',['1000']);
 await sample('call-state','SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND id=$2',[actor.tenantId,record]);
 await sample('active-participants',"SELECT u.id::text AS id FROM public.users u JOIN public.tenants t ON t.id=u.tenant_id WHERE u.id::text=ANY($1::text[]) AND u.tenant_id::text=$2 AND LOWER(u.status)='active' AND LOWER(t.status)='active'",[[actor.id],actor.tenantId]);
 const permission=nativeCallPermissionQuery(actor,'POST','/v1/calls/command','INTERNAL_CALL_COMMAND');await sample('native-permission',permission.text,permission.values);
 // Never obtain or log a real session hash; this exercises the denied-token path.
 await sample('context-missing-session',contextQuery,['0'.repeat(64),'POST','/v1/calls/command','INTERNAL_CALL_COMMAND',record,null,null]);
 report.contextScope='Missing session only; permission and state components separately profiled with an existing active principal.';report.passed=true;
}catch(error){report.reason='call_index_profile_failed';if(/^[A-Z0-9]{5}$/.test(error.code??''))report.sqlState=error.code;process.exitCode=1;
}finally{if(connected){await db.query('ROLLBACK').catch(()=>{});await db.end();}await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/call-index-profile.json',JSON.stringify(report,null,2)+'\n');console.log('CALL_INDEX_PROFILE '+JSON.stringify(report));}
