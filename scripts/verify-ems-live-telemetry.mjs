/** Verify the exact production traffic reader and dashboard parser without a user session. */
import {mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import {readEndpointAnalytics} from '../cloudflare/workers/src/endpoint-analytics.ts';
import {readTrafficReport} from '../websites/typescript/src/endpoint-traffic-report.ts';
import {inspectEndpointManagement} from './endpoint-management-preflight.mjs';
export async function verifyLiveTelemetry(env,{send=fetch,read=readEndpointAnalytics,now=Date.now()}={}){
 const receipt={source:env.GITHUB_SHA??null,observedAt:new Date(now).toISOString(),providerWrites:0,businessActions:0,productionCapacityVerified:false,status:'unavailable'};
 const preflight=await inspectEndpointManagement(env,send);receipt.configuration=preflight.configuration;receipt.health=preflight.health;
 if(preflight.blockers.length)return {...receipt,blocker:'Live collection configuration or health is incomplete'};
 const queryDiagnostics=[];
 const analyticsSend=async(url,init)=>{const response=await send(url,init);queryDiagnostics.push({query:typeof init?.body==='string'&&init.body.includes('quantileExactWeighted')?'latency':'counts',httpStatus:response.status});return response;};
 const readerEnv={ENDPOINT_ANALYTICS_ACCOUNT_ID:env.CLOUDFLARE_ACCOUNT_ID,ENDPOINT_ANALYTICS_READ_TOKEN:env.ENDPOINT_ANALYTICS_READ_TOKEN||env.CLOUDFLARE_API_TOKEN};
 try{
  const traffic=await read(readerEnv,analyticsSend,now),parsed=readTrafficReport(traffic);
  // No inbox content, credentials, caller identities or request bodies are read or exported.
  return {...receipt,queryDiagnostics,status:parsed.observedRequests>0?'observations_available':'empty_completed_window',measurementKind:parsed.measurementKind,traffic,summary:{observedRequests:parsed.observedRequests,requestsPerSecond:parsed.requestsPerSecond,knownInboundBytes:parsed.inboundBytes,knownOutboundBytes:parsed.outboundBytes,unknownInboundRequests:parsed.unknownInbound,unknownOutboundRequests:parsed.unknownOutbound,http2xx:parsed.successfulRequests,http5xxOrNoResponse:parsed.failedRequests,statusCoveredRequests:parsed.statusCoveredRequests,inboundBytesPerSecond:parsed.inboundBytesPerSecond,outboundBytesPerSecond:parsed.outboundBytesPerSecond},scope:'Platform gateway estimates for one completed five-minute window; not full-system capacity or authenticated API acceptance'};
 }catch{return {...receipt,queryDiagnostics,blocker:'Exact production reader or dashboard traffic parser failed; inspect redacted query diagnostics'};}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 const receipt=await verifyLiveTelemetry(process.env);
 await mkdir('test-results/endpoint-management',{recursive:true});
 await writeFile('test-results/endpoint-management/live-telemetry.json',JSON.stringify(receipt,null,2)+'\n');
 const {traffic,...safe}=receipt;console.log('EMS_LIVE_TELEMETRY '+JSON.stringify(safe));
 if(receipt.status==='unavailable')process.exitCode=1;
}
