import definition from '../../../packages/shared/src/endpoint-management/contract.json';
import {readCapacityEvidence,assessCapacity,capacityRecommendation} from '../../../packages/shared/src/endpoint-management/capacity.mjs';
import pin from '../../../tools/governance-production/production-pin.json';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import {privilegedActor} from './auth-projection';
import {assertRegisteredPermissionRows,registeredMetadataValue as metadataValue} from './business-tasks/endpoint-policy';
import {sourceLimitAllowed} from './source-limit-result';
import {governanceRows,endpointManagement,filterGovernanceRows,serviceVerificationSummary,parseGovernanceQuery} from './governance-api';
import {readEndpointAnalytics,type EndpointAnalyticsEnv} from './endpoint-analytics';
import {emsPermissionQuery} from './code-admin-ems-policy';
type EmsEnv=Env & EndpointAnalyticsEnv & {ENDPOINT_RELEASE_ID?:string;ENDPOINT_CAPACITY_EVIDENCE?:string};
class Denied extends Error {constructor(readonly status:number,message:string){super(message);}}
const stop=(status:number,message:string):never=>{throw new Denied(status,message);};
export async function codeAdminEms(request:Request,env:EmsEnv,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||!(path==='/platform/ems'||path.startsWith('/platform/ems/')))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 const full='/v1/governance'+path,operation=definition.operations.find(op=>op.path===full);
 if(!operation)return json({error:'EMS route not found'},404,safe);
 if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
 const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)return json({error:'No session'},401,safe);
 const url=new URL(request.url),query=parseGovernanceQuery(url);
 if(!query||request.body!==null||request.headers.has('x-tenant-id')||!operation.usesPagination&&url.search)return json({error:'Invalid EMS query or scope override'},400,safe);
 try{
  if(env.WORKSPACE_SOURCE_LIMIT&&!sourceLimitAllowed(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('ems:'+ (request.headers.get('cf-connecting-ip')??'unknown'))}))){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
  return await withDb(env,async db=>{
   await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
   try{
    const actor=privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2",[await sha256(token)])).rows);
    if(!actor)stop(401,'Invalid session');
    if(actor.roles!==definition.role||!actor.tenant_id)stop(403,'Code Admin required');
    const manifest=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`)).rows;
    if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance manifest unavailable');
    const statement=emsPermissionQuery({id:actor.id,tenantId:actor.tenant_id},request.method,full);
    try{const grants=(await db.query(statement.text,statement.values)).rows;assertRegisteredPermissionRows(grants);if(grants.length!==1||grants.some(row=>['role_id','screen_id','api_id'].some(key=>typeof row[key]!=='string'||!/^[1-9][0-9]*$/.test(row[key] as string))))throw Error('Ambiguous EMS grant');}catch{stop(403,'EMS screen and endpoint grant required');}
    const now=Date.now(),observedAt=new Date(now).toISOString();
    if(operation.name==='traffic'){
     if(env.ENDPOINT_ANALYTICS_READER_ROLE!==actor.roles||env.ENDPOINT_ANALYTICS_READER_TENANT_ID!==actor.tenant_id)return json({status:'not_configured',observedAt,scope:'platform_gateway',reason:'Approved platform traffic reader is not configured for this Code Admin tenant.'},200,safe);
     try{return json({status:'available',observedAt,scope:'platform_gateway',report:await readEndpointAnalytics(env)},200,safe);}
     catch{return json({status:'unavailable',observedAt,scope:'platform_gateway'},200,safe);}
    }
    if(operation.name==='capacity'){
     const guidance=capacityRecommendation('unknown');
     if(!env.ENDPOINT_CAPACITY_EVIDENCE)return json({status:'unmeasured',observedAt,scope:'full_system',recommendation:guidance},200,safe);
     try{
      if(env.ENDPOINT_CAPACITY_EVIDENCE.length>20000)throw Error('Invalid capacity evidence');
      const benchmark=readCapacityEvidence(JSON.parse(env.ENDPOINT_CAPACITY_EVIDENCE),now);
      return json({status:'reference',observedAt,benchmark,servingReleaseMatches:!!env.ENDPOINT_RELEASE_ID&&benchmark.releaseId===env.ENDPOINT_RELEASE_ID,recommendation:assessCapacity(benchmark,0).recommendation,scope:benchmark.measurementScope??'operator_reviewed_workload',productionCapacityVerified:false},200,safe);
     }catch{return json({status:'unavailable',observedAt,scope:'full_system',recommendation:guidance},200,safe);}
    }
    const snapshot=governanceRows('/api-execution-status',now,env.ENDPOINT_RELEASE_ID);
    // Include the new EMS reads from their live registration, without inventing IDs
    // or waiting for the next governed catalog export.
    const names=['id','route_path','http_method','endpoint_code','service_name','auth_required','permission_key','implementation_status','request_schema','response_schema'];
    const catalogStatement='SELECT '+names.map(name=>metadataValue('a',name)+' AS "'+name+'"').join(',')+` FROM "${pin.schema}"."govt_api_endpoints" a WHERE ${metadataValue('a','http_method')}='GET' AND ${metadataValue('a','route_path')}=ANY($1::text[])`;
    const registered=(await db.query(catalogStatement,[definition.operations.map(op=>op.path)])).rows;
    const byKey=new Map(snapshot.map(row=>[String(row.id)+' '+String(row.api),row]));
    const schemaPresent=(value:unknown)=>{if(typeof value!=='string'||value.length>1000000)return false;try{const schema=JSON.parse(value);return schema&&typeof schema==='object'&&!Array.isArray(schema)&&schema.type==='object';}catch{return false;}};
    for(const entry of registered){
     if(typeof entry.id!=='string'||!/^[1-9][0-9]*$/.test(entry.id)||!Number.isSafeInteger(Number(entry.id)))throw Error('Invalid EMS catalog identity');
     const contract=definition.operations.find(op=>op.path===entry.route_path);if(!contract)throw Error('Unexpected EMS catalog route');
     const missingContractFields=[];if(entry.permission_key!=='role_screen_permissions')missingContractFields.push('permission');if(!schemaPresent(entry.request_schema))missingContractFields.push('requestSchema');if(!schemaPresent(entry.response_schema))missingContractFields.push('responseSchema');
     const api='GET '+contract.path,key=entry.id+' '+api;
     const inconsistent=entry.endpoint_code!==contract.code||entry.service_name!=='governance'||entry.auth_required!=='1'||registered.filter(row=>row.route_path===entry.route_path).length!==1;
     const row={...byKey.get(key),id:Number(entry.id),api,method:'GET',route:contract.path,service:'governance',apps:['gv'],roles:['code_admin'],screens:[definition.screenCode],declaredImplementation:entry.implementation_status,verificationState:inconsistent?'blocked':'verification_pending',missingContractFields,registrationSource:'live_ems_metadata'};
     const management=endpointManagement(row,now,env.ENDPOINT_RELEASE_ID);byKey.set(key,{...row,management,productionVerified:Boolean(management.verificationEvidence)});
    }
    const rows=[...byKey.values()];
    if(operation.name==='summary'){
     const count=(field:string)=>rows.reduce<Record<string,number>>((result,row)=>{const key=String((row.management as Record<string,unknown>)[field]);result[key]=(result[key]??0)+1;return result;},{});
     return json({observedAt,scope:'registered_catalog',declarations:rows.length,uniqueOperations:new Set(rows.map(row=>row.api)).size,implementation:count('implementation'),protection:count('protection'),readiness:count('readiness'),maintenance:count('maintenance'),evidence:'Registration and release receipts; not a live probe of every operation.'},200,safe);
    }
    let data=filterGovernanceRows(rows,query);
    if(operation.name==='services')data=serviceVerificationSummary(data,now,env.ENDPOINT_RELEASE_ID);
    if(operation.name==='maintenance')data=data.filter(row=>{
     const management=row.management as Record<string,unknown>;return management.maintenance!=='unknown';
    });
    return json({data:data.slice(query.offset,query.offset+query.limit),pagination:{limit:query.limit,offset:query.offset,total:data.length,hasMore:query.offset+query.limit<data.length},source:{evidenceType:'registered_snapshot_and_live_ems_metadata'},observedAt,...(operation.name==='maintenance'?{trafficEnforced:false}:{})},200,safe);
   }finally{await db.query('ROLLBACK');}
  });
 }catch(error){return json({error:error instanceof Denied?error.message:'EMS unavailable'},error instanceof Denied?error.status:503,safe);}
}
