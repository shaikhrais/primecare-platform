/** Versioned, caller-free telemetry projection shared by the gateway and reader. */
export interface EndpointAnalyticsDataset {
  writeDataPoint(point:{indexes:string[];blobs:string[];doubles:number[]}):void;
}
export type AnalyticsEvent={endpoint:string;status:number|null;latencyMs:number;declaredRequestBytes:number|null;declaredResponseBytes:number|null};
export function writeEndpointAnalytics(dataset:EndpointAnalyticsDataset,event:AnalyticsEvent){
  dataset.writeDataPoint({indexes:[event.endpoint],blobs:[event.endpoint,event.status===null?'no_response':String(event.status)],
    doubles:[event.latencyMs,event.declaredRequestBytes??0,event.declaredRequestBytes===null?1:0,
      event.declaredResponseBytes??0,event.declaredResponseBytes===null?1:0]});
}
export interface EndpointAnalyticsEnv {
  ENDPOINT_ANALYTICS_ACCOUNT_ID?:string;
  ENDPOINT_ANALYTICS_READ_TOKEN?:string;
  /** Explicit platform-wide reader authority; empty disables remote reporting. */
  ENDPOINT_ANALYTICS_READER_ROLE?:string;
  ENDPOINT_ANALYTICS_READER_TENANT_ID?:string;
}
const integer=(value:unknown)=>{
  if(typeof value!=='number'&&!(typeof value==='string'&&/^\d+$/.test(value)))throw Error('Invalid analytics number');
  const n=Number(value);if(!Number.isSafeInteger(n)||n<0)throw Error('Invalid analytics number');return n;
};
const table='primecare_endpoint_traffic_v1';
export async function readEndpointAnalytics(env:EndpointAnalyticsEnv,send:typeof fetch=fetch,now=Date.now()){
  const account=env.ENDPOINT_ANALYTICS_ACCOUNT_ID,token=env.ENDPOINT_ANALYTICS_READ_TOKEN;
  if(!account||!/^[a-f0-9]{32}$/i.test(account)||!token)throw Error('Analytics unavailable');
  // A completed five-minute window with a two-minute ingestion allowance.
  const end=Math.floor((now-120000)/300000)*300000,start=end-300000;
  const date=(n:number)=>new Date(n).toISOString().slice(0,19).replace('T',' ');
  const scope=`FROM ${table} WHERE timestamp >= toDateTime('${date(start)}') AND timestamp < toDateTime('${date(end)}')`;
  async function query(sql:string){
    const response=await send(`https://api.cloudflare.com/client/v4/accounts/${account}/analytics_engine/sql`,{
      method:'POST',headers:{authorization:'Bearer '+token,'content-type':'text/plain'},body:sql,
      redirect:'error',signal:AbortSignal.timeout(8000)});
    if(!response.ok)throw Error('Analytics unavailable');
    // Bound decoded input even when the upstream omits Content-Length.
    if(!response.body)throw Error('Analytics unavailable');
    const reader=response.body.getReader(),chunks:Uint8Array[]=[];let size=0;
    try{while(true){const part=await reader.read();if(part.done)break;size+=part.value.length;
      if(size>2000000)throw Error('Analytics response too large');chunks.push(part.value);}}
    finally{await reader.cancel();}
    const bytes=new Uint8Array(size);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.length;}
    const raw=JSON.parse(new TextDecoder().decode(bytes));
    if(!Array.isArray(raw.data)||raw.data.length>=10000||raw.rows!==raw.data.length)throw Error('Incomplete analytics');
    return raw.data as Array<Record<string,unknown>>;
  }
  const [groups,latencies,completions]=await Promise.all([
    query(`SELECT blob1 AS endpoint, blob2 AS status, SUM(_sample_interval) AS requests, SUM(_sample_interval * double2) AS inbound, SUM(_sample_interval * double3) AS unknownInbound, SUM(_sample_interval * double4) AS outbound, SUM(_sample_interval * double5) AS unknownOutbound ${scope} GROUP BY endpoint, status LIMIT 10000 FORMAT JSON`),
    query(`SELECT blob1 AS endpoint, quantileExactWeighted(0.95)(double1, _sample_interval) AS p95 ${scope} GROUP BY endpoint LIMIT 10000 FORMAT JSON`),
    query(`SELECT blob1 AS endpoint, blob2 AS completion, SUM(_sample_interval) AS responses, SUM(_sample_interval * double1) AS bytes ${scope.replace('FROM '+table,'FROM primecare_endpoint_body_v1')} GROUP BY endpoint, completion LIMIT 10000 FORMAT JSON`).catch(()=>null),
  ]);
  const p95=new Map<string,number>();
  for(const row of latencies){if(typeof row.endpoint!=='string'||p95.has(row.endpoint))throw Error('Invalid analytics latency');p95.set(row.endpoint,integer(row.p95));}
  const endpoints=new Map<string,{endpoint:string;observedRequests:number;statusCounts:Record<string,number>;declaredRequestBytes:{knownBytes:number;unknownRequests:number};declaredResponseBytes:{knownBytes:number;unknownRequests:number};responseHeaderLatencyP95Ms:number}>();
  for(const row of groups){
    if(typeof row.endpoint!=='string'||row.endpoint.length>400||typeof row.status!=='string'||!/^(?:[1-5][0-9]{2}|no_response)$/.test(row.status)||!p95.has(row.endpoint))throw Error('Invalid analytics dimensions');
    const entry=endpoints.get(row.endpoint)??{endpoint:row.endpoint,observedRequests:0,statusCounts:{},declaredRequestBytes:{knownBytes:0,unknownRequests:0},declaredResponseBytes:{knownBytes:0,unknownRequests:0},responseHeaderLatencyP95Ms:p95.get(row.endpoint)!};
    if(Object.hasOwn(entry.statusCounts,row.status))throw Error('Duplicate analytics status');
    const requests=integer(row.requests),unknownIn=integer(row.unknownInbound),unknownOut=integer(row.unknownOutbound);
    if(unknownIn>requests||unknownOut>requests)throw Error('Invalid analytics coverage');
    entry.observedRequests+=requests;entry.statusCounts[row.status]=requests;
    entry.declaredRequestBytes.knownBytes+=integer(row.inbound);entry.declaredRequestBytes.unknownRequests+=unknownIn;
    entry.declaredResponseBytes.knownBytes+=integer(row.outbound);entry.declaredResponseBytes.unknownRequests+=unknownOut;
    endpoints.set(row.endpoint,entry);
  }
  if(p95.size!==endpoints.size)throw Error('Inconsistent analytics snapshot');
  const data=[...endpoints.values()];
  const total=data.reduce((n,row)=>n+row.observedRequests,0);
  if(!Number.isSafeInteger(total)||data.some(row=>![row.observedRequests,row.declaredRequestBytes.knownBytes,row.declaredResponseBytes.knownBytes,row.declaredRequestBytes.unknownRequests,row.declaredResponseBytes.unknownRequests].every(Number.isSafeInteger)))throw Error('Analytics overflow');
  // Completion events have their own timestamp/window and never increase request counts.
  let responseBodies:{status:string;endpoints?:Array<{endpoint:string;completedResponses:number;completedBytes:number;incompleteResponses:number;partialBytes:number}>}={status:'unavailable'};
  try{
    if(!completions)throw Error('Body dataset unavailable');
    const bodies=new Map<string,{endpoint:string;completedResponses:number;completedBytes:number;incompleteResponses:number;partialBytes:number}>();
    for(const row of completions){
      if(typeof row.endpoint!=='string'||row.endpoint.length>400||!['complete','incomplete'].includes(String(row.completion)))throw Error('Invalid body dimensions');
      const body=bodies.get(row.endpoint)??{endpoint:row.endpoint,completedResponses:0,completedBytes:0,incompleteResponses:0,partialBytes:0};
      const countKey=row.completion==='complete'?'completedResponses':'incompleteResponses',bytesKey=row.completion==='complete'?'completedBytes':'partialBytes';
      if(Object.hasOwn(body,'seen_'+row.completion))throw Error('Duplicate body group');
      Object.defineProperty(body,'seen_'+row.completion,{value:true});body[countKey]=integer(row.responses);body[bytesKey]=integer(row.bytes);bodies.set(row.endpoint,body);
    }
    responseBodies={status:'available',endpoints:[...bodies.values()]};
  }catch{/* Older deployments or unavailable completion evidence leave header metrics intact. */}
  return {responseBodies,intervalSeconds:300,windowStartedAt:new Date(start).toISOString(),windowEndedAt:new Date(end).toISOString(),
    observedRequests:total,endpoints:data,measurementKind:'sample_weighted_estimate',measurement:'Platform-wide gateway estimates; declared lengths and separate application response-body completions before gateway compression; direct service traffic and network overhead excluded'};
}
