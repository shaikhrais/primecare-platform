type Bytes = {knownBytes:number;unknownRequests:number};
type Traffic = {observedRequests:number; declaredRequestBytes:Bytes; declaredResponseBytes:Bytes; responseHeaderLatencyP95Ms:number};
type Report = {intervalSeconds:number; windowStartedAt:string; windowEndedAt:string;
  observedRequests:number; endpoints:Array<Traffic & {endpoint:string}>};

const count = (n:unknown):n is number => typeof n==='number'&&Number.isSafeInteger(n)&&n>=0;

export function readTrafficReport(raw:unknown) {
  const report=raw as Report;
  if(!report||!count(report.intervalSeconds)||report.intervalSeconds===0||!count(report.observedRequests)||
     typeof report.windowStartedAt!=='string'||typeof report.windowEndedAt!=='string'||
     !Array.isArray(report.endpoints)||report.endpoints.length>10000)throw Error('Invalid traffic report');
  const start=Date.parse(report.windowStartedAt),end=Date.parse(report.windowEndedAt);
  if(!Number.isFinite(start)||!Number.isFinite(end)||end-start!==report.intervalSeconds*1000)throw Error('Invalid traffic interval');
  const endpoints=new Map<string,Traffic>();
  let observedRequests=0,inboundBytes=0,outboundBytes=0;
  for(const row of report.endpoints){
    if(!row||typeof row.endpoint!=='string'||row.endpoint.length>400||endpoints.has(row.endpoint)||
       !count(row.observedRequests)||!count(row.responseHeaderLatencyP95Ms)||
       ![row.declaredRequestBytes,row.declaredResponseBytes].every(bytes=>
         bytes&&count(bytes.knownBytes)&&count(bytes.unknownRequests)&&bytes.unknownRequests<=row.observedRequests)){
      throw Error('Invalid endpoint metrics');
    }
    endpoints.set(row.endpoint,row);
    observedRequests+=row.observedRequests;
    inboundBytes+=row.declaredRequestBytes.knownBytes;
    outboundBytes+=row.declaredResponseBytes.knownBytes;
  }
  if(observedRequests!==report.observedRequests||!count(inboundBytes)||!count(outboundBytes))throw Error('Invalid request total');
  return {endpoints,start,end,observedRequests,inboundBytes,outboundBytes,requestsPerSecond:observedRequests/report.intervalSeconds};
}
