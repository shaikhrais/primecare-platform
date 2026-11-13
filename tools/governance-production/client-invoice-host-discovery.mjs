/** Exact client invoice host discovery. Production metadata only; no account or invoice rows. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
const q=s=>'"'+s.replaceAll('"','""')+'"',table=t=>q(pin.schema)+'.'+q(pin.tablePrefix+t);
let db;
try {
 const raw=process.env.PRODUCTION_DATABASE_URL;if(!raw)throw Error('connection');
 const u=new URL(raw);if(u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres'||!['postgres:','postgresql:'].includes(u.protocol))throw Error('connection');
 db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await db.connect();
 await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='30s'");
 const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
 if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('authority');
 const rows=async(name,where,values=[])=>{const r=(await db.query('SELECT to_jsonb(x)-\'_primecare_import_row\' AS metadata FROM '+table(name)+' x WHERE '+where+' LIMIT 301',values)).rows.map(r=>r.metadata);if(r.length>300)throw Error('bounded metadata exceeded');return r;};
 const screenIds=['665','676','2534'];
 const screens=await rows('screens','id::text=ANY($1::text[]) ORDER BY id',[screenIds]);
 const endpoints=await rows('api_endpoints',"route_path LIKE '/v1/client/invoices%' ORDER BY id");
 const endpointIds=endpoints.map(r=>String(r.id));
 const links=await rows('screen_api_links','screen_id::text=ANY($1::text[]) AND api_id::text=ANY($2::text[]) ORDER BY screen_id,api_id',[screenIds,endpointIds]);
 const roleScreens=await rows('role_screen_permissions','screen_id::text=ANY($1::text[]) ORDER BY screen_id,role_id',[['665','676']]);
 const roleIds=[...new Set(roleScreens.map(r=>String(r.role_id)))];
 const roles=await rows('roles','id::text=ANY($1::text[]) ORDER BY id',[roleIds]);
 const grants=await rows('api_permissions','api_id::text=ANY($1::text[]) AND role_id::text=ANY($2::text[]) ORDER BY api_id,role_id',[endpointIds,roleIds]);
 const controls=await rows('screen_components',"screen_id IN (665,676) OR (screen_id=2534 AND data_cy ILIKE '%invoice%') ORDER BY screen_id,id");
 const elements=await rows('screen_required_elements','screen_id IN (665,676) ORDER BY screen_id,id');
 const resources=await rows('language_resources',"resource_key ILIKE '%invoice%' OR resource_key ILIKE '%client_profile%' ORDER BY resource_id");
 const resourceIds=resources.map(r=>String(r.resource_id));
 const translations=(await db.query('SELECT v.resource_id,l.language_code,v.translated_text,v.reviewed,v.approved FROM '+table('language_resource_values')+' v JOIN '+table('languages')+" l ON l.language_id=v.language_id WHERE v.resource_id::text=ANY($1::text[]) AND l.language_code IN ('en','fr','es') ORDER BY v.resource_id,l.language_code",[resourceIds])).rows;
 const columns=(await db.query('SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND (table_name LIKE $2 OR table_name LIKE $3 OR table_name LIKE $4) ORDER BY table_name,ordinal_position',[pin.schema,pin.tablePrefix+'%screen%',pin.tablePrefix+'%route%',pin.tablePrefix+'%source%'])).rows;
 const related={};
 for(const name of [...new Set(columns.filter(c=>c.column_name==='screen_id').map(c=>c.table_name))]) {
  if(['screens','screen_components','screen_required_elements','screen_api_links','role_screen_permissions'].some(t=>name===pin.tablePrefix+t))continue;
  if(!/^govt_[a-z0-9_]+$/.test(name))throw Error('relation');
  related[name]=(await db.query('SELECT to_jsonb(x)-\'_primecare_import_row\' AS metadata FROM '+q(pin.schema)+'.'+q(name)+' x WHERE screen_id::text=ANY($1::text[]) LIMIT 301',[['665','676']])).rows.map(r=>r.metadata);
  if(related[name].length>300)throw Error('bounded relation exceeded');
 }
 await db.query('ROLLBACK');
 const report={format:1,sourceCommit:process.env.GITHUB_SHA,manifestSha256:pin.manifestSha256,writes:0,businessRowsRead:0,screens,endpoints,links,roleScreens,roles,grants,controls,elements,resources,translations,columns,related};
 await mkdir('test-results/client-invoice-host',{recursive:true});await writeFile('test-results/client-invoice-host/discovery.json',JSON.stringify(report,null,2)+'\n');
 console.log('CLIENT_INVOICE_HOST_DISCOVERY '+JSON.stringify(report));
} catch {console.error('Pinned client invoice host metadata discovery failed; no mutations attempted.');process.exitCode=1;} finally {if(db)await db.end();}
