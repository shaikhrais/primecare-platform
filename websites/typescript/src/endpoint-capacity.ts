/** Capacity evidence must describe the same deployment, environment and workload. */
export type CapacityEvidence = {
  releaseId:string; environment:string; workload:string; evidenceUrl:string;
  measurementScope?:'staging_http_read_mix';
  measuredAt:string; expiresAt:string; sustainableRequestsPerSecond:number;
  p95LatencyMs:number; errorRate:number; targetP95LatencyMs:number;
  targetErrorRate:number; bottleneck:'database'|'transfer'|'downstream'|'worker'|'unknown';
};
const positive=(v:unknown):v is number=>typeof v==='number'&&Number.isFinite(v)&&v>0;
const nonNegative=(v:unknown):v is number=>typeof v==='number'&&Number.isFinite(v)&&v>=0;
const rate=(v:unknown):v is number=>typeof v==='number'&&Number.isFinite(v)&&v>=0&&v<=1;
export function readCapacityEvidence(raw:unknown,now=Date.now()):CapacityEvidence {
  const value=raw as CapacityEvidence;
  if(!value||![value.releaseId,value.environment,value.workload].every(text=>
    typeof text==='string'&&text.trim().length>0&&text.length<=200)||
    !positive(value.sustainableRequestsPerSecond)||!nonNegative(value.p95LatencyMs)||!positive(value.targetP95LatencyMs)||
    !rate(value.errorRate)||!rate(value.targetErrorRate)||
    !['database','transfer','downstream','worker','unknown'].includes(value.bottleneck))throw Error('Invalid capacity evidence');
  if(value.measurementScope!==undefined&&value.measurementScope!=='staging_http_read_mix')throw Error('Invalid capacity scope');
  const measured=Date.parse(value.measuredAt),expires=Date.parse(value.expiresAt);
  if(!Number.isFinite(measured)||!Number.isFinite(expires)||measured>now||expires<=now||expires<=measured)throw Error('Expired or invalid capacity evidence');
  const url=new URL(value.evidenceUrl);
  if(url.protocol!=='https:'||url.username||url.password)throw Error('Invalid evidence URL');
  if(value.p95LatencyMs>value.targetP95LatencyMs||value.errorRate>value.targetErrorRate)throw Error('Benchmark does not meet targets');
  return value;
}
export function assessCapacity(evidence:CapacityEvidence,observedRps:number) {
  if(!Number.isFinite(observedRps)||observedRps<0)throw Error('Invalid observed rate');
  return {
    // Interval averages are not peaks; sampled traffic cannot establish spare capacity.
    observedAverageUtilization:observedRps/evidence.sustainableRequestsPerSecond,
    averageRateMargin:evidence.sustainableRequestsPerSecond-observedRps,
    successfulBenchmarkRps:evidence.sustainableRequestsPerSecond*(1-evidence.errorRate),
    recommendation:{
      database:'Inspect slow queries and connection waits; verify indexes and pooling, then repeat the same load test.',
      transfer:'Reduce response fields, paginate and measure compression, then repeat the same load test.',
      downstream:'Check provider quotas; use bounded concurrency and queues where permitted, then repeat the same load test.',
      worker:'Measure CPU per operation; remove repeated work and cache safe responses, then repeat the same load test.',
      unknown:'Measure Worker CPU, database waits, queue age and provider quotas before choosing a scaling change.',
    }[evidence.bottleneck],
  };
}
