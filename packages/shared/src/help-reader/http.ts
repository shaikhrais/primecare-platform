import contract from '../../../../tools/governance-production/pc10-help-reader-contract.json';
import {guardedJson} from '../guarded-json';
import {readPublishedHelp,type HelpReadEffects} from './service';
import {HelpReadFailure} from './protocol';
export {HelpReadFailure} from './protocol';
type Database=Parameters<typeof readPublishedHelp>[0];
export type HelpHttpContext=Readonly<{
 db:Database;
 effects:HelpReadEffects;
 /** Bind the existing session-token parser/hash adapter; never accept a caller-supplied actor. */
 authenticate:(request:Request)=>Promise<string|null>;
}>;
const headers={'content-type':'application/json; charset=utf-8','cache-control':'no-store','pragma':'no-cache','vary':'Authorization, Cookie','x-content-type-options':'nosniff'};
const failures:Record<string,number>={invalid_request:400,unauthenticated:401,forbidden:403,not_found:404,conflict:409,rate_limited:429,unavailable:503};
/** Unmounted API794 HTTP boundary. Real host authorization/quota/audit bindings are required. */
export async function handleHelpRead(request:Request,context:HelpHttpContext):Promise<Response>{
 let body:Response|undefined;
 const reply=(value:unknown,status:number)=>new Response(JSON.stringify(value),{status,headers});
 try{
  const {db,effects,authenticate}=context;
  if(!db||typeof db.query!=='function'||typeof authenticate!=='function'||!effects||typeof effects.isCurrent!=='function'||typeof effects.consumeQuota!=='function'||typeof effects.auditRead!=='function')throw new HelpReadFailure('unavailable',503);
  // Capture the adapters before the first asynchronous operation.
  const owner=effects.isCurrent,consumeQuota=effects.consumeQuota,auditRead=effects.auditRead;
  const current=()=>{if(request.signal.aborted||owner()!==true)throw new HelpReadFailure('conflict',409);};
  const url=new URL(request.url);
  if(request.method!==contract.method||url.pathname!==contract.path||url.search||request.headers.get('content-encoding')&&!/^identity$/i.test(request.headers.get('content-encoding')!))throw new HelpReadFailure('invalid_request',400);
  if(!/^application\/json(?:\s*;\s*charset\s*=\s*utf-8)?$/i.test(request.headers.get('content-type')??''))throw new HelpReadFailure('invalid_request',400);
  current();const tokenHash=await authenticate(request);current();
  if(!tokenHash)throw new HelpReadFailure('unauthenticated',401);
  body=new Response(request.body,{headers:request.headers});
  const raw=await guardedJson(body,65536,current,()=>new HelpReadFailure('invalid_request',400),request.signal);current();
  const result=await readPublishedHelp(db,tokenHash,raw,{consumeQuota,auditRead,isCurrent:()=>{current();return true;}});current();
  return reply(result,200);
 }catch(error){
  const safe=error instanceof HelpReadFailure&&failures[error.code]===error.status?error:new HelpReadFailure('unavailable',503);
  return reply({version:1,error:{code:safe.code}},safe.status);
 }finally{
  // Also release bodies rejected before decoding (auth, media type or route errors).
  if(!body&&request.body&&!request.body.locked)await request.body.cancel().catch(()=>{});
 }
}
