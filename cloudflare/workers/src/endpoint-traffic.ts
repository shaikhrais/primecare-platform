import {writeEndpointAnalytics,type EndpointAnalyticsDataset} from './endpoint-analytics';
import ems from '../../../packages/shared/src/endpoint-management/contract.json';
import inventory from './api-execution-inventory.json';

const exact = new Set<string>();
const templates = new Map<string, string[][]>();
for (const {method,route} of [...inventory.data,...ems.operations.map(op=>({method:op.method,route:op.path}))]) {
  if (!route.includes('{')) {
    exact.add(`${method} ${route}`);
    continue;
  }
  const parts=route.split('/');
  const key=`${method} ${parts.length} ${parts[1]}`;
  const group=templates.get(key)??[];
  group.push(parts);
  templates.set(key,group);
}

function endpoint(method:string,path:string) {
  const key=`${method} ${path}`;
  if (exact.has(key)) return key;
  const parts=path.split('/');
  const candidates=templates.get(`${method} ${parts.length} ${parts[1]}`)??[];
  const matches=new Set(candidates.filter(route=>route.every((part,i)=>
    /^\{[^{}]+\}$/.test(part)?Boolean(parts[i]):part===parts[i])).map(route=>route.join('/')));
  return matches.size===1?`${method} ${matches.values().next().value}`:'unmatched';
}

function bodyBytes(message:Request|Response) {
  if (!message.body) return 0;
  const length=message.headers.get('content-length');
  return length&&/^\d{1,16}$/.test(length)&&Number.isSafeInteger(Number(length))?Number(length):null;
}

/** Observe the forwarded response without consuming, cloning or buffering bodies. */
export function recordEndpointTraffic(request:Request,response:Response|undefined,elapsedMs:number,dataset?:EndpointAnalyticsDataset) {
  const route=endpoint(request.method,new URL(request.url).pathname);
  const event={
    endpoint:route,status:response?.status??null,latencyMs:Math.max(0,Math.round(elapsedMs)),
    declaredRequestBytes:bodyBytes(request),
    declaredResponseBytes:response?(request.method==='HEAD'?0:bodyBytes(response)):null,
  };
  if(dataset){try{writeEndpointAnalytics(dataset,event);}catch{/* Observability cannot fail the business request. */}}
  console.log('primecare_endpoint_traffic_v1 '+JSON.stringify(event));
}
