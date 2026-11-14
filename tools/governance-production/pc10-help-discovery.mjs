/** Bounded Help schema/access readback. Never reads business rows or changes authority. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const quote=s=>'"'+s.replaceAll('"','""')+'"';
const table=name=>quote(pin.schema)+'.'+quote(pin.tablePrefix+name);
export async function discoverHelp(db){
 let phase='begin';
 const query=async(sql,args=[])=>{phase=sql.includes('information_schema.columns')?'columns':sql.includes('pg_constraint')?'constraints':sql.includes('pg_indexes')?'indexes':sql.match(/govt_([a-z_]+)/)?.[1]??'transaction';return db.query(sql,args);};
 await query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 try{
  await query("SET LOCAL statement_timeout='20s'");
  const manifest=(await query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority mismatch');
  const bounded=async(sql,args=[])=>{const rows=(await query(sql,args)).rows;if(rows.length>300)throw Error('Metadata bound exceeded');return rows;};
  const metadata=(name,where,args=[])=>bounded('SELECT to_jsonb(x)-\'_primecare_import_row\' AS metadata FROM '+table(name)+' x WHERE '+where+' LIMIT 301',args).then(rows=>rows.map(r=>r.metadata));
  const screens=await metadata('screens','id=685');
  const endpoints=await metadata('api_endpoints','id=794');
  const roles=await bounded('SELECT id,role_code,active FROM '+table('roles')+' WHERE id=51');
  const apiPermissions=await metadata('api_permissions','api_id=794 ORDER BY role_id,id');
  const screenPermissions=await metadata('role_screen_permissions','screen_id=685 ORDER BY role_id');
  const links=await metadata('screen_api_links','screen_id=685 OR api_id=794 ORDER BY screen_id,api_id');
  const controls=await metadata('screen_components','screen_id=685 OR id=779 ORDER BY screen_id,id');
  const elements=await metadata('screen_required_elements','screen_id=685 ORDER BY id');
  // Inspect business schema only: no SELECT is issued against faqs, users or tenants.
  const businessColumns=await bounded(`SELECT table_schema,table_name,column_name,data_type,udt_name,is_nullable,column_default,character_maximum_length FROM information_schema.columns WHERE table_schema='public' AND table_name IN ('faqs','tenants','users') ORDER BY table_name,ordinal_position`);
  const constraints=await bounded(`SELECT c.conrelid::regclass::text AS relation,c.conname,c.contype,pg_get_constraintdef(c.oid) AS definition FROM pg_constraint c JOIN pg_class r ON r.oid=c.conrelid JOIN pg_namespace n ON n.oid=r.relnamespace WHERE n.nspname='public' AND r.relname IN ('faqs','tenants','users') ORDER BY relation,c.conname LIMIT 301`);
  const indexes=await bounded(`SELECT schemaname,tablename,indexname,indexdef FROM pg_indexes WHERE schemaname='public' AND tablename IN ('faqs','tenants','users') ORDER BY tablename,indexname LIMIT 301`);
  const governanceColumns=await bounded(`SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND (table_name LIKE $2 OR table_name LIKE $3 OR table_name=$4) AND column_name IN ('screen_id','role_id','id','permission_key','can_access','can_view') ORDER BY table_name,ordinal_position LIMIT 301`,[pin.schema,pin.tablePrefix+'%permission%',pin.tablePrefix+'%screen%',pin.tablePrefix+'primecare_ui_component_registry']);
  const registryColumns=governanceColumns.filter(c=>c.table_name===pin.tablePrefix+'primecare_ui_component_registry').map(c=>c.column_name);
  const registry=registryColumns.includes('id')?await metadata('primecare_ui_component_registry','id=779'):[];
  // Exact screen-associated access metadata only; a missing table/column is reported, never guessed.
  const related={};
  for(const name of [...new Set(governanceColumns.filter(c=>c.column_name==='screen_id').map(c=>c.table_name))]){
   if(['screens','screen_components','screen_required_elements','screen_api_links','role_screen_permissions'].some(t=>name===pin.tablePrefix+t))continue;
   if(!/^govt_[a-z0-9_]+$/.test(name))throw Error('Invalid relation');
   related[name]=await bounded('SELECT to_jsonb(x)-\'_primecare_import_row\' AS metadata FROM '+quote(pin.schema)+'.'+quote(name)+' x WHERE screen_id=685 LIMIT 301').then(rows=>rows.map(r=>r.metadata));
  }
  await query('ROLLBACK');
  return {format:1,sourceCommit:process.env.GITHUB_SHA??null,manifestSha256:pin.manifestSha256,screens,endpoints,roles,apiPermissions,screenPermissions,links,controls,elements,registry,businessColumns,constraints,indexes,governanceColumns,related,writes:0,businessRowsRead:0,grantsChanged:0,hostActivated:false,authorityInferred:false};
 }catch(error){const failedPhase=phase;await db.query('ROLLBACK');error.helpPhase=failedPhase;throw error;}
}
async function main(){
 const raw=process.env.PRODUCTION_DATABASE_URL;if(!raw)throw Error('Missing connection');
 const u=new URL(raw);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned connection required');
 const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
 try{await db.connect();const result=await discoverHelp(db);await mkdir('test-results/pc10-help',{recursive:true});await writeFile('test-results/pc10-help/discovery.json',JSON.stringify(result,null,2)+'\n');console.log('PC10_HELP_DISCOVERY '+JSON.stringify(result));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help schema/access discovery failed closed; no mutations attempted. '+JSON.stringify({phase:error.helpPhase??'connection',sqlstate:/^[0-9A-Z]{5}$/.test(error.code??'')?error.code:null,bounded:error.message==='Metadata bound exceeded'}));process.exitCode=1;});
