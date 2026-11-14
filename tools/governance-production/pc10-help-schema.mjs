/** Exact additive Help schema migration. Legacy content is never adopted/published. */
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const sql=await readFile(new URL('./pc10-help-schema.sql',import.meta.url),'utf8');
export const helpSchemaHash=createHash('sha256').update(sql).digest('hex');
const definition=JSON.parse(await readFile(new URL('./pc10-help-schema.definition.json',import.meta.url)));
const existing={id:['text','NO'],question:['text','NO'],answer:['text','NO'],category:['text','NO'],created_at:['timestamp without time zone','NO'],updated_at:['timestamp without time zone','NO']};
const added={tenant_id:['text','YES'],locale:['text','YES'],publication_state:['text','NO'],revision:['bigint','NO'],summary:['text','NO'],published_at:['timestamp with time zone','YES']};
const q=s=>'"'+s.replaceAll('"','""')+'"';
export async function migrateHelpSchema(db,{apply=false}={}){
 await db.query(apply?'BEGIN ISOLATION LEVEL SERIALIZABLE':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 try{
  await db.query("SET LOCAL statement_timeout='30s'");await db.query("SET LOCAL lock_timeout='5s'");
  if(apply){await db.query("SELECT pg_advisory_xact_lock(794,685)");await db.query('LOCK TABLE public.faqs IN ACCESS EXCLUSIVE MODE');}
  const manifest=(await db.query('SELECT manifest_sha256 FROM '+q(pin.schema)+'.'+q(pin.tablePrefix+'source_manifest'))).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority differs');
  const columns=(await db.query("SELECT column_name,data_type,is_nullable,column_default FROM information_schema.columns WHERE table_schema='public' AND table_name='faqs' ORDER BY ordinal_position")).rows;
  const hasAdded=columns.some(c=>Object.hasOwn(added,c.column_name));
  const expected=hasAdded?{...existing,...added}:existing;
  if(columns.length!==Object.keys(expected).length||columns.some(c=>!Object.hasOwn(expected,c.column_name)||expected[c.column_name][0]!==c.data_type||expected[c.column_name][1]!==c.is_nullable))throw Error('FAQ schema differs');
  const tenant=(await db.query("SELECT data_type FROM information_schema.columns WHERE table_schema='public' AND table_name='tenants' AND column_name='id'")).rows;
  if(tenant.length!==1||tenant[0].data_type!=='text')throw Error('Tenant identity differs');
  if(!hasAdded&&apply){
   // The SQL has no transaction controls; the wrapper owns the entire migration.
   if(typeof db.exec==='function')await db.exec(sql);else await db.query(sql);
  }
  if(hasAdded||apply){
   const defaults=(await db.query("SELECT column_name,column_default FROM information_schema.columns WHERE table_schema='public' AND table_name='faqs' AND column_name IN ('publication_state','revision','summary') ORDER BY column_name")).rows;
   if(JSON.stringify(defaults)!==JSON.stringify([{column_name:'publication_state',column_default:"'draft'::text"},{column_name:'revision',column_default:'1'},{column_name:'summary',column_default:"''::text"}]))throw Error('Help defaults differ');
   const definitions=(await db.query("SELECT proname,prosrc FROM pg_proc p JOIN pg_namespace n ON n.oid=p.pronamespace WHERE n.nspname='public' AND proname IN ('pc10_help_v1_valid_text','pc10_help_v1_revision') ORDER BY proname")).rows;
   if(definitions.length!==2)throw Error('Help functions differ');
   for(const f of definitions){const marker=f.proname==='pc10_help_v1_valid_text'?'CREATE FUNCTION public.pc10_help_v1_valid_text':'CREATE FUNCTION public.pc10_help_v1_revision';const body=sql.slice(sql.indexOf(marker)).split('$body$')[1];if(f.prosrc!==body)throw Error('Help function source differs');}
   const constraints=(await db.query("SELECT conname,convalidated,pg_get_constraintdef(oid) AS definition FROM pg_constraint WHERE conrelid='public.faqs'::regclass ORDER BY conname")).rows;
   const actual=constraints.filter(c=>c.conname!=='faqs_pkey');if(actual.some(c=>!c.convalidated)||JSON.stringify(actual.map(({conname,definition})=>({conname,definition})))!==JSON.stringify(definition.constraints))throw Error('Help constraints differ');
   for(const name of ['faqs_tenant_id_fkey','faqs_locale_check','faqs_publication_state_check','faqs_revision_check','pc10_help_v1_publication_content','pc10_help_v1_unpublished_timestamp'])if(!constraints.some(c=>c.conname===name))throw Error('Help constraint missing');
   if(!constraints.some(c=>c.conname==='faqs_tenant_id_fkey'&&/FOREIGN KEY \(tenant_id\) REFERENCES (public\.)?tenants\(id\)/.test(c.definition)))throw Error('Help tenant binding differs');
   const triggers=(await db.query("SELECT tgname,tgenabled,pg_get_triggerdef(oid) AS definition FROM pg_trigger WHERE tgrelid='public.faqs'::regclass AND NOT tgisinternal AND tgname='pc10_help_v1_revision_guard'")).rows;
   if(triggers.length!==1||triggers[0].tgenabled!=='O'||!triggers[0].definition.includes('BEFORE UPDATE ON public.faqs FOR EACH ROW EXECUTE FUNCTION')||!triggers[0].definition.includes('pc10_help_v1_revision()'))throw Error('Help trigger differs');
   const indexes=(await db.query("SELECT indexdef FROM pg_indexes WHERE schemaname='public' AND tablename='faqs' AND indexname='pc10_help_v1_read'")).rows;
   if(indexes.length!==1||!indexes[0].indexdef.includes('(tenant_id, locale, id)')||!indexes[0].indexdef.includes("publication_state = 'published'"))throw Error('Help index differs');
  }
  await db.query(apply?'COMMIT':'ROLLBACK');
  return{migrationSha256:helpSchemaHash,alreadyApplied:hasAdded,applied:apply&&!hasAdded,schemaChanged:apply&&!hasAdded,contentPublished:0,grantsChanged:0,handlerImplemented:false,hostActivated:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){
 const mode=process.argv[2];if(!['--plan','--apply'].includes(mode))throw Error('Explicit mode required');
 const raw=process.env.PRODUCTION_DATABASE_URL,u=new URL(raw??'');if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned connection required');
 if(mode==='--apply'){
  if(process.env.APPLY_PC10_HELP_SCHEMA!=='1'||process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||process.env.GITHUB_REF!=='refs/heads/main')throw Error('Exact migration scope required');
  if(pin.helpGuideSchemaMigration?.migrationSha256!==helpSchemaHash)throw Error('Unregistered migration');
  const response=await fetch('https://api.github.com/repos/shaikhrais/primecare-platform/branches/main',{headers:{authorization:'Bearer '+process.env.GH_TOKEN,'x-github-api-version':'2022-11-28'}});
  if(!response.ok||(await response.json()).commit?.sha!==process.env.GITHUB_SHA)throw Error('Stale migration source');
 }
 const connect=()=>new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
 const db=connect();try{await db.connect();const result=await migrateHelpSchema(db,{apply:mode==='--apply'});if(mode==='--apply'){const reader=connect();try{await reader.connect();if(!(await migrateHelpSchema(reader)).alreadyApplied)throw Error('Independent readback differs');result.independentReadback=true;}finally{await reader.end();}}console.log('PC10_HELP_SCHEMA '+JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result}));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help schema migration failed closed; inspect preconditions. '+JSON.stringify({sqlstate:/^[0-9A-Z]{5}$/.test(error.code??'')?error.code:null}));process.exitCode=1;});
