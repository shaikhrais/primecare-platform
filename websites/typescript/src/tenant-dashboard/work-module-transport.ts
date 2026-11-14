import {guardedJson} from '../../../../packages/shared/src/guarded-json';
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
  try{guard();if(!response.ok)throw new WorkFailure(response.status===401||response.status===403?'denied':response.status===409?'conflict':response.status===400?'invalid':'error',response.status);}
  catch(error){if(response.body)await response.body.cancel().catch(()=>{});guard();throw error;}
  return guardedJson(response,maxReplyBytes,guard,()=>new WorkFailure('error',502),signal);
 };
}
