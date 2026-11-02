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
export function checkAuthProvider({policy=accepted,auth}){
 if(auth?.worker!==policy.worker||auth.service!=='auth'||auth.deploymentId!==policy.deploymentId||auth.independentlyReadDeployment!==true||auth.preferenceSyncEnabled!==policy.preferenceRuntimeActivated||auth.versions?.length!==1||auth.versions[0].versionId!==policy.versionId||auth.versions[0].trafficPercent!==100)throw Error('Active auth provider identity differs');
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
 const log=call('gh',['api',base+'jobs/'+accepted.job+'/logs']),marker='AUTH_PREFERENCE_CODE_DEPLOYED ';
 const lines=log.split('\n').filter(line=>line.includes(marker+'{'));if(lines.length!==1)throw Error('Unique uploaded-version receipt required');
 const receipt=JSON.parse(lines[0].slice(lines[0].indexOf(marker)+marker.length));
 const approved=checkAuthLiveProof({run,job,receipt,workerSourceMatches:true});
 const {auditRuntimeArtifacts}=await import('./audit-theme-runtime-artifacts.mjs');
 phase='provider_read';
 const live=await auditRuntimeArtifacts({account:process.env.CLOUDFLARE_ACCOUNT_ID,token:process.env.CLOUDFLARE_API_TOKEN});
 const auth=live.artifacts.find(a=>a.service==='auth');
 console.log('AUTH_LIVE_AUTH_IDENTITY '+JSON.stringify({worker:auth?.worker,service:auth?.service,deploymentId:auth?.deploymentId,versions:auth?.versions?.map(v=>({versionId:v.versionId,trafficPercent:v.trafficPercent})),preferenceSyncEnabled:auth?.preferenceSyncEnabled}));
 phase='provider_identity_match';checkAuthProvider({auth});
 const result={...approved,producer:process.env.GITHUB_SHA,independentActiveDeploymentRead:true,preferenceRuntimeActivated:accepted.preferenceRuntimeActivated};
 await mkdir('test-results/account-mutations',{recursive:true});await writeFile('test-results/account-mutations/auth-release-approved.json',JSON.stringify(result,null,2)+'\n');
 console.log('AUTH_LIVE_PROOF_SOURCE '+JSON.stringify(result));
}
if(import.meta.url===pathToFileURL(process.argv[1]??'').href)main().catch(()=>{console.error('AUTH_LIVE_PROOF_SOURCE_REJECTED '+JSON.stringify({phase}));process.exitCode=1;});
