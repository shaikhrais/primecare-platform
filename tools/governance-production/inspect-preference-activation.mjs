import {readFile} from 'node:fs/promises';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
const accepted=JSON.parse(await readFile(new URL('../auth-verification/accepted-auth-live-proof-release.json',import.meta.url),'utf8'));
if(accepted.worker!=='primecare-auth-api'||accepted.preferenceRuntimeActivated!==false||!/^[a-f0-9-]{36}$/i.test(accepted.versionId??'')||!/^[a-f0-9-]{36}$/i.test(accepted.deploymentId??''))throw Error('Accepted auth proof mismatch');
const raw=process.env.PRODUCTION_DATABASE_URL,account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;
const url=new URL(raw);
if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres'||!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Pinned production read access required');
const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
const table=n=>'"'+pin.schema+'"."'+pin.tablePrefix+n+'"';
try{
 await db.connect();await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
 if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority mismatch');
 const endpoint=(await db.query('SELECT id,route_path,http_method,service_name,implementation_status FROM '+table('api_endpoints')+' WHERE id=777')).rows;
 const links=(await db.query('SELECT screen_id,api_id FROM '+table('screen_api_links')+' WHERE api_id=777 AND screen_id IN (1269,2534) ORDER BY screen_id')).rows;
 const controls=(await db.query("SELECT data_cy,implementation_status FROM "+table('screen_components')+" WHERE screen_id=2534 AND data_cy IN ('theme-migration-review','theme-migration-save','theme-migration-retry','theme-restore-review','theme-restore-confirm') ORDER BY data_cy")).rows;
 await db.query('ROLLBACK');
 const response=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/primecare-auth-api/settings',{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
 const result=await response.json();if(!response.ok||result.success!==true||!Array.isArray(result.result?.bindings))throw Error('Worker settings unavailable');
 const flags=result.result.bindings.filter(b=>b.name==='PREFERENCE_SYNC_ENABLED');
 const preferenceFlag=flags.length===0?'absent':flags.length===1&&flags[0].type==='plain_text'&&['0','1'].includes(flags[0].text)?flags[0].text:'unexpected';
 const deploymentResponse=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/primecare-auth-api/deployments?per_page=1',{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
 const deploymentResult=await deploymentResponse.json();
 if(!deploymentResponse.ok||deploymentResult.success!==true)throw Error('Worker deployment unavailable');
 const versions=deploymentResult.result?.deployments?.[0]?.versions;
 if(!Array.isArray(versions))throw Error('Worker version unavailable');
 const releaseVersion=accepted.versionId;
 const releaseResponse=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/primecare-auth-api/versions/'+releaseVersion,{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
 const release=await releaseResponse.json();if(!releaseResponse.ok||release.success!==true||!release.result?.resources?.script?.etag)throw Error('Release script hash unavailable');
 const activeVersions=[];
 for(const item of versions){
  if(!/^[a-f0-9-]{36}$/i.test(item.version_id??''))throw Error('Invalid version identity');
  const detailResponse=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/primecare-auth-api/versions/'+item.version_id,{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
  const detail=await detailResponse.json();if(!detailResponse.ok||detail.success!==true)throw Error('Worker version details unavailable');
  activeVersions.push({versionId:item.version_id,percentage:item.percentage,createdOn:detail.result?.metadata?.created_on??null,scriptMatchesRelease:!!detail.result?.resources?.script?.etag&&detail.result.resources.script.etag===release.result.resources.script.etag});
 }
 console.log(JSON.stringify({endpoint,links,controls,preferenceFlag,acceptedVersion:accepted.versionId,acceptedDeployment:accepted.deploymentId,activeDeployment:deploymentResult.result?.deployments?.[0]?.id??null,activeVersions,writes:0}));
}finally{await db.end();}
