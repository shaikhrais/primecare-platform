/** Narrow inactive Help publication. --plan performs provider GETs only. */
import {readFile,writeFile,mkdir,readdir,rm,lstat,realpath,readlink,cp} from 'node:fs/promises';
import {createReadStream} from 'node:fs';
import {execFileSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {resolve,dirname} from 'node:path';
import {pathToFileURL} from 'node:url';
import {genericWorkerName,retainedGenericConfig,assertRetainedGenericPreserves} from './generic-worker-release.mjs';
import {assertWorkerSecretBindingsPreserved} from './worker-secret-retention.mjs';
import {uploadedWorkerVersion} from './worker-deployment-receipt.mjs';

export const SCOPE=Object.freeze({governance:'services/governance_api/worker/governance-help-service.ts',gateway:'services/api_gateway/worker/help-gateway.ts'});
export const WORKFLOW='.github/workflows/inactive-help-workers.yml';
export const PLAN_JOB='production-plan',RELEASE_JOB='production-release';
class ProducerError extends Error {}
let phase='configuration';
let rejectionContext=null;
const acceptedCloudflareTree='88b9689f0efd5c892be0e57bed063131b0f9541c';
const guardSource='718eaff3e6b3d4c5b26d68ec0b7a6ceaca5da3ea';
export const RELEASE_TOOLCHAIN=Object.freeze({nodeMajor:24,wrangler:'4.86.0',lockBlob:'0a25c42592d30c27e41e4a643144909f532590eb'});
/** Match the accepted 15c release's Node major, actual locked Wrangler and entire npm lock. */
export function assertReleaseToolchain({nodeVersion,wranglerVersion,lockBlob}){
 if(!/^24\./.test(nodeVersion??'')||wranglerVersion!==RELEASE_TOOLCHAIN.wrangler||lockBlob!==RELEASE_TOOLCHAIN.lockBlob)throw new ProducerError('Accepted locked release toolchain required');
 return {...RELEASE_TOOLCHAIN};
}
const uuid=/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i;
const sha=/^[a-f0-9]{40}$/;
const MAX_BYTES=25*1024*1024;
const readOperations=new Set(['zone-inventory','zone-routes','worker-settings','schedules','subdomain','versions','deployments','content']);
export function providerReadOperation(path){
 if(/^\/zones\?/.test(path))return 'zone-inventory';
 if(/^\/zones\/[a-f0-9]{32}\/workers\/routes$/.test(path))return 'zone-routes';
 if(/^\/accounts\/[a-f0-9]{32}\/workers\/subdomain$/.test(path))return 'subdomain';
 const match=path.match(/^\/accounts\/[a-f0-9]{32}\/workers\/scripts\/(?:primecare-governance-api|primecare-api-gateway|primecare-auth-api)\/(settings|schedules|subdomain|versions|deployments)(?:\?|\/|$)/);
 if(match)return match[1]==='settings'?'worker-settings':match[1];
 throw new ProducerError('Unsupported provider read operation');
}
/** Never include provider bodies, messages, URLs or credentials in rejected-read evidence. */
export async function readProviderResponse(operation,request){
 if(!readOperations.has(operation))throw new ProducerError('Unsupported provider read operation');
 let response;try{response=await request();}catch{
  const error=new ProducerError('Provider read failed: '+operation+' HTTP unavailable');error.providerRead={operation,httpStatus:null};throw error;
 }
 if(!response.ok){
  const status=Number.isInteger(response.status)&&response.status>=100&&response.status<=599?response.status:null;
  const error=new ProducerError('Provider read rejected: '+operation+' HTTP '+(status??'unavailable'));error.providerRead={operation,httpStatus:status};throw error;
 }
 return response;
}
/** The accepted identity is a subtree, never a repository commit or fetch ref. */
export function verifyInactiveSourceGit(run){
 run('git',['fetch','--no-tags','--depth=1','origin',guardSource]);
 const tree=run('git',['rev-parse','HEAD:cloudflare']).trim();
 if(tree!==acceptedCloudflareTree||run('git',['cat-file','-t',tree]).trim()!=='tree')throw new ProducerError('Accepted entire Cloudflare subtree changed');
 run('git',['diff','--exit-code',guardSource,'HEAD','--','package.json','package-lock.json','tools/governance-production/production-pin.json','scripts/verify-auth-live-proof-source.mjs','scripts/generic-worker-release.mjs','scripts/check-generic-worker-deploy.mjs','scripts/preserve-generic-worker-observability.mjs','scripts/worker-secret-retention.mjs','scripts/worker-deployment-receipt.mjs']);
 return {cloudflareTree:tree,protectedSource:guardSource};
}
const canonical=value=>JSON.stringify(value&&typeof value==='object'&&!Array.isArray(value)?Object.fromEntries(Object.keys(value).sort().map(k=>[k,JSON.parse(canonical(value[k]))])):Array.isArray(value)?value.map(x=>JSON.parse(canonical(x))):value);
const hash=bytes=>createHash('sha256').update(bytes).digest('hex');
const gitBlob=bytes=>createHash('sha1').update('blob '+bytes.length+'\0').update(bytes).digest('hex');
const withoutJsonAttributes=path=>path.replace(/ with \{ type: ['"]json['"] \}$/,'');
export function acceptedAuthArchivePaths(inputs){
 if(!Array.isArray(inputs)||!inputs.length)throw new ProducerError('Current Auth build input identities required');
 const paths=new Set(['package.json','package-lock.json']);
 for(const input of inputs){
  if(input.virtual===true||input.path?.startsWith('node_modules/'))continue;
  const path=typeof input.path==='string'?withoutJsonAttributes(input.path):'';
  const trackedScope=/^(cloudflare|packages|tools|scripts)\/[A-Za-z0-9_@./-]+$/.test(path)||path==='docs/transport/compression-policy.json';
  if(!trackedScope||path.split('/').some(part=>part==='.'||part==='..'))throw new ProducerError('Tracked Auth archive input path invalid');
  paths.add(path);
 }
 return [...paths].sort();
}
/** Esbuild does not list package/TS configuration scopes in its input metafile. */
export function authCompilerMetadataCandidates(paths){
 const candidates=new Set(['package.json','tsconfig.json','jsconfig.json']);
 for(const path of paths){let directory=dirname(path);while(directory!=='.'){
  for(const file of ['package.json','tsconfig.json','jsconfig.json'])candidates.add(directory+'/'+file);
  directory=dirname(directory);
 }}
 return [...candidates].sort();
}
/** Verify the complete locked install without following workspace or executable symlinks. */
export async function dependencyTreeIdentity(directory,{maxEntries=100000,maxBytes=4*1024*1024*1024}={}){
 const root=resolve(directory),container=dirname(root),entries=[];let totalBytes=0;
 if(await realpath(root)!==root||!(await lstat(root)).isDirectory())throw new ProducerError('Physical dependency directory required');
 async function visit(current){
  for(const name of (await readdir(current)).sort()){
   const file=resolve(current,name),path=file.slice(root.length+1),stat=await lstat(file);
   if(entries.length>=maxEntries)throw new ProducerError('Dependency tree exceeds verification bound');
   if(stat.isSymbolicLink()){
    const target=await readlink(file),destination=resolve(dirname(file),target);
    if(target.startsWith('/')||!destination.startsWith(container+'/'))throw new ProducerError('Dependency symlink escapes isolated source layout');
    entries.push({path,type:'symlink',target});
   }else if(stat.isDirectory()){
    entries.push({path,type:'directory',mode:stat.mode&0o777});await visit(file);
   }else if(stat.isFile()){
    const digest=createHash('sha256');let bytes=0;
    for await(const chunk of createReadStream(file)){bytes+=chunk.length;totalBytes+=chunk.length;if(totalBytes>maxBytes)throw new ProducerError('Dependency tree exceeds verification bound');digest.update(chunk);}
    if(bytes!==stat.size)throw new ProducerError('Dependency file changed during verification');
    entries.push({path,type:'file',mode:stat.mode&0o777,bytes,sha256:digest.digest('hex')});
   }else throw new ProducerError('Unsupported dependency filesystem entry');
  }
 }
 await visit(root);
 return {entries:entries.length,files:entries.filter(e=>e.type==='file').length,symlinks:entries.filter(e=>e.type==='symlink').length,totalBytes,manifestSha256:hash(canonical(entries))};
}
/** Physical layout is part of emitted bytes: a symlink to another source root changes labels. */
export async function copyLockedDependencies({source,destination,copyTree=cp}){
 const before=await dependencyTreeIdentity(source);
 await copyTree(source,destination,{recursive:true,dereference:false,verbatimSymlinks:true,preserveTimestamps:true,errorOnExist:true,force:false});
 const copied=await dependencyTreeIdentity(destination),confirmed=await dependencyTreeIdentity(source);
 if(canonical(before)!==canonical(copied)||canonical(before)!==canonical(confirmed))throw new ProducerError('Physical locked dependency copy differs');
 const binary=await realpath(resolve(destination,'.bin/wrangler'));
 if(!binary.startsWith(resolve(destination)+'/'))throw new ProducerError('Archived Wrangler escapes physical dependency copy');
 return {...copied,physicalCopyVerified:true,wranglerRelativePath:binary.slice(resolve(destination).length+1)};
}
/** Compare historical sources, not a replacement authority or a deployment exemption.
 * The sole recorded historical difference stays inside the isolated accepted-source archive.
 */
export function assertAcceptedAuthSourceRecords(records){
 if(!Array.isArray(records)||!records.length||new Set(records.map(r=>r.path)).size!==records.length)throw new ProducerError('Unique Auth source identity records required');
 const changed=[];
 for(const record of records){
  if(record.currentMode!=='100644'||record.acceptedMode!=='100644'||!sha.test(record.currentBlob??'')||!sha.test(record.acceptedBlob??''))throw new ProducerError('Regular immutable Auth source files required');
  if(record.currentBlob===record.acceptedBlob)continue;
  if(record.path!=='tools/governance-production/production-pin.json'||record.acceptedBlob!=='ab9d20ad4516a70063f77a9483856d2738f1a51e'||record.currentBlob!=='8478c2892885e57109e898736b1f1995344cb70b')throw new ProducerError('Unreviewed Auth transitive source difference');
  changed.push({...record});
 }
 return {comparedSourceFiles:records.length,historicalSourceDifferences:changed};
}
const meaningfulSettings=settings=>Object.fromEntries(Object.entries(settings).filter(([key])=>!['etag','created_on','modified_on'].includes(key)));
function meaningfulSchedules(raw){
 if(!Array.isArray(raw?.schedules)||Object.keys(raw).some(k=>k!=='schedules'))throw new ProducerError('Schedule metadata unsupported');
 return {schedules:raw.schedules.map(schedule=>{
  if(typeof schedule.cron!=='string'||Object.keys(schedule).some(k=>!['cron','created_on','modified_on'].includes(k)))throw new ProducerError('Schedule metadata unsupported');
  return {cron:schedule.cron};
 }).sort((a,b)=>a.cron.localeCompare(b.cron))};
}
function scoped(service){if(!Object.hasOwn(SCOPE,service))throw new ProducerError('Only governance and gateway are authorized');return genericWorkerName(service);}
const inert=value=>value===undefined||value===null||value===false||Array.isArray(value)&&value.length===0||value&&typeof value==='object'&&Object.keys(value).length===0;

/** These categories have no supported non-default representation in the generic generator.
 * Refuse meaningful values rather than guessing that Wrangler will retain them. */
const settingType=value=>value===null?'null':Array.isArray(value)?'array':typeof value;
const usageObservation=(has,value)=>({enum:!has?'absent':['standard','bundled','unbound'].includes(value)?value:'unrecognized',type:!has?'absent':settingType(value)});
function readOnlyUploadAnnotation(value){
 if(!value||typeof value!=='object'||Array.isArray(value)||Object.keys(value).length!==1)return false;
 const field=Object.getOwnPropertyDescriptor(value,'workers/triggered_by');
 return field?.enumerable===true&&field.value==='version_upload';
}
function annotationProjection(value){
 const fields=[];let truncated=false;
 function visit(current,path,depth){
  if(fields.length>=256){truncated=true;return;}
  const field={path,type:settingType(current),valueSha256:hash(canonical(current)??'undefined'),emptyObject:!!current&&typeof current==='object'&&!Array.isArray(current)&&Object.keys(current).length===0,emptyArray:Array.isArray(current)&&current.length===0};
  if(path==='annotations.workers/triggered_by'&&['upload','secret','rollback','promotion','version_upload'].includes(current))field.operation=current;
  fields.push(field);
  if(current&&typeof current==='object'){
   if(depth>=6){if(Object.keys(current).length)truncated=true;return;}
   for(const key of Object.keys(current).sort())visit(current[key],path+'.'+(/^[a-z0-9_/-]{1,80}$/i.test(key)?key:'unrecognized-key'),depth+1);
  }
 }
 visit(value,'annotations',0);return {fields,truncated};
}
export function assertSupportedSettings(settings,{version}={}){
 const known=new Set(['bindings','compatibility_date','compatibility_flags','observability']);
 const emptyOnly=new Set(['placement','limits','tail_consumers','logpush','migrations','routes','workers_dev','assets','annotations']);
 if(!settings||typeof settings!=='object'||Array.isArray(settings))throw new ProducerError('Worker settings unavailable');
 const runtime=version?.resources?.script_runtime;
 const usageModel={settings:usageObservation(Object.hasOwn(settings,'usage_model'),settings.usage_model),versionRuntime:usageObservation(!!runtime&&Object.hasOwn(runtime,'usage_model'),runtime?.usage_model)};
 const unsupported=[];
 for(const [key,value] of Object.entries(settings)){
  if(known.has(key))continue;
  if(key==='tags'&&Array.isArray(value)&&value.length===0)continue;
  // Actual one-key object observed in run 43685442567. The API marks this field read-only/server-set.
  // https://developers.cloudflare.com/api/resources/workers/subresources/scripts/subresources/script_and_version_settings/methods/get/
  if(key==='annotations'&&readOnlyUploadAnnotation(value))continue;
  // Cloudflare removed this Wrangler option in v4. Observe standard only; never add it to config.
  // https://developers.cloudflare.com/workers/wrangler/migration/update-v3-to-v4/
  if(key==='usage_model'&&value==='standard')continue;
  if(emptyOnly.has(key)&&inert(value))continue;
  // Metadata is deliberately narrow. Unknown meaningful settings always stop publication.
  if(['etag','created_on','modified_on'].includes(key)&&typeof value==='string')continue;
  unsupported.push({key:/^[a-z][a-z0-9_]{0,79}$/i.test(key)?key:'unrecognized-key',type:settingType(value),inert:!!inert(value),emptyObject:!!value&&typeof value==='object'&&!Array.isArray(value)&&Object.keys(value).length===0,emptyArray:Array.isArray(value)&&value.length===0});
 }
 if(runtime&&Object.hasOwn(runtime,'usage_model')&&runtime.usage_model!=='standard')unsupported.push({key:'version-runtime.usage_model',type:settingType(runtime.usage_model),inert:!!inert(runtime.usage_model),emptyObject:false,emptyArray:false});
 if(unsupported.length){const error=new ProducerError('Unsupported meaningful Worker settings');error.unsupportedSettings=unsupported;error.usageModel=usageModel;if(Object.hasOwn(settings,'annotations'))error.annotationProjection=annotationProjection(settings.annotations);throw error;}
 return usageModel;
}
export function inactiveConfig(service,generated,hosting){
 scoped(service);
 // Preserve the generic helper's original entrypoint check. Substitute only after it passes.
 const candidate=retainedGenericConfig(service,generated);
 if(!hosting||hosting.enabled!==candidate.workers_dev||typeof hosting.previews_enabled!=='boolean'||Object.keys(hosting).some(k=>!['enabled','previews_enabled'].includes(k)))throw new ProducerError('Worker subdomain configuration unsupported');
 candidate.main='../'+SCOPE[service];
 candidate.preview_urls=hosting.previews_enabled;
 candidate.routes=[];
 return candidate;
}
export function activeLineage(raw){
 const active=raw?.deployments?.[0],versions=active?.versions;
 if(!uuid.test(active?.id??'')||versions?.length!==1||!uuid.test(versions[0]?.version_id??'')||versions[0].percentage!==100)
  throw new ProducerError('Sole active Worker deployment required');
 return {deploymentId:active.id,versionId:versions[0].version_id};
}
function latest(raw){const id=raw?.items?.[0]?.id;if(!uuid.test(id??''))throw new ProducerError('Latest Worker upload unavailable');return id;}
export async function boundedBody(response,limit=MAX_BYTES){
 if(!response.ok||!response.body)throw new ProducerError('Provider content unavailable');
 const declared=response.headers.get('content-length');if(declared!==null&&(!/^\d+$/.test(declared)||Number(declared)>limit))throw new ProducerError('Provider content exceeds bound');
 const reader=response.body.getReader(),parts=[];let length=0;
 try{for(;;){const {done,value}=await reader.read();if(done)break;length+=value.byteLength;if(length>limit)throw new ProducerError('Provider content exceeds bound');parts.push(Buffer.from(value));}}
 catch(error){await reader.cancel().catch(()=>{});throw error;}finally{reader.releaseLock();}
 return Buffer.concat(parts,length);
}
export async function moduleEvidence(response,expected,context){
 if(!Buffer.isBuffer(expected)||!expected.length||expected.length>MAX_BYTES)throw new ProducerError('Bounded rebuilt module required');
 if(context&&(!['primecare-auth-api','primecare-governance-api','primecare-api-gateway'].includes(context.worker)||!['accepted-auth','baseline','inactive'].includes(context.buildLabel)))throw new ProducerError('Known module comparison context required');
 const bytes=await boundedBody(response),type=response.headers.get('content-type')??'';let modules;
 if(/^multipart\/form-data\s*;/i.test(type)){
  const form=await new Response(bytes,{headers:{'content-type':type}}).formData();
  modules=[];for(const [name,value] of form.entries()){
   if(typeof value==='string'){if(name!=='metadata')throw new ProducerError('Unexpected provider content field');continue;}
   modules.push(Buffer.from(await value.arrayBuffer()));
  }
 }else if(/^(application|text)\/(javascript|ecmascript)(?:;|$)/i.test(type))modules=[bytes];
 else throw new ProducerError('Unexpected provider content type');
 if(modules.length!==1||!modules[0].equals(expected)){
  const error=new ProducerError('Provider module bytes differ from exact rebuilt module');
  error.moduleComparison={...(context?{worker:context.worker,buildLabel:context.buildLabel}:{}),expected:{moduleBytes:expected.length,moduleSha256:hash(expected)},moduleCount:modules.length,providerModuleBytes:modules.reduce((total,module)=>total+module.length,0),providerModules:modules.slice(0,8).map(module=>({moduleBytes:module.length,moduleSha256:hash(module)})),providerModuleDiagnosticsTruncated:modules.length>8};
  throw error;
 }
 return {moduleCount:1,moduleBytes:expected.length,moduleSha256:hash(expected),exactBytes:true};
}
/** Supplemental bytes must come from the actual accepted release source, never today's pin. */
export async function verifyAcceptedAuthBytes({api,content,acceptedSource,rebuildAccepted}){
 if(!sha.test(acceptedSource??''))throw new ProducerError('Immutable accepted Auth source required');
 const rebuilt=await rebuildAccepted(acceptedSource);
 const before=activeLineage(await api('/workers/scripts/primecare-auth-api/deployments?per_page=1'));
 const proof=await moduleEvidence(await content('primecare-auth-api'),rebuilt.module,{worker:'primecare-auth-api',buildLabel:'accepted-auth'});
 const after=activeLineage(await api('/workers/scripts/primecare-auth-api/deployments?per_page=1'));
 if(canonical(before)!==canonical(after))throw new ProducerError('Auth changed during byte comparison');
 return {...before,...proof,acceptedSource,inputs:rebuilt.module.inputEvidence,sourceComparison:rebuilt.sourceComparison};
}
export function assertBuildGraph(meta,service,label,{baseDirectory=resolve('.')}={}){
 if(!meta?.inputs||!meta?.outputs)throw new ProducerError('Actual Wrangler build graph required');
 const emitted=new Map();
 for(const output of Object.values(meta.outputs))for(const [path,record] of Object.entries(output.inputs??{})){
  if(!Number.isSafeInteger(record.bytesInOutput)||record.bytesInOutput<0)throw new ProducerError('Build contribution metadata invalid');
  const absolute=resolve(baseDirectory,path);emitted.set(absolute,(emitted.get(absolute)??0)+record.bytesInOutput);
 }
 const required=label==='inactive'?[SCOPE[service],...(service==='governance'?['packages/shared/src/help-reader/service.ts','packages/shared/src/help-reader/postgres-store.ts','packages/shared/src/help-reader/operational-effects.ts']:[])]:[];
 for(const path of required)if(!Object.keys(meta.inputs).some(p=>resolve(baseDirectory,p)===resolve(path))||!(emitted.get(resolve(path))>0))throw new ProducerError('Required Help code absent from actual emitted graph');
 if(service==='auth'&&Object.keys(meta.inputs).some(path=>path.includes('/help-reader/')||path.includes('/governance_api/worker/')))throw new ProducerError('Auth graph unexpectedly contains Help code');
 return Object.keys(meta.inputs).sort();
}
export async function captureWorker({api,content,service,config,expectedModule,buildLabel='baseline'}){
 const worker=scoped(service),base='/workers/scripts/'+worker;
 const deployments=await api(base+'/deployments?per_page=2'),before=activeLineage(deployments);
 if(latest(await api(base+'/versions?per_page=1'))!==before.versionId)throw new ProducerError('Latest upload is not active');
 const version=await api(base+'/versions/'+before.versionId);
 if(version?.id!==before.versionId)throw new ProducerError('Version identity mismatch');
 const [settings,schedules,subdomain,routes]=await Promise.all([api(base+'/settings'),api(base+'/schedules'),api(base+'/subdomain'),api.routes(worker)]);
 const usageModel=assertSupportedSettings(settings,{version});
 meaningfulSchedules(schedules);
 if(subdomain?.enabled!==config.workers_dev||subdomain?.previews_enabled!==config.preview_urls||Object.keys(subdomain).some(k=>!['enabled','previews_enabled'].includes(k)))throw new ProducerError('Worker subdomain configuration unsupported');
 if(!Array.isArray(routes)||routes.length!==0)throw new ProducerError('Existing Worker routes require explicit preservation support');
 assertWorkerSecretBindingsPreserved(version.resources,settings);
 assertRetainedGenericPreserves(service,settings,schedules,config);
 const module=await moduleEvidence(await content(worker),expectedModule,{worker,buildLabel});
 const after=activeLineage(await api(base+'/deployments?per_page=2'));
 if(canonical(before)!==canonical(after)||latest(await api(base+'/versions?per_page=1'))!==before.versionId)throw new ProducerError('Worker lineage changed during byte inspection');
 return {worker,...before,settings,schedules,subdomain,routes,module,usageModel,predecessorDeploymentId:deployments.deployments[1]?.id??null};
}
function publicSnapshot(snapshot){
 return {worker:snapshot.worker,deploymentId:snapshot.deploymentId,versionId:snapshot.versionId,
  predecessorDeploymentId:snapshot.predecessorDeploymentId,module:snapshot.module,usageModel:snapshot.usageModel,serverOperation:readOnlyUploadAnnotation(snapshot.settings.annotations)?'version_upload':null,
  settingsSha256:hash(canonical(meaningfulSettings(snapshot.settings))),schedulesSha256:hash(canonical(meaningfulSchedules(snapshot.schedules))),
  subdomainSha256:hash(canonical(snapshot.subdomain)),routesSha256:hash(canonical(snapshot.routes)),
  secretBindingIdentities:snapshot.settings.bindings.filter(b=>['secret_text','secret_key'].includes(b.type)).map(b=>({name:b.name,type:b.type})).sort((a,b)=>a.name.localeCompare(b.name))};
}
export function assertPriorPlan(prior,current){
 if(prior?.format!==1||prior.mode!=='plan'||prior.providerWrites!==0||prior.source!==current.source||prior.preStateDigest!==current.preStateDigest||prior.inputsDigest!==current.inputsDigest||prior.authGateUnchanged!==true||prior.inactiveBindingLiteralNull!==true||canonical(prior.targets)!==canonical(current.targets)||canonical(prior.auth)!==canonical(current.auth))throw new ProducerError('Fresh plan differs from reviewed prior plan');
 if(!Number.isSafeInteger(prior.producer?.runId)||prior.producer.runId<=0||!Number.isSafeInteger(prior.producer?.jobId)||prior.producer.jobId<=0||!Number.isSafeInteger(prior.producer.runAttempt)||prior.producer.runAttempt<=0||prior.producer.workflow!==WORKFLOW||prior.producer.job!==PLAN_JOB)throw new ProducerError('Prior plan producer unavailable');
}
/** All injected publication hooks are called only after both targets pass complete preflight. */
export async function produceInactiveHelp({mode,source,producer,configs,build,api,content,authProof,sourceProof,prior,expectedPreState,expectedInputs,verifyPrior,freshMain,writeConfig,publish,recordAuthProof=async()=>{},recordAttempt=async()=>{},recordReceipt=async()=>{},wait=()=>new Promise(r=>setTimeout(r,1000))}){
 if(!['plan','deploy'].includes(mode)||!sha.test(source??'')||!producer||!Number.isSafeInteger(producer.runId)||producer.runId<=0||!Number.isSafeInteger(producer.jobId)||producer.jobId<=0||!Number.isSafeInteger(producer.runAttempt)||producer.runAttempt<=0||producer.workflow!==WORKFLOW||producer.job!==(mode==='plan'?PLAN_JOB:RELEASE_JOB))throw new ProducerError('Exact producer and mode required');
 const inputs=await sourceProof();
 const checkedAuth=async()=>{const proof=await authProof();await recordAuthProof(proof);return proof;};
 const auth=await checkedAuth();
 const prepared={},snapshots={},targets=[];
 for(const service of Object.keys(SCOPE)){
  const generic=retainedGenericConfig(service,configs[service]);
  const hosting=await api('/workers/scripts/'+scoped(service)+'/subdomain');
  const candidate=inactiveConfig(service,configs[service],hosting);
  const oldModule=await build(service,generic,'baseline'),newModule=await build(service,candidate,'inactive');
  const snapshot=await captureWorker({api,content,service,config:candidate,expectedModule:oldModule});
  prepared[service]={candidate,newModule,oldModule};snapshots[service]=snapshot;
  targets.push({service,entry:SCOPE[service],configSha256:hash(canonical(candidate)),before:publicSnapshot(snapshot),candidateModule:{moduleBytes:newModule.length,moduleSha256:hash(newModule),inputs:newModule.inputEvidence??null}});
 }
 const {inputs:authInputs,...authProvider}=auth;
 const preStateDigest=hash(canonical({auth:authProvider,targets:targets.map(t=>({service:t.service,before:t.before}))}));
 const inputsDigest=hash(canonical({inputs,authInputs:authInputs??null,targets:targets.map(t=>({service:t.service,entry:t.entry,configSha256:t.configSha256,candidateModule:t.candidateModule}))}));
 const plan={format:1,mode:'plan',source,producer,authGateUnchanged:true,inactiveBindingLiteralNull:true,auth,targets,preStateDigest,inputsDigest,providerWrites:0};
 if(mode==='plan')return plan;
 if(!/^[a-f0-9]{64}$/.test(expectedPreState??'')||!/^[a-f0-9]{64}$/.test(expectedInputs??'')||preStateDigest!==expectedPreState||inputsDigest!==expectedInputs)throw new ProducerError('Actual state and inputs differ from reviewed digest guards');
 assertPriorPlan(prior,plan);await verifyPrior(prior);
 const receipts=[],released={};
 for(const service of Object.keys(SCOPE)){
  const {candidate,newModule,oldModule}=prepared[service];
  await writeConfig(service,candidate);
  const fresh=await captureWorker({api,content,service,config:candidate,expectedModule:oldModule});
  if(canonical(publicSnapshot(fresh))!==canonical(publicSnapshot(snapshots[service])))throw new ProducerError('Worker changed after plan');
  if(canonical(await sourceProof())!==canonical(inputs)||canonical(await checkedAuth())!==canonical(auth))throw new ProducerError('Source or Auth proof changed before publication');
  for(const [previous,completed] of Object.entries(released)){
   const current=await captureWorker({api,content,service:previous,config:prepared[previous].candidate,expectedModule:prepared[previous].newModule,buildLabel:'inactive'});
   if(canonical(publicSnapshot(current))!==canonical(publicSnapshot(completed)))throw new ProducerError('Previously released Worker changed before next publication');
  }
  if(newModule.inputEvidence){if(typeof newModule.verifyInputs!=='function')throw new ProducerError('Prepared input verification unavailable');await newModule.verifyInputs();}
  const attempt={format:1,source,producer,service,worker:scoped(service),reportedVersionId:null,previousDeploymentId:fresh.deploymentId,previousServerOperation:readOnlyUploadAnnotation(fresh.settings.annotations)?'version_upload':null,publicationInvocationIntent:true,independentlyVerified:false};
  // Persist intent before Wrangler: an invocation may upload and then fail without a parseable ID.
  await recordAttempt(attempt);
  // Last operation before the sole provider-writing invocation. This hook fetches remote main.
  await freshMain(source);
  const versionId=uploadedWorkerVersion(await publish(service,candidate));
  await recordAttempt({...attempt,reportedVersionId:versionId});
  let after,lastError;
  for(let n=0;n<4;n++){
   try{after=await captureWorker({api,content,service,config:candidate,expectedModule:newModule,buildLabel:'inactive'});
    if(after.versionId!==versionId||after.deploymentId===fresh.deploymentId||after.predecessorDeploymentId!==fresh.deploymentId)throw new ProducerError('Exact upload and predecessor lineage required');lastError=null;break;
   }catch(error){
    if(error instanceof ProducerError&&error.annotationProjection){const observed=error.annotationProjection.fields.find(field=>field.path==='annotations.workers/triggered_by'),operation=observed?.operation??(observed?'unrecognized':null);if(operation!==attempt.previousServerOperation)error.serverOperationTransition={before:attempt.previousServerOperation,after:observed?{operation,valueSha256:observed.valueSha256}:null,permitted:false};}
    lastError=error;if(n<3)await wait();
   }
  }
  if(lastError)throw lastError;
  released[service]=after;
  assertWorkerSecretBindingsPreserved(fresh.settings,after.settings);
  if(canonical(meaningfulSettings(fresh.settings))!==canonical(meaningfulSettings(after.settings))){const error=new ProducerError('Worker preservation changed: settings');const operation=readOnlyUploadAnnotation(after.settings.annotations)?'version_upload':null;if(operation!==attempt.previousServerOperation)error.serverOperationTransition={before:attempt.previousServerOperation,after:operation,permitted:false};throw error;}
  if(canonical(meaningfulSchedules(fresh.schedules))!==canonical(meaningfulSchedules(after.schedules)))throw new ProducerError('Worker preservation changed: schedules');
  for(const key of ['subdomain','routes'])if(canonical(fresh[key])!==canonical(after[key]))throw new ProducerError('Worker preservation changed: '+key);
  receipts.push({format:1,source,producer,service,worker:after.worker,before:publicSnapshot(fresh),after:publicSnapshot(after),versionId,
   independentlyReadDeployment:true,exactUploadedModuleBytes:true,existingSettingsPreserved:true,secretBindingsPreserved:true,keepVars:true,trafficPercent:100,
   inactiveBindingLiteralNull:true,runtimeActivated:false,productionGrantsChanged:0,productionSchemaChanged:false,registeredGovernanceArtifactId:null,grantAssociationApproved:false});
  await recordReceipt(receipts[receipts.length-1]);
 }
 if(canonical(await checkedAuth())!==canonical(auth))throw new ProducerError('Auth changed before aggregate completion');
 for(const [service,completed] of Object.entries(released)){
  const current=await captureWorker({api,content,service,config:prepared[service].candidate,expectedModule:prepared[service].newModule,buildLabel:'inactive'});
  if(canonical(publicSnapshot(current))!==canonical(publicSnapshot(completed)))throw new ProducerError('Released Worker changed before aggregate completion');
 }
 // Wrangler owns its internal HTTP sequence. Count guarded CLI invocations, not fabricated HTTP writes.
 return {format:1,mode:'deploy',source,producer,receipts,providerWriteInvocations:receipts.length,runtimeActivated:false};
}

const call=(program,args,options={})=>execFileSync(program,args,{encoding:'utf8',stdio:['ignore','pipe','pipe'],maxBuffer:32*1024*1024,...options});
function verifyMain(source){
 if(call('git',['rev-parse','HEAD']).trim()!==source)throw new ProducerError('Checkout source mismatch');
 call('git',['diff','--quiet','HEAD']);
 const line=call('git',['ls-remote','--exit-code','origin','refs/heads/main']).trim();
 if(line!==source+'\trefs/heads/main')throw new ProducerError('Remote main advanced');
}
async function main(){
 const args=process.argv.slice(2),mode=args.shift();
 if(!['--plan','--deploy'].includes(mode)||args.length!==(mode==='--plan'?0:6)||mode==='--deploy'&&(args[0]!=='--plan-file'||args[2]!=='--expected-pre-state'||args[4]!=='--expected-inputs'))throw new ProducerError('Expected --plan or --deploy --plan-file PATH --expected-pre-state SHA256 --expected-inputs SHA256');
 const env=process.env,source=env.GITHUB_SHA;
 const expectedJob=mode==='--plan'?PLAN_JOB:RELEASE_JOB;
 rejectionContext={mode:mode.slice(2),source:sha.test(source??'')?source:null,producer:{workflow:WORKFLOW,job:expectedJob,runId:Number.isSafeInteger(Number(env.GITHUB_RUN_ID))?Number(env.GITHUB_RUN_ID):null}};
 if(env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||env.GITHUB_REF!=='refs/heads/main'||!['push','workflow_dispatch'].includes(env.GITHUB_EVENT_NAME)||!sha.test(source??'')||!env.RUNNER_TEMP||env.GITHUB_JOB!==expectedJob)throw new ProducerError('Exact main producer required');
 if(mode==='--deploy'&&env.INACTIVE_HELP_DEPLOYMENT_AUTHORIZATION!=='DEPLOY_INACTIVE_HELP')throw new ProducerError('Explicit inactive Help deployment opt-in required');
 verifyMain(source);
 assertReleaseToolchain({nodeVersion:process.versions.node,wranglerVersion:call('node_modules/.bin/wrangler',['--version']).trim(),lockBlob:call('git',['rev-parse','HEAD:package-lock.json']).trim()});
 const runId=Number(env.GITHUB_RUN_ID),base='repos/'+env.GITHUB_REPOSITORY+'/actions/';
 const run=JSON.parse(call('gh',['api',base+'runs/'+runId]));
 const jobs=JSON.parse(call('gh',['api',base+'runs/'+runId+'/jobs?per_page=100']));
 const job=jobs.jobs?.filter(j=>j.name===expectedJob&&j.run_id===runId&&j.status==='in_progress');
 if(!Number.isSafeInteger(runId)||runId<=0||run.id!==runId||run.head_sha!==source||run.head_branch!=='main'||run.path!==WORKFLOW||run.event!==env.GITHUB_EVENT_NAME||run.run_attempt!==Number(env.GITHUB_RUN_ATTEMPT)||jobs.total_count>100||job?.length!==1||!Number.isSafeInteger(job[0].id)||job[0].id<=0||job[0].run_attempt!==run.run_attempt)throw new ProducerError('Exact GitHub run and job required');
 const producer={runId,jobId:job[0].id,workflow:WORKFLOW,job:expectedJob,runAttempt:Number(env.GITHUB_RUN_ATTEMPT)};
 rejectionContext.producer=producer;
 const account=env.CLOUDFLARE_ACCOUNT_ID,token=env.CLOUDFLARE_API_TOKEN;
 if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw new ProducerError('Scoped provider credentials required');
 const get=async path=>{const operation=providerReadOperation(path),response=await readProviderResponse(operation,()=>fetch('https://api.cloudflare.com/client/v4'+path,{redirect:'error',headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)}));const raw=JSON.parse((await boundedBody(response,2*1024*1024)).toString());if(raw.success!==true)throw new ProducerError('Provider metadata unavailable: '+operation);return raw;};
 const api=async path=>{phase='provider_read_only_preservation';return (await get('/accounts/'+account+path)).result;};
 if((await api('/workers/subdomain'))?.subdomain!=='itpro-mohammed')throw new ProducerError('Worker account host mismatch');
 api.routes=async worker=>{
  const zones=[];for(let page=1;page<=20;page++){
   const raw=await get('/zones?account.id='+account+'&per_page=50&page='+page);
   if(!Array.isArray(raw.result)||!Number.isSafeInteger(raw.result_info?.total_pages)||raw.result_info.total_pages>20)throw new ProducerError('Bounded route inventory unavailable');
   zones.push(...raw.result);if(page>=raw.result_info.total_pages)break;
  }
  const routes=[];for(const zone of zones){if(!/^[a-f0-9]{32}$/.test(zone.id??''))throw new ProducerError('Zone identity unavailable');const raw=await get('/zones/'+zone.id+'/workers/routes');if(!Array.isArray(raw.result)||raw.result_info?.total_pages>1)throw new ProducerError('Complete route inventory unavailable');routes.push(...raw.result.filter(r=>r.script===worker));}
  return routes;
 };
 const content=worker=>readProviderResponse('content',()=>fetch('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/'+worker+'/content/v2',{redirect:'error',headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)}));
 const sourceProof=async()=>{
  phase='source_identity_and_inactive_contract';
  verifyInactiveSourceGit(call);
  if(await readFile('services/governance_api/worker/help-reader-runtime-binding.json','utf8')!=='null\n')throw new ProducerError('Inactive Help binding must remain literal null');
  const policy=JSON.parse(await readFile('packages/shared/src/help-reader/operational-policy.json','utf8'));
  if(policy.runtimeBound!==false||policy.purgeScheduleVerified!==true)throw new ProducerError('Help operational policy must remain inactive with verified inherited purge schedule');
  const sourceFiles=[...Object.values(SCOPE),'services/governance_api/worker/help-reader-runtime-binding.json','packages/shared/src/help-reader/operational-policy.json','scripts/release-inactive-help-workers.mjs','package.json','package-lock.json'];
  const identities=[];for(const file of sourceFiles){
   const record=call('git',['ls-tree','HEAD','--',file]).trim();
   if(!/^100644 blob [a-f0-9]{40}\t/.test(record)||(await lstat(file)).isSymbolicLink()||await realpath(file)!==resolve(file))throw new ProducerError('Regular tracked inactive source required');
   identities.push({path:file,sha256:hash(await readFile(file))});
  }
  return identities;
 };
 call('node',['scripts/generate-cloudflare-worker-config.mjs']);
 const configs=Object.fromEntries(await Promise.all(Object.keys(SCOPE).map(async service=>[service,JSON.parse(await readFile('.cloudflare-workers/'+service+'.jsonc','utf8'))])));
 const build=async(service,config,label,{root=resolve('.'),sourceRef='HEAD'}={})=>{
  phase='actual_wrangler_dry_run_and_graph';
  const file=resolve(root,'.cloudflare-workers',service+'.jsonc'),out=resolve(env.RUNNER_TEMP,'inactive-help-'+service+'-'+label);
  await rm(out,{recursive:true,force:true});await mkdir(out,{recursive:true});await mkdir(dirname(file),{recursive:true});await writeFile(file,JSON.stringify(config,null,2)+'\n');
  call('node_modules/.bin/wrangler',['deploy','--dry-run','--config',file,'--outdir',out,'--metafile',out+'/metafile.json'],{cwd:root});
  const files=(await readdir(out)).filter(name=>name.endsWith('.js'));if(files.length!==1)throw new ProducerError('Single rebuilt module required');
  const meta=JSON.parse(await readFile(out+'/metafile.json','utf8')),baseDirectory=resolve(dirname(file));
  const paths=assertBuildGraph(meta,service,label,{baseDirectory});
  const inputEvidence=[],physicalInputs=[],cwd=root,dependencies=await realpath(resolve(root,'node_modules'));for(const path of paths){
   if(/^node-built-in-modules:[a-z0-9_/-]+$/.test(path)){
    const record=meta.inputs[path];if(!Number.isSafeInteger(record.bytes)||record.bytes<0)throw new ProducerError('Virtual built-in input unavailable');
    inputEvidence.push({path,virtual:true,bytes:record.bytes,imports:record.imports});continue;
   }
   const attributes=path.match(/ with \{ type: ['"]json['"] \}$/)?.[0]??'';
   const absolute=resolve(baseDirectory,attributes?path.slice(0,-attributes.length):path),actual=await realpath(absolute),dependency=actual.startsWith(dependencies+'/');
   const relative=dependency?'node_modules/'+actual.slice(dependencies.length+1):absolute.slice(cwd.length+1);
   if(!(await lstat(absolute)).isFile()||!dependency&&(!absolute.startsWith(cwd+'/')||actual!==absolute||!/^100644 blob [a-f0-9]{40}\t/.test(call('git',['ls-tree',sourceRef,'--',relative]).trim())))throw new ProducerError('Build input outside checked source');
   const sha256=hash(await readFile(absolute));inputEvidence.push({path:relative+attributes,sha256});physicalInputs.push({absolute,actual,sha256});
  }
  const module=await readFile(out+'/'+files[0]);Object.defineProperty(module,'inputEvidence',{value:inputEvidence});
  Object.defineProperty(module,'verifyInputs',{value:async()=>{for(const input of physicalInputs)if(await realpath(input.absolute)!==input.actual||hash(await readFile(input.absolute))!==input.sha256)throw new ProducerError('Prepared build input changed');}});
  return module;
 };
 const authProof=async()=>{
  phase='unchanged_auth_source_gate_and_exact_provider_bytes';
  call('node',['scripts/verify-auth-live-proof-source.mjs']);
  const {selectAuthLiveProofPolicy}=await import('./verify-auth-live-proof-source.mjs');
  const acceptedSource=selectAuthLiveProofPolicy().source;
  const config=JSON.parse(await readFile('.cloudflare-workers/auth.jsonc','utf8'));
  return verifyAcceptedAuthBytes({api,content,acceptedSource,rebuildAccepted:async source=>{
   const currentModule=await build('auth',config,'current-auth');await currentModule.verifyInputs();
   const initialPaths=acceptedAuthArchivePaths(currentModule.inputEvidence),metadataCandidates=authCompilerMetadataCandidates(initialPaths);
   const metadataPaths=ref=>call('git',['ls-tree','-r','--name-only',ref,'--',...metadataCandidates]).trim().split('\n').filter(Boolean);
   const paths=[...new Set([...initialPaths,...metadataPaths(source),...metadataPaths('HEAD')])].sort(),records=[];
   const identity=(ref,path)=>{
    const line=call('git',['ls-tree',ref,'--',path]).trim(),match=line.match(/^(100644) blob ([a-f0-9]{40})\t/);
    if(!match)throw new ProducerError('Regular tracked accepted Auth source required');return {mode:match[1],blob:match[2]};
   };
   for(const path of paths){const current=identity('HEAD',path),accepted=identity(source,path);
    if(gitBlob(await readFile(path))!==current.blob)throw new ProducerError('Current Auth archive input changed');
    records.push({path,currentMode:current.mode,currentBlob:current.blob,acceptedMode:accepted.mode,acceptedBlob:accepted.blob});
   }
   const sourceComparison={...assertAcceptedAuthSourceRecords(records),currentModule:{moduleBytes:currentModule.length,moduleSha256:hash(currentModule)}};
   for(const path of paths.filter(path=>/(?:^|\/)(?:tsconfig|jsconfig)\.json$/.test(path)))if(/"extends"\s*:/.test(call('git',['show',source+':'+path])))throw new ProducerError('Accepted compiler metadata inheritance requires explicit archive');
   const root=resolve(env.RUNNER_TEMP,'inactive-help-accepted-auth-source');await rm(root,{recursive:true,force:true});await mkdir(root,{recursive:true});
   const archive=call('git',['archive','--format=tar',source,'--',...paths],{encoding:null});
   const archivePath=resolve(root,'accepted-auth.tar');await writeFile(archivePath,archive);call('tar',['-xf',archivePath,'-C',root]);await rm(archivePath);
   for(const record of records){const file=resolve(root,record.path);if(!(await lstat(file)).isFile()||await realpath(file)!==file||gitBlob(await readFile(file))!==record.acceptedBlob)throw new ProducerError('Accepted Auth archive file identity differs');}
   sourceComparison.dependencies=await copyLockedDependencies({source:await realpath('node_modules'),destination:resolve(root,'node_modules')});
   const module=await build('auth',config,'accepted-auth',{root,sourceRef:source});
   const currentInputs=new Map(currentModule.inputEvidence.map(input=>[input.path,input]));
   if(module.inputEvidence.length!==currentInputs.size)throw new ProducerError('Accepted Auth build input graph changed');
   for(const input of module.inputEvidence){const before=currentInputs.get(input.path);if(!before)throw new ProducerError('Accepted Auth build input graph changed');
    if(withoutJsonAttributes(input.path)==='tools/governance-production/production-pin.json')continue;
    if(canonical(before)!==canonical(input))throw new ProducerError('Accepted Auth source or dependency input differs');
   }
   await module.verifyInputs();
   return {module,sourceComparison};
  }});
 };
 const prior=mode==='--deploy'?JSON.parse(await readFile(args[1],'utf8')):undefined;
 const verifyPrior=async plan=>{
  const r=JSON.parse(call('gh',['api',base+'runs/'+plan.producer.runId]));
  const j=JSON.parse(call('gh',['api',base+'jobs/'+plan.producer.jobId]));
  if(r.id!==plan.producer.runId||r.head_sha!==source||r.path!==WORKFLOW||r.head_branch!=='main'||!['push','workflow_dispatch'].includes(r.event)||!(r.id===runId&&r.status==='in_progress'||r.status==='completed'&&r.conclusion==='success')||j.id!==plan.producer.jobId||j.run_id!==r.id||j.run_attempt!==plan.producer.runAttempt||j.name!==PLAN_JOB||j.status!=='completed'||j.conclusion!=='success')throw new ProducerError('Prior successful plan CI required');
  const log=call('gh',['api',base+'jobs/'+j.id+'/logs']);
  const marker='INACTIVE_HELP_PLAN ',lines=log.split('\n').filter(line=>line.includes(marker+'{'));
  const receipt=lines.length===1?JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length)):null;
  if(receipt?.format!==1||receipt.source!==plan.source||receipt.planSha256!==hash(canonical(plan))||canonical(receipt.producer)!==canonical(plan.producer)||receipt.preStateDigest!==plan.preStateDigest||receipt.inputsDigest!==plan.inputsDigest||receipt.providerWrites!==0)throw new ProducerError('Prior plan differs from independent CI receipt');
 };
 phase='complete_preflight_and_optional_scoped_publication';
 const result=await produceInactiveHelp({mode:mode.slice(2),source,producer,configs,build,api,content,authProof,sourceProof,prior,expectedPreState:args[3],expectedInputs:args[5],verifyPrior,
  recordAuthProof:async proof=>{const receipt={format:1,component:'accepted-auth-bytes',currentProducerSource:source,producer,worker:'primecare-auth-api',...proof,independentlyReadDeployment:true,deploymentReadiness:false,componentProviderWrites:0};await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/accepted-auth-bytes.json',JSON.stringify(receipt,null,2)+'\n');console.log('INACTIVE_HELP_ACCEPTED_AUTH_BYTES '+JSON.stringify({source,producer,acceptedSource:proof.acceptedSource,worker:'primecare-auth-api',deploymentId:proof.deploymentId,versionId:proof.versionId,moduleSha256:proof.moduleSha256,moduleBytes:proof.moduleBytes,exactBytes:proof.exactBytes,deploymentReadiness:false,componentProviderWrites:0}));},
  recordAttempt:async attempt=>{await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/'+attempt.service+'-attempt.json',JSON.stringify(attempt,null,2)+'\n');},
  recordReceipt:async receipt=>{await writeFile('test-results/inactive-help/'+receipt.service+'-receipt.json',JSON.stringify(receipt,null,2)+'\n');console.log('INACTIVE_HELP_WORKER_RECEIPT '+JSON.stringify({source,producer,service:receipt.service,worker:receipt.worker,versionId:receipt.versionId,deploymentId:receipt.after.deploymentId,previousDeploymentId:receipt.before.deploymentId,moduleSha256:receipt.after.module.moduleSha256,receiptSha256:hash(canonical(receipt)),runtimeActivated:false}));},
  freshMain:async s=>verifyMain(s),writeConfig:async(service,config)=>writeFile('.cloudflare-workers/'+service+'.jsonc',JSON.stringify(config,null,2)+'\n'),
  publish:async(service,config)=>{const file='.cloudflare-workers/'+service+'.jsonc';if(await readFile(file,'utf8')!==JSON.stringify(config,null,2)+'\n')throw new ProducerError('Prepared configuration changed');return call('node_modules/.bin/wrangler',['deploy','--config',file,'--keep-vars']);}});
 await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/'+mode.slice(2)+'.json',JSON.stringify(result,null,2)+'\n');
 if(mode==='--plan')console.log('INACTIVE_HELP_PLAN '+JSON.stringify({format:1,source,producer,planSha256:hash(canonical(result)),preStateDigest:result.preStateDigest,inputsDigest:result.inputsDigest,providerWrites:0}));
 else console.log('INACTIVE_HELP_DEPLOYED '+JSON.stringify({format:1,source,producer,receiptSha256:hash(canonical(result)),providerWriteInvocations:result.providerWriteInvocations,receipts:result.receipts.map(r=>({service:r.service,worker:r.worker,versionId:r.versionId,deploymentId:r.after.deploymentId,predecessorDeploymentId:r.before.deploymentId,moduleSha256:r.after.module.moduleSha256})),runtimeActivated:false}));
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(async error=>{
 const failure={format:1,...rejectionContext,phase,reason:error instanceof ProducerError?error.message:'source_build_or_preservation_gate_failed',...(error instanceof ProducerError&&error.providerRead?{providerRead:error.providerRead}:{}),...(error instanceof ProducerError&&error.moduleComparison?{moduleComparison:error.moduleComparison}:{}),...(error instanceof ProducerError&&error.unsupportedSettings?{unsupportedSettings:error.unsupportedSettings,usageModel:error.usageModel,...(error.annotationProjection?{annotationProjection:error.annotationProjection}:{})}:{}),...(error instanceof ProducerError&&error.serverOperationTransition?{serverOperationTransition:error.serverOperationTransition}:{})};
 if(rejectionContext?.mode==='plan'){
  failure.providerWrites=0;
  try{await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/plan-rejected.json',JSON.stringify(failure,null,2)+'\n');}catch{}
 }
 console.error('INACTIVE_HELP_REJECTED '+JSON.stringify(failure));process.exitCode=1;
});
