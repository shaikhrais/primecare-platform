import http from 'k6/http';
import execution from 'k6/execution';
import {Counter,Trend} from 'k6/metrics';
import {capacityProfile} from '../../scripts/endpoint-capacity-profile.mjs';

const profile=capacityProfile(JSON.parse(open(__ENV.CAPACITY_PROFILE||'./profile.example.json')));
if(__ENV.CAPACITY_TEST_ORIGIN!==profile.origin)throw Error('CAPACITY_TEST_ORIGIN must match the reviewed staging origin');
if(!__ENV.CAPACITY_TEST_TOKEN)throw Error('A staging-only session is required');
const completed=new Counter('capacity_completed'),failed=new Counter('capacity_failed'),latency=new Trend('capacity_latency',true);
const thresholds={},scenarios={warmup:{executor:'constant-arrival-rate',rate:profile.stages[0].rate,timeUnit:'1s',duration:'60s',preAllocatedVUs:profile.preAllocatedVUs,maxVUs:profile.maxVUs,gracefulStop:'30s',tags:{capacity_stage:'warmup'}}};
let start=90;
profile.stages.forEach((stage,index)=>{
 const name='stage_'+index;
 scenarios[name]={executor:'constant-arrival-rate',rate:stage.rate,timeUnit:'1s',duration:stage.durationSeconds+'s',startTime:start+'s',preAllocatedVUs:profile.preAllocatedVUs,maxVUs:profile.maxVUs,gracefulStop:'30s',tags:{capacity_stage:name}};
 start+=stage.durationSeconds+30;
 const tag='{capacity_stage:'+name+'}';
 thresholds['capacity_completed'+tag]=['count>=100'];thresholds['capacity_failed'+tag]=['count>=0'];
 thresholds['capacity_latency'+tag]=['p(95)<='+profile.targetP95LatencyMs];thresholds['dropped_iterations'+tag]=['count==0'];
 for(const op of profile.operations){const pair='{capacity_stage:'+name+',operation:'+op.name+'}';thresholds['capacity_completed'+pair]=['count>=20'];thresholds['capacity_failed'+pair]=['count>=0'];thresholds['capacity_latency'+pair]=['p(95)<='+profile.targetP95LatencyMs];}
});
export const options={scenarios,thresholds,discardResponseBodies:true,maxRedirects:0,summaryTrendStats:['p(95)'],systemTags:['method','name','scenario','status','expected_response','error_code']};
export function setup(){
 const response=http.get(profile.origin+'/health',{headers:{'X-PrimeCare-Load-Test':'staging-read-mix'},timeout:'10s',responseType:'text',tags:{name:'gateway_health'}});
 if(response.status!==200)throw Error('Staging gateway health check failed');
 return {startedAt:new Date().toISOString()};
}
export default function(){
 const total=profile.operations.reduce((n,op)=>n+op.weight,0);let choice=((execution.scenario.iterationInTest*2654435761)%4294967296)/4294967296*total;
 const op=profile.operations.find(item=>{choice-=item.weight;return choice<0;})||profile.operations[profile.operations.length-1];
 const tags={capacity_stage:execution.scenario.name,operation:op.name,name:'capacity_'+op.name};
 const response=http.get(profile.origin+op.path,{headers:{authorization:'Bearer '+__ENV.CAPACITY_TEST_TOKEN,'X-PrimeCare-Load-Test':'staging-read-mix'},tags,timeout:'10s',responseType:op.jsonObjectKeys.length?'text':'none'});
 let valid=response.status===op.expectedStatus;
 if(valid&&op.jsonObjectKeys.length){try{const body=response.json();valid=body!==null&&typeof body==='object'&&!Array.isArray(body)&&op.jsonObjectKeys.every(key=>Object.prototype.hasOwnProperty.call(body,key));}catch{valid=false;}}
 completed.add(1,tags);failed.add(valid?0:1,tags);latency.add(response.timings.duration,tags);
}
export function handleSummary(data){
 const value=(name,stat)=>{const n=data.metrics[name]?.values?.[stat];if(typeof n!=='number'||!Number.isFinite(n))throw Error('Missing stage measurement: '+name);return n;};
 const stages=profile.stages.map((stage,index)=>{
  const name='stage_'+index,tag='{capacity_stage:'+name+'}';
  return {name,completed:value('capacity_completed'+tag,'count'),failed:value('capacity_failed'+tag,'count'),p95LatencyMs:value('capacity_latency'+tag,'p(95)'),
   dropped:data.metrics['dropped_iterations'+tag]?.values?.count??0,
   operations:profile.operations.map(op=>{const pair='{capacity_stage:'+name+',operation:'+op.name+'}';return {name:op.name,completed:value('capacity_completed'+pair,'count'),failed:value('capacity_failed'+pair,'count'),p95LatencyMs:value('capacity_latency'+pair,'p(95)')};})};
 });
 const endedAt=new Date().toISOString();
 const duration=data.state?.testRunDurationMs;
 if(typeof duration!=='number'||!Number.isFinite(duration))throw Error('Missing test duration');
 const report={version:1,scope:'staging_http_read_mix',profile,startedAt:new Date(Date.now()-duration).toISOString(),endedAt,stages};
 return {'capacity-run.json':JSON.stringify(report,null,2)+'\n',stdout:JSON.stringify({scope:report.scope,stages:stages.length,benchmarkGenerated:false})+'\n'};
}
