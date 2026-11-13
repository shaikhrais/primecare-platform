/** One preservation contract for read-only inspection and generic Worker publication. */
import {readFile,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {pathToFileURL} from 'node:url';
import {GENERIC_WORKER_SERVICES,assertGenericWorkerPreserves} from './check-generic-worker-deploy.mjs';
import {preserveGenericObservability} from './preserve-generic-worker-observability.mjs';
import {assertExplicitSecretRetention,assertWorkerSecretBindingsPreserved} from './worker-secret-retention.mjs';
import {uploadedWorkerVersion} from './worker-deployment-receipt.mjs';

const uuid=/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
export function genericWorkerName(service){
 if(!GENERIC_WORKER_SERVICES.includes(service))throw Error('Unknown generic Worker');
 return service==='gateway'?'primecare-api-gateway':`primecare-${service}-api`;
}
export function retainedGenericConfig(service,raw){
 const allowed=new Set(['name','main','compatibility_date','compatibility_flags','workers_dev','vars','services','ratelimits','send_email','observability','triggers','keep_vars']);
 if(!raw||Object.keys(raw).some(key=>!allowed.has(key)))throw Error('Unreviewed generic Worker configuration');
 const config={...preserveGenericObservability(service,raw),keep_vars:true};
 assertExplicitSecretRetention(config);
 return config;
}
export function assertRetainedGenericPreserves(service,settings,schedules,config){
 if(config?.name!==genericWorkerName(service))throw Error('Worker target mismatch');
 assertExplicitSecretRetention(config);
 const evidence=assertWorkerSecretBindingsPreserved(settings,settings);
 // The legacy guard is unchanged: all nonsecret bindings, compatibility,
 // observability and schedules must still match exactly. DB_URL stays required.
 const bindings=settings.bindings.filter(b=>b.type!=='secret_key'&&
   !(b.type==='secret_text'&&b.name!=='DB_URL'));
 assertGenericWorkerPreserves({...settings,bindings},schedules,config,{requireDatabase:service!=='gateway'});
 return evidence;
}
function activeDeployment(raw){
 const active=raw?.deployments?.[0];
 if(!active||!uuid.test(active.id??'')||active.versions?.length!==1||
    !uuid.test(active.versions[0].version_id??'')||active.versions[0].percentage!==100)
  throw Error('A sole active Worker version is required');
 return {deploymentId:active.id,versionId:active.versions[0].version_id};
}
function latestVersion(raw){
 const id=raw?.items?.[0]?.id;
 if(!uuid.test(id??''))throw Error('Latest Worker version metadata unavailable');
 return id;
}
async function snapshot(api,worker){
 const base='/workers/scripts/'+worker;
 const before=activeDeployment(await api(base+'/deployments?per_page=1'));
 if(latestVersion(await api(base+'/versions?per_page=1'))!==before.versionId)
  throw Error('Latest upload is not the active Worker version');
 const version=await api(base+'/versions/'+before.versionId);
 if(version?.id!==before.versionId)throw Error('Worker version readback mismatch');
 const [settings,schedules]=await Promise.all([api(base+'/settings'),api(base+'/schedules')]);
 assertWorkerSecretBindingsPreserved(version.resources,settings);
 const after=activeDeployment(await api(base+'/deployments?per_page=1'));
 const latest=latestVersion(await api(base+'/versions?per_page=1'));
 if(after.deploymentId!==before.deploymentId||after.versionId!==before.versionId||latest!==before.versionId)
  throw Error('Worker lineage changed during preservation inspection');
 return {...before,settings,schedules};
}
export async function inspectGenericRelease({api,service,config}){
 const worker=genericWorkerName(service),candidate=retainedGenericConfig(service,config);
 const current=await snapshot(api,worker);
 const evidence=assertRetainedGenericPreserves(service,current.settings,current.schedules,candidate);
 return {worker,candidate,current,evidence};
}
export async function releaseGenericWorker({api,service,config,source,writeConfig,deploy,
 wait=()=>new Promise(resolve=>setTimeout(resolve,1000))}){
 if(!/^[0-9a-f]{40}$/.test(source??''))throw Error('Immutable release source required');
 const checked=await inspectGenericRelease({api,service,config});
 await writeConfig(checked.candidate);
 // Recheck after local preparation, immediately before the only provider write.
 const fresh=await inspectGenericRelease({api,service,config:checked.candidate});
 if(fresh.current.deploymentId!==checked.current.deploymentId||fresh.current.versionId!==checked.current.versionId)
  throw Error('Worker changed before deployment');
 const uploaded=await deploy();
 if(!uuid.test(uploaded?.versionId??''))throw Error('Exact uploaded version required');
 let after,lastError;
 for(let attempt=0;attempt<4;attempt++){
  try{
   after=await snapshot(api,checked.worker);
   if(after.versionId!==uploaded.versionId||after.deploymentId===fresh.current.deploymentId)
    throw Error('Uploaded version is not independently active');
   lastError=null;break;
  }catch(error){lastError=error;if(attempt<3)await wait();}
 }
 if(lastError)throw lastError;
 const evidence=assertWorkerSecretBindingsPreserved(fresh.current.settings,after.settings);
 assertRetainedGenericPreserves(service,after.settings,after.schedules,checked.candidate);
 return {source,service,worker:checked.worker,deploymentId:after.deploymentId,versionId:after.versionId,
  independentlyReadDeployment:true,existingSettingsPreserved:true,grantAssociationApproved:false,
  registeredGovernanceArtifactId:null,...evidence};
}
async function main(){
 const args=process.argv.slice(2),mode=args.shift();
 if(!['--check','--deploy'].includes(mode)||args.length!==2||args[0]!=='--service')throw Error('Expected --check|--deploy --service NAME');
 const service=args[1],worker=genericWorkerName(service);
 const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;
 if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Scoped provider credentials required');
 const api=async path=>{
  const response=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+path,
   {redirect:'error',headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
  const raw=await response.json();
  if(!response.ok||raw.success!==true)throw Error('Worker preservation metadata unavailable');
  return raw.result;
 };
 const file='.cloudflare-workers/'+service+'.jsonc',config=JSON.parse(await readFile(file,'utf8'));
 if(mode==='--check'){
  const checked=await inspectGenericRelease({api,service,config});
  console.log(JSON.stringify({service,worker,versionId:checked.current.versionId,...checked.evidence,providerWrites:0}));return;
 }
 const source=process.env.GITHUB_SHA;
 if(process.env.WORKER_DEPLOYMENT_AUTHORIZATION!=='DEPLOY'||process.env.GITHUB_REF!=='refs/heads/main'||
    !/^[0-9a-f]{40}$/.test(source??'')||execFileSync('git',['rev-parse','HEAD'],{encoding:'utf8'}).trim()!==source)
  throw Error('Authorized immutable main release required');
 execFileSync('git',['diff','--quiet','HEAD'],{stdio:'ignore'});
 const subdomain=await api('/workers/subdomain');
 if(subdomain?.subdomain!=='itpro-mohammed')throw Error('Worker account host mismatch');
 let persisted;
 const receipt=await releaseGenericWorker({api,service,config,source,
  writeConfig:async candidate=>{persisted=JSON.stringify(candidate,null,2)+'\n';await writeFile(file,persisted);},
  deploy:async()=>{
   if(await readFile(file,'utf8')!==persisted)throw Error('Prepared Worker configuration changed');
   let output;
   try{output=execFileSync('node_modules/.bin/wrangler',['deploy','--config',file,'--keep-vars'],
     {stdio:['ignore','pipe','pipe'],maxBuffer:8*1024*1024}).toString();}
   catch{throw Error('Worker publication failed; no deployment output or credentials logged');}
   return {versionId:uploadedWorkerVersion(output)};
  }});
 await writeFile('.cloudflare-workers/'+service+'-receipt.json',JSON.stringify(receipt,null,2)+'\n');
 console.log(JSON.stringify({...receipt,url:'https://'+worker+'.'+subdomain.subdomain+'.workers.dev'}));
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)
 main().catch(error=>{console.error(error.message);process.exitCode=1;});
