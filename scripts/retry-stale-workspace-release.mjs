/** Queue fresh verification after a stale-source rejection; never publish or bypass a guard. */
import {readFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';

const repository='shaikhrais/primecare-platform';
const workflow='.github/workflows/psw-workspace.yml';
const prepublication='Verify current main before publication';
const shaPattern=/^[0-9a-f]{40}$/;
export function retryDecision({run,jobs,currentHead,currentRuns}) {
 if(!run||run.repository?.full_name!==repository||run.head_repository?.full_name!==repository||
    run.head_branch!=='main'||run.path!==workflow||!['push','workflow_dispatch'].includes(run.event)||
    run.status!=='completed'||run.conclusion!=='failure'||!Number.isSafeInteger(run.id)||
    !shaPattern.test(run.head_sha??''))return {retry:false,reason:'untrusted_or_ineligible_run'};
 if(!shaPattern.test(currentHead??'')||!Array.isArray(jobs)||!Array.isArray(currentRuns))throw Error('Invalid release metadata');
 if(currentHead===run.head_sha)return {retry:false,reason:'source_is_current'};
 const publish=jobs.filter(j=>j.name==='publish');
 if(publish.length!==1||publish[0].conclusion!=='failure')return {retry:false,reason:'not_a_publication_failure'};
 const steps=publish[0].steps;
 if(!Array.isArray(steps))throw Error('Missing publication steps');
 const failed=steps.filter(s=>s.conclusion==='failure');
 if(failed.length!==1||failed[0].name!==prepublication)return {retry:false,reason:'not_a_prepublication_stale_guard'};
 const index=steps.indexOf(failed[0]);
 if(steps.slice(index+1).some(s=>!s.name.startsWith('Post ')&&s.name!=='Complete job'&&
    !['skipped',null,undefined].includes(s.conclusion)))return {retry:false,reason:'later_steps_executed'};
 if(currentRuns.some(r=>r.head_sha===currentHead&&r.path===workflow))return {retry:false,reason:'current_source_already_attempted'};
 return {retry:true,reason:'verify_new_main',source:currentHead,ref:'main'};
}

export async function queueFreshVerification({event,token,fetcher=fetch}) {
 const run=event.workflow_run;
 // Reject untrusted events before using the token for any API request.
 if(!run||run.repository?.full_name!==repository||run.head_repository?.full_name!==repository||
    run.head_branch!=='main'||run.path!==workflow||!['push','workflow_dispatch'].includes(run.event)||
    run.status!=='completed'||run.conclusion!=='failure'||!Number.isSafeInteger(run.id)||
    !shaPattern.test(run.head_sha??''))return {retry:false,reason:'untrusted_or_ineligible_run'};
 if(typeof token!=='string'||!token)throw Error('Actions token required');
 const api=async(path,options={})=>{
  const response=await fetcher('https://api.github.com/repos/'+repository+path,{
   ...options,redirect:'error',signal:AbortSignal.timeout(30000),
   headers:{authorization:'Bearer '+token,accept:'application/vnd.github+json',
    'X-GitHub-Api-Version':'2022-11-28',...(options.body?{'content-type':'application/json'}:{})}});
  if(!response.ok)throw Error('Release scheduling API rejected request: '+response.status);
  return response.status===204?null:response.json();
 };
 const branch=await api('/git/ref/heads/main'),currentHead=branch.object?.sha;
 const jobs=[];
 for(let page=1;page<=10;page++){
  const result=await api('/actions/runs/'+run.id+'/jobs?per_page=100&page='+page);
  if(!Array.isArray(result.jobs))throw Error('Invalid workflow jobs');jobs.push(...result.jobs);
  if(result.jobs.length<100)break;
  if(page===10)throw Error('Workflow job inventory truncated');
 }
 const result=await api('/actions/workflows/psw-workspace.yml/runs?head_sha='+encodeURIComponent(currentHead)+'&per_page=100');
 if(!Array.isArray(result.workflow_runs)||result.total_count>100)throw Error('Current workflow inventory incomplete');
 const decision=retryDecision({run,jobs,currentHead,currentRuns:result.workflow_runs});
 if(decision.retry){
  // A last read avoids dispatching after a stale decision. The dispatched workflow
  // captures its own SHA, re-runs acceptance and retains both publication guards.
  const fresh=await api('/git/ref/heads/main');
  if(fresh.object?.sha!==currentHead)return {retry:false,reason:'main_changed_during_scheduling'};
  await api('/actions/workflows/psw-workspace.yml/dispatches',{method:'POST',body:JSON.stringify({ref:'main'})});
 }
 return decision;
}

if(import.meta.url===pathToFileURL(process.argv[1]??'').href){
 if(process.env.GITHUB_EVENT_NAME!=='workflow_run'||process.env.GITHUB_REPOSITORY!==repository)throw Error('Trusted workflow-run context required');
 const event=JSON.parse(await readFile(process.env.GITHUB_EVENT_PATH,'utf8'));
 console.log(JSON.stringify(await queueFreshVerification({event,token:process.env.GITHUB_TOKEN})));
}
