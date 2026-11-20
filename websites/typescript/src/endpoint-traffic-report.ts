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
  return {endpoints,start,end,failedRequests,successfulRequests,statusCoveredRequests,unknownInbound,unknownOutbound,observedRequests,inboundBytes,outboundBytes,requestsPerSecond:observedRequests/report.intervalSeconds,inboundBytesPerSecond:inboundBytes/report.intervalSeconds,outboundBytesPerSecond:outboundBytes/report.intervalSeconds,successfulRequestsPerSecond:successfulRequests/report.intervalSeconds};
}

/** Missing status evidence stays unknown, including for legacy exports. */
export function endpointTrafficMetrics(row:Traffic,intervalSeconds:number){
  if(!Number.isFinite(intervalSeconds)||intervalSeconds<=0)throw Error('Invalid traffic interval');
  if(!row.statusCounts)return {requestsPerSecond:row.observedRequests/intervalSeconds,successful:null,failed:null,errorRate:null};
  const successful=Object.entries(row.statusCounts).reduce((n,[status,count])=>n+(Number(status)>=200&&Number(status)<300?count:0),0);
  const failed=Object.entries(row.statusCounts).reduce((n,[status,count])=>n+(status==='no_response'||Number(status)>=500?count:0),0);
  return {requestsPerSecond:row.observedRequests/intervalSeconds,successful,failed,errorRate:row.observedRequests?failed/row.observedRequests:null};
}

export function readEndpointSummary(raw:unknown){
  const value=raw as {data:Array<{service:string;declaredOperations:number;managementStates:Record<string,number>}>;pagination:{hasMore:boolean;total:number}};
  if(!value||!Array.isArray(value.data)||value.data.length>100||!value.pagination||value.pagination.hasMore!==false||value.pagination.total!==value.data.length)throw Error('Incomplete endpoint summary');
  const seen=new Set<string>();
  const totals={operations:0,ready:0,blocked:0,maintenance:0,unverified:0};
  for(const row of value.data){
    if(!row||typeof row.service!=='string'||seen.has(row.service)||!count(row.declaredOperations)||!row.managementStates)throw Error('Invalid service summary');
    seen.add(row.service);
    let sum=0;
    for(const state of ['ready','blocked','maintenance','unverified'] as const){
      const n=row.managementStates[state];if(!count(n))throw Error('Invalid service status');
      totals[state]+=n;sum+=n;
    }
    if(sum!==row.declaredOperations)throw Error('Invalid service total');
    totals.operations+=sum;
  }
  if(!Object.values(totals).every(count))throw Error('Invalid summary total');
  return totals;
}
