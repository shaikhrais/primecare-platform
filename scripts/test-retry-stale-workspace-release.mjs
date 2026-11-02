import {test} from 'node:test';
import assert from 'node:assert/strict';
import {retryDecision,queueFreshVerification} from './retry-stale-workspace-release.mjs';
const old='a'.repeat(40),head='b'.repeat(40),path='.github/workflows/psw-workspace.yml';
const run={id:17,repository:{full_name:'shaikhrais/primecare-platform'},head_repository:{full_name:'shaikhrais/primecare-platform'},head_branch:'main',path,event:'push',status:'completed',conclusion:'failure',head_sha:old};
const jobs=[{name:'acceptance',conclusion:'success',steps:[]},{name:'publish',conclusion:'failure',steps:[{name:'Setup',conclusion:'success'},{name:'Verify current main before publication',conclusion:'failure'},{name:'Publish governance API',conclusion:'skipped'},{name:'Post Run actions/checkout@v4',conclusion:'success'}]}];
const input=()=>({run:structuredClone(run),jobs:structuredClone(jobs),currentHead:head,currentRuns:[]});
test('only a prepublication stale guard queues fresh verification',()=>assert.deepEqual(retryDecision(input()),{retry:true,reason:'verify_new_main',source:head,ref:'main'}));
test('the always-run evidence upload does not suppress fresh verification after a stale rejection',()=>{
 const i=input();i.jobs[1].steps.splice(3,0,{name:'Run actions/upload-artifact@v4',conclusion:'success'});
 assert.equal(retryDecision(i).retry,true);
 for(const name of ['Publish governance API','Upload and publish provider assets','Run actions/upload-artifact@v5']){
  const changed=structuredClone(i);changed.jobs[1].steps.splice(3,0,{name,conclusion:'success'});assert.equal(retryDecision(changed).reason,'later_steps_executed');
 }
});
test('missing, duplicate or failed acceptance cannot schedule a fresh publication workflow',()=>{
 for(const mutate of [i=>i.jobs.shift(),i=>i.jobs.push(structuredClone(i.jobs[0])),i=>i.jobs[0].conclusion='failure',i=>i.jobs[0].conclusion='skipped']){const i=input();mutate(i);assert.equal(retryDecision(i).reason,'acceptance_not_successful');}
});
test('current source and already queued or successful current runs do not loop',()=>{
 const i=input();i.currentHead=old;assert.equal(retryDecision(i).retry,false);
 for(const r of [{status:'queued'},{status:'in_progress'},{status:'completed',conclusion:'success'},{status:'completed',conclusion:'failure'},{status:'completed',conclusion:'cancelled'}]){const i=input();i.currentRuns=[{...r,path,head_sha:head}];assert.equal(retryDecision(i).retry,false);}
});
test('contract, provider or acceptance failures cannot trigger automatic release retry',()=>{
 for(const name of ['Publish governance API','Verify current main before Pages publication','Run tests']){const i=input();i.jobs[1].steps[1].name=name;assert.equal(retryDecision(i).retry,false);}
 const i=input();i.jobs[1].steps[2].conclusion='success';assert.equal(retryDecision(i).retry,false);
});
test('fork, PR, other workflow and wrong branch events are rejected',()=>{
 for(const patch of [{head_repository:{full_name:'other/fork'}},{repository:{full_name:'other/repo'}},{event:'pull_request'},{head_branch:'feature'},{path:'other.yml'},{id:'17'},{head_sha:'invalid'}]){const i=input();Object.assign(i.run,patch);assert.equal(retryDecision(i).retry,false);}
});
test('untrusted events make zero API calls',async()=>{
 let calls=0;const result=await queueFreshVerification({event:{workflow_run:{...run,event:'pull_request'}},token:'fixture',fetcher:()=>{calls++;throw Error();}});assert.equal(result.retry,false);assert.equal(calls,0);
});
test('dispatch uses fixed workflow/main and never publishes or replays failed writes',async()=>{
 const requests=[];const fetcher=async(url,options)=>{requests.push([url,options]);let data;
  if(url.includes('/git/ref/'))data={object:{sha:head}};else if(url.includes('/jobs?'))data={jobs};else if(url.includes('/runs?'))data={total_count:0,workflow_runs:[]};else {assert.ok(url.endsWith('/actions/workflows/psw-workspace.yml/dispatches'));assert.deepEqual(JSON.parse(options.body),{ref:'main'});return new Response(null,{status:204});}
  return Response.json(data);
 };assert.equal((await queueFreshVerification({event:{workflow_run:run},token:'fixture',fetcher})).retry,true);
 assert.equal(requests.filter(([,o])=>o.method==='POST').length,1);assert.ok(requests.every(([url])=>url.startsWith('https://api.github.com/repos/shaikhrais/primecare-platform/')));
});
test('changed main or incomplete API reads never dispatch',async()=>{
 let posts=0,refs=0;const fetcher=async(url,options)=>{if(options.method==='POST')posts++;return Response.json(url.includes('/git/ref/')?{object:{sha:++refs===1?head:'c'.repeat(40)}}:url.includes('/jobs?')?{jobs}:{total_count:0,workflow_runs:[]});};
 assert.equal((await queueFreshVerification({event:{workflow_run:run},token:'fixture',fetcher})).reason,'main_changed_during_scheduling');assert.equal(posts,0);
 await assert.rejects(queueFreshVerification({event:{workflow_run:run},token:'fixture',fetcher:async()=>new Response('',{status:403})}));
});
