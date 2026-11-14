import {guardedJson} from '../guarded-json';
import {HelpReadFailure,helpRequest,helpResponse,helpScope,type HelpActor,type HelpResponse} from './protocol';
export {HelpReadFailure} from './protocol';
/** Unmounted API794 client. Hosts still need registered controls, permission and lifecycle binding. */
export function createHelpReaderClient(options:{origin:string;getToken:()=>string|null;scope:HelpActor;isCurrent:()=>boolean;fetcher?:typeof fetch}){
 const url=new URL(options.origin),scope=helpScope(options.scope),getToken=options.getToken,isCurrent=options.isCurrent;
 if(url.protocol!=='https:'||url.username||url.password||url.search||url.hash||url.pathname!=='/')throw new HelpReadFailure('invalid_request',400);
 const send=options.fetcher??globalThis.fetch;
 const tokenNow=()=>{try{return getToken();}catch{return null;}};
 const ownerCurrent=()=>{try{return isCurrent()===true;}catch{return false;}};
 let dead=false,epoch=0,pending:AbortController|undefined;
 return {
  async read(raw:unknown,signal?:AbortSignal):Promise<HelpResponse>{
   if(dead||signal?.aborted)throw new HelpReadFailure('conflict',409);
   const request=helpRequest(raw);const currentOwner=ownerCurrent();if(dead||!currentOwner)throw new HelpReadFailure('conflict',409);
   const token=tokenNow();
   if(typeof token!=='string'||!/^[A-Za-z0-9_-]{43}$/.test(token))throw new HelpReadFailure('unauthenticated',401);
   if(dead||!ownerCurrent()||signal?.aborted)throw new HelpReadFailure('conflict',409);
   const n=++epoch;pending?.abort();const controller=new AbortController();pending=controller;
   const abort=()=>controller.abort();signal?.addEventListener('abort',abort,{once:true});
   const guard=()=>{
    if(dead||epoch!==n||controller.signal.aborted)throw new HelpReadFailure('conflict',409);
    const validOwner=ownerCurrent();if(dead||epoch!==n||controller.signal.aborted||!validOwner)throw new HelpReadFailure('conflict',409);
    const activeToken=tokenNow();if(dead||epoch!==n||controller.signal.aborted||activeToken!==token)throw new HelpReadFailure('conflict',409);
   };
   const json=async(path:string,body?:unknown,max=65536)=>{
    guard();const response=await send(url.origin+path,{method:body===undefined?'GET':'POST',headers:{authorization:'Bearer '+token,accept:'application/json',...(body===undefined?{}:{'content-type':'application/json'})},body:body===undefined?undefined:JSON.stringify(body),cache:'no-store',credentials:'omit',redirect:'error',signal:controller.signal});
    try{guard();if(response.status!==200){const map:Record<number,[HelpReadFailure['code'],number]>={401:['unauthenticated',401],403:['forbidden',403],404:['not_found',404],409:['conflict',409],429:['rate_limited',429]};const e=map[response.status]??['unavailable',503];throw new HelpReadFailure(e[0],e[1]);}
     if(response.headers.get('content-type')?.split(';')[0].trim().toLowerCase()!=='application/json')throw new HelpReadFailure('unavailable',503);
    }catch(error){await response.body?.cancel().catch(()=>{});guard();throw error;}
    return guardedJson(response,max,guard,()=>new HelpReadFailure('unavailable',503),controller.signal);
   };
   const self=async()=>{const a:any=await json('/v1/auth/me');guard();if(a?.status!=='authenticated'||a.userId!==scope.userId||a.tenantId!==scope.tenantId||a.roles!==scope.role)throw new HelpReadFailure('conflict',409);};
   try{
    await self();const response=helpResponse(await json('/v1/psw/help-support',request,1048576),request,scope);await self();guard();return response;
   }catch(error){guard();if(error instanceof HelpReadFailure)throw error;throw new HelpReadFailure('unavailable',503);}
   finally{signal?.removeEventListener('abort',abort);controller.abort();if(pending===controller)pending=undefined;}
  },
  dispose(){if(dead)return;dead=true;epoch++;pending?.abort();pending=undefined;}
 };
}
