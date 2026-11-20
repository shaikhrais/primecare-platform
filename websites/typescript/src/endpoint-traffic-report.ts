type Bytes = {knownBytes:number;unknownRequests:number};
type Traffic = {observedRequests:number; declaredRequestBytes:Bytes; declaredResponseBytes:Bytes; responseHeaderLatencyP95Ms:number; statusCounts?:Record<string,number>};
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
  let observedRequests=0,inboundBytes=0,outboundBytes=0,failedRequests=0,successfulRequests=0,statusCoveredRequests=0,unknownInbound=0,unknownOutbound=0;
  for(const row of report.endpoints){
    if(!row||typeof row.endpoint!=='string'||row.endpoint.length>400||endpoints.has(row.endpoint)||
       !count(row.observedRequests)||!count(row.responseHeaderLatencyP95Ms)||
       ![row.declaredRequestBytes,row.declaredResponseBytes].every(bytes=>
         bytes&&count(bytes.knownBytes)&&count(bytes.unknownRequests)&&bytes.unknownRequests<=row.observedRequests)){
      throw Error('Invalid endpoint metrics');
    }
    if(row.statusCounts!==undefined){
      if(!row.statusCounts||typeof row.statusCounts!=='object'||Array.isArray(row.statusCounts))throw Error('Invalid status counts');
      let total=0;
      for(const [status,n] of Object.entries(row.statusCounts)){
        if(!/^(?:[1-5][0-9]{2}|no_response)$/.test(status)||!count(n))throw Error('Invalid status counts');
        total+=n;
        if(status==='no_response'||Number(status)>=500)failedRequests+=n;
        if(Number(status)>=200&&Number(status)<300)successfulRequests+=n;
      }
      if(total!==row.observedRequests)throw Error('Invalid status total');
      statusCoveredRequests+=total;
    }
    unknownInbound+=row.declaredRequestBytes.unknownRequests;
    unknownOutbound+=row.declaredResponseBytes.unknownRequests;
    endpoints.set(row.endpoint,row);
    observedRequests+=row.observedRequests;
    inboundBytes+=row.declaredRequestBytes.knownBytes;
    outboundBytes+=row.declaredResponseBytes.knownBytes;
  }
  if(!count(observedRequests)||observedRequests!==report.observedRequests||!count(inboundBytes)||!count(outboundBytes))throw Error('Invalid request total');
  return {endpoints,start,end,failedRequests,successfulRequests,statusCoveredRequests,unknownInbound,unknownOutbound,observedRequests,inboundBytes,outboundBytes,requestsPerSecond:observedRequests/report.intervalSeconds};
}
