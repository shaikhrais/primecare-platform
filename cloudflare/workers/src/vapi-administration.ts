import {vapiPermissionQuery} from './vapi-administration-policy';
import {VapiAdminClient} from '../../../packages/shared/src/communications/vapi-admin.mjs';
import {handleVapiAdmin} from '../../../packages/shared/src/communications/vapi-admin-http.mjs';
import {withDb,tokenFrom,sha256,type Env} from './auth';
import {privilegedActor} from './auth-projection';
import {assertRegisteredPermissionRows} from './business-tasks/endpoint-policy';
import pin from '../../../tools/governance-production/production-pin.json';
type VapiEnv=Env & {VAPI_PRIVATE_API_KEY?:string;VAPI_ADMIN_ORG_ID?:string;VAPI_ADMIN_TEMPLATE_ID?:string;VAPI_ADMIN_CATALOG?:string};
/** Configuration management uses native current Code Admin authority. It cannot
 * execute business tasks or change phone routing. Missing registry grants deny. */
export async function vapiAdministration(request:Request,env:VapiEnv,path:string,headers:HeadersInit):Promise<Response|null>{
 if(!path.startsWith('/platform/vapi/'))return null;
 const token=request.headers.has('authorization')?tokenFrom(request):null;
 if(!token)return Response.json({error:'unauthorized'},{status:401,headers:{...Object.fromEntries(new Headers(headers)),'cache-control':'no-store'}});
 return withDb(env,async db=>{
  let actorId='';const authorize=async(operation:string)=>{
   const actor=privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2",[await sha256(token)])).rows);
   if(!actor)throw Object.assign(Error('Denied'),{status:401});if(actor.roles!=='code_admin'||!actor.tenant_id||actorId&&actorId!==actor.id)throw Object.assign(Error('Denied'),{status:403});actorId=actor.id;
   const manifest=await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`);if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Manifest mismatch');
   const statement=vapiPermissionQuery({id:actor.id,tenantId:actor.tenant_id},request.method,'/v1/governance'+path,'VAPI_ADMIN_'+operation.toUpperCase());
   try{assertRegisteredPermissionRows((await db.query(statement.text,statement.values)).rows);}catch{throw Object.assign(Error('Denied'),{status:403});}
  };
  let client;try{if(env.VAPI_PRIVATE_API_KEY&&env.VAPI_ADMIN_ORG_ID&&env.VAPI_ADMIN_TEMPLATE_ID)client=new VapiAdminClient({apiKey:env.VAPI_PRIVATE_API_KEY,orgId:env.VAPI_ADMIN_ORG_ID,templateId:env.VAPI_ADMIN_TEMPLATE_ID,catalog:JSON.parse(env.VAPI_ADMIN_CATALOG??'[]')});}catch{}
  const claim=async(key:string,operation:string,body:unknown)=>{
   const digest=await sha256(JSON.stringify({operation,body}));key='vapi:'+key;const rate=(await db.query("INSERT INTO platform_administration_rate(actor_id,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(actor_id) DO UPDATE SET attempts=CASE WHEN platform_administration_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE platform_administration_rate.attempts+1 END,window_start=CASE WHEN platform_administration_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE platform_administration_rate.window_start END RETURNING attempts",[actorId])).rows;if(rate.length!==1||!Number.isSafeInteger(rate[0].attempts)||rate[0].attempts>30)throw Object.assign(Error('Rate limited'),{status:429});await db.query('BEGIN');try{
    await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[actorId+':'+key]);
    const rows=(await db.query('SELECT request_hash,response,status FROM platform_administration_requests WHERE actor_id=$1 AND idempotency_key=$2',[actorId,key])).rows;
    if(rows.length){const old=rows[0];await db.query('COMMIT');if(old.request_hash!==digest)throw Object.assign(Error('Conflict'),{status:409});return old.response?.error==='reconciliation_required'?{body:{error:'reconciliation_required'},status:409}:{body:old.response,status:old.status};}
    await db.query('INSERT INTO platform_administration_requests(actor_id,idempotency_key,request_hash,response,status) VALUES($1,$2,$3,$4,200)',[actorId,key,digest,JSON.stringify({error:'reconciliation_required'})]);await db.query('COMMIT');return null;
   }catch(e){await db.query('ROLLBACK');throw e;}
  };
  const complete=async(key:string,result:unknown)=>{const r=await db.query("UPDATE platform_administration_requests SET response=$1,status=$2 WHERE actor_id=$3 AND idempotency_key=$4 AND status=200 AND response->>'error'='reconciliation_required' RETURNING actor_id",[JSON.stringify(result),path.endsWith('/assistants')?201:200,actorId,'vapi:'+key]);if(r.rows.length!==1)throw Error('Receipt unavailable');};
  return handleVapiAdmin(request,{client,authorize,claim,complete});
 });
}
