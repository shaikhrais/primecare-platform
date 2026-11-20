/** Cancel only obsolete push-to-main PSW workflow runs; never current/manual/other-branch runs. */
import {pathToFileURL} from 'node:url';
export function obsoletePswRuns(runs,currentSha){
 if(!Array.isArray(runs)||!/^[a-f0-9]{40}$/.test(currentSha??''))throw Error('Invalid workflow state');
 return runs.filter(r=>r&&Number.isSafeInteger(r.id)&&r.id>0&&r.head_branch==='main'&&r.event==='push'&&r.head_sha!==currentSha&&/^[a-f0-9]{40}$/.test(r.head_sha??'')&&r.path==='.github/workflows/psw-workspace.yml'&&['queued','in_progress','pending','waiting','requested'].includes(r.status)).slice(0,8);
}
export async function cancelStalePsw(env,send=fetch){
 if(env.GITHUB_REPOSITORY!=='shaikhrais/primecare-platform'||env.GITHUB_REF!=='refs/heads/main'||!/^[a-f0-9]{40}$/.test(env.GITHUB_SHA??'')||!env.GH_ACTION_TOKEN)throw Error('Protected current-main context required');
 const base='https://api.github.com/repos/'+env.GITHUB_REPOSITORY,headers={authorization:'Bearer '+env.GH_ACTION_TOKEN,accept:'application/vnd.github+json','x-github-api-version':'2022-11-28'};
 const request=(path,method='GET')=>send(base+path,{method,headers,redirect:'error',signal:AbortSignal.timeout(15000)});
 const current=async()=>{const r=await request('/git/ref/heads/main');if(!r.ok||(await r.json()).object?.sha!==env.GITHUB_SHA)throw Error('Main advanced; stale-run cancellation stopped');};
 await current();const r=await request('/actions/workflows/psw-workspace.yml/runs?branch=main&per_page=100');if(!r.ok)throw Error('PSW workflow list unavailable');
 const targets=obsoletePswRuns((await r.json()).workflow_runs,env.GITHUB_SHA),cancelled=[];
 for(const run of targets){await current();const result=await request('/actions/runs/'+run.id+'/cancel','POST');if(result.status===202)cancelled.push(run.id);else if(result.status!==409)throw Error('Stale publication cancellation unavailable (HTTP '+result.status+')');}
 return {source:env.GITHUB_SHA,cancelledRunIds:cancelled,currentRunsPreserved:true,otherWorkflowsTouched:0};
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){try{console.log('STALE_PSW_PUBLICATIONS '+JSON.stringify(await cancelStalePsw(process.env)));}catch{console.error('Stale PSW publication cleanup stopped; no permission or source guard bypassed');process.exitCode=1;}}
