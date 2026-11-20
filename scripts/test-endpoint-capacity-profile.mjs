import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readFile} from 'node:fs/promises';
import {capacityProfile,evaluateCapacityRun} from './endpoint-capacity-profile.mjs';
const profile=JSON.parse(await readFile(new URL('../tools/endpoint-capacity/profile.example.json',import.meta.url)));
const now=Date.parse('2026-11-20T14:00:00Z');
function run(){return {version:1,scope:'staging_http_read_mix',profile,startedAt:'2026-11-20T12:00:00Z',endedAt:'2026-11-20T12:10:00Z',stages:profile.stages.map((stage,index)=>({name:'stage_'+index,completed:stage.rate*stage.durationSeconds,failed:0,dropped:0,p95LatencyMs:100,operations:[{name:'auth_me',completed:stage.rate*stage.durationSeconds*.8,failed:0,p95LatencyMs:100},{name:'endpoint_status',completed:stage.rate*stage.durationSeconds*.2,failed:0,p95LatencyMs:100}]}))};}
test('profile restricts load to an explicit nonproduction origin and bounded synthetic reads',()=>{
 assert.equal(capacityProfile(profile),profile);
 for(const patch of [{origin:'https://primecare-api-gateway.itpro-mohammed.workers.dev'},{environment:'production'},{origin:'https://staging.example.com@production.example.com'},{maxVUs:1001},{stages:[{rate:1,durationSeconds:1}]},{token:'private'}])assert.throws(()=>capacityProfile({...profile,...patch}));
 assert.throws(()=>capacityProfile({...profile,operations:[{...profile.operations[0],path:'//production.example.com/secret'}]}));
 assert.throws(()=>capacityProfile({...profile,operations:[{...profile.operations[0],method:'POST'}]}));
});
test('highest contiguous passing rate produces expiring evidence for only the measured read mix',()=>{
 const result=evaluateCapacityRun(run(),now);
 assert.equal(result.benchmark.sustainableRequestsPerSecond,20);
 assert.equal(result.benchmark.measurementScope,'staging_http_read_mix');
 assert.equal(result.benchmark.expiresAt,'2026-11-21T12:10:00.000Z');
 const saturated=run();saturated.stages[2].dropped=1;
 assert.equal(evaluateCapacityRun(saturated,now).benchmark.sustainableRequestsPerSecond,10);
});
test('overall passing averages cannot hide a failing operation or an unrepresentative workload mix',()=>{
 const bad=run();bad.stages[0].operations[1].p95LatencyMs=1000;
 const report=evaluateCapacityRun(bad,now);
 assert.equal(report.benchmark,null);assert.ok(report.stages[0].reasons.includes('operation_target_missed:endpoint_status'));
 const mix=run();mix.stages[0].operations[0].completed=580;mix.stages[0].operations[1].completed=20;
 assert.equal(evaluateCapacityRun(mix,now).benchmark,null);
});
test('truncated, corrupt, expired, future and inconsistent evidence cannot create a benchmark',()=>{
 for(const mutate of [r=>r.stages.pop(),r=>r.stages[0].operations[0].completed++,r=>r.endedAt='2026-11-20T12:01:00Z',r=>r.endedAt='2026-11-21T12:10:00Z',r=>r.endedAt='2026-11-19T12:10:00Z',r=>r.stages[0].p95LatencyMs=NaN,r=>r.stages[0].failed=601]){const value=run();mutate(value);assert.throws(()=>evaluateCapacityRun(value,now));}
});

test('CLI removes stale benchmark after a failed run without replacing the raw input',async()=>{
 const {mkdtemp,writeFile,access}=await import('node:fs/promises');const {tmpdir}=await import('node:os');const {join}=await import('node:path');const {spawnSync}=await import('node:child_process');
 const dir=await mkdtemp(join(tmpdir(),'capacity-evaluator-')),input=join(dir,'run.json'),output=join(dir,'assessment.json'),benchmark=join(dir,'assessment.benchmark.json');
 const valid=run(),end=Date.now()-1000;
 valid.startedAt=new Date(end-600000).toISOString();valid.endedAt=new Date(end).toISOString();
 await writeFile(input,JSON.stringify(valid));
 let result=spawnSync(process.execPath,['scripts/evaluate-endpoint-capacity.mjs',input,output],{encoding:'utf8'});
 assert.equal(result.status,0,result.stderr);await access(benchmark);
 valid.stages[0].dropped=1;await writeFile(input,JSON.stringify(valid));
 result=spawnSync(process.execPath,['scripts/evaluate-endpoint-capacity.mjs',input,output],{encoding:'utf8'});
 assert.equal(result.status,2,result.stderr);await assert.rejects(access(benchmark));
 assert.equal(JSON.parse(await readFile(input,'utf8')).stages[0].dropped,1);
 assert.notEqual(spawnSync(process.execPath,['scripts/evaluate-endpoint-capacity.mjs',input,input]).status,0);
});

test('generated benchmark is accepted by the dashboard without changing its scope',async()=>{
 const {readCapacityEvidence}=await import('../websites/typescript/src/endpoint-capacity.ts');
 const result=evaluateCapacityRun(run(),now);
 assert.equal(readCapacityEvidence(result.benchmark,now).measurementScope,'staging_http_read_mix');
 assert.equal(readCapacityEvidence({...result.benchmark,p95LatencyMs:0},now).p95LatencyMs,0);
 assert.throws(()=>readCapacityEvidence({...result.benchmark,measurementScope:'unmeasured_full_system'},now));
});
