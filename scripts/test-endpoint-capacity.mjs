import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readCapacityEvidence,assessCapacity} from '../websites/typescript/src/endpoint-capacity.ts';
import {readTrafficReport} from '../websites/typescript/src/endpoint-traffic-report.ts';
const now=Date.parse('2026-11-20T12:00:00Z');
const benchmark={releaseId:'release-1',environment:'staging',workload:'representative-mix',
 evidenceUrl:'https://example.com/load-test',measuredAt:'2026-11-20T10:00:00Z',expiresAt:'2026-11-21T10:00:00Z',
 sustainableRequestsPerSecond:100,p95LatencyMs:150,errorRate:0.01,targetP95LatencyMs:200,targetErrorRate:0.02,bottleneck:'database'};
test('capacity compares interval average without clamping overload or inventing peak headroom',()=>{
 const evidence=readCapacityEvidence(benchmark,now);
 assert.equal(assessCapacity(evidence,25).observedAverageUtilization,0.25);
 assert.equal(assessCapacity(evidence,125).averageRateMargin,-25);
 assert.equal(assessCapacity(evidence,0).successfulBenchmarkRps,99);
 assert.match(assessCapacity(evidence,0).recommendation,/pooling/);
});
test('invalid, future, expired, unsafe and failed benchmark evidence is rejected',()=>{
 for(const patch of [{sustainableRequestsPerSecond:0},{errorRate:NaN},{measuredAt:'2027-01-01'},
 {expiresAt:'2026-11-20T11:00:00Z'},{evidenceUrl:'javascript:alert(1)'},{p95LatencyMs:201},
 {errorRate:0.03},{bottleneck:'made-up'},{releaseId:''}]){
  assert.throws(()=>readCapacityEvidence({...benchmark,...patch},now));
 }
 assert.throws(()=>assessCapacity(benchmark,Infinity));
});
test('traffic totals include status and transfer coverage; mismatched status totals are rejected',()=>{
 const row={endpoint:'GET /test',observedRequests:4,statusCounts:{'200':2,'403':1,no_response:1},
 responseHeaderLatencyP95Ms:100,declaredRequestBytes:{knownBytes:0,unknownRequests:0},
 declaredResponseBytes:{knownBytes:200,unknownRequests:1}};
 const raw={intervalSeconds:60,windowStartedAt:'2026-11-20T10:00:00Z',windowEndedAt:'2026-11-20T10:01:00Z',observedRequests:4,endpoints:[row]};
 const report=readTrafficReport(raw);
 assert.equal(report.failedRequests,1);assert.equal(report.successfulRequests,2);
 assert.equal(report.statusCoveredRequests,4);assert.equal(report.unknownOutbound,1);
 assert.throws(()=>readTrafficReport({...raw,endpoints:[{...row,statusCounts:{'200':5}}]}));
 const legacy=readTrafficReport({...raw,endpoints:[{...row,statusCounts:undefined}]});
 assert.equal(legacy.statusCoveredRequests,0);
});

test('per-endpoint rates preserve unknowns and distinguish denial from server errors',async()=>{
 const {endpointTrafficMetrics}=await import('../websites/typescript/src/endpoint-traffic-report.ts');
 const row={observedRequests:10,statusCounts:{'200':6,'403':2,'500':1,no_response:1}};
 assert.deepEqual(endpointTrafficMetrics(row,2),{requestsPerSecond:5,successful:6,failed:2,errorRate:0.2});
 assert.equal(endpointTrafficMetrics({...row,statusCounts:undefined},2).failed,null);
 assert.equal(endpointTrafficMetrics({...row,observedRequests:0,statusCounts:{}},2).errorRate,null);
 assert.throws(()=>endpointTrafficMetrics(row,0));
});
test('service summary requires complete coverage and reconciled readiness counts',async()=>{
 const {readEndpointSummary}=await import('../websites/typescript/src/endpoint-traffic-report.ts');
 const row={service:'auth',declaredOperations:4,managementStates:{ready:1,blocked:1,maintenance:1,unverified:1}};
 const raw={data:[row],pagination:{hasMore:false,total:1}};
 assert.deepEqual(readEndpointSummary(raw),{operations:4,ready:1,blocked:1,maintenance:1,unverified:1});
 for(const patch of [{pagination:{hasMore:true,total:2}},{data:[{...row,declaredOperations:5}]},{data:[row,row],pagination:{hasMore:false,total:2}}])assert.throws(()=>readEndpointSummary({...raw,...patch}));
});
