import {Client} from 'pg';
import contract from '../../../tools/governance-production/pc10-help-reader-contract.json';
import {handleHelpRead,HelpReadFailure} from '../../../packages/shared/src/help-reader/http';
import {createHelpPostgresStore} from '../../../packages/shared/src/help-reader/postgres-store';
import {createHelpOperationalEffects} from '../../../packages/shared/src/help-reader/operational-effects';
import {tokenFrom,sha256} from './session-token';

type Database={query:(sql:string,values?:any[])=>Promise<{rows:any[]}>};
export type HelpWorkerClient=Database&{connect:()=>Promise<void>;end:()=>Promise<void>};
export type HelpWorkerConnection=Readonly<{connectionString:string;connectionTimeoutMillis:10000;query_timeout:20000;statement_timeout:15000;lock_timeout:5000}>;
export type HelpActivationVerifier=(reader:Database)=>Promise<void>;
type Environment={DB_URL:string;SERVICE_NAME:string};
type ClientFactory=(options:HelpWorkerConnection)=>HelpWorkerClient;
const client:ClientFactory=options=>new Client(options);
const statuses={invalid_request:400,unauthenticated:401,forbidden:403,not_found:404,conflict:409,rate_limited:429,unavailable:503};
const failure=(code:keyof typeof statuses)=>Response.json({version:1,error:{code}},{status:statuses[code],headers:{'content-type':'application/json; charset=utf-8','cache-control':'no-store','pragma':'no-cache','vary':'Authorization, Cookie','x-content-type-options':'nosniff'}});
function headersFor(response:Response,outer:HeadersInit){
 const merged=new Headers(outer);new Headers(response.headers).forEach((value,key)=>{
  if(key==='vary')value=[...new Set([...value.split(','),...(merged.get('vary')??'').split(',')].map(x=>x.trim()).filter(Boolean))].join(', ');
  merged.set(key,value);
 });
 return new Response(response.body,{status:response.status,headers:merged});
}

/** Worker composition for registered API794. Unmounted until PC-01 supplies a
 * real registered runtime/control/source and scheduled-purge verifier. There is
 * deliberately no enabled flag, permissive verifier, or in-memory store fallback.
 * The verifier runs under the reader transaction before any private read/effect;
 * it must lock and verify its exact reviewed metadata and throw on any mismatch.
 */
export function createHelpWorkerAdapter(verifyActivation?:HelpActivationVerifier,createClient:ClientFactory=client){
 const verify=verifyActivation,makeClient=createClient;
 return async function helpReader(request:Request,env:Environment,path:string,headers:HeadersInit={}):Promise<Response|null>{
  if(env.SERVICE_NAME!==contract.service||path!==contract.path)return null;
  let response:Response|undefined,transaction=false,alive=true;
  const clients:{object:HelpWorkerClient;connect:()=>Promise<void>;query:Database['query'];end:()=>Promise<void>}[]=[];
  const current=()=>{if(!alive||request.signal.aborted)throw new HelpReadFailure('conflict',409);};
  try{
   current();
   if(request.method!==contract.method||request.headers.has('x-tenant-id'))throw new HelpReadFailure('invalid_request',400);
   if(typeof verify!=='function'||typeof makeClient!=='function'||typeof env.DB_URL!=='string'||!env.DB_URL)throw new HelpReadFailure('unavailable',503);
   const options:HelpWorkerConnection=Object.freeze({connectionString:env.DB_URL,connectionTimeoutMillis:10000,query_timeout:20000,statement_timeout:15000,lock_timeout:5000});
   const token=tokenFrom(request);if(!token)throw new HelpReadFailure('unauthenticated',401);
   const digest=await sha256(token);current();
   for(let n=0;n<2;n++){
    const object=makeClient(options);
    if(!object||typeof object.connect!=='function'||typeof object.query!=='function'||typeof object.end!=='function'||clients.some(c=>c.object===object))throw new HelpReadFailure('unavailable',503);
    clients.push({object,connect:object.connect.bind(object),query:object.query.bind(object),end:object.end.bind(object)});
   }
   for(const connection of clients){await connection.connect();current();}
   const reader=clients[0],quota=clients[1];
   const db:Database={query:async(sql,values)=>{
    // Retired requests still own their transaction cleanup. A genuine rollback
    // failure remains an unavailable error; cancellation itself is not one.
    if(sql==='ROLLBACK'){const result=await reader.query(sql,values);transaction=false;return result;}
    current();const result=await reader.query(sql,values);
    if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ')transaction=true;
    if(sql==='COMMIT'||sql==='ROLLBACK')transaction=false;
    current();
    if(sql==='BEGIN ISOLATION LEVEL REPEATABLE READ'){
     await reader.query("SET LOCAL statement_timeout='15s'");await reader.query("SET LOCAL lock_timeout='5s'");
     await verify({query:reader.query});current();
    }
    return result;
   }};
   const autocommit:Database={query:async(sql,values)=>{current();const result=await quota.query(sql,values);current();return result;}};
   const store=createHelpPostgresStore(db,autocommit),effects=createHelpOperationalEffects(store,()=>{current();return true;});
   response=await handleHelpRead(request,{db,effects,authenticate:async()=>{current();return digest;}});
  }catch(error){
   const known=error instanceof HelpReadFailure&&statuses[error.code]===error.status;
   response=failure(known?error.code:'unavailable');
  }finally{
   alive=false;
   // A verifier/abort can reject inside BEGIN before the shared reader observes
   // its success. This owner still rolls back that transaction before disposal.
   let rollbackFailed=false;
   if(transaction&&clients[0])await Promise.resolve().then(()=>clients[0].query('ROLLBACK')).catch(()=>{rollbackFailed=true;});
   const closed=await Promise.allSettled(clients.map(c=>Promise.resolve().then(()=>c.end())));
   if(rollbackFailed||closed.some(r=>r.status==='rejected')){await response?.body?.cancel().catch(()=>{});response=failure('unavailable');}
   if(request.body&&!request.body.locked)await request.body.cancel().catch(()=>{});
  }
  return headersFor(response??failure('unavailable'),headers);
 };
}
