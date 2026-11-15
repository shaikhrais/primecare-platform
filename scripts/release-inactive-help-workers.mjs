/** Narrow inactive Help publication. --plan performs provider GETs only. */
import {readFile,writeFile,mkdir,readdir,rm,lstat,realpath,readlink,cp} from 'node:fs/promises';
import {createReadStream} from 'node:fs';
import {execFileSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {resolve,dirname,relative} from 'node:path';
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
let producerOperation='configuration',lastCompletedChildCommand=null;
const commandKinds=new Set(['git-fetch','git-archive','git-source-read','git-worktree-check','git-remote-main','github-run-read','github-job-read','github-job-log-read','github-run-jobs-read','auth-source-gate','local-config-generation','wrangler-dry-run','wrangler-version','wrangler-publish','local-archive-extract','local-child-other']);
const operationKinds=new Set([...commandKinds,'configuration','historical-source-identities','historical-source-config-metadata','historical-source-archive','historical-archive-files-verify','historical-dependency-copy','historical-bundle-build','historical-input-hash-compare','governance-history-receipt-parse','governance-history-validation']);
export function classifyProducerCommand(program,args){
 if(program==='git')return ({fetch:'git-fetch',archive:'git-archive','rev-parse':'git-source-read','cat-file':'git-source-read','ls-tree':'git-source-read',show:'git-source-read',diff:'git-worktree-check','ls-remote':'git-remote-main'})[args[0]]??'local-child-other';
 if(program==='gh'&&args[0]==='api'){
  if(/\/jobs\/\d+\/logs$/.test(args[1]??''))return 'github-job-log-read';
  if(/\/jobs\/\d+$/.test(args[1]??''))return 'github-job-read';
  if(/\/runs\/\d+\/jobs(?:\?|$)/.test(args[1]??''))return 'github-run-jobs-read';
  if(/\/runs\/\d+$/.test(args[1]??''))return 'github-run-read';
 }
 if(program==='node'&&args[0]==='scripts/verify-auth-live-proof-source.mjs')return 'auth-source-gate';
 if(program==='node'&&args[0]==='scripts/generate-cloudflare-worker-config.mjs')return 'local-config-generation';
 if(program==='node_modules/.bin/wrangler'||program.endsWith('/_temp/worker-dependencies/node_modules/.bin/wrangler'))return args.includes('--dry-run')?'wrangler-dry-run':args.includes('--version')?'wrangler-version':args[0]==='deploy'?'wrangler-publish':'local-child-other';
 return program==='tar'?'local-archive-extract':'local-child-other';
}
export function producerFailureDiagnostics(error,{operation=producerOperation,childCommand=error?.safeChildCommand,lastCompletedCommand=lastCompletedChildCommand}={}){
 const names=new Set(['Error','TypeError','SyntaxError','RangeError','ReferenceError','URIError','EvalError','AggregateError','AbortError','SystemError']);
 const frames=[];
 for(const line of String(error?.stack??'').split('\n').slice(1)){
  const match=line.match(/\/scripts\/release-inactive-help-workers\.mjs:(\d{1,6}):(\d{1,6})\)?\s*$/);
  if(match&&frames.length<8)frames.push({line:Number(match[1]),column:Number(match[2])});
 }
 const safeCommand=value=>value?{kind:commandKinds.has(value.kind)?value.kind:'local-child-other',exitStatus:Number.isInteger(value.exitStatus)&&value.exitStatus>=0&&value.exitStatus<=255?value.exitStatus:null}:null;
 return {errorClass:names.has(error?.originalErrorClass??error?.name)?error.originalErrorClass??error.name:'Error',operation:operationKinds.has(operation)?operation:'configuration',producerFrames:frames,...(childCommand?{childCommand:safeCommand(childCommand)}:{}),...(lastCompletedCommand?{lastCompletedChildCommand:safeCommand(lastCompletedCommand)}:{})};
}
const acceptedCloudflareTree='88b9689f0efd5c892be0e57bed063131b0f9541c';
const guardSource='718eaff3e6b3d4c5b26d68ec0b7a6ceaca5da3ea';
export const RELEASE_TOOLCHAIN=Object.freeze({nodeMajor:24,wrangler:'4.86.0',lockBlob:'0a25c42592d30c27e41e4a643144909f532590eb'});
/** Byte reproduction only: the original Gateway publisher/run remains unknown. */
export const GATEWAY_REPRODUCTION=Object.freeze({profile:'gateway-wrangler-4.68.1-byte-reproduction-v1',wrangler:'4.68.1',lockSha256:'6b20b277bf1f57eddf14a9a325f9b9aaf27f62de9a8a108472308add79693752',packageSha256:'73086d337b2c14da43c086487b5e1c31005bd8998b61d54d20c76ac3c70e99c0',deploymentId:'af3ae49b-3d12-481b-86b1-30cb4fff1f3f',versionId:'9f8654b5-a5a0-4e91-854a-325cb754afdc',moduleBytes:153692,moduleSha256:'f8e2c8b6c951b06344c1640f96db62c6c93698ed28a87922b92f1a29e52d66c2',dependencyLabel:'../../../_temp/worker-dependencies/node_modules'});
export const GATEWAY_REPRODUCTION_SOURCES=Object.freeze({
 'docs/transport/compression-policy.json':'38d101c1fb33e6b87ea3e2a80e4a560388a4c1f2',
 'cloudflare/workers/src/core/response-compression.ts':'3b85b77f5bb0b8420b1400baeaff741a06e8c3db',
 'cloudflare/workers/src/core/base-worker.ts':'edb4b57c5253e83529fc0a58dbaffb58868dab0a',
 'cloudflare/workers/src/governed-read-aliases.json':'eb958d6998e5af9ded08baf60540d87ac31b3a2c',
 'tools/governance-production/external-call-registration.json':'b736fb30143c917663344827316cc5888df0f947',
 'tools/governance-production/internal-call-preparation-registration.json':'2a57eec02a63fe2a6e112da00442ae1ab6c46157',
 'tools/governance-production/internal-call-events-registration.json':'5d514cc7ba0257e8b1acfddb6dc77a23a8c93e0c',
 'tools/governance-production/internal-call-contracts-registration.json':'6d1a795ea93a22f52fd4309c785011521e66a261',
 'tools/governance-production/voice-contact-contracts-registration.json':'e4394bb97a0d43aa69d7ff038eb5d7f19a84106b',
 'tools/governance-production/twilio-contracts-registration.json':'9e347860fd4ec386885f86d677a68920930688bb',
 'packages/shared/src/communications/registered-contracts.json':'e61526a1e59fdca2604ae5a0eeaa51537900c8e6',
 'cloudflare/workers/src/gateway.ts':'f4364d399be57acd67968c9a889b16ce17ee729e'});
