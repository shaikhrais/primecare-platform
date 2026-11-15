import {Client} from 'pg';
import contract from '../../../tools/governance-production/pc10-help-reader-contract.json';
import {handleHelpRead} from '../../../packages/shared/src/help-reader/http';
import {HelpReadFailure} from '../../../packages/shared/src/help-reader/protocol';
import {createHelpPostgresStore} from '../../../packages/shared/src/help-reader/postgres-store';
import {createHelpOperationalEffects} from '../../../packages/shared/src/help-reader/operational-effects';
import {loadRegisteredHelpBinding,verifyHelpRuntimeBinding} from './help-reader-activation';
import {tokenFrom,sha256} from '../../../cloudflare/workers/src/session-token';
export type HelpWorkerEnvironment=Readonly<{DB_URL:string;SERVICE_NAME:string}>;

type Database={query:(sql:string,values?:unknown[])=>Promise<{rows:any[]}>};
const statuses={invalid_request:400,unauthenticated:401,forbidden:403,not_found:404,conflict:409,rate_limited:429,unavailable:503};
function failure(code:keyof typeof statuses,status=statuses[code],extra:HeadersInit={}){
 const headers=new Headers({'cache-control':'no-store','pragma':'no-cache','vary':'Authorization, Cookie','x-content-type-options':'nosniff'});
 new Headers(extra).forEach((value,key)=>headers.set(key,value));return Response.json({version:1,error:{code}},{status,headers});
}
function safeHeaders(response:Response,outer:HeadersInit){
 const headers=new Headers(outer);
 response.headers.forEach((value,key)=>{if(key==='vary')value=[...new Set([...value.split(','),...(headers.get(key)??'').split(',')].map(v=>v.trim()).filter(Boolean))].join(', ');headers.set(key,value);});
 return new Response(response.body,{status:response.status,headers});
}

/** Concrete inactive composition. There is no injected verifier, client factory,
 * environment-only activation switch, memory store, or permissive fallback.
 */
export async function helpReader(request:Request,env:HelpWorkerEnvironment,path:string,headers:HeadersInit={}):Promise<Response|null>{
 if(env.SERVICE_NAME!==contract.service||path!==contract.path)return null;
 let response:Response|undefined,transaction=false,alive=true;
 const clients:{connect:()=>Promise<void>;query:Database['query'];end:()=>Promise<void>}[]=[];
 const current=()=>{if(!alive||request.signal.aborted)throw new HelpReadFailure('conflict',409);};
 try{
  current();
  if(request.method!==contract.method)return safeHeaders(failure('invalid_request',405,{allow:contract.method}),headers);
  if(request.headers.has('x-tenant-id'))throw new HelpReadFailure('invalid_request',400);
  // Missing registered metadata must not even allocate a database client/effect.
  const binding=await loadRegisteredHelpBinding();current();
  if(!binding)throw new HelpReadFailure('unavailable',503);
  const connectionString=env.DB_URL;
  if(typeof connectionString!=='string'||!connectionString)throw new HelpReadFailure('unavailable',503);
  const token=tokenFrom(request);if(!token)throw new HelpReadFailure('unauthenticated',401);
  const hash=await sha256(token);current();
  for(let n=0;n<2;n++){
   const object=new Client({connectionString,connectionTimeoutMillis:10000,query_timeout:20000,statement_timeout:15000,lock_timeout:5000});
   clients.push({connect:object.connect.bind(object),query:object.query.bind(object) as Database['query'],end:object.end.bind(object)});
  }
  for(const client of clients){await client.connect();current();}
  const reader=clients[0],quota=clients[1];
  const db:Database={query:async(sql,values)=>{
   if(sql==='ROLLBACK'){const result=await reader.query(sql,values);transaction=false;return result;}
   current();const result=await reader.query(sql,values);
   if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ')transaction=true;
   if(sql==='COMMIT')transaction=false;
   current();return result;
  }};
  const autocommit:Database={query:async(sql,values)=>{current();const result=await quota.query(sql,values);current();return result;}};
  const store=createHelpPostgresStore(db,autocommit);
  const operational=createHelpOperationalEffects(store,()=>{current();return true;});
  const effects={...operational,consumeQuota:async(actor:Parameters<typeof operational.consumeQuota>[0],key:string)=>{
   // The shared reader already holds its endpoint/grant/screen locks. Add the
   // exact activation snapshots under that SAME transaction before any quota.
   current();await verifyHelpRuntimeBinding(db,binding,actor);current();
   await operational.consumeQuota(actor,key);current();
  }};
  response=await handleHelpRead(request,{db,effects,authenticate:async()=>{current();return hash;}});
 }catch(error){
  response=failure(error instanceof HelpReadFailure&&statuses[error.code]===error.status?error.code:'unavailable');
 }finally{
  alive=false;let cleanupFailed=false;
  if(transaction&&clients[0])await Promise.resolve().then(()=>clients[0].query('ROLLBACK')).catch(()=>{cleanupFailed=true;});
  const closed=await Promise.allSettled(clients.map(client=>Promise.resolve().then(()=>client.end())));
  if(cleanupFailed||closed.some(result=>result.status==='rejected')){await response?.body?.cancel().catch(()=>{});response=failure('unavailable');}
  if(request.body&&!request.body.locked)await request.body.cancel().catch(()=>{});
 }
 return safeHeaders(response??failure('unavailable'),headers);
}
