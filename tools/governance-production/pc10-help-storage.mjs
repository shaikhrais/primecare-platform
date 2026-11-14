/** Additive operational schema only. No content, grants, counters or audit events. */
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const definitionText=await readFile(new URL('./pc10-help-storage.definition.json',import.meta.url),'utf8');
const definition=JSON.parse(definitionText);
const sql=await readFile(new URL('./pc10-help-storage.sql',import.meta.url),'utf8');
export const storageHash=createHash('sha256').update(sql).digest('hex');
const names=['help_reader_audit','help_reader_rate'];
const quote=s=>'"'+s.replaceAll('"','""')+'"';
export async function inspectHelpStorage(db){
 const columns=(await db.query("SELECT table_name,column_name,data_type,is_nullable,column_default,is_identity,identity_generation FROM information_schema.columns WHERE table_schema='public' AND table_name=ANY($1::text[]) ORDER BY table_name,ordinal_position",[names])).rows;
 const constraints=(await db.query("SELECT r.relname AS table_name,c.conname,c.convalidated,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname='public' AND r.relname=ANY($1::text[]) ORDER BY r.relname,c.conname",[names])).rows;
 const indexes=(await db.query("SELECT tablename,indexname,indexdef FROM pg_indexes WHERE schemaname='public' AND tablename=ANY($1::text[]) ORDER BY tablename,indexname",[names])).rows;
 const relations=(await db.query("SELECT c.relname,c.relkind,obj_description(c.oid,'pg_class') AS comment FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname='public' AND c.relname=ANY($1::text[]) ORDER BY c.relname",[names])).rows;
 const triggers=(await db.query("SELECT r.relname AS table_name,t.tgname,t.tgenabled,pg_get_triggerdef(t.oid) AS definition FROM pg_trigger t JOIN pg_class r ON r.oid=t.tgrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname='public' AND r.relname=ANY($1::text[]) AND NOT t.tgisinternal ORDER BY r.relname,t.tgname",[names])).rows;
 return {columns,constraints,indexes,relations,triggers};
}
function registered(){
 const scope=pin.helpOperationalStorageMigration;
 if(definition.migrationSha256!==storageHash||scope?.migrationSha256!==storageHash||scope.definitionSha256!==createHash('sha256').update(definitionText).digest('hex')||JSON.stringify(scope.tables)!==JSON.stringify(names)||scope.roleGrants!==false||scope.runtimeActivation!==false||scope.contentWrites!==false)throw Error('Unregistered Help storage migration');
}
export async function migrateHelpStorage(db,{apply=false}={}){
 registered();
 await db.query(apply?'BEGIN ISOLATION LEVEL SERIALIZABLE':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 try{
  await db.query("SET LOCAL statement_timeout='30s'");await db.query("SET LOCAL lock_timeout='5s'");
  if(apply)await db.query('SELECT pg_advisory_xact_lock(794,30)');
  const manifest=(await db.query('SELECT manifest_sha256 FROM '+quote(pin.schema)+'.'+quote(pin.tablePrefix+'source_manifest'))).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority differs');
  const identities=(await db.query("SELECT table_name,data_type FROM information_schema.columns WHERE table_schema='public' AND table_name IN ('tenants','users') AND column_name='id' ORDER BY table_name")).rows;
  if(JSON.stringify(identities)!==JSON.stringify([{table_name:'tenants',data_type:'text'},{table_name:'users',data_type:'text'}]))throw Error('Identity schema differs');
  const before=await inspectHelpStorage(db),present=before.relations.length;
  if(apply&&present===2)await db.query('LOCK TABLE public.help_reader_rate,public.help_reader_audit IN SHARE MODE');
  if(present&&JSON.stringify(before)!==JSON.stringify(definition.shape))throw Error('Help storage schema differs');
  if(!present&&(before.columns.length||before.constraints.length||before.indexes.length||before.triggers.length))throw Error('Partial Help storage schema');
  if(!present&&apply){if(typeof db.exec==='function')await db.exec(sql);else await db.query(sql);}
  if(present||apply){const after=await inspectHelpStorage(db);if(JSON.stringify(after)!==JSON.stringify(definition.shape))throw Error('Help storage readback differs');}
  await db.query(apply?'COMMIT':'ROLLBACK');
  return {migrationSha256:storageHash,alreadyApplied:present===2,applied:apply&&!present,contentWrites:0,grantsChanged:0,operationalRowsWritten:0,hostActivated:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){
 const mode=process.argv[2];if(!['--plan','--apply'].includes(mode))throw Error('Explicit mode required');
 const raw=process.env.PRODUCTION_DATABASE_URL,u=new URL(raw??'');if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned connection required');
 if(mode==='--apply'){
  if(process.env.APPLY_PC10_HELP_STORAGE!=='1'||process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||process.env.GITHUB_REF!=='refs/heads/main')throw Error('Exact schema scope required');
  const r=await fetch('https://api.github.com/repos/shaikhrais/primecare-platform/branches/main',{headers:{authorization:'Bearer '+process.env.GH_TOKEN,'x-github-api-version':'2022-11-28'}});
  if(!r.ok||(await r.json()).commit?.sha!==process.env.GITHUB_SHA)throw Error('Stale migration source');
 }
 const connect=()=>new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
 const db=connect();try{await db.connect();const result=await migrateHelpStorage(db,{apply:mode==='--apply'});if(mode==='--apply'){const reader=connect();try{await reader.connect();if(!(await migrateHelpStorage(reader)).alreadyApplied)throw Error('Independent storage readback differs');result.independentReadback=true;}finally{await reader.end();}}console.log('PC10_HELP_STORAGE '+JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result}));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help storage schema failed closed. '+JSON.stringify({sqlstate:/^[0-9A-Z]{5}$/.test(error.code??'')?error.code:null}));process.exitCode=1;});
