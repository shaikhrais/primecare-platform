/** Portable validation shared by k6 and the offline evidence evaluator. No I/O. */
const text=(value,max=200)=>typeof value==='string'&&value.trim().length>0&&value.length<=max;
const integer=(value,min,max)=>Number.isSafeInteger(value)&&value>=min&&value<=max;
const number=(value,min,max)=>typeof value==='number'&&Number.isFinite(value)&&value>=min&&value<=max;
const keys=(value,allowed)=>value&&typeof value==='object'&&!Array.isArray(value)&&Object.keys(value).every(k=>allowed.includes(k));
export function capacityProfile(raw){
 if(!keys(raw,['version','origin','environment','releaseId','workload','evidenceUrl','stages','preAllocatedVUs','maxVUs','targetP95LatencyMs','targetErrorRate','operations'])||raw.version!==1||
 !['staging','test','sandbox'].includes(raw.environment)||!text(raw.releaseId,80)||!/^[A-Za-z0-9][A-Za-z0-9._-]*$/.test(raw.releaseId)||!text(raw.workload)||
 !/^https:\/\/[a-z0-9][a-z0-9.-]*[a-z0-9]$/.test(raw.origin)||!new RegExp('(?:^|[.-])'+raw.environment+'(?:[.-]|$)').test(raw.origin.slice(8))||
 !text(raw.evidenceUrl,1000)||!/^https:\/\/[a-z0-9][a-z0-9.-]*(?:\/[^\s]*)?$/i.test(raw.evidenceUrl)||
 !integer(raw.preAllocatedVUs,1,500)||!integer(raw.maxVUs,raw.preAllocatedVUs,1000)||!number(raw.targetP95LatencyMs,1,60000)||!number(raw.targetErrorRate,0,0.1)||
 !Array.isArray(raw.stages)||raw.stages.length<1||raw.stages.length>8||!Array.isArray(raw.operations)||raw.operations.length<1||raw.operations.length>20)throw Error('Invalid staging capacity profile');
 let previous=0,totalSeconds=60;
 for(const stage of raw.stages){
  if(!keys(stage,['rate','durationSeconds'])||!integer(stage.rate,1,1000)||stage.rate<=previous||!integer(stage.durationSeconds,60,1800))throw Error('Invalid load stage');
  previous=stage.rate;totalSeconds+=stage.durationSeconds+30;
 }
 if(totalSeconds>7200)throw Error('Load profile exceeds two hours');
 const names=new Set();
 for(const op of raw.operations){
  if(!keys(op,['name','path','weight','expectedStatus','jsonObjectKeys'])||!text(op.name,60)||!/^[a-z][a-z0-9_]*$/.test(op.name)||names.has(op.name)||
   typeof op.path!=='string'||!/^\/v1\/[a-zA-Z0-9_/-]+$/.test(op.path)||op.path.includes('..')||op.path.length>300||
   !integer(op.weight,1,100)||!integer(op.expectedStatus,200,299)||!Array.isArray(op.jsonObjectKeys)||op.jsonObjectKeys.length>20||op.jsonObjectKeys.some(k=>!text(k,80)||!/^[a-zA-Z][a-zA-Z0-9_]*$/.test(k)))throw Error('Invalid synthetic read operation');
  names.add(op.name);
 }
 return raw;
}
export function evaluateCapacityRun(raw,now=Date.now()){
 if(!raw||raw.version!==1||raw.scope!=='staging_http_read_mix')throw Error('Unsupported capacity measurement');
 const profile=capacityProfile(raw.profile),started=Date.parse(raw.startedAt),ended=Date.parse(raw.endedAt);
 if(!Number.isFinite(started)||!Number.isFinite(ended)||ended<=started||ended>now||now-ended>86400000||!Array.isArray(raw.stages)||raw.stages.length!==profile.stages.length)throw Error('Invalid capacity observation window');
 const minimumSeconds=60+profile.stages.reduce((n,stage)=>n+stage.durationSeconds,0)+30*profile.stages.length;
 if(ended-started<minimumSeconds*1000)throw Error('Incomplete sustained load run');
 let highest=null,contiguous=true;
 const results=raw.stages.map((row,index)=>{
  const stage=profile.stages[index];
  if(!row||row.name!=='stage_'+index||!integer(row.completed,0,Number.MAX_SAFE_INTEGER)||!integer(row.failed,0,row.completed)||!integer(row.dropped,0,Number.MAX_SAFE_INTEGER)||!number(row.p95LatencyMs,0,3600000)||
    !Array.isArray(row.operations)||row.operations.length!==profile.operations.length)throw Error('Invalid stage evidence');
  const reasons=[];
  if(row.completed<100)reasons.push('insufficient_requests');
  if(row.completed<stage.rate*stage.durationSeconds*0.98)reasons.push('target_rate_not_achieved');
  if(row.dropped!==0)reasons.push('dropped_iterations');
  if(row.failed/Math.max(1,row.completed)>profile.targetErrorRate)reasons.push('error_target_missed');
  if(row.p95LatencyMs>profile.targetP95LatencyMs)reasons.push('latency_target_missed');
  const seen=new Set();let completed=0,failed=0;
  for(const op of row.operations){
   if(!op||!profile.operations.some(p=>p.name===op.name)||seen.has(op.name)||!integer(op.completed,0,row.completed)||!integer(op.failed,0,op.completed)||!number(op.p95LatencyMs,0,3600000))throw Error('Invalid operation evidence');
   seen.add(op.name);completed+=op.completed;failed+=op.failed;
   const expected=profile.operations.find(p=>p.name===op.name).weight/profile.operations.reduce((n,p)=>n+p.weight,0);
   if(row.completed&&Math.abs(op.completed/row.completed-expected)>0.05)reasons.push('workload_mix_missed:'+op.name);
   if(op.completed<20||op.p95LatencyMs>profile.targetP95LatencyMs||op.failed/Math.max(1,op.completed)>profile.targetErrorRate)reasons.push('operation_target_missed:'+op.name);
  }
  if(completed!==row.completed||failed!==row.failed)throw Error('Inconsistent operation totals');
  if(reasons.length)contiguous=false;
  const result={name:row.name,targetRequestsPerSecond:stage.rate,observedRequestsPerSecond:row.completed/stage.durationSeconds,p95LatencyMs:row.p95LatencyMs,errorRate:row.failed/Math.max(1,row.completed),passed:reasons.length===0,reasons};
  if(result.passed&&contiguous)highest=result;
  return result;
 });
 const benchmark=highest?{releaseId:profile.releaseId,environment:profile.environment,workload:profile.workload,evidenceUrl:profile.evidenceUrl,measuredAt:raw.endedAt,expiresAt:new Date(ended+86400000).toISOString(),
   sustainableRequestsPerSecond:Math.min(highest.targetRequestsPerSecond,highest.observedRequestsPerSecond),p95LatencyMs:highest.p95LatencyMs,errorRate:highest.errorRate,targetP95LatencyMs:profile.targetP95LatencyMs,targetErrorRate:profile.targetErrorRate,bottleneck:'unknown',measurementScope:'staging_http_read_mix'}:null;
 return {measurementScope:raw.scope,benchmark,stages:results,limitations:['Read-only staging workload; excludes write workflows and external provider capacity.','Release identity, sanitized fixtures, generator resources and server bottlenecks require separate review.','Highest passing tested rate is a measured lower bound for this workload, not the system maximum.']};
}
