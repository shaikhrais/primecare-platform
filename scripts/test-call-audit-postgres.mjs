import pg from 'pg';import assert from 'node:assert/strict';import {build} from 'esbuild';import {mkdtemp,writeFile,rm} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {pathToFileURL} from 'node:url';
const u=new URL(process.env.AUDIT_TEST_DATABASE_URL??'');if(!['localhost','127.0.0.1'].includes(u.hostname)||u.username!=='audit_fixture'||u.pathname!=='/call_audit_test'||process.env.PRODUCTION_DATABASE_URL)throw Error('Named disposable database required');
const dir=await mkdtemp(join(tmpdir(),'audit-db-')),file=join(dir,'repo.mjs');const built=await build({entryPoints:['cloudflare/workers/src/business-tasks/call-audit.ts'],bundle:true,format:'esm',platform:'node',write:false});await writeFile(file,built.outputFiles[0].text);
const {PostgresCallAudit}=await import(pathToFileURL(file)),pool=new pg.Pool({connectionString:u.href,max:6}),repo=new PostgresCallAudit(pool),call='fixture-call';
const p={kind:'tool_attempt',source:'fixture',at:'2026-10-27T20:00:00.000Z',phase:'started'};
try{
 await Promise.all(Array.from({length:12},(_,i)=>repo.append(call,'event-'+i,{...p,traceId:'trace-'+i})));
 assert.equal((await repo.timeline(call)).length,12);assert.equal((await repo.verify(call)).valid,true);
 await Promise.all(Array.from({length:4},()=>repo.append(call,'same-key',p)));assert.equal((await repo.timeline(call)).length,13);
 await assert.rejects(()=>repo.append(call,'same-key',{...p,phase:'finished'}),/replay conflict/);
 assert.equal((await repo.timeline('other-call')).length,0);
 await pool.query("UPDATE communication_call_audit SET payload=jsonb_set(payload,'{phase}','\"changed\"') WHERE call_id=$1 AND sequence=1",[call]);assert.equal((await repo.verify(call)).valid,false);
 await pool.query('DELETE FROM communication_call_audit WHERE call_id=$1',[call]);
 console.log('CALL_AUDIT_POSTGRES_PASS concurrent append, replay deduplication, conflict rejection, per-call isolation and tamper detection');
}finally{await pool.end();await rm(dir,{recursive:true,force:true});}
