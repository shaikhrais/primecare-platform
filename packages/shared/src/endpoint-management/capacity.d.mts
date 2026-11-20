export type CapacityEvidence = {
  releaseId:string; environment:string; workload:string; evidenceUrl:string;
  measurementScope?:'staging_http_read_mix';
  measuredAt:string; expiresAt:string; sustainableRequestsPerSecond:number;
  p95LatencyMs:number; errorRate:number; targetP95LatencyMs:number;
  targetErrorRate:number; bottleneck:'database'|'transfer'|'downstream'|'worker'|'unknown';
};
export function readCapacityEvidence(raw:unknown,now?:number):CapacityEvidence;
export function capacityRecommendation(bottleneck:CapacityEvidence['bottleneck']):string;
export function assessCapacity(evidence:CapacityEvidence,observedRps:number):{observedAverageUtilization:number;averageRateMargin:number;successfulBenchmarkRps:number;recommendation:string};
