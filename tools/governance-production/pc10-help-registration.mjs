/** Register the accepted read contract and usage link only. Never repairs or activates legacy grants. */
import {readFile} from 'node:fs/promises';import {pathToFileURL} from 'node:url';import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
export const helpReader=JSON.parse(await readFile(new URL('./pc10-help-reader-contract.json',import.meta.url)));
const q=s=>'"'+s.replaceAll('"','""')+'"',t=n=>q(pin.schema)+'.'+q(pin.tablePrefix+n);
const canonical=v=>JSON.stringify(v);
export async function registerHelpReader(db,{apply=false}={}){
 await db.query(apply?'BEGIN ISOLATION LEVEL SERIALIZABLE':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 try{
  await db.query("SET LOCAL statement_timeout='20s'");await db.query("SET LOCAL lock_timeout='5s'");
  if(apply){await db.query('LOCK TABLE '+t('api_endpoints')+','+t('screen_api_links')+' IN SHARE ROW EXCLUSIVE MODE');await db.query('LOCK TABLE '+t('roles')+','+t('screens')+','+t('api_permissions')+' IN SHARE MODE');}
  const manifest=(await db.query('SELECT manifest_sha256 FROM '+t('source_manifest'))).rows;if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority differs');
  if(helpReader.apiId!==794||helpReader.screenId!==685||helpReader.roleId!==51||helpReader.permissionKey!=='psw_published_help_read'||helpReader.runtimeActivation!==false||helpReader.grantsChanged!==false||helpReader.hostActivated!==false)throw Error('Reader scope differs');
  const endpoints=(await db.query('SELECT id,http_method,route_path,auth_required,permission_key,service_name,rate_limit_key,request_schema,response_schema,implementation_status FROM '+t('api_endpoints')+' WHERE id=794')).rows;
  const e=endpoints[0];if(endpoints.length!==1||e.http_method!==helpReader.method||e.route_path!==helpReader.path||Number(e.auth_required)!==1)throw Error('Existing API differs');
  const roles=(await db.query('SELECT id,role_code,active FROM '+t('roles')+' WHERE id=51')).rows;if(roles.length!==1||roles[0].role_code!=='psw'||Number(roles[0].active)!==1)throw Error('Existing role differs');
  const screens=(await db.query('SELECT id,screen_code,route_path,active FROM '+t('screens')+' WHERE id=685')).rows;if(screens.length!==1||screens[0].screen_code!=='psw_help_support'||screens[0].route_path!=='/generated/psw-help-support'||Number(screens[0].active)!==1)throw Error('Existing host differs');
  const columns=(await db.query("SELECT column_name FROM information_schema.columns WHERE table_schema='public' AND table_name='faqs' AND column_name IN ('tenant_id','locale','publication_state','revision','summary','published_at') ORDER BY column_name")).rows;
  if(columns.map(c=>c.column_name).join(',')!=='locale,publication_state,published_at,revision,summary,tenant_id')throw Error('Registered Help data model missing');
  const before=(await db.query('SELECT * FROM '+t('api_permissions')+' WHERE api_id=794 ORDER BY id')).rows;
  if(before.some(g=>g.permission_key===helpReader.permissionKey&&Number(g.can_access)===1))throw Error('Unexpected active reader grant');
  const duplicates=(await db.query('SELECT id FROM '+t('api_endpoints')+' WHERE id<>794 AND http_method=$1 AND route_path=$2 AND service_name=$3',[helpReader.method,helpReader.path,helpReader.service])).rows;if(duplicates.length)throw Error('Duplicate reader endpoint');
  const request=JSON.stringify(helpReader.requestSchema),response=JSON.stringify(helpReader.responseSchema);
  const registered=e.permission_key===helpReader.permissionKey&&e.service_name===helpReader.service&&e.rate_limit_key===helpReader.rateLimitKey&&e.request_schema===request&&e.response_schema===response&&e.implementation_status==='registered-unimplemented';
  if(!registered&&(e.permission_key!==null||e.rate_limit_key!==null||e.request_schema!==null||e.response_schema!==null||e.service_name!=='PRISMA'||e.implementation_status!=='active'))throw Error('Conflicting API definition');
  const existing=(await db.query('SELECT id,purpose FROM '+t('screen_api_links')+' WHERE screen_id=685 AND api_id=794')).rows;
  if(existing.length>1||existing.length===1&&existing[0].purpose!==helpReader.linkPurpose)throw Error('Conflicting Help link');
  if(apply){
   if(!registered)await db.query('UPDATE '+t('api_endpoints')+' SET permission_key=$1,service_name=$2,rate_limit_key=$3,request_schema=$4,response_schema=$5,implementation_status=$6 WHERE id=794',[helpReader.permissionKey,helpReader.service,helpReader.rateLimitKey,request,response,'registered-unimplemented']);
   if(!existing.length)await db.query('INSERT INTO '+t('screen_api_links')+' (id,_primecare_import_row,screen_id,api_id,purpose) SELECT COALESCE(MAX(id),0)+1,COALESCE(MAX(_primecare_import_row),-1)+1,685,794,$1 FROM '+t('screen_api_links'),[helpReader.linkPurpose]);
  }
  const after=(await db.query('SELECT * FROM '+t('api_permissions')+' WHERE api_id=794 ORDER BY id')).rows;if(canonical(after)!==canonical(before))throw Error('Legacy grant changed');
  await db.query(apply?'COMMIT':'ROLLBACK');return{apiId:794,screenId:685,alreadyRegistered:registered&&existing.length===1,plannedApiChanges:registered?0:1,plannedLinkInsert:existing.length?0:1,applied:apply,grantsPreserved:before.length,grantsChanged:0,readerGrantActivated:false,screenAccessChanged:false,contentPublished:0,handlerImplemented:false,hostActivated:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){const mode=process.argv[2];if(!['--plan','--apply'].includes(mode))throw Error('Explicit mode required');const raw=process.env.PRODUCTION_DATABASE_URL,u=new URL(raw??'');if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Pinned connection required');
 if(mode==='--apply'){if(process.env.REGISTER_PC10_HELP_READER!=='1'||process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||process.env.GITHUB_REF!=='refs/heads/main')throw Error('Exact scope required');const r=await fetch('https://api.github.com/repos/shaikhrais/primecare-platform/branches/main',{headers:{authorization:'Bearer '+process.env.GH_TOKEN,'x-github-api-version':'2022-11-28'}});if(!r.ok||(await r.json()).commit?.sha!==process.env.GITHUB_SHA)throw Error('Stale source');}
 const connect=()=>new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});const db=connect();try{await db.connect();const result=await registerHelpReader(db,{apply:mode==='--apply'});if(mode==='--apply'){const reader=connect();try{await reader.connect();if(!(await registerHelpReader(reader)).alreadyRegistered)throw Error('Independent registration readback differs');result.independentReadback=true;}finally{await reader.end();}}console.log('PC10_HELP_READER_REGISTRATION '+JSON.stringify({sourceCommit:process.env.GITHUB_SHA,...result}));}finally{await db.end();}}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{console.error('Help registration failed closed. '+JSON.stringify({sqlstate:/^[0-9A-Z]{5}$/.test(error.code??'')?error.code:null}));process.exitCode=1;});
