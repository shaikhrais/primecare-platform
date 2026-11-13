/** Add only the existing self-session API's usage link on the existing native host. */
import {readFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const contracts=JSON.parse(await readFile(new URL('./auth-session-tenant-contracts.json',import.meta.url)));
const schema=contracts.contracts.find(c=>c.reviewed.id===16402).response;
const table=name=>'"'+pin.schema+'"."'+pin.tablePrefix+name+'"';
const purpose='Authenticated self identity via API 16402';
const canonical=value=>JSON.stringify(value&&typeof value==='object' ? Array.isArray(value)?value.map(v=>JSON.parse(canonical(v))):Object.fromEntries(Object.keys(value).sort().map(k=>[k,JSON.parse(canonical(value[k]))])):value);

export async function registerNativeApplicationHost(db,{commit=false,readOnly=false}={}){
  if(commit&&readOnly)throw Error('Read-only registration cannot commit');
  await db.query(readOnly?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN ISOLATION LEVEL SERIALIZABLE');
  try{
    await db.query("SET LOCAL statement_timeout='20s'");
    await db.query("SET LOCAL lock_timeout='5s'");
    if(!readOnly){
      await db.query('LOCK TABLE '+['source_manifest','api_endpoints','screens','roles','role_screen_permissions','api_permissions'].map(table).join(',')+' IN SHARE MODE');
      await db.query('LOCK TABLE '+table('screen_api_links')+' IN SHARE ROW EXCLUSIVE MODE');
    }
    const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
    if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Native host authority mismatch');
    const endpoints=(await db.query('SELECT id,http_method,route_path,auth_required,permission_key,response_schema FROM '+table('api_endpoints')+' WHERE id=16402')).rows;
    const endpoint=endpoints[0];
    if(endpoints.length!==1||endpoint.http_method!=='GET'||endpoint.route_path!=='/v1/auth/me'||Number(endpoint.auth_required)!==1||endpoint.permission_key!=='authenticated_self_session'||
        canonical(typeof endpoint.response_schema==='string'?JSON.parse(endpoint.response_schema):endpoint.response_schema)!==canonical(schema))throw Error('Existing self-session contract differs');
    const host=(await db.query('SELECT s.id FROM '+table('screens')+' s JOIN '+table('role_screen_permissions')+' v ON v.screen_id=s.id JOIN '+table('roles')+' r ON r.id=v.role_id '+
      "WHERE s.id=2534 AND s.screen_code='tenant_admin_command_center' AND s.route_path='/tenant-dashboard' AND s.active=1 AND r.id=72 AND r.role_code='tenant_admin' AND r.active=1 AND v.can_view=1")).rows;
    if(host.length!==1)throw Error('Existing native host view authority differs');
    const shortcut=(await db.query('SELECT id FROM '+table('screen_api_links')+' WHERE screen_id=2534 AND api_id=777')).rows;
    if(shortcut.length!==1)throw Error('Existing shortcut host binding missing');
    const permissions=await db.query('SELECT id,api_id,role_id,can_access,permission_key FROM '+table('api_permissions')+' WHERE api_id IN (777,16402) ORDER BY id');
    const before=canonical(permissions.rows);
    const existing=(await db.query('SELECT id,purpose FROM '+table('screen_api_links')+' WHERE screen_id=2534 AND api_id=16402')).rows;
    if(existing.length>1||(existing.length===1&&existing[0].purpose!==purpose))throw Error('Conflicting native self-session link');
    const missing=existing.length===0;
    if(missing&&!readOnly)await db.query('INSERT INTO '+table('screen_api_links')+' (id,_primecare_import_row,screen_id,api_id,purpose) SELECT COALESCE(MAX(id),0)+1,COALESCE(MAX(_primecare_import_row),-1)+1,2534,16402,$1 FROM '+table('screen_api_links'),[purpose]);
    if(!readOnly){const link=(await db.query('SELECT purpose FROM '+table('screen_api_links')+' WHERE screen_id=2534 AND api_id=16402')).rows;if(link.length!==1||link[0].purpose!==purpose)throw Error('Native link readback differs');}
    const after=(await db.query('SELECT id,api_id,role_id,can_access,permission_key FROM '+table('api_permissions')+' WHERE api_id IN (777,16402) ORDER BY id')).rows;
    if(canonical(after)!==before)throw Error('Native registration changed permissions');
    await db.query(commit?'COMMIT':'ROLLBACK');
    return {screenId:2534,apiId:16402,missing:readOnly?missing:false,plannedInsert:missing?1:0,writes:commit&&missing?1:0,committed:commit,grantsChanged:0,schemaChanges:false,businessRowsChanged:0,reviewApproved:false};
  }catch(error){await db.query('ROLLBACK');throw error;}
}

async function main(){
  const mode=process.argv[2];if(!['--plan','--apply'].includes(mode))throw Error('Explicit native host registration mode required');
  const raw=process.env.PRODUCTION_DATABASE_URL,url=new URL(raw??'');
  if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Pinned production connection required');
  if(mode==='--apply'){
    if(process.env.REGISTER_PC10_NATIVE_HOST!=='1'||process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||process.env.GITHUB_REF!=='refs/heads/main')throw Error('Exact native registration scope required');
    const response=await fetch('https://api.github.com/repos/shaikhrais/primecare-platform/branches/main',{headers:{authorization:'Bearer '+process.env.GH_TOKEN,'x-github-api-version':'2022-11-28'}});
    if(!response.ok||(await response.json()).commit?.sha!==process.env.GITHUB_SHA)throw Error('Stale native registration source');
  }
  const connect=()=>new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
  const db=connect();try{
    await db.connect();const receipt=await registerNativeApplicationHost(db,{commit:mode==='--apply',readOnly:mode==='--plan'});
    if(mode==='--apply'){
      const reader=connect();try{await reader.connect();const readback=await registerNativeApplicationHost(reader,{readOnly:true});if(readback.missing)throw Error('Independent native link readback missing');receipt.independentReadback=true;}finally{await reader.end();}
    }
    console.log('PC10_NATIVE_HOST_REGISTRATION '+JSON.stringify({source:process.env.GITHUB_SHA,...receipt}));
  }finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(()=>{console.error('Native host registration failed closed; inspect exact metadata contract and current source.');process.exitCode=1;});
