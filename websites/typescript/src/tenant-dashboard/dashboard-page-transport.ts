import catalog from '../../../../packages/shared/src/tenant-dashboard/catalog.json';
/** Uses existing API16578 only. Token checks also surround JSON decoding. No mutation or retry. */
export function dashboardPageTransport(origin:string, token:string, dataset:'live'|'demo', currentToken:()=>string|null, fetcher:typeof fetch=fetch) {
 const base=new URL(origin);
 if(!token||!['live','demo'].includes(dataset)||base.username||base.password||base.pathname!=='/'||base.search||base.hash||!(base.protocol==='https:'||base.protocol==='http:'&&['localhost','127.0.0.1'].includes(base.hostname)))throw Error('invalid_origin');
 return async(signal:AbortSignal)=>{
  const guard=()=>{if(signal.aborted)throw Error('aborted');if(currentToken()!==token)throw Error('denied');};
  guard();const url=new URL(catalog.endpoint,base);url.searchParams.set('dataset',dataset);
  const response=await fetcher(url,{method:'GET',headers:{authorization:'Bearer '+token},signal,cache:'no-store',redirect:'error'});
  guard();if(!response.ok)throw Error(response.status===401||response.status===403?'denied':'read_failed');
  const raw:unknown=await response.json();guard();return raw;
 };
}
