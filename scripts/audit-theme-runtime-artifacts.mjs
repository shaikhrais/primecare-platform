/** Read deployment-backed artifact candidates. No registration, grants or runtime changes. */
import {mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
const targets=[{worker:'primecare-auth-api',service:'auth',apiIds:[777]},{worker:'primecare-governance-api',service:'governance',apiIds:[710,857]}];
const uuid=/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
export async function auditRuntimeArtifacts({account,token,fetcher=fetch}){
 if(!/^[0-9a-f]{32}$/i.test(account??'')||typeof token!=='string'||!token)throw Error('Pinned Cloudflare read configuration required');
 const api=async path=>{
  const response=await fetcher('https://api.cloudflare.com/client/v4/accounts/'+account+path,{
   method:'GET',redirect:'error',signal:AbortSignal.timeout(30000),headers:{authorization:'Bearer '+token}});
  if(!response.ok)throw Error('Cloudflare metadata read rejected: '+response.status);
  const value=await response.json();if(value.success!==true)throw Error('Cloudflare metadata response rejected');return value.result;
 };
 const artifacts=[];
 for(const target of targets){
  const base='/workers/scripts/'+target.worker;
  const settings=await api(base+'/settings');
  if(!Array.isArray(settings.bindings))throw Error('Worker binding inventory missing');
  const service=settings.bindings.filter(b=>b.name==='SERVICE_NAME'&&b.type==='plain_text');
  if(service.length!==1||service[0].text!==target.service)throw Error('Worker service identity mismatch');
  const deployments=await api(base+'/deployments?per_page=1');
  const active=deployments?.deployments?.[0];
  if(!active||!uuid.test(active.id??'')||!Number.isFinite(Date.parse(active.created_on))||!Array.isArray(active.versions)||active.versions.length<1||active.versions.length>10)throw Error('Active deployment identity unavailable');
  if(active.versions.some(v=>!uuid.test(v.version_id??'')||!Number.isFinite(v.percentage)||v.percentage<=0||v.percentage>100)||
     new Set(active.versions.map(v=>v.version_id)).size!==active.versions.length||Math.abs(active.versions.reduce((sum,v)=>sum+v.percentage,0)-100)>0.0001)throw Error('Active traffic versions invalid');
  const versions=[];
  for(const activeVersion of active.versions){
   const version=await api(base+'/versions/'+activeVersion.version_id);
   if(version.id!==activeVersion.version_id)throw Error('Version readback mismatch');
   const tag=version.annotations?.['workers/tag'];
   const created=version.metadata?.created_on,uploadSource=version.metadata?.source;
   versions.push({versionId:version.id,trafficPercent:activeVersion.percentage,
    createdOn:typeof created==='string'&&Number.isFinite(Date.parse(created))?created:null,
    uploadSource:typeof uploadSource==='string'&&/^[a-z_-]{1,80}$/i.test(uploadSource)?uploadSource:null,
    sourceCommitTag:typeof tag==='string'&&/^[0-9a-f]{40}$/.test(tag)?tag:null});
  }
  const after=await api(base+'/deployments?per_page=1');
  if(after?.deployments?.[0]?.id!==active.id||JSON.stringify(after.deployments[0].versions)!==JSON.stringify(active.versions))throw Error('Active deployment changed during readback');
  artifacts.push({worker:target.worker,service:target.service,apiIds:target.apiIds,
   deploymentId:active.id,createdOn:active.created_on,versions,
   bindingShape:settings.bindings.filter(b=>/^[A-Za-z_][A-Za-z0-9_]{0,127}$/.test(b.name??'')&&/^[a-z_]{1,80}$/.test(b.type??'')).map(b=>({name:b.name,type:b.type})).sort((a,b)=>a.name.localeCompare(b.name)),
   preferenceSyncEnabled:target.service==='auth'?settings.bindings.some(b=>b.name==='PREFERENCE_SYNC_ENABLED'&&b.type==='plain_text'&&b.text==='1'):null,
   sourceCommitTagsPresent:versions.every(v=>v.sourceCommitTag!==null),sourceCommitFullyEstablished:false,
   independentlyReadDeployment:true,registeredGovernanceArtifactId:null,grantAssociationApproved:false});
 }
 return {format:1,readOnly:true,providerOperationsSent:0,settingsChanged:0,grantsChanged:0,runtimeActivated:false,
  artifacts,limits:['Deployment identities are candidate provenance, not permission to relink legacy grant rows',
   'No code, secret binding value, author email or account identifier is emitted',
   'Source commit tags, if present, still require source/release receipt validation',
   'No placeholder runtime_artifact_id is registered or inferred']};
}
if(import.meta.url===pathToFileURL(process.argv[1]??'').href){
 const result=await auditRuntimeArtifacts({account:process.env.CLOUDFLARE_ACCOUNT_ID,token:process.env.CLOUDFLARE_API_TOKEN});
 result.capturedAt=new Date().toISOString();result.sourceCommit=process.env.GITHUB_SHA;
 await mkdir('test-results/theme-runtime-artifacts',{recursive:true});
 await writeFile('test-results/theme-runtime-artifacts/readback.json',JSON.stringify(result,null,2)+'\n');
 console.log('THEME_RUNTIME_ARTIFACTS '+JSON.stringify(result));
}
