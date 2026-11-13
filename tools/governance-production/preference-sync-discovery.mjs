/** Read only metadata for the registered preference operation. No account rows or preference values. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));let db;
const q=s=>'"'+s.replaceAll('"','""')+'"';
try{
 const raw=process.env.PRODUCTION_DATABASE_URL;if(!raw)throw Error();const url=new URL(raw);if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error();
 db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await db.connect();await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='30s'");
 const manifest=(await db.query('SELECT manifest_sha256,manifest FROM '+q(pin.schema)+'.'+q(pin.manifestTable))).rows;if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error();
 const relation=t=>q(pin.schema)+'.'+q(pin.tablePrefix+t),columns={};for(const table of ['api_endpoints','api_permissions','screen_api_links','screens'])columns[table]=(await db.query('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2 ORDER BY ordinal_position',[pin.schema,pin.tablePrefix+table])).rows;
 const apiFields=['id','api_code','http_method','route_path','service_name','auth_required','permission_key','request_schema','response_schema','rate_limit_key','rate_limit','active','implementation_status'].filter(c=>columns.api_endpoints.some(x=>x.column_name===c));
 const endpoints=(await db.query('SELECT '+apiFields.map(q).join(',')+' FROM '+relation('api_endpoints')+' WHERE id::text=ANY($1::text[]) ORDER BY id',['777,16425,16426'.split(',')])).rows;
 const permissions=(await db.query('SELECT to_jsonb(p)-\'_primecare_import_row\' AS metadata FROM '+relation('api_permissions')+' p WHERE api_id::text=ANY($1::text[]) ORDER BY api_id',['777,16425,16426'.split(',')])).rows;
 const links=(await db.query('SELECT to_jsonb(p)-\'_primecare_import_row\' AS metadata FROM '+relation('screen_api_links')+' p WHERE api_id::text=$1',['777'])).rows;
 const tables=(await db.query("SELECT table_schema,table_name FROM information_schema.tables WHERE table_schema IN ('public',$1) AND (table_name ILIKE '%preference%' OR table_name ILIKE '%setting%') ORDER BY table_schema,table_name",[pin.schema])).rows;
 const storage=[];for(const t of tables){storage.push({...t,columns:(await db.query('SELECT column_name,data_type,is_nullable,column_default FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2 ORDER BY ordinal_position',[t.table_schema,t.table_name])).rows});}
 const roleRows=(await db.query('SELECT to_jsonb(r)-\'_primecare_import_row\' AS metadata FROM '+relation('roles')+' r ORDER BY id')).rows;
 const roles=roleRows.map(({metadata:r})=>Object.fromEntries(Object.entries(r).filter(([k])=>['id','role_code','role_name','name','active','enabled','role_key'].includes(k))));
 const resourceScreens=(await db.query('SELECT id,screen_code,route_path,active FROM '+relation('screens')+' WHERE screen_code=ANY($1::text[])',[['tenant_admin_command_center','AUTHENTICATED_ACCOUNT']])).rows;
 const resourceControls=(await db.query('SELECT screen_id,data_cy,component_type,file_path FROM '+relation('screen_components')+' WHERE data_cy=$1',['tenant-preference-form'])).rows;
 // A role grant alone does not prove that its registered screen can call this API.
 const hostBindings=(await db.query(
  'SELECT DISTINCT s.id AS screen_id,s.screen_code,s.active AS screen_active,'+
  'r.id AS role_id,r.role_code,r.active AS role_active,p.can_view,g.can_access,g.permission_key,g.runtime_artifact_id '+
  'FROM '+relation('screen_api_links')+' l JOIN '+relation('screens')+' s ON s.id=l.screen_id '+
  'JOIN '+relation('api_permissions')+' g ON g.api_id=l.api_id '+
  'JOIN '+relation('roles')+' r ON r.id=g.role_id '+
  'LEFT JOIN '+relation('role_screen_permissions')+' p ON p.screen_id=s.id AND p.role_id=r.id '+
  'WHERE l.api_id=$1 AND r.role_code=ANY($2::text[]) ORDER BY s.id,r.id',
  [777,['platform_admin','tenant_admin','code_admin']]
 )).rows;
 const entryRoutes=JSON.parse(await readFile(new URL('../../packages/shared/src/admin-entry-routes.json',import.meta.url),'utf8'));
 const adminRoles=['platform_admin','tenant_admin','code_admin'];
 const hostCandidates=(await db.query(
  'SELECT DISTINCT r.role_code,s.id AS screen_id,s.screen_code,s.route_path,s.active AS screen_active,p.can_view '+
  'FROM unnest($1::text[],$2::text[]) AS entry(role_code,route_path) '+
  'JOIN '+relation('roles')+' r ON r.role_code=entry.role_code AND r.active=1 '+
  'JOIN '+relation('screens')+' s ON s.route_path=entry.route_path '+
  'LEFT JOIN '+relation('role_screen_permissions')+' p ON p.screen_id=s.id AND p.role_id=r.id '+
  'ORDER BY r.role_code,s.id',
  [adminRoles,adminRoles.map(role=>entryRoutes[role])]
 )).rows;
 const registeredThemeControls=(await db.query(
  'SELECT screen_id,data_cy,component_type,file_path FROM '+relation('screen_components')+
  " WHERE screen_id=ANY($1::bigint[]) AND (data_cy ILIKE '%theme%' OR data_cy ILIKE '%appearance%') ORDER BY screen_id,data_cy",
  [[1269,2534]]
 )).rows;
 const shortcutDestinations=(await db.query(
  'SELECT DISTINCT r.id AS role_id,r.role_code,s.id AS screen_id,s.screen_code,s.screen_name,s.route_path '+
  'FROM '+relation('roles')+' r JOIN '+relation('role_screen_permissions')+' p ON p.role_id=r.id '+
  'JOIN '+relation('screens')+' s ON s.id=p.screen_id '+
  'WHERE r.id=ANY($1::bigint[]) AND r.active=1 AND p.can_view=1 AND s.active=1 ORDER BY r.id,s.id',
  [[70,72,80]]
 )).rows;
 const settingDefinitions=(await db.query('SELECT setting_code,setting_type,default_value FROM '+relation('user_setting_definitions')+' ORDER BY id LIMIT 100')).rows;
 const actorColumns=(await db.query("SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema='public' AND table_name IN ('users','auth_sessions','tenants') AND column_name IN ('id','roles','tenant_id','status','user_id','token_hash','expires_at') ORDER BY table_name,column_name")).rows;
 const report={format:1,sourceCommit:process.env.GITHUB_SHA,authority:'pinned-production-postgresql',manifestSha256:pin.manifestSha256,writes:0,accountRowsRead:0,preferenceValuesRead:0,columns,endpoints,permissions,links,storage,actorColumns,roles,resourceScreens,resourceControls,hostBindings,hostCandidates,registeredThemeControls,shortcutDestinations,settingDefinitions};await db.query('ROLLBACK');await mkdir('test-results/preference-sync',{recursive:true});await writeFile('test-results/preference-sync/discovery.json',JSON.stringify(report,null,2)+'\n');console.log('PREFERENCE_SYNC_DISCOVERY '+JSON.stringify(report));
}catch{console.error('Preference synchronization metadata inspection failed; no mutations were attempted.');process.exitCode=1;}finally{if(db)await db.end();}
