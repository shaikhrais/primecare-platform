import assert from 'node:assert/strict';
import {test} from 'node:test';
import {writeEndpointAnalytics,readEndpointAnalytics} from '../cloudflare/workers/src/endpoint-analytics.ts';
import {readTrafficReport} from '../websites/typescript/src/endpoint-traffic-report.ts';
const env={ENDPOINT_ANALYTICS_ACCOUNT_ID:'a'.repeat(32),ENDPOINT_ANALYTICS_READ_TOKEN:'private-token'};
const group={endpoint:'GET /v1/test/{id}',status:'200',requests:'3',inbound:'0',unknownInbound:'0',outbound:'100',unknownOutbound:'1'};
function sendFixture(groups=[group],latencies=[{endpoint:group.endpoint,p95:30}]){
 return async(url,init)=>{
  assert.equal(url,'https://api.cloudflare.com/client/v4/accounts/'+'a'.repeat(32)+'/analytics_engine/sql');
  assert.equal(init.redirect,'error');assert.match(init.body,/timestamp >= toDateTime/);
  const rows=init.body.includes('quantileExactWeighted')?latencies:groups;
  return Response.json({data:rows,rows:rows.length});
 };
}
test('analytics event projection contains only bounded route and observation fields',()=>{
 let point;writeEndpointAnalytics({writeDataPoint(value){point=value;}},{endpoint:group.endpoint,status:401,latencyMs:20,declaredRequestBytes:0,declaredResponseBytes:null});
 assert.deepEqual(point,{indexes:[group.endpoint],blobs:[group.endpoint,'401'],doubles:[20,0,0,0,1]});
});
test('weighted analytics become compatible timestamped reports, explicitly labelled estimates',async()=>{
 const report=await readEndpointAnalytics(env,sendFixture(),Date.parse('2026-11-20T12:07:00Z'));
 assert.equal(report.windowStartedAt,'2026-11-20T12:00:00.000Z');
 assert.equal(report.windowEndedAt,'2026-11-20T12:05:00.000Z');
 const parsed=readTrafficReport(report);
 assert.equal(parsed.successfulRequests,3);assert.equal(parsed.outboundBytes,100);
 assert.equal(parsed.measurementKind,'sample_weighted_estimate');
 assert.equal(parsed.unknownOutbound,1);
});
test('missing credentials, duplicate groups, incomplete latency and invalid counts fail closed',async()=>{
 await assert.rejects(readEndpointAnalytics({},()=>assert.fail('Network touched')));
 for(const [groups,latencies] of [[[group,group],[{endpoint:group.endpoint,p95:1}]],[[{...group,unknownOutbound:4}],[{endpoint:group.endpoint,p95:1}]],[[group],[]],[[{...group,requests:'secret'}],[{endpoint:group.endpoint,p95:1}]]]){
  await assert.rejects(readEndpointAnalytics(env,sendFixture(groups,latencies)));
 }
 await assert.rejects(readEndpointAnalytics(env,async()=>new Response('provider credential detail',{status:403})),/Analytics unavailable/);
});
test('bounded response decoder rejects oversized input before JSON parsing',async()=>{
 await assert.rejects(readEndpointAnalytics(env,async()=>new Response('x'.repeat(2000001))),/too large/);
});

test('config preparation preserves routes, secrets metadata and observability; rejects conflicting identity',async()=>{
 const {endpointAnalyticsConfigs}=await import('./prepare-endpoint-analytics-config.mjs');
 const gateway={name:'primecare-api-gateway',main:'../cloudflare/workers/src/gateway.ts',services:[{binding:'AUTH',service:'auth'}],vars:{OTHER:'preserve'},observability:{enabled:false}};
 const governance={name:'primecare-governance-api',main:'../cloudflare/workers/src/service.ts',vars:{SERVICE_NAME:'governance',ENDPOINT_RELEASE_ID:'preserve'},bindings:[{type:'secret_text',name:'DB_URL'}]};
 const result=endpointAnalyticsConfigs(gateway,governance,'a'.repeat(32),'ceo',{ceo:{inventory:true}},'platform-tenant');
 assert.deepEqual(result.gateway.services,gateway.services);
 assert.deepEqual(result.gateway.observability,gateway.observability);
 assert.deepEqual(result.governance.bindings,governance.bindings);
 assert.equal(result.governance.vars.ENDPOINT_RELEASE_ID,'preserve');
 assert.equal(gateway.vars.ENDPOINT_TRAFFIC_ENABLED,undefined);
 assert.throws(()=>endpointAnalyticsConfigs(gateway,governance,'bad','ceo',{ceo:{inventory:true}},'platform-tenant'));
 assert.throws(()=>endpointAnalyticsConfigs(gateway,governance,'a'.repeat(32),'psw',{psw:{inventory:false}},'platform-tenant'));
});
