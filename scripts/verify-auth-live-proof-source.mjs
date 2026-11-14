/** Read-only auth release acceptance. No deployment, key, flag, grant or account writes. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {pathToFileURL} from 'node:url';
export const accepted=JSON.parse(await readFile(new URL('../tools/auth-verification/accepted-auth-live-proof-release.json',import.meta.url),'utf8'));
export const acceptedActivation=JSON.parse(await readFile(new URL('../docs/appearance/pc10-preferences-activation.json',import.meta.url),'utf8'));
/** Select the recorded code release, preserving historical source/reconciliation identities in the policy file.
 * Selection grants nothing: main still verifies exact Worker bytes, successful CI, uploaded receipt and live provider.
 */
export function selectAuthLiveProofPolicy(policy=accepted){
 if(!Object.hasOwn(policy,'currentCodeRelease'))return policy;
 const c=policy.currentCodeRelease,e=c?.evidence;
 if(c?.format!==1||!/^[a-f0-9]{40}$/.test(c.source??'')||c.worker!==policy.worker||c.service!=='auth'||!/^[a-f0-9-]{36}$/i.test(c.deploymentId??'')||!/^[a-f0-9-]{36}$/i.test(c.versionId??'')||c.trafficPercent!==100||c.independentlyReadDeployment!==true||c.sourceCheckoutVerified!==true||c.existingBindingsPreserved!==true||c.existingCronSchedulesPreserved!==true||c.keySelectionChanged!==false||c.sourceFingerprintUpdated!==true||c.preferenceRuntimeActivated!==false||policy.preferenceRuntimeActivated!==false||c.productionGrantsChanged!==0||c.productionSchemaChanged!==false||c.registeredGovernanceArtifactId!==null||c.grantAssociationApproved!==false||c.healthStatus!==200||c.disabledPreferenceProbe!==503||!Number.isSafeInteger(e?.runId)||e.runId<=0||!Number.isSafeInteger(e?.jobId)||e.jobId<=0||e.workflow!=='.github/workflows/auth-preference-candidate.yml'||e.conclusion!=='success'||e.event!=='workflow_dispatch'||e.headBranch!=='main')throw Error('Current auth code release policy invalid');
 return {...policy,source:c.source,run:e.runId,job:e.jobId,workflow:e.workflow,deploymentId:c.deploymentId,versionId:c.versionId,reconciledActive:undefined};
}
export function checkAuthLiveProof({policy=accepted,run,job,receipt,workerSourceMatches}){
 if(!/^[a-f0-9]{40}$/.test(policy.source)||!Number.isSafeInteger(policy.run)||!Number.isSafeInteger(policy.job)||policy.worker!=='primecare-auth-api'||policy.workflow!=='.github/workflows/auth-preference-candidate.yml'||typeof policy.preferenceRuntimeActivated!=='boolean'||workerSourceMatches!==true)throw Error('Unapproved auth source');
 if(policy.currentCodeRelease?.source===policy.source&&(run?.event!=='workflow_dispatch'||receipt?.format!==1||receipt.sourceFingerprintUpdated!==true||receipt.productionGrantsChanged!==0||receipt.productionSchemaChanged!==false||receipt.registeredGovernanceArtifactId!==null||receipt.grantAssociationApproved!==false))throw Error('Auth deployment receipt not accepted');
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
/** Verify the already approved activation independently of the preserved disabled-code receipt. */
export function checkAuthPreferenceActivation({policy,activation=acceptedActivation,run,job,receipt,ownedProof}){
 const a=activation,e=a?.evidence;
 const flags=['realBrowserCredentialLogin','deployedPickerSave','independentSql','reload','idempotentReceiptReplay','crossActorAndTenantDenial','ungrantedRoleDenial','staleRevisionDenial','sessionTeardown','exactSyntheticCleanup'];
 if(a?.format!==1||a.worker!==policy.worker||a.apiId!==777||a.codeSource!==policy.source||!/^[a-f0-9]{40}$/.test(a.activationSource??'')||a.runtimeActivated!==true||a.codePreserved!==true||a.bindingsPreserved!==true||a.schedulesPreserved!==true||a.grantsChanged!==0||a.metadataStatus!=='implemented-unverified'||a.humanReviewApproved!==false||a.deviceTested!==false||!/^[a-f0-9]{64}$/.test(a.codeEtag??'')||a.ownedProof?.passed!==true||a.ownedProof.checks!==63||a.ownedProof.kind!=='shortcuts'||a.ownedProof.resource!=='navigation'||flags.some(k=>a.ownedProof[k]!==true)||JSON.stringify(a.ownedProof.locales)!==JSON.stringify([{locale:'en',width:320},{locale:'fr',width:768},{locale:'es',width:1440}])||e?.workflow!=='.github/workflows/pc10-preference-activation.yml'||e.conclusion!=='success'||!Number.isSafeInteger(e.runId)||e.runId<=0||!Number.isSafeInteger(e.jobId)||e.jobId<=0)throw Error('Auth preference activation policy invalid');
 if(run?.id!==e.runId||run.head_sha!==a.activationSource||run.head_branch!=='main'||run.path!==e.workflow||run.event!=='push'||run.status!=='completed'||run.conclusion!=='success'||job?.id!==e.jobId||job.run_id!==e.runId||job.name!=='activate-and-prove'||job.status!=='completed'||job.conclusion!=='success')throw Error('Auth preference activation CI not accepted');
 if(receipt?.source!==a.activationSource||receipt.before?.version!==policy.versionId||receipt.active?.id!==a.active?.id||receipt.active?.version!==a.active?.version||receipt.newVersion!==a.active?.version||receipt.codeEtag!==a.codeEtag||!/^[a-f0-9-]{36}$/i.test(a.active?.id??'')||!/^[a-f0-9-]{36}$/i.test(a.active?.version??'')||!/^[a-f0-9]{64}$/.test(receipt.bindingFingerprint??'')||receipt.runtimeActivated!==true||receipt.codePreserved!==true||receipt.bindingsPreserved!==true||receipt.schedulesPreserved!==true||receipt.grantsChanged!==0||receipt.reusedReviewedUpload!==true||receipt.patchAttempted!==false||receipt.metadata?.committed!==true||receipt.metadata.changed!==true||receipt.metadata.previousStatus!=='registered-unimplemented'||receipt.metadata.targetStatus!==a.metadataStatus||receipt.metadata.grantsChanged!==0||receipt.metadata.schemaChanged!==false)throw Error('Auth preference activation receipt not accepted');
 if(ownedProof?.scope!=='owned-production-PC10-shortcuts'||ownedProof.synthetic!==true||ownedProof.passed!==true||ownedProof.humanReviewApproved!==false||ownedProof.deviceTested!==false||!Array.isArray(ownedProof.checks)||ownedProof.checks.length!==a.ownedProof.checks||ownedProof.checks.some(c=>typeof c!=='string'||!c.trim())||ownedProof.cleanup!=='Exact fixture users/tenants/preferences/sessions/audits/account counters removed; shared source counters preserved')throw Error('Auth preference activation owned proof not accepted');
 return {source:a.activationSource,codeSource:a.codeSource,deploymentId:a.active.id,versionId:a.active.version,run:e.runId,job:e.jobId,preferenceRuntimeActivated:true,verified:true};
}
export function checkAuthProvider({policy=accepted,auth,reconciliation=null,activation=null}){
 if(activation&&(reconciliation||activation.verified!==true||activation.source!==acceptedActivation.activationSource||activation.codeSource!==policy.source||activation.run!==acceptedActivation.evidence.runId||activation.job!==acceptedActivation.evidence.jobId||activation.deploymentId!==acceptedActivation.active.id||activation.versionId!==acceptedActivation.active.version||activation.preferenceRuntimeActivated!==true))throw Error('Auth preference activation not accepted');
 const target=activation??reconciliation??policy;
 if(reconciliation&&(!policy.reconciledActive||reconciliation.deploymentId!==policy.reconciledActive.deploymentId||reconciliation.versionId!==policy.reconciledActive.versionId||reconciliation.run!==policy.reconciledActive.run||reconciliation.job!==policy.reconciledActive.job||reconciliation.independentModuleMatch!==true))throw Error('Auth reconciliation not accepted');
 if(auth?.worker!==policy.worker||auth.service!=='auth'||auth.deploymentId!==target.deploymentId||auth.independentlyReadDeployment!==true||auth.preferenceSyncEnabled!==(activation?true:policy.preferenceRuntimeActivated)||auth.versions?.length!==1||auth.versions[0].versionId!==target.versionId||auth.versions[0].trafficPercent!==100)throw Error('Active auth provider identity differs');
}
let phase='configuration';
async function main(){
 const policy=selectAuthLiveProofPolicy();
 if(process.env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||!/^[a-f0-9]{40}$/.test(process.env.GITHUB_SHA??'')||!/^[a-f0-9]{40}$/.test(policy.source)||!Number.isSafeInteger(policy.run)||!Number.isSafeInteger(policy.job))throw Error('Pinned repository and release required');
 const call=(program,args)=>execFileSync(program,args,{encoding:'utf8',maxBuffer:16*1024*1024,stdio:['ignore','pipe','pipe']});
 phase='checkout_and_worker_source';
 if(call('git',['rev-parse','HEAD']).trim()!==process.env.GITHUB_SHA)throw Error('Proof checkout does not match its producer');
 call('git',['fetch','--no-tags','--depth=1','origin',policy.source]);
 // Compare the exact Worker tree, including service composition and gateway, with the uploaded source.
 call('git',['diff','--exit-code',policy.source,'HEAD','--','cloudflare/workers']);
 const base='repos/'+process.env.GITHUB_REPOSITORY+'/actions/';
 phase='successful_ci_run';const run=JSON.parse(call('gh',['api',base+'runs/'+policy.run]));
 phase='successful_ci_job';const job=JSON.parse(call('gh',['api',base+'jobs/'+policy.job]));
 phase='uploaded_version_receipt';
 const log=call('gh',['run','view',String(policy.run),'--repo',process.env.GITHUB_REPOSITORY,'--job',String(policy.job),'--log']),marker='AUTH_PREFERENCE_CODE_DEPLOYED ';
 const lines=log.split('\n').filter(line=>line.includes(marker+'{'));console.log('AUTH_LIVE_CI_RECEIPT_COUNT '+JSON.stringify({count:lines.length}));if(lines.length!==1)throw Error('Unique uploaded-version receipt required');
 const receipt=JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length));
 phase='ci_receipt_validation';
 const approved=checkAuthLiveProof({policy,run,job,receipt,workerSourceMatches:true});
 let reconciliation=null;
 if(policy.reconciledActive){
  const r=policy.reconciledActive;phase='comparison_ci_run';
  const compareRun=JSON.parse(call('gh',['api',base+'runs/'+r.run]));
  const compareJob=JSON.parse(call('gh',['api',base+'jobs/'+r.job]));
  const compareLog=call('gh',['run','view',String(r.run),'--repo',process.env.GITHUB_REPOSITORY,'--job',String(r.job),'--log']);
  const marker='AUTH_GENERIC_CODE_COMPARISON ',lines=compareLog.split('\n').filter(line=>line.includes(marker+'{'));
  if(lines.length!==1)throw Error('Unique auth comparison receipt required');
  const compareReceipt=JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length));
  reconciliation=checkAuthReconciliation({policy,run:compareRun,job:compareJob,receipt:compareReceipt});
 }
 let activation=null;
 if(acceptedActivation){
  const e=acceptedActivation.evidence;phase='activation_ci_run';
  const activationRun=JSON.parse(call('gh',['api',base+'runs/'+e.runId]));
  const activationJob=JSON.parse(call('gh',['api',base+'jobs/'+e.jobId]));
  phase='activation_receipts';
  const activationLog=call('gh',['run','view',String(e.runId),'--repo',process.env.GITHUB_REPOSITORY,'--job',String(e.jobId),'--log']);
  const unique=marker=>{const lines=activationLog.split('\n').filter(line=>line.includes(marker+'{'));if(lines.length!==1)throw Error('Auth preference activation receipt not accepted');return JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length));};
  activation=checkAuthPreferenceActivation({policy,run:activationRun,job:activationJob,receipt:unique('PC10_PREFERENCES_ACTIVATED '),ownedProof:unique('PC10_OWNED_PRODUCTION ')});
 }
 const {auditRuntimeArtifacts}=await import('./audit-theme-runtime-artifacts.mjs');
 phase='provider_read';
 const live=await auditRuntimeArtifacts({account:process.env.CLOUDFLARE_ACCOUNT_ID,token:process.env.CLOUDFLARE_API_TOKEN});
 const auth=live.artifacts.find(a=>a.service==='auth');
 console.log('AUTH_LIVE_AUTH_IDENTITY '+JSON.stringify({worker:auth?.worker,service:auth?.service,deploymentId:auth?.deploymentId,versions:auth?.versions?.map(v=>({versionId:v.versionId,trafficPercent:v.trafficPercent})),preferenceSyncEnabled:auth?.preferenceSyncEnabled}));
 phase='provider_identity_match';checkAuthProvider({policy,auth,reconciliation,activation});
 const result={...approved,...(reconciliation?{versionId:reconciliation.versionId,deploymentId:reconciliation.deploymentId,reconciliation}:{}),...(activation?{versionId:activation.versionId,deploymentId:activation.deploymentId,activation}:{}),producer:process.env.GITHUB_SHA,independentActiveDeploymentRead:true,preferenceRuntimeActivated:activation?true:policy.preferenceRuntimeActivated};
 await mkdir('test-results/account-mutations',{recursive:true});await writeFile('test-results/account-mutations/auth-release-approved.json',JSON.stringify(result,null,2)+'\n');
 console.log('AUTH_LIVE_PROOF_SOURCE '+JSON.stringify(result));
}
if(import.meta.url===pathToFileURL(process.argv[1]??'').href)main().catch(e=>{const reason=['Current auth code release policy invalid','Unapproved auth source','Auth deployment run not accepted','Auth deployment job not accepted','Auth deployment receipt not accepted','Active auth provider identity differs','Auth reconciliation policy invalid','Auth comparison run not accepted','Auth comparison receipt not accepted','Auth reconciliation not accepted','Auth preference activation policy invalid','Auth preference activation CI not accepted','Auth preference activation receipt not accepted','Auth preference activation owned proof not accepted','Auth preference activation not accepted'].includes(e?.message)?e.message:'source_or_provider_validation';const status=String(e?.stderr??'').match(/HTTP (\d{3})/);console.error('AUTH_LIVE_PROOF_SOURCE_REJECTED '+JSON.stringify({phase,reason,httpStatus:status?Number(status[1]):null}));process.exitCode=1;});
