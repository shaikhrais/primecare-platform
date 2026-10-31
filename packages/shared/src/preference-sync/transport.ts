import {PreferenceFailure,type PreferenceRequest,type PreferenceTransport,type PreferenceCache} from './client';
/** One transport per authenticated session. Dispose its client when identity changes. */
export function preferenceHttpTransport(origin:string,token:string,fetcher:typeof fetch=fetch):PreferenceTransport{
 const base=new URL(origin);if((base.protocol!=='https:'&&!(base.protocol==='http:'&&['localhost','127.0.0.1'].includes(base.hostname)))||base.username||base.password||base.search||base.hash||base.pathname!=='/'||!/^[A-Za-z0-9_-]{43}$/.test(token))throw new PreferenceFailure('invalid_transport',400);
 const url=new URL('/v1/user/preferences',base).href;
 return async(request:PreferenceRequest,signal:AbortSignal)=>{
  let response:Response;try{response=await fetcher(url,{method:'POST',credentials:'omit',cache:'no-store',redirect:'error',headers:{authorization:'Bearer '+token,'content-type':'application/json'},body:JSON.stringify(request),signal});}catch{throw new PreferenceFailure('offline');}
  let raw:unknown;try{if(!response.body)throw Error();const reader=response.body.getReader(),chunks:Uint8Array[]=[];let size=0;try{while(true){const r=await reader.read();if(r.done)break;size+=r.value.byteLength;if(size>262144)throw Error();chunks.push(r.value);}}finally{await reader.cancel();}const bytes=new Uint8Array(size);let offset=0;for(const chunk of chunks){bytes.set(chunk,offset);offset+=chunk.length;}raw=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(bytes));}catch{throw new PreferenceFailure('invalid_response',502);}
  if(!response.ok){const value=raw as any;const code=typeof value?.error==='string'&&/^[a-z_]{1,80}$/.test(value.error)?value.error:'request_failed';throw new PreferenceFailure(code,response.status,value?.current);}
  return raw;
 };
}
export function preferenceStorageCache(storage:Pick<Storage,'getItem'|'setItem'|'removeItem'>):PreferenceCache{return {read:async key=>storage.getItem(key),write:async(key,value)=>storage.setItem(key,value),remove:async key=>storage.removeItem(key)};}
