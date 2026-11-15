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
/** Own backpressure and cancellation without awaiting an upload source's cleanup.
 * One source read serves each pull; retirement stops further reads and releases
 * the source reader even when its cancellation promise never settles.
 */
function ownedUpload(upload:ReadableStream<Uint8Array>|null):ReadableStream<Uint8Array>|null{
 if(!upload)return null;
 const source=upload.getReader();let retired=false,released=false;
 const release=()=>{if(released)return;try{source.releaseLock();released=true;}catch{}};
 const cancel=()=>{
  if(retired)return;retired=true;
  try{void source.cancel().catch(()=>{});}catch{}
  release();
 };
 return new ReadableStream<Uint8Array>({
  async pull(controller){
   if(retired)return;
   try{
    const chunk=await source.read();if(retired){release();return;}
    if(chunk.done){retired=true;release();controller.close();}else controller.enqueue(chunk.value);
   }catch(error){if(!retired){cancel();controller.error(error);}else release();}
  },
  cancel(){cancel();}
 },{highWaterMark:0});
}
/** Unmounted API794 HTTP boundary. Real host authorization/quota/audit bindings are required. */
export async function handleHelpRead(request:Request,context:HelpHttpContext):Promise<Response>{
 let body:Response|undefined;
 const reply=(value:unknown,status:number)=>new Response(JSON.stringify(value),{status,headers});
 try{
  const {db,effects,authenticate}=context;
  if(!db||typeof db.query!=='function'||typeof authenticate!=='function'||!effects||typeof effects.isCurrent!=='function'||typeof effects.consumeQuota!=='function'||typeof effects.auditRead!=='function')throw new HelpReadFailure('unavailable',503);
  // Capture the adapters before the first asynchronous operation.
  const owner=effects.isCurrent,consumeQuota=effects.consumeQuota,auditRead=effects.auditRead;
  const database={query:db.query.bind(db)};
  const current=()=>{
   if(request.signal.aborted)throw new HelpReadFailure('conflict',409);
   const active=owner();
   if(request.signal.aborted||active!==true)throw new HelpReadFailure('conflict',409);
  };
  const url=new URL(request.url);
  if(request.method!==contract.method||url.pathname!==contract.path||url.search||request.headers.get('content-encoding')&&!/^identity$/i.test(request.headers.get('content-encoding')!))throw new HelpReadFailure('invalid_request',400);
  if(!/^application\/json(?:\s*;\s*charset\s*=\s*utf-8)?$/i.test(request.headers.get('content-type')??''))throw new HelpReadFailure('invalid_request',400);
  current();const tokenHash=await authenticate(request);current();
  if(!tokenHash)throw new HelpReadFailure('unauthenticated',401);
  body=new Response(ownedUpload(request.body),{headers:request.headers});
  const raw=await guardedJson(body,65536,current,()=>new HelpReadFailure('invalid_request',400),request.signal);current();
  const result=await readPublishedHelp(database,tokenHash,raw,{consumeQuota,auditRead,isCurrent:()=>{current();return true;}});current();
  return reply(result,200);
 }catch(error){
  const safe=error instanceof HelpReadFailure&&failures[error.code]===error.status?error:new HelpReadFailure('unavailable',503);
  return reply({version:1,error:{code:safe.code}},safe.status);
 }finally{
  // Start releasing rejected uploads, but an untrusted source's cancellation
  // promise must not hold the safe denial response open indefinitely.
  if(!body&&request.body&&!request.body.locked)void request.body.cancel().catch(()=>{});
 }
}
