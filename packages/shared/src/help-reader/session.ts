import {createHelpReaderClient} from './client';
import {HelpReadFailure,helpRequest,type HelpRequest,type HelpResponse} from './protocol';

type Summary = Extract<HelpResponse,{action:'list'}>['items'][number];
type Article = Extract<HelpResponse,{action:'read'}>['article'];
export type HelpReaderState = Readonly<{
 phase:'idle'|'loading'|'list'|'empty'|'detail'|'error'|'retired'|'disposed';
 locale:HelpRequest['locale'];query:string;offset:number;limit:number;total:number;
 items:readonly Summary[];article:Article|null;error:HelpReadFailure|null;
}>;
const statuses={invalid_request:400,unauthenticated:401,forbidden:403,not_found:404,conflict:409,rate_limited:429,unavailable:503};
const safeFailure=(error:unknown):HelpReadFailure=>{
 // Transport errors may carry credentials/content or mutable accessor properties.
 // Publish a fresh immutable approved pair, never the producer's Error instance.
 try{if(error instanceof HelpReadFailure){
  const code=Object.getOwnPropertyDescriptor(error,'code')?.value as HelpReadFailure['code'];
  const status=Object.getOwnPropertyDescriptor(error,'status')?.value;
  if(typeof code==='string'&&Object.hasOwn(statuses,code)&&statuses[code]===status)return Object.freeze(new HelpReadFailure(code,status));
 }}catch{/* An uninspectable producer failure is unavailable. */}
 return Object.freeze(new HelpReadFailure('unavailable',503));
};
const blank=(locale:HelpRequest['locale'],limit:number):HelpReaderState=>Object.freeze({phase:'idle',locale,query:'',offset:0,limit,total:0,items:Object.freeze([]),article:null,error:null});

/** Unmounted reader state. A registered host supplies captured session callbacks,
 * observes sessionChanged, and disposes this session on navigation/logout.
 * Creating the controller never grants screen or runtime access.
 */
