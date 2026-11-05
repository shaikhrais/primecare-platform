/** Read-only auth release acceptance. No deployment, key, flag, grant or account writes. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {pathToFileURL} from 'node:url';
export const accepted=JSON.parse(await readFile(new URL('../tools/auth-verification/accepted-auth-live-proof-release.json',import.meta.url),'utf8'));
export function checkAuthLiveProof({policy=accepted,run,job,receipt,workerSourceMatches}){
 if(!/^[a-f0-9]{40}$/.test(policy.source)||!Number.isSafeInteger(policy.run)||!Number.isSafeInteger(policy.job)||policy.worker!=='primecare-auth-api'||policy.workflow!=='.github/workflows/auth-preference-candidate.yml'||typeof policy.preferenceRuntimeActivated!=='boolean'||workerSourceMatches!==true)throw Error('Unapproved auth source');
 if(run?.id!==policy.run||run.head_sha!==policy.source||run.head_branch!=='main'||run.path!==policy.workflow||run.status!=='completed'||run.conclusion!=='success')throw Error('Auth deployment run not accepted');
 if(job?.id!==policy.job||job.run_id!==policy.run||job.name!=='deploy-code'||job.status!=='completed'||job.conclusion!=='success')throw Error('Auth deployment job not accepted');
 if(receipt?.source!==policy.source||receipt.worker!==policy.worker||receipt.service!=='auth'||receipt.versionId!==policy.versionId||receipt.deploymentId!==policy.deploymentId||receipt.trafficPercent!==100||receipt.independentlyReadDeployment!==true||receipt.sourceCheckoutVerified!==true||receipt.existingBindingsPreserved!==true||receipt.existingCronSchedulesPreserved!==true||receipt.keySelectionChanged!==false||receipt.preferenceRuntimeActivated!==policy.preferenceRuntimeActivated||receipt.healthStatus!==200||receipt.disabledPreferenceProbe!==503)throw Error('Auth deployment receipt not accepted');
 return {run:policy.run,releaseSource:policy.source,workerSourceMatch:true,worker:policy.worker,versionId:policy.versionId,deploymentId:policy.deploymentId,ciDeploymentVerified:true};
}
/** Validate the independent byte comparison without replacing the historical release receipt. */
export function checkAuthReconciliation({policy=accepted,run,job,receipt}){
 const r=policy.reconciledActive;
 if(!r||!/^[a-f0-9]{40}$/.test(r.source??'')||!/^[a-f0-9]{40}$/.test(r.genericSource??'')||!/^[a-f0-9]{64}$/.test(r.bundleSha256??'')||!/^[a-f0-9-]{36}$/i.test(r.deploymentId??'')||!/^[a-f0-9-]{36}$/i.test(r.versionId??'')||policy.preferenceRuntimeActivated!==false||!Number.isSafeInteger(r.run)||!Number.isSafeInteger(r.job)||r.workflow!=='.github/workflows/compare-generic-auth-release.yml'||!['absent','0'].includes(r.preferenceFlag))throw Error('Auth reconciliation policy invalid');
 if(run?.id!==r.run||run.head_sha!==r.source||run.head_branch!=='main'||run.path!==r.workflow||run.status!=='completed'||run.conclusion!=='success'||job?.id!==r.job||job.run_id!==r.run||job.name!=='compare'||job.status!=='completed'||job.conclusion!=='success')throw Error('Auth comparison run not accepted');
 if(receipt?.acceptedSource!==policy.source||receipt.genericSource!==r.genericSource||receipt.activeDeployment!==r.deploymentId||receipt.activeVersion!==r.versionId||receipt.moduleCount!==1||receipt.matchingModules!==1||receipt.bundleSha256!==r.bundleSha256||receipt.preferenceFlag!==r.preferenceFlag||receipt.preferenceRuntimeActivated!==false||receipt.providerWrites!==0||receipt.humanApproved!==false)throw Error('Auth comparison receipt not accepted');
 return {deploymentId:r.deploymentId,versionId:r.versionId,run:r.run,job:r.job,independentModuleMatch:true};
}
export function checkAuthProvider({policy=accepted,auth,reconciliation=null}){
 const target=reconciliation??policy;
 if(reconciliation&&(!policy.reconciledActive||reconciliation.deploymentId!==policy.reconciledActive.deploymentId||reconciliation.versionId!==policy.reconciledActive.versionId||reconciliation.run!==policy.reconciledActive.run||reconciliation.job!==policy.reconciledActive.job||reconciliation.independentModuleMatch!==true))throw Error('Auth reconciliation not accepted');
 if(auth?.worker!==policy.worker||auth.service!=='auth'||auth.deploymentId!==target.deploymentId||auth.independentlyReadDeployment!==true||auth.preferenceSyncEnabled!==policy.preferenceRuntimeActivated||auth.versions?.length!==1||auth.versions[0].versionId!==target.versionId||auth.versions[0].trafficPercent!==100)throw Error('Active auth provider identity differs');
}
let phase='configuration';
async function main(){
 if(process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||!/^[a-f0-9]{40}$/.test(process.env.GITHUB_SHA??'')||!/^[a-f0-9]{40}$/.test(accepted.source)||!Number.isSafeInteger(accepted.run)||!Number.isSafeInteger(accepted.job))throw Error('Pinned repository and release required');
 const call=(program,args)=>execFileSync(program,args,{encoding:'utf8',maxBuffer:16*1024*1024,stdio:['ignore','pipe','pipe']});
 phase='checkout_and_worker_source';
 if(call('git',['rev-parse','HEAD']).trim()!==process.env.GITHUB_SHA)throw Error('Proof checkout does not match its producer');
 call('git',['fetch','--no-tags','--depth=1','origin',accepted.source]);
 // Compare the exact Worker tree, including service composition and gateway, with the uploaded source.
 call('git',['diff','--exit-code',accepted.source,'HEAD','--','cloudflare/workers']);
 const base='repos/'+process.env.GITHUB_REPOSITORY+'/actions/';
 phase='successful_ci_run';const run=JSON.parse(call('gh',['api',base+'runs/'+accepted.run]));
 phase='successful_ci_job';const job=JSON.parse(call('gh',['api',base+'jobs/'+accepted.job]));
 phase='uploaded_version_receipt';
 const log=call('gh',['run','view',String(accepted.run),'--repo',process.env.GITHUB_REPOSITORY,'--job',String(accepted.job),'--log']),marker='AUTH_PREFERENCE_CODE_DEPLOYED ';
 const lines=log.split('\n').filter(line=>line.includes(marker+'{'));console.log('AUTH_LIVE_CI_RECEIPT_COUNT '+JSON.stringify({count:lines.length}));if(lines.length!==1)throw Error('Unique uploaded-version receipt required');
 const receipt=JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length));
 phase='ci_receipt_validation';
 const approved=checkAuthLiveProof({run,job,receipt,workerSourceMatches:true});
 let reconciliation=null;
 if(accepted.reconciledActive){
  const r=accepted.reconciledActive;phase='comparison_ci_run';
  const compareRun=JSON.parse(call('gh',['api',base+'runs/'+r.run]));
  const compareJob=JSON.parse(call('gh',['api',base+'jobs/'+r.job]));
  const compareLog=call('gh',['run','view',String(r.run),'--repo',process.env.GITHUB_REPOSITORY,'--job',String(r.job),'--log']);
  const marker='AUTH_GENERIC_CODE_COMPARISON ',lines=compareLog.split('\n').filter(line=>line.includes(marker+'{'));
  if(lines.length!==1)throw Error('Unique auth comparison receipt required');
  const compareReceipt=JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length));
  reconciliation=checkAuthReconciliation({run:compareRun,job:compareJob,receipt:compareReceipt});
 }
 const {auditRuntimeArtifacts}=await import('./audit-theme-runtime-artifacts.mjs');
 phase='provider_read';
 const live=await auditRuntimeArtifacts({account:process.env.CLOUDFLARE_ACCOUNT_ID,token:process.env.CLOUDFLARE_API_TOKEN});
 const auth=live.artifacts.find(a=>a.service==='auth');
 console.log('AUTH_LIVE_AUTH_IDENTITY '+JSON.stringify({worker:auth?.worker,service:auth?.service,deploymentId:auth?.deploymentId,versions:auth?.versions?.map(v=>({versionId:v.versionId,trafficPercent:v.trafficPercent})),preferenceSyncEnabled:auth?.preferenceSyncEnabled}));
 phase='provider_identity_match';checkAuthProvider({auth,reconciliation});
 const result={...approved,...(reconciliation?{versionId:reconciliation.versionId,deploymentId:reconciliation.deploymentId,reconciliation}:{}),producer:process.env.GITHUB_SHA,independentActiveDeploymentRead:true,preferenceRuntimeActivated:accepted.preferenceRuntimeActivated};
 await mkdir('test-results/account-mutations',{recursive:true});await writeFile('test-results/account-mutations/auth-release-approved.json',JSON.stringify(result,null,2)+'\n');
 console.log('AUTH_LIVE_PROOF_SOURCE '+JSON.stringify(result));
}
if(import.meta.url===pathToFileURL(process.argv[1]??'').href)main().catch(e=>{const reason=['Unapproved auth source','Auth deployment run not accepted','Auth deployment job not accepted','Auth deployment receipt not accepted','Active auth provider identity differs','Auth reconciliation policy invalid','Auth comparison run not accepted','Auth comparison receipt not accepted','Auth reconciliation not accepted'].includes(e?.message)?e.message:'source_or_provider_validation';const status=String(e?.stderr??'').match(/HTTP (\d{3})/);console.error('AUTH_LIVE_PROOF_SOURCE_REJECTED '+JSON.stringify({phase,reason,httpStatus:status?Number(status[1]):null}));process.exitCode=1;});
