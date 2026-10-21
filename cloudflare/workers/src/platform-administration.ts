import {createTenantRecord} from '../../../packages/shared/src/tenant-creation.mjs';
import {platformBundle} from './platform-bundle/service';
import {bundleAccess} from '../../../packages/shared/src/platform-bundle/contract';
import {tenantOperations,operationsAccess} from './tenant-operations';
import {territoryAdministration,territoryAccess} from './territories/service';
import reportRegistry from './report-registry.json';
import {registry as growthRegistry} from '../../../packages/shared/src/growth/contract';
import {partnerProvisioning} from './growth/provisioning';
import bcrypt from 'bcryptjs';
import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from './auth';
import {privilegedActor,mutatedAccount} from './auth-projection';
import {accountUser} from './account-read-projection';
import {optionalRow,requiredRow} from './database-results';
import policy from './account-policy.json';
import hierarchy from './admin-hierarchy.json';
const roles=policy.ceo;
const grants=hierarchy.permissions as Record<string,{view:boolean;create:boolean;edit:boolean}>;
const scopes=hierarchy.roles as Record<string,{scope:string;createTenant:boolean;assignable:string[]}>;
const types=['location','department','service_category'];
const identifier=/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/;
const uuid=/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const clean=(v:unknown,max=150):v is string=>typeof v==='string'&&v.trim().length>0&&v.length<=max&&!/[\u0000-\u001f\u007f]/.test(v);
const canonical=(value:unknown)=>{const sort=(v:any):any=>Array.isArray(v)?v.map(sort):v&&typeof v==='object'?Object.fromEntries(Object.keys(v).sort().map(k=>[k,sort(v[k])])):v;return JSON.stringify(sort(JSON.parse(JSON.stringify(value))));};
class Failure extends Error {constructor(readonly status:number,message:string){super(message);}}
const fail=(status:number,message:string):never=>{throw new Failure(status,message);};
export function platformCommand(path:string,method:string,body:Record<string,unknown>={},allowedRoles:string[]=roles) {
 const match=/^\/platform(?:\/tenants(?:\/([^/]+)(?:\/(accounts|masters|audit)(?:\/([^/]+))?)?)?)?$/.exec(path);
 if(!match)fail(404,'Route not found');const tenantId=match![1],entity=match![2],id=match![3];
 if(tenantId&&!identifier.test(tenantId)||id&&(!identifier.test(id)||entity==='masters'&&!uuid.test(id)))fail(400,'Invalid identifier');
 const valid=method==='GET'&&!id || method==='POST'&&!id&&(path==='/platform/tenants'||!!tenantId&&['accounts','masters'].includes(entity!)) || method==='PATCH'&&!!id&&['accounts','masters'].includes(entity!);
 if(!valid)fail(405,'Method not allowed');
 if(method==='GET'){if(Object.keys(body).length)fail(400,'Unexpected body');return {tenantId,entity,id,body};}
 const allowed=entity==='accounts'?(id?['role','status']:['email','password','role']):entity==='masters'?(id?['label','status','version']:['type','code','label']):['slug','name'];
 if(Object.keys(body).some(k=>!allowed.includes(k)))fail(400,'Unknown field');
 if(!entity&&(!clean(body.name)||typeof body.slug!=='string'||! /^[a-z][a-z0-9-]{2,62}$/.test(body.slug)))fail(400,'Invalid tenant');
 if(entity==='accounts'){
  if(typeof body.role!=='string'||!allowedRoles.includes(body.role))fail(400,'Role is not assignable');
  if(id){if(!['active','inactive'].includes(body.status as string))fail(400,'Invalid status');}
  else if(!clean(body.email,254)||! /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(body.email as string)||typeof body.password!=='string'||body.password.length<12||new TextEncoder().encode(body.password).length>72)fail(400,'Invalid account');
 }
 if(entity==='masters'){
  if(!clean(body.label))fail(400,'Invalid label');
  if(id){if(!['active','inactive'].includes(body.status as string)||!Number.isSafeInteger(body.version)||(body.version as number)<1)fail(400,'Invalid master version or status');}
  else if(!types.includes(body.type as string)||typeof body.code!=='string'||! /^[a-z][a-z0-9_-]{1,63}$/.test(body.code))fail(400,'Invalid master record');
 }
 return {tenantId,entity,id,body};
}
/** Platform provisioning is separate from all tenant roles and clinical workflows. */
export async function platformAdministration(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
 if(env.SERVICE_NAME!=='governance'||!(path==='/platform'||path.startsWith('/platform/')))return null;
 const bundle=await platformBundle(request,env,path,headers);if(bundle)return bundle;
 const operations=await tenantOperations(request,env,path,headers);if(operations)return operations;
 const territory=await territoryAdministration(request,env,path,headers);if(territory)return territory;
 const partner=await partnerProvisioning(request,env,path,headers);if(partner)return partner;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)fail(401,'No session');
  const url=new URL(request.url);if(url.search||request.headers.has('x-tenant-id'))fail(400,'Tenant overrides and query options are not accepted');
  if(!['GET','POST','PATCH'].includes(request.method))fail(405,'Method not allowed');
  const mutation=request.method!=='GET';
  let body:Record<string,unknown>={};if(mutation){try{body=await parseBody(request);}catch(error){return bodyFailure(error,'Invalid request',safe);}};if(!mutation&&request.body)fail(400,'Unexpected body');
  const command=platformCommand(path,request.method,body,scopes.central_admin.assignable);const fingerprintBody={...body};if(command.entity==='accounts'&&!command.id)delete fingerprintBody.password;const fingerprint=()=>sha256(canonical({path,method:request.method,body:fingerprintBody}));const key=request.headers.get('idempotency-key');
  if(mutation&&(!key||! /^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400,'Idempotency-Key required');
  return await withDb(env,async db=>{
   const session=async(lock=false)=>privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active'"+(lock?' FOR SHARE OF u,s':' LIMIT 1'),[await sha256(token!)])).rows);
   const authority=(actor:ReturnType<typeof privilegedActor>)=>{if(!actor)fail(401,'Invalid session');if(!scopes[actor!.roles]||!grants[actor!.roles]?.view||mutation&&!(request.method==='POST'?grants[actor!.roles]?.create:grants[actor!.roles]?.edit)||!actor!.tenant_id)fail(403,'Platform administrator required');return actor!;};
   let actor=authority(await session());
   const checkScope=async()=>{const scope=scopes[actor.roles];if(scope.scope==='tenant'){if(command.tenantId&&command.tenantId!==actor.tenant_id)fail(403,'Tenant administrator scope');if(!optionalRow((await db.query("SELECT id FROM tenants WHERE id::text=$1 AND LOWER(status)='active'",[actor.tenant_id])).rows))fail(403,'Active tenant required');if(mutation&&!command.tenantId)fail(403,'Tenant creation forbidden');}if(command.entity==='accounts'&&mutation&&!scope.assignable.includes(body.role as string))fail(400,'Role is not assignable');};
   await checkScope();
   if(mutation){const rate=requiredRow((await db.query("INSERT INTO platform_administration_rate(actor_id,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(actor_id) DO UPDATE SET attempts=CASE WHEN platform_administration_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE platform_administration_rate.attempts+1 END,window_start=CASE WHEN platform_administration_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE platform_administration_rate.window_start END RETURNING attempts",[actor.id])).rows).attempts;if(typeof rate!=='number'||!Number.isSafeInteger(rate)||rate<1)throw Error('Invalid rate state');if(rate>30){safe.set('retry-after','60');fail(429,'Too many administration requests');}}
   await db.query(mutation?'BEGIN':'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');let committed=false;
   try{
    actor=authority(await session(mutation));await checkScope();
    if(mutation){await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[actor.id+':'+key]);const previous=optionalRow((await db.query('SELECT request_hash,response,status FROM platform_administration_requests WHERE actor_id=$1 AND idempotency_key=$2',[actor.id,key])).rows);if(previous){if(previous.request_hash!==await fingerprint())fail(409,'Idempotency key already used');if(![200,201].includes(previous.status as number)||!previous.response||typeof previous.response!=='object'||Array.isArray(previous.response))throw Error('Invalid replay');if(command.entity==='accounts'&&!command.id){const response=previous.response as {user?:{id?:string}};if(typeof response.user?.id!=='string'||!identifier.test(response.user.id))throw Error('Invalid replay identity');const credential=optionalRow((await db.query('SELECT password_hash FROM users WHERE id::text=$1 AND tenant_id::text=$2 FOR SHARE',[response.user.id,command.tenantId])).rows);if(!credential||typeof credential.password_hash!=='string'||!await bcrypt.compare(body.password as string,credential.password_hash))fail(409,'Idempotency key already used');}return json(previous.response,previous.status as number,safe);}}
    let result:unknown,status=200;const {tenantId,entity,id}=command;
    if(!tenantId){if(!mutation)result={role:actor.roles,scope:scopes[actor.roles].scope,canCreateTenant:scopes[actor.roles].createTenant,canViewTerritories:!!territoryAccess(actor.roles),canViewOperations:!!operationsAccess(actor.roles),canViewBundle:!!bundleAccess(actor.roles),canViewReports:reportRegistry.definitions.some(d=>d.grants.some(g=>g.role===actor.roles&&g.view===1)),growthDashboard:growthRegistry.roles.includes(actor.roles),extended:actor.roles==='platform_admin',canViewTraining:['code_admin','platform_admin','tenant_admin'].includes(actor.roles),identity:{userId:actor.id},tenants:(await db.query('SELECT id,slug,name,created_at FROM tenants'+(scopes[actor.roles].scope==='tenant'?' WHERE id::text=$1':'')+' ORDER BY slug LIMIT 100',scopes[actor.roles].scope==='tenant'?[actor.tenant_id]:[])).rows,assignableRoles:scopes[actor.roles].assignable,masterTypes:types};else{const inserted=await createTenantRecord(db,{id:crypto.randomUUID(),slug:body.slug,name:(body.name as string).trim()});const tenant={id:inserted.id,slug:inserted.slug,name:inserted.name,created_at:inserted.created_at};result={tenant};status=201;await audit('tenant_created',String(tenant.id),String(tenant.id),{},{slug:tenant.slug,name:tenant.name});}}
    else{
     if(!optionalRow((await db.query('SELECT id FROM tenants WHERE id::text=$1'+(mutation?' FOR SHARE':''),[tenantId])).rows))fail(404,'Tenant not found');
     if(!entity)result={tenant:requiredRow((await db.query('SELECT id,slug,name,created_at FROM tenants WHERE id::text=$1',[tenantId])).rows)};
     else if(!mutation){if(entity==='accounts')result={users:(await db.query("SELECT id,email,roles,status,updated_at FROM users WHERE tenant_id::text=$1 AND roles NOT IN ('central_admin','code_admin') AND (roles <> 'platform_admin' OR $2 IN ('central_admin','code_admin')) ORDER BY LOWER(email),id LIMIT 100",[tenantId,actor.roles])).rows.map(row=>({...accountUser(row,actor.id),canModify:String(row.id).toLowerCase()!==actor.id.toLowerCase()&&(['central_admin','code_admin'].includes(actor.roles)||!hierarchy.protected.includes(String(row.roles)))&&(scopes[actor.roles].scope!=='tenant'||!hierarchy.localProtected.includes(String(row.roles)))})),assignableRoles:scopes[actor.roles].assignable};else if(entity==='masters')result={records:(await db.query('SELECT id,type,code,label,status,version FROM platform_master_records WHERE tenant_id::text=$1 ORDER BY type,code LIMIT 100',[tenantId])).rows,types};else result={events:(await db.query('SELECT id,action,target_id,previous_state,current_state,created_at FROM platform_administration_audit WHERE tenant_id::text=$1 ORDER BY created_at DESC,id DESC LIMIT 100',[tenantId])).rows};}
     else if(entity==='accounts'){
      if(!id){const email=(body.email as string).trim().toLowerCase();await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[email]);if(optionalRow((await db.query('SELECT id FROM users WHERE LOWER(email)=$1',[email])).rows))fail(409,'Account already exists');const createdId=crypto.randomUUID();const user=requiredRow((await db.query("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES($1,$2,$3,$4,$5,'active',NOW()) RETURNING id,email,roles,status,tenant_id,updated_at",[createdId,email,tenantId,body.role,await bcrypt.hash(body.password as string,12)])).rows);mutatedAccount(user,{id:createdId,email,tenantId,role:body.role as string,status:'active'});result={user:accountUser(user,actor.id)};status=201;await audit('account_created',tenantId,String(user.id),{},{role:user.roles,status:user.status});}
      else{if(id.toLowerCase()===actor.id.toLowerCase())fail(403,'Cannot modify your own account');const user=optionalRow((await db.query('SELECT id,roles,status FROM users WHERE id::text=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenantId])).rows);if(!user)fail(404,'Account not found');if(['central_admin','code_admin'].includes(String(user.roles))||hierarchy.protected.includes(String(user.roles))&&!['central_admin','code_admin'].includes(actor.roles)||scopes[actor.roles].scope==='tenant'&&[...hierarchy.protected,...hierarchy.localProtected].includes(String(user.roles)))fail(403,'Protected administrator account');const updated=requiredRow((await db.query('UPDATE users SET roles=$1,status=$2,updated_at=NOW() WHERE id::text=$3 AND tenant_id::text=$4 RETURNING id,email,roles,status,tenant_id,updated_at',[body.role,body.status,id,tenantId])).rows);mutatedAccount(updated,{id,tenantId,role:body.role as string,status:body.status as string});await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[id]);await audit('account_updated',tenantId,id,{role:user.roles,status:user.status},{role:updated.roles,status:updated.status});result={user:accountUser(updated,actor.id)};}
     }else{
      if(!id){const record=requiredRow((await db.query('INSERT INTO platform_master_records(tenant_id,type,code,label) VALUES($1,$2,$3,$4) RETURNING id,type,code,label,status,version',[tenantId,body.type,body.code,(body.label as string).trim()])).rows);result={record};status=201;await audit('master_created',tenantId,String(record.id),{},{type:record.type,code:record.code,label:record.label,status:record.status,version:record.version});}
      else{const before=optionalRow((await db.query('SELECT id,label,status,version FROM platform_master_records WHERE id=$1 AND tenant_id::text=$2 FOR UPDATE',[id,tenantId])).rows);if(!before)fail(404,'Master record not found');if(before.version!==body.version)fail(409,'Master record changed; refresh before saving');const record=requiredRow((await db.query('UPDATE platform_master_records SET label=$1,status=$2,version=version+1,updated_at=NOW() WHERE id=$3 AND tenant_id::text=$4 RETURNING id,type,code,label,status,version',[(body.label as string).trim(),body.status,id,tenantId])).rows);await audit('master_updated',tenantId,id,{label:before.label,status:before.status,version:before.version},{label:record.label,status:record.status,version:record.version});result={record};}
     }
    }
    if(mutation){const hash=await fingerprint();const saved=requiredRow((await db.query('INSERT INTO platform_administration_requests(actor_id,idempotency_key,request_hash,response,status) VALUES($1,$2,$3,$4,$5) RETURNING actor_id,idempotency_key,request_hash,response,status',[actor.id,key,hash,JSON.stringify(result),status])).rows);if(saved.actor_id!==actor.id||saved.idempotency_key!==key||saved.request_hash!==hash||saved.status!==status||canonical(saved.response)!==canonical(result))throw Error('Invalid persisted request');await db.query('COMMIT');committed=true;}return json(result,status,safe);
    async function audit(action:string,tenant:string,target:string,previous:unknown,current:unknown){const saved=requiredRow((await db.query('INSERT INTO platform_administration_audit(actor_id,tenant_id,target_id,action,previous_state,current_state) VALUES($1,$2,$3,$4,$5,$6) RETURNING id,actor_id,tenant_id,target_id,action,previous_state,current_state',[actor.id,tenant,target,action,JSON.stringify(previous),JSON.stringify(current)])).rows);if(typeof saved.id!=='string'||!uuid.test(saved.id)||saved.actor_id!==actor.id||saved.tenant_id!==tenant||saved.target_id!==target||saved.action!==action||canonical(saved.previous_state)!==canonical(previous)||canonical(saved.current_state)!==canonical(current))throw Error('Invalid persisted audit');}
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){if(error instanceof Failure)return json({error:error.message},error.status,safe);if((error as {code?:string}).code==='23505')return json({error:'Record already exists'},409,safe);return json({error:'Platform administration unavailable'},503,safe);}
}
