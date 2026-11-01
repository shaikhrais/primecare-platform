import catalog from '../../../../packages/shared/src/tenant-dashboard/catalog.json';
import {WorkFailure} from '../../../../packages/domain/src/work_modules';
import type {TenantTaskTransport} from '../../../../packages/shared/src/work-modules/tenant-task-adapter';
const maxReplyBytes=1048576;
/** Optional API16578/16579 adapter. Captured session checks cover the complete streamed reply. */
export function tenantTaskModuleTransport(origin:string,token:string,fetcher:typeof fetch=fetch):TenantTaskTransport {
 const base=new URL(origin);
 if(base.protocol!=='https:'&&!(base.protocol==='http:'&&['localhost','127.0.0.1'].includes(base.hostname))||base.username||base.password||base.pathname!=='/'||base.search||base.hash||!token||/[\x00-\x20\x7f]/.test(token))throw new WorkFailure('invalid');
 return async(request,signal)=>{
  const guard=()=>{if(signal.aborted)throw new WorkFailure('unavailable');if(sessionStorage.getItem('primecare_session')!==token)throw new WorkFailure('denied',401);};
  guard();const url=new URL(catalog.endpoint,base);url.search=new URLSearchParams(request.filters).toString();
  const response=await fetcher(url,{method:request.method,signal,cache:'no-store',redirect:'error',headers:{authorization:'Bearer '+token,...(request.method==='POST'?{'content-type':'application/json','idempotency-key':request.requestId!}:{})},...(request.body===undefined?{}:{body:JSON.stringify(request.body)})});
  let reader:ReadableStreamDefaultReader<Uint8Array>|undefined;
  try {
   guard();
   if(!response.ok)throw new WorkFailure(response.status===401||response.status===403?'denied':response.status===409?'conflict':response.status===400?'invalid':'error',response.status);
   const length=response.headers.get('content-length');
   if(length!==null&&(!/^\d+$/.test(length)||Number(length)>maxReplyBytes)||!response.body)throw new WorkFailure('error',502);
   reader=response.body.getReader();const chunks:Uint8Array[]=[];let size=0;
   while(true){guard();const part=await reader.read();guard();if(part.done)break;size+=part.value.byteLength;if(size>maxReplyBytes)throw new WorkFailure('error',502);chunks.push(part.value);}
   const bytes=new Uint8Array(size);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.byteLength;}
   let raw:unknown;try{raw=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{throw new WorkFailure('error',502);}
   guard();return raw;
  } catch(error) {guard();throw error;}
  finally {if(reader){await reader.cancel().catch(()=>{});reader.releaseLock();}else if(response.body)await response.body.cancel().catch(()=>{});guard();}
 };
}