export function createHelpReaderSession(options:Parameters<typeof createHelpReaderClient>[0],initial:{locale?:HelpRequest['locale'];limit?:number}={}){
 const locale=initial.locale??'en',limit=initial.limit??25;
 const first=helpRequest({version:1,action:'list',locale,query:'',offset:0,limit});
 if(first.action!=='list')throw new HelpReadFailure('invalid_request',400);
 const capturedOptions={...options},owner=capturedOptions.isCurrent,getToken=capturedOptions.getToken;
 const reader=createHelpReaderClient(capturedOptions);
 let capturedToken:string|null;try{capturedToken=getToken();}catch{reader.dispose();throw new HelpReadFailure('unauthenticated',401);}
 if(typeof capturedToken!=='string'||!/^[A-Za-z0-9_-]{43}$/.test(capturedToken)){reader.dispose();throw new HelpReadFailure('unauthenticated',401);}
 let state=blank(locale,limit),generation=0,disposed=false,retired=false;
 let pending:AbortController|undefined,lastRequest:HelpRequest|undefined;
 let listRequest:HelpRequest&{action:'list'}=first;
 const listeners=new Set<(state:HelpReaderState)=>void>();
 const current=()=>{try{return !disposed&&!retired&&owner()===true&&getToken()===capturedToken&&!disposed&&!retired;}catch{return false;}};
 const publish=(next:HelpReaderState)=>{
  if(disposed)return;
  state=Object.freeze(next);
  for(const listener of [...listeners]){
   if(disposed||state!==next)break;
   if(!listeners.has(listener))continue;
   try{listener(next);}catch{/* One view observer cannot interrupt cleanup or another observer. */}
  }
 };
 const replaceAndAbort=(next:HelpReaderState,previous?:AbortController)=>{
  if(disposed){previous?.abort();return;}
  state=Object.freeze(next);
  previous?.abort();
  if(!disposed&&state===next)publish(next);
 };
 const retire=(error=new HelpReadFailure('conflict',409))=>{
  if(disposed||retired)return;
  retired=true;generation++;lastRequest=undefined;
  const previous=pending;pending=undefined;
  listRequest={version:1,action:'list',locale:state.locale,query:'',offset:0,limit};
  replaceAndAbort({...blank(state.locale,limit),phase:'retired',error:safeFailure(error)},previous);
 };
 const issue=async(raw:unknown):Promise<void>=>{
  if(disposed||retired)return;
  const started=generation,active=current();
  if(disposed||retired||started!==generation)return;
  if(!active){retire();return;}
  let request:HelpRequest;
  try{request=helpRequest(raw);}catch(error){
   if(disposed||retired||started!==generation)return;
   const failure=safeFailure(error);
   if(disposed||retired||started!==generation)return;
   generation++;lastRequest=undefined;const previous=pending;pending=undefined;
   replaceAndAbort({...blank(state.locale,limit),query:listRequest.query,offset:listRequest.offset,phase:'error',error:failure},previous);
   return;
  }
  if(disposed||retired||started!==generation)return;
  const n=++generation,previous=pending;
  const controller=new AbortController();pending=controller;lastRequest=undefined;
  if(request.action==='list')listRequest=request;
  replaceAndAbort({...blank(request.locale,limit),query:listRequest.query,offset:listRequest.offset,phase:'loading'},previous);
  if(disposed||retired||n!==generation)return;
  let onAbort:(()=>void)|undefined;
  try{
   const cancellation=new Promise<never>((_resolve,reject)=>{
    onAbort=()=>reject(new HelpReadFailure('conflict',409));
    controller.signal.addEventListener('abort',onAbort,{once:true});
    if(controller.signal.aborted)onAbort();
   });
   // The outer lifetime must settle even if a transport's body cleanup does not.
   const reply=await Promise.race([reader.read(request,controller.signal),cancellation]);
   if(disposed||retired||n!==generation)return;
   const active=current();
   if(disposed||retired||n!==generation)return;
   if(!active){retire();return;}
   if(reply.action==='list')publish({...blank(reply.locale,limit),query:listRequest.query,
    offset:reply.offset,total:reply.total,items:reply.items,phase:reply.items.length?'list':'empty'});
   else publish({...blank(reply.locale,limit),query:listRequest.query,offset:listRequest.offset,
    article:reply.article,phase:'detail'});
  }catch(error){
   if(disposed||retired||n!==generation)return;
   const active=current();
   if(disposed||retired||n!==generation)return;
   if(!active){retire();return;}
   const failure=safeFailure(error);
   if(disposed||retired||n!==generation)return;
   if([401,403,409].includes(failure.status)){retire(failure);return;}
   lastRequest=failure.status===400?undefined:request;
   publish({...blank(request.locale,limit),query:listRequest.query,offset:listRequest.offset,phase:'error',error:failure});
  }finally{
   if(onAbort)controller.signal.removeEventListener('abort',onAbort);
   controller.abort();if(pending===controller)pending=undefined;
  }
 };
 return {
  get state(){return state;},
  get canNext(){return state.phase==='list'&&state.offset+limit<state.total&&state.offset+limit<=100000;},
  get canPrevious(){return ['list','empty'].includes(state.phase)&&state.offset>0;},
  get canRetry(){return !disposed&&!retired&&state.phase==='error'&&lastRequest!==undefined;},
  subscribe(listener:(state:HelpReaderState)=>void){
   if(disposed)return ()=>{};
   listeners.add(listener);return ()=>{listeners.delete(listener);};
  },
  load(){return issue(listRequest);},
  search(query:string){return issue({...listRequest,query,offset:0});},
  changeLocale(next:HelpRequest['locale']){return issue({...listRequest,locale:next,offset:0});},
  nextPage(){return state.phase==='list'&&state.offset+limit<state.total&&state.offset+limit<=100000?issue({...listRequest,offset:state.offset+limit}):Promise.resolve();},
  previousPage(){return ['list','empty'].includes(state.phase)&&state.offset>0?issue({...listRequest,offset:Math.max(0,state.offset-limit)}):Promise.resolve();},
  openArticle(articleId:string){return issue({version:1,action:'read',locale:state.locale,articleId});},
  backToList(){return issue(listRequest);},
  retry(){return lastRequest&&state.phase==='error'?issue(lastRequest):Promise.resolve();},
  sessionChanged(){if(disposed||retired)return;const observed=generation,active=current();if(!disposed&&!retired&&observed===generation&&!active)retire();},
  retire,
  dispose(){
   if(disposed)return;
   disposed=true;retired=true;generation++;lastRequest=undefined;
   const previous=pending;pending=undefined;
   listRequest={version:1,action:'list',locale:state.locale,query:'',offset:0,limit};
   state=Object.freeze({...blank(state.locale,limit),phase:'disposed'});
   listeners.clear();previous?.abort();reader.dispose();
  }
 };
}
