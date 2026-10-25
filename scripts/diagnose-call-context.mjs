// Bounded rollback-only diagnostic. No grants, deployed code or data changes.
import pg from 'pg';import {readFile} from 'node:fs/promises';import {createHash} from 'node:crypto';import {nativePostgresOptions} from '../cloudflare/workers/src/business-tasks/native-postgres.ts';
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8')),sql=await readFile('packages/database/migrations/20261025_internal_call_context.sql','utf8');if(createHash('sha256').update(sql).digest('hex')!==pin.internalCallContextProcedure?.sourceSha256)throw Error('Pinned diagnostic required');
const options=nativePostgresOptions(process.env.PRODUCTION_DATABASE_URL),report={source:process.env.GITHUB_SHA,committedWrites:false,grantsChanged:false,targets:[]};
for(const host of ['pooled.db.prisma.io','db.prisma.io']){
 const db=new pg.Client({...options,host}),target={host};report.targets.push(target);let began=false;
 try{
  await db.connect();await db.query('BEGIN');began=true;await db.query("SET LOCAL statement_timeout='10s';SET LOCAL lock_timeout='5s'");
  target.phase='manifest';const rows=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`)).rows;if(rows.length!==1||rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Manifest mismatch');
  target.phase='privileges';target.privileges=(await db.query("SELECT has_schema_privilege(current_user,'public','CREATE') AS schema_create,has_language_privilege(current_user,'sql','USAGE') AS sql_usage")).rows[0];
  target.phase='catalog';target.exists=(await db.query("SELECT to_regprocedure('public.primecare_call_context_v1(text,text,text,text,text,text[],text)') IS NOT NULL AS exists")).rows[0].exists;
  target.phase='catalog-owner-check';await db.query("SELECT p.proowner=(SELECT oid FROM pg_roles WHERE rolname=current_user) AS owned FROM pg_proc p WHERE p.oid=to_regprocedure('public.primecare_call_context_v1(text,text,text,text,text,text[],text)')");
  target.phase='catalog-acl-check';await db.query("SELECT NOT EXISTS(SELECT 1 FROM aclexplode(COALESCE(p.proacl,acldefault('f',p.proowner))) a WHERE a.grantee<>p.proowner) AS owner_only FROM pg_proc p WHERE p.oid=to_regprocedure('public.primecare_call_context_v1(text,text,text,text,text,text[],text)')");
  if(!target.exists){target.phase='create-function';await db.query(sql);target.createdAndRolledBack=true;}
  target.phase='complete';
 }catch(error){target.sqlState=/^[A-Z0-9]{5}$/.test(error.code??'')?error.code:undefined;const message=String(error.message??'').replace(/"[^"]*"/g,'"redacted"');target.permissionError=error.code==='42501'&&/^permission denied [a-zA-Z0-9_ ."()-]{1,180}$/.test(message)?message:'bounded_diagnostic_failed';}
 finally{if(began)await db.query('ROLLBACK').catch(()=>{});await db.end().catch(()=>{});}
}
console.log('CALL_CONTEXT_DIAGNOSTIC '+JSON.stringify(report));