export function assertGatewayReproductionIdentity(identity){
 const p=GATEWAY_REPRODUCTION;
 if(identity?.service!=='gateway'||identity.worker!=='primecare-api-gateway'||identity.deploymentId!==p.deploymentId||identity.versionId!==p.versionId||identity.latestVersionId!==p.versionId)throw new ProducerError('Gateway identity differs from fixed byte reproduction profile');
}
export function assertGatewayReproductionSources(records){
 if(!Array.isArray(records)||records.length!==Object.keys(GATEWAY_REPRODUCTION_SOURCES).length||new Set(records.map(r=>r.path)).size!==records.length)throw new ProducerError('Exact Gateway reproduction source closure required');
 for(const r of records)if(r.mode!=='100644'||r.type!=='blob'||!Object.hasOwn(GATEWAY_REPRODUCTION_SOURCES,r.path)||r.blob!==GATEWAY_REPRODUCTION_SOURCES[r.path])throw new ProducerError('Gateway reproduction source identity differs');
}
export function assertGatewayReproductionToolchain({nodeVersion,wranglerVersion,packageSha256,lockSha256,dependencyLabel}){
 const p=GATEWAY_REPRODUCTION;
 if(!/^24\./.test(nodeVersion??'')||wranglerVersion!==p.wrangler||packageSha256!==p.packageSha256||lockSha256!==p.lockSha256||dependencyLabel!==p.dependencyLabel)throw new ProducerError('Fixed Gateway reproduction compiler, lock and physical layout required');
 return {profile:p.profile,wrangler:p.wrangler,nodeMajor:24,packageSha256,lockSha256,dependencyLabel,originalPublisherKnown:false,historicalSourceAssociationVerified:false,deploymentReadiness:false};
}
export function assertGatewayReproductionGraph(inputs){
 const expected=[...Object.keys(GATEWAY_REPRODUCTION_SOURCES),'node_modules/unenv/dist/runtime/_internal/utils.mjs','node_modules/unenv/dist/runtime/node/internal/perf_hooks/performance.mjs','node_modules/unenv/dist/runtime/node/internal/perf_hooks/histogram.mjs','node_modules/unenv/dist/runtime/node/internal/perf_hooks/constants.mjs','node_modules/unenv/dist/runtime/node/perf_hooks.mjs','node_modules/@cloudflare/unenv-preset/dist/runtime/polyfill/performance.mjs'].sort();
 if(!Array.isArray(inputs)||canonical(inputs.map(i=>i.path).sort())!==canonical(expected))throw new ProducerError('Exact Gateway reproduction emitted input graph required');
}
export function assertGatewayReproductionBytes(module){
 const p=GATEWAY_REPRODUCTION;
 if(!Buffer.isBuffer(module)||module.length!==p.moduleBytes||hash(module)!==p.moduleSha256)throw new ProducerError('Fixed Gateway reproduction raw module bytes differ');
}
export const GOVERNANCE_PREDECESSOR=Object.freeze({source:'07a2ea799d6bda0adcca60531f20a5f02766358f',runId:43669947275,jobId:132678080810,acceptanceJobId:132677568913,workflow:'.github/workflows/psw-workspace.yml',deploymentId:'0b5b8ae3-e38a-468d-b5b9-ead32b267c80',versionId:'4f12b2ed-53d8-4c8a-9811-7199e18bb7f3'});
export function assertGovernancePredecessorIdentity(identity){
 if(identity?.service!=='governance'||identity.worker!=='primecare-governance-api'||identity.deploymentId!==GOVERNANCE_PREDECESSOR.deploymentId||identity.versionId!==GOVERNANCE_PREDECESSOR.versionId||identity.latestVersionId!==GOVERNANCE_PREDECESSOR.versionId)throw new ProducerError('Governance predecessor differs from recorded code deployment');
}
/** The code step succeeded; the historical parent later failed. Never promote that parent to success. */
export function checkGovernanceHistoricalProducer({run,job,acceptance,receipt}){
 const p=GOVERNANCE_PREDECESSOR;
 if(run?.id!==p.runId||run.head_sha!==p.source||run.head_branch!=='main'||run.path!==p.workflow||run.event!=='workflow_dispatch'||run.status!=='completed'||run.conclusion!=='failure'||job?.id!==p.jobId||job.run_id!==p.runId||job.name!=='publish'||job.status!=='completed'||job.conclusion!=='failure'||acceptance?.id!==p.acceptanceJobId||acceptance.run_id!==p.runId||acceptance.name!=='acceptance'||acceptance.status!=='completed'||acceptance.conclusion!=='success')throw new ProducerError('Exact historical governance producer required');
 const steps=job.steps;
 if(!Array.isArray(steps))throw new ProducerError('Historical governance code-step evidence required');
 const find=name=>steps.map((step,index)=>({step,index})).filter(item=>item.step.name===name);
 const fresh=find('Verify current main before publication'),code=find('Publish governance API while preserving existing live bindings'),failed=steps.map((step,index)=>({step,index})).filter(item=>item.step.conclusion==='failure');
 if(fresh.length!==1||fresh[0].step.conclusion!=='success'||code.length!==1||code[0].step.conclusion!=='success'||fresh[0].index>=code[0].index||failed.length!==1||failed[0].step.name!=='Verify current main before Pages publication'||failed[0].index<=code[0].index||steps.slice(failed[0].index+1).some(step=>!step.name.startsWith('Post ')&&!['Run actions/upload-artifact@v4','Complete job'].includes(step.name)&&!['skipped',null,undefined].includes(step.conclusion)))throw new ProducerError('Historical governance code success and later parent failure required');
 if(receipt?.format!==1||receipt.source!==p.source||receipt.worker!=='primecare-governance-api'||receipt.service!=='governance'||receipt.deploymentId!==p.deploymentId||receipt.versionId!==p.versionId||receipt.trafficPercent!==100||receipt.independentlyReadDeployment!==true||receipt.sourceCheckoutVerified!==true||receipt.existingBindingsPreserved!==true||receipt.healthStatus!==200||receipt.otherWorkersModified!==0)throw new ProducerError('Exact historical governance uploaded receipt required');
 return {...p,codeStepConclusion:'success',acceptanceJobConclusion:'success',parentJobConclusion:'failure',parentRunConclusion:'failure',wholePipelineAccepted:false,historicalReceiptSha256:hash(canonical(receipt))};
}
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
function githubLogError(category,stage,httpStatus=null){
 const error=new ProducerError('GitHub job log evidence unavailable');error.githubEvidence={operation:'github-job-log-read',category,stage,httpStatus};return error;
}
function trustedGithubLogLocation(value){
 try{const url=new URL(value);if(url.protocol!=='https:'||url.username||url.password||url.hash||url.port)return false;
  return url.hostname.endsWith('.actions.githubusercontent.com')||/^productionresultssa[a-z0-9]*\.blob\.core\.windows\.net$/.test(url.hostname);
 }catch{return false;}
}
/** GitHub documents a 302 to a short-lived plaintext log URL. Never forward the API credential. */
export async function fetchGithubJobLog({jobId,token,fetcher=fetch,maxBytes=32*1024*1024}){
 producerOperation='github-job-log-read';
 if(!Number.isSafeInteger(maxBytes)||maxBytes<=0||maxBytes>32*1024*1024)throw githubLogError('body-bound-required','api');
 if(!Number.isSafeInteger(jobId)||jobId<=0||typeof token!=='string'||!token)throw githubLogError('authentication-or-job-identity-required','api');
 let url='https://api.github.com/repos/shaikhrais/primecare-platform/actions/jobs/'+jobId+'/logs';
 for(let redirects=0;redirects<=2;redirects++){
  const stage=redirects===0?'api':'signed-log';let response;
  try{response=await fetcher(url,{method:'GET',redirect:'manual',headers:redirects===0?{authorization:'Bearer '+token,accept:'application/vnd.github+json','x-github-api-version':'2026-03-10','user-agent':'primecare-readonly-producer-evidence'}:{accept:'text/plain','user-agent':'primecare-readonly-producer-evidence'},signal:AbortSignal.timeout(30000)});}catch{throw githubLogError('transport-unavailable',stage);}
  if([301,302,303,307,308].includes(response.status)){
   const location=response.headers.get('location');await response.body?.cancel().catch(()=>{});
   if(redirects===2)throw githubLogError('redirect-limit',stage,response.status);
   if(!trustedGithubLogLocation(location))throw githubLogError('redirect-rejected',stage,response.status);
   url=location;continue;
  }
  if(response.status!==200){
   const status=response.status,category=status===401?'authentication-required':status===403?(response.headers.get('x-ratelimit-remaining')==='0'?'rate-limited':'permission-denied'):status===404?'not-found':status===410?'logs-expired':status===429?'rate-limited':status>=500?'upstream-failure':'unexpected-status';
   await response.body?.cancel().catch(()=>{});throw githubLogError(category,stage,status);
  }
  const type=(response.headers.get('content-type')??'').split(';')[0].trim().toLowerCase();
  if(!['text/plain','application/octet-stream'].includes(type)){await response.body?.cancel().catch(()=>{});throw githubLogError('content-type-rejected',stage,response.status);}
  let bytes;try{bytes=await boundedBody(response,maxBytes);}catch{throw githubLogError('body-read-or-size-rejected',stage,response.status);}
  try{return new TextDecoder('utf-8',{fatal:true}).decode(bytes);}catch{throw githubLogError('text-decoding-rejected',stage,response.status);}
 }
 throw githubLogError('redirect-limit','signed-log');
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
/** Separate, fixed governance predecessor rule; it does not alter accepted Auth source policy. */
export function assertGovernanceSourceRecords(records){
 if(!Array.isArray(records)||!records.length||new Set(records.map(r=>r.path)).size!==records.length)throw new ProducerError('Unique governance source identity records required');
 const changed=[];
 for(const record of records){
  if(record.currentMode!=='100644'||record.acceptedMode!=='100644'||!sha.test(record.currentBlob??'')||!sha.test(record.acceptedBlob??''))throw new ProducerError('Regular immutable governance source files required');
  if(record.currentBlob===record.acceptedBlob)continue;
  if(record.path!=='tools/governance-production/production-pin.json'||record.acceptedBlob!=='05e7a153405ffa5210927c20357d92248023f358'||record.currentBlob!=='8478c2892885e57109e898736b1f1995344cb70b')throw new ProducerError('Unreviewed governance transitive source difference');
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
const providerSourceEnums=new Set(['unknown','api','wrangler','terraform','dash','cf_cli','dash_template','integration','quick_editor','playground','workersci']);
const safeSource=value=>({enum:value===undefined?'absent':providerSourceEnums.has(value)?value:'unrecognized',...(value!==undefined&&!providerSourceEnums.has(value)?{valueSha256:hash(canonical(value)??'undefined')}: {})});
const safeCreatedOn=value=>typeof value==='string'&&/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{1,9})?Z$/.test(value)&&Number.isFinite(Date.parse(value))?value:null;
/** Identity only: this never asserts code equivalence, preserved settings, or deployment readiness. */
export async function inspectWorkerPredecessor({api,service}){
 const worker=scoped(service),base='/workers/scripts/'+worker,raw=await api(base+'/deployments?per_page=2'),before=activeLineage(raw);
 if(latest(await api(base+'/versions?per_page=1'))!==before.versionId)throw new ProducerError('Latest upload is not active');
 const version=await api(base+'/versions/'+before.versionId);if(version?.id!==before.versionId)throw new ProducerError('Version identity mismatch');
 const after=activeLineage(await api(base+'/deployments?per_page=2'));
 if(canonical(before)!==canonical(after)||latest(await api(base+'/versions?per_page=1'))!==before.versionId)throw new ProducerError('Worker lineage changed during predecessor inspection');
 return {format:1,component:'worker-predecessor-identity',service,worker,...before,latestVersionId:before.versionId,
  predecessorDeploymentId:uuid.test(raw.deployments?.[1]?.id??'')?raw.deployments[1].id:null,
  deploymentCreatedOn:safeCreatedOn(raw.deployments[0].created_on),versionCreatedOn:safeCreatedOn(version.metadata?.created_on),
  versionSource:safeSource(version.metadata?.source),lastDeployedFrom:safeSource(version.resources?.script?.last_deployed_from),
  versionNumber:Number.isSafeInteger(version.number)&&version.number>0?version.number:null,
  independentProviderIdentityRead:true,baselineBytesVerified:false,settingsPreservationVerified:false,deploymentReadiness:false,componentProviderWrites:0};
}
/** Hash/range diagnostics use provider bytes privately; section names come only from local build inputs. */
export function moduleMismatchAttribution(expected,actual){
 const limit=Math.min(expected.length,actual.length);let prefix=0,suffix=0;
 while(prefix<limit&&expected[prefix]===actual[prefix])prefix++;
 while(suffix<limit-prefix&&expected[expected.length-1-suffix]===actual[actual.length-1-suffix])suffix++;
 const known=new Set((expected.inputEvidence??[]).filter(input=>!input.virtual).map(input=>withoutJsonAttributes(input.path))),sections=[];
 for(let position=0;position<expected.length;){
  let end=expected.indexOf(10,position);if(end===-1)end=expected.length;
  if(end-position<300&&expected[position]===47&&expected[position+1]===47&&expected[position+2]===32){
   const path=withoutJsonAttributes(expected.subarray(position+3,end).toString('utf8').trim()).replace(/^(?:\.\.\/)+/,'');
   if(known.has(path)&&/^[A-Za-z0-9_@./-]+$/.test(path))sections.push({start:position,path});
  }
  position=end+1;
 }
 const sectionAt=position=>{for(let i=sections.length-1;i>=0;i--)if(sections[i].start<=position){const section=sections[i],end=sections[i+1]?.start??expected.length;return {path:section.path,headerOffset:section.start,localSectionSha256:hash(expected.subarray(section.start,end))};}return null;};
 const ranges=[];let count=0,differingBytes=Math.abs(expected.length-actual.length);
 for(let position=prefix;position<limit;){
  if(expected[position]===actual[position]){position++;continue;}
  const start=position;while(position<limit&&expected[position]!==actual[position])position++;
  count++;differingBytes+=position-start;
  if(ranges.length<16)ranges.push({start,endExclusive:position,expectedRangeSha256:hash(expected.subarray(start,position)),providerRangeSha256:hash(actual.subarray(start,position)),localSection:sectionAt(start)});
 }
 if(expected.length!==actual.length){count++;if(ranges.length<16)ranges.push({start:limit,expectedEndExclusive:expected.length,providerEndExclusive:actual.length,expectedRangeSha256:hash(expected.subarray(limit)),providerRangeSha256:hash(actual.subarray(limit)),localSection:sectionAt(limit)});}
 return {comparison:'same-byte-offset',commonPrefixBytes:prefix,commonSuffixBytes:suffix,differingByteCount:differingBytes,changedRangeCount:count,ranges,rangesTruncated:count>ranges.length};
}
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
  if(modules.length===1)error.moduleComparison.byteAttribution=moduleMismatchAttribution(expected,modules[0]);
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
export async function produceInactiveHelp({mode,source,producer,configs,build,baselineModule=async({currentModule})=>({module:currentModule,sourceProof:null}),api,content,authProof,sourceProof,prior,expectedPreState,expectedInputs,verifyPrior,freshMain,writeConfig,publish,recordAuthProof=async()=>{},recordPredecessor=async()=>{},recordBaselineProof=async()=>{},recordAttempt=async()=>{},recordReceipt=async()=>{},wait=()=>new Promise(r=>setTimeout(r,1000))}){
 if(!['plan','deploy'].includes(mode)||!sha.test(source??'')||!producer||!Number.isSafeInteger(producer.runId)||producer.runId<=0||!Number.isSafeInteger(producer.jobId)||producer.jobId<=0||!Number.isSafeInteger(producer.runAttempt)||producer.runAttempt<=0||producer.workflow!==WORKFLOW||producer.job!==(mode==='plan'?PLAN_JOB:RELEASE_JOB))throw new ProducerError('Exact producer and mode required');
 const inputs=await sourceProof();
 const checkedAuth=async()=>{const proof=await authProof();await recordAuthProof(proof);return proof;};
 const auth=await checkedAuth();
 const predecessors={};
 for(const service of Object.keys(SCOPE)){const identity=await inspectWorkerPredecessor({api,service});predecessors[service]=identity;await recordPredecessor(identity);}
 const prepared={},snapshots={},targets=[];
 for(const service of Object.keys(SCOPE)){
  const generic=retainedGenericConfig(service,configs[service]);
  const hosting=await api('/workers/scripts/'+scoped(service)+'/subdomain');
  const candidate=inactiveConfig(service,configs[service],hosting);
  const currentModule=await build(service,generic,'baseline'),newModule=await build(service,candidate,'inactive');
  const baseline=await baselineModule({service,config:generic,currentModule,predecessor:predecessors[service]}),oldModule=baseline.module;
  const snapshot=await captureWorker({api,content,service,config:candidate,expectedModule:oldModule});
  if(snapshot.deploymentId!==predecessors[service].deploymentId||snapshot.versionId!==predecessors[service].versionId)throw new ProducerError('Worker changed after predecessor identity inspection');
  await recordBaselineProof({service,worker:snapshot.worker,deploymentId:snapshot.deploymentId,versionId:snapshot.versionId,module:snapshot.module,sourceProof:baseline.sourceProof,exactProviderBytes:true,deploymentReadiness:false,componentProviderWrites:0});
  prepared[service]={candidate,newModule,oldModule};snapshots[service]=snapshot;
  targets.push({service,entry:SCOPE[service],configSha256:hash(canonical(candidate)),before:publicSnapshot(snapshot),baselineSourceProof:baseline.sourceProof,candidateModule:{moduleBytes:newModule.length,moduleSha256:hash(newModule),inputs:newModule.inputEvidence??null}});
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

const call=(program,args,options={})=>{
 const kind=classifyProducerCommand(program,args);producerOperation=kind;
 try{const output=execFileSync(program,args,{encoding:'utf8',stdio:['ignore','pipe','pipe'],maxBuffer:32*1024*1024,...options});lastCompletedChildCommand={kind,exitStatus:0};return output;}
 catch(original){const error=new ProducerError('Known child command failed');error.originalErrorClass=['Error','TypeError','SyntaxError','RangeError','ReferenceError'].includes(original?.name)?original.name:'Error';error.safeChildCommand={kind,exitStatus:original?.status};error.safeProducerDiagnostics=producerFailureDiagnostics(original,{operation:kind,childCommand:error.safeChildCommand});throw error;}
};
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
  const sourceFiles=[...Object.values(SCOPE),'services/governance_api/worker/help-reader-runtime-binding.json','packages/shared/src/help-reader/operational-policy.json','scripts/release-inactive-help-workers.mjs','package.json','package-lock.json','tools/inactive-help-gateway-reproduction/package.json','tools/inactive-help-gateway-reproduction/package-lock.json'];
  const identities=[];for(const file of sourceFiles){
   const record=call('git',['ls-tree','HEAD','--',file]).trim();
   if(!/^100644 blob [a-f0-9]{40}\t/.test(record)||(await lstat(file)).isSymbolicLink()||await realpath(file)!==resolve(file))throw new ProducerError('Regular tracked inactive source required');
   identities.push({path:file,sha256:hash(await readFile(file))});
  }
  return identities;
 };
 call('node',['scripts/generate-cloudflare-worker-config.mjs']);
 const configs=Object.fromEntries(await Promise.all(Object.keys(SCOPE).map(async service=>[service,JSON.parse(await readFile('.cloudflare-workers/'+service+'.jsonc','utf8'))])));
 const build=async(service,config,label,{root=resolve('.'),sourceRef='HEAD',compiler='node_modules/.bin/wrangler',dependencyRoot=resolve(root,'node_modules')}={})=>{
  phase='actual_wrangler_dry_run_and_graph';
  const file=resolve(root,'.cloudflare-workers',service+'.jsonc'),out=resolve(env.RUNNER_TEMP,'inactive-help-'+service+'-'+label);
  await rm(out,{recursive:true,force:true});await mkdir(out,{recursive:true});await mkdir(dirname(file),{recursive:true});await writeFile(file,JSON.stringify(config,null,2)+'\n');
  call(compiler,['deploy','--dry-run','--config',file,'--outdir',out,'--metafile',out+'/metafile.json'],{cwd:root});
  const files=(await readdir(out)).filter(name=>name.endsWith('.js'));if(files.length!==1)throw new ProducerError('Single rebuilt module required');
  const meta=JSON.parse(await readFile(out+'/metafile.json','utf8')),baseDirectory=resolve(dirname(file));
  const paths=assertBuildGraph(meta,service,label,{baseDirectory});
  const inputEvidence=[],physicalInputs=[],cwd=root,dependencies=await realpath(dependencyRoot);for(const path of paths){
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
 const rebuildHistoricalModule=async({service,config,currentModule,source,assertRecords})=>{
   await currentModule.verifyInputs();
   producerOperation='historical-source-identities';
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
   const sourceComparison={...assertRecords(records),currentModule:{moduleBytes:currentModule.length,moduleSha256:hash(currentModule)}};
   producerOperation='historical-source-config-metadata';
   for(const path of paths.filter(path=>/(?:^|\/)(?:tsconfig|jsconfig)\.json$/.test(path)))if(/"extends"\s*:/.test(call('git',['show',source+':'+path])))throw new ProducerError('Accepted compiler metadata inheritance requires explicit archive');
   const root=resolve(env.RUNNER_TEMP,'inactive-help-accepted-'+service+'-source');await rm(root,{recursive:true,force:true});await mkdir(root,{recursive:true});
   const archive=call('git',['archive','--format=tar',source,'--',...paths],{encoding:null});
   producerOperation='historical-source-archive';
   const archivePath=resolve(root,'accepted-auth.tar');await writeFile(archivePath,archive);call('tar',['-xf',archivePath,'-C',root]);await rm(archivePath);
   producerOperation='historical-archive-files-verify';
   for(const record of records){const file=resolve(root,record.path);if(!(await lstat(file)).isFile()||await realpath(file)!==file||gitBlob(await readFile(file))!==record.acceptedBlob)throw new ProducerError('Accepted Auth archive file identity differs');}
   producerOperation='historical-dependency-copy';
   sourceComparison.dependencies=await copyLockedDependencies({source:await realpath('node_modules'),destination:resolve(root,'node_modules')});
   producerOperation='historical-bundle-build';
   const module=await build(service,config,'accepted-'+service,{root,sourceRef:source});
   producerOperation='historical-input-hash-compare';
   const currentInputs=new Map(currentModule.inputEvidence.map(input=>[input.path,input]));
   if(module.inputEvidence.length!==currentInputs.size)throw new ProducerError('Accepted Auth build input graph changed');
   for(const input of module.inputEvidence){const before=currentInputs.get(input.path);if(!before)throw new ProducerError('Accepted Auth build input graph changed');
    if(withoutJsonAttributes(input.path)==='tools/governance-production/production-pin.json')continue;
    if(canonical(before)!==canonical(input))throw new ProducerError('Accepted Auth source or dependency input differs');
   }
   await module.verifyInputs();
   return {module,sourceComparison};
 };
 const authProof=async()=>{
  phase='unchanged_auth_source_gate_and_exact_provider_bytes';
  call('node',['scripts/verify-auth-live-proof-source.mjs']);
  const {selectAuthLiveProofPolicy}=await import('./verify-auth-live-proof-source.mjs');
  const acceptedSource=selectAuthLiveProofPolicy().source;
  const config=JSON.parse(await readFile('.cloudflare-workers/auth.jsonc','utf8'));
  return verifyAcceptedAuthBytes({api,content,acceptedSource,rebuildAccepted:async source=>{
   const currentModule=await build('auth',config,'current-auth');
   return rebuildHistoricalModule({service:'auth',config,currentModule,source,assertRecords:assertAcceptedAuthSourceRecords});
  }});
 };
 const baselineModule=async({service,config,currentModule,predecessor})=>{
  if(service==='gateway'){
   assertGatewayReproductionIdentity(predecessor);
   const p=GATEWAY_REPRODUCTION,directory=resolve(env.RUNNER_TEMP,'worker-dependencies'),dependencies=resolve(directory,'node_modules'),compiler=resolve(dependencies,'.bin/wrangler');
   if(await realpath(directory)!==directory||await realpath(dependencies)!==dependencies||!(await realpath(compiler)).startsWith(dependencies+'/'))throw new ProducerError('Gateway reproduction compiler escapes physical install');
   const profileDirectory='tools/inactive-help-gateway-reproduction';
   for(const file of ['package.json','package-lock.json'])if(!Buffer.from(await readFile(resolve(directory,file))).equals(await readFile(resolve(profileDirectory,file))))throw new ProducerError('Gateway reproduction installed lock differs from tracked profile');
   const toolchain=assertGatewayReproductionToolchain({nodeVersion:process.versions.node,wranglerVersion:call(compiler,['--version']).trim(),packageSha256:hash(await readFile(profileDirectory+'/package.json')),lockSha256:hash(await readFile(profileDirectory+'/package-lock.json')),dependencyLabel:relative(resolve('.cloudflare-workers'),dependencies)});
   const records=[];
   for(const path of Object.keys(GATEWAY_REPRODUCTION_SOURCES)){
    const match=call('git',['ls-tree','HEAD','--',path]).trim().match(/^(100644) (blob) ([a-f0-9]{40})\t/);
    if(!match||await realpath(path)!==resolve(path)||!(await lstat(path)).isFile()||gitBlob(await readFile(path))!==match[3])throw new ProducerError('Regular unchanged Gateway reproduction source required');
    records.push({path,mode:match[1],type:match[2],blob:match[3]});
   }
   assertGatewayReproductionSources(records);
   const before=await dependencyTreeIdentity(dependencies);
   const module=await build(service,config,'gateway-byte-reproduction',{compiler,dependencyRoot:dependencies});
   assertGatewayReproductionGraph(module.inputEvidence);assertGatewayReproductionBytes(module);await module.verifyInputs();
   if(canonical(before)!==canonical(await dependencyTreeIdentity(dependencies)))throw new ProducerError('Gateway reproduction dependency tree changed');
   return {module,sourceProof:{...toolchain,sourceRecords:records,configSha256:hash(canonical(config)),compilerInputs:module.inputEvidence,dependencies:before,rawModuleBytes:p.moduleBytes,rawModuleSha256:p.moduleSha256,exactRebuiltBytes:true,originalPublisherRunId:null,originalPublisherJobId:null}};
  }
  if(service!=='governance')throw new ProducerError('Unsupported baseline service');
  assertGovernancePredecessorIdentity(predecessor);
  const p=GOVERNANCE_PREDECESSOR;
  const run=JSON.parse(call('gh',['api',base+'runs/'+p.runId]));
  const job=JSON.parse(call('gh',['api',base+'jobs/'+p.jobId]));
  const acceptance=JSON.parse(call('gh',['api',base+'jobs/'+p.acceptanceJobId]));
  const log=await fetchGithubJobLog({jobId:p.jobId,token:env.GH_TOKEN}),marker='APPROVED_GOVERNANCE_DEPLOYED ';
  const lines=log.split('\n').filter(line=>line.includes(marker+'{'));
  if(lines.length!==1)throw new ProducerError('Unique historical governance uploaded receipt required');
  producerOperation='governance-history-receipt-parse';
  const receipt=JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length));
  producerOperation='governance-history-validation';
  const evidence=checkGovernanceHistoricalProducer({run,job,acceptance,receipt});
  call('git',['fetch','--no-tags','--depth=1','origin',p.source]);
  if(call('git',['rev-parse',p.source+':cloudflare']).trim()!==acceptedCloudflareTree||call('git',['rev-parse',p.source+':package-lock.json']).trim()!==RELEASE_TOOLCHAIN.lockBlob)throw new ProducerError('Historical governance tree or locked dependencies changed');
  const rebuilt=await rebuildHistoricalModule({service,config,currentModule,source:p.source,assertRecords:assertGovernanceSourceRecords});
  return {module:rebuilt.module,sourceProof:{...evidence,sourceComparison:rebuilt.sourceComparison}};
 };
 const prior=mode==='--deploy'?JSON.parse(await readFile(args[1],'utf8')):undefined;
 const verifyPrior=async plan=>{
  const r=JSON.parse(call('gh',['api',base+'runs/'+plan.producer.runId]));
  const j=JSON.parse(call('gh',['api',base+'jobs/'+plan.producer.jobId]));
  if(r.id!==plan.producer.runId||r.head_sha!==source||r.path!==WORKFLOW||r.head_branch!=='main'||!['push','workflow_dispatch'].includes(r.event)||!(r.id===runId&&r.status==='in_progress'||r.status==='completed'&&r.conclusion==='success')||j.id!==plan.producer.jobId||j.run_id!==r.id||j.run_attempt!==plan.producer.runAttempt||j.name!==PLAN_JOB||j.status!=='completed'||j.conclusion!=='success')throw new ProducerError('Prior successful plan CI required');
  const log=await fetchGithubJobLog({jobId:j.id,token:env.GH_TOKEN});
  const marker='INACTIVE_HELP_PLAN ',lines=log.split('\n').filter(line=>line.includes(marker+'{'));
  const receipt=lines.length===1?JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length)):null;
  if(receipt?.format!==1||receipt.source!==plan.source||receipt.planSha256!==hash(canonical(plan))||canonical(receipt.producer)!==canonical(plan.producer)||receipt.preStateDigest!==plan.preStateDigest||receipt.inputsDigest!==plan.inputsDigest||receipt.providerWrites!==0)throw new ProducerError('Prior plan differs from independent CI receipt');
 };
 phase='complete_preflight_and_optional_scoped_publication';
 const result=await produceInactiveHelp({mode:mode.slice(2),source,producer,configs,build,baselineModule,api,content,authProof,sourceProof,prior,expectedPreState:args[3],expectedInputs:args[5],verifyPrior,
  recordAuthProof:async proof=>{const receipt={format:1,component:'accepted-auth-bytes',currentProducerSource:source,producer,worker:'primecare-auth-api',...proof,independentlyReadDeployment:true,deploymentReadiness:false,componentProviderWrites:0};await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/accepted-auth-bytes.json',JSON.stringify(receipt,null,2)+'\n');console.log('INACTIVE_HELP_ACCEPTED_AUTH_BYTES '+JSON.stringify({source,producer,acceptedSource:proof.acceptedSource,worker:'primecare-auth-api',deploymentId:proof.deploymentId,versionId:proof.versionId,moduleSha256:proof.moduleSha256,moduleBytes:proof.moduleBytes,exactBytes:proof.exactBytes,deploymentReadiness:false,componentProviderWrites:0}));},
  recordPredecessor:async identity=>{const receipt={...identity,currentProducerSource:source,producer};await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/'+identity.service+'-predecessor.json',JSON.stringify(receipt,null,2)+'\n');console.log('INACTIVE_HELP_PREDECESSOR_IDENTITY '+JSON.stringify(receipt));},
  recordBaselineProof:async proof=>{const receipt={format:1,component:'target-baseline-bytes',currentProducerSource:source,producer,...proof};await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/'+proof.service+'-baseline-bytes.json',JSON.stringify(receipt,null,2)+'\n');console.log('INACTIVE_HELP_BASELINE_BYTES '+JSON.stringify({source,producer,service:proof.service,worker:proof.worker,deploymentId:proof.deploymentId,versionId:proof.versionId,moduleSha256:proof.module.moduleSha256,moduleBytes:proof.module.moduleBytes,historicalSource:proof.sourceProof?.source??null,historicalParentConclusion:proof.sourceProof?.parentJobConclusion??null,exactProviderBytes:true,deploymentReadiness:false,componentProviderWrites:0}));},
  recordAttempt:async attempt=>{await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/'+attempt.service+'-attempt.json',JSON.stringify(attempt,null,2)+'\n');},
  recordReceipt:async receipt=>{await writeFile('test-results/inactive-help/'+receipt.service+'-receipt.json',JSON.stringify(receipt,null,2)+'\n');console.log('INACTIVE_HELP_WORKER_RECEIPT '+JSON.stringify({source,producer,service:receipt.service,worker:receipt.worker,versionId:receipt.versionId,deploymentId:receipt.after.deploymentId,previousDeploymentId:receipt.before.deploymentId,moduleSha256:receipt.after.module.moduleSha256,receiptSha256:hash(canonical(receipt)),runtimeActivated:false}));},
  freshMain:async s=>verifyMain(s),writeConfig:async(service,config)=>writeFile('.cloudflare-workers/'+service+'.jsonc',JSON.stringify(config,null,2)+'\n'),
  publish:async(service,config)=>{const file='.cloudflare-workers/'+service+'.jsonc';if(await readFile(file,'utf8')!==JSON.stringify(config,null,2)+'\n')throw new ProducerError('Prepared configuration changed');return call('node_modules/.bin/wrangler',['deploy','--config',file,'--keep-vars']);}});
 await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/'+mode.slice(2)+'.json',JSON.stringify(result,null,2)+'\n');
 if(mode==='--plan')console.log('INACTIVE_HELP_PLAN '+JSON.stringify({format:1,source,producer,planSha256:hash(canonical(result)),preStateDigest:result.preStateDigest,inputsDigest:result.inputsDigest,providerWrites:0}));
 else console.log('INACTIVE_HELP_DEPLOYED '+JSON.stringify({format:1,source,producer,receiptSha256:hash(canonical(result)),providerWriteInvocations:result.providerWriteInvocations,receipts:result.receipts.map(r=>({service:r.service,worker:r.worker,versionId:r.versionId,deploymentId:r.after.deploymentId,predecessorDeploymentId:r.before.deploymentId,moduleSha256:r.after.module.moduleSha256})),runtimeActivated:false}));
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(async error=>{
 const failure={format:1,...rejectionContext,phase,reason:error instanceof ProducerError?error.message:'source_build_or_preservation_gate_failed',errorDiagnostics:error?.safeProducerDiagnostics??producerFailureDiagnostics(error),...(error instanceof ProducerError&&error.githubEvidence?{githubEvidence:error.githubEvidence}:{}),...(error instanceof ProducerError&&error.providerRead?{providerRead:error.providerRead}:{}),...(error instanceof ProducerError&&error.moduleComparison?{moduleComparison:error.moduleComparison}:{}),...(error instanceof ProducerError&&error.unsupportedSettings?{unsupportedSettings:error.unsupportedSettings,usageModel:error.usageModel,...(error.annotationProjection?{annotationProjection:error.annotationProjection}:{})}:{}),...(error instanceof ProducerError&&error.serverOperationTransition?{serverOperationTransition:error.serverOperationTransition}:{})};
 if(rejectionContext?.mode==='plan'){
  failure.providerWrites=0;
  try{await mkdir('test-results/inactive-help',{recursive:true});await writeFile('test-results/inactive-help/plan-rejected.json',JSON.stringify(failure,null,2)+'\n');}catch{}
 }
 console.error('INACTIVE_HELP_REJECTED '+JSON.stringify(failure));process.exitCode=1;
});
