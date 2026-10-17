import policy from '../../../packages/shared/src/tenant-operations.json';
import territoryPolicy from '../../../packages/shared/src/territories/registry.json';
import hierarchy from './admin-hierarchy.json';
import {matchesCatalog} from './territories/service';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import {privilegedActor} from './auth-projection';
import {accountId} from './account-read-projection';
import {requiredRow,resultRows} from './database-results';
import {sourceLimitAllowed} from './source-limit-result';
import {fail,GrowthFailure} from '../../../packages/shared/src/growth/contract';
export function operationsAccess(role:string):string|undefined{
 return Object.hasOwn(policy.roles,role)&&(hierarchy.permissions as Record<string,{view:boolean}>)[role]?.view?(policy.roles as Record<string,string>)[role]:undefined;
}
export function operationsQuery(url:URL){
 const query=url.searchParams;
 for(const key of query.keys())if(!['search','filter','offset'].includes(key)||query.getAll(key).length!==1)fail(400);
 const search=(query.get('search')??'').trim(),filter=query.get('filter')??'all',raw=query.get('offset')??'0';
 if(search.length>100||/[\u0000-\u001f\u007f]/.test(search)||!policy.filters.includes(filter)||!/^(0|[1-9]\d{0,5})$/.test(raw)||Number(raw)>policy.maxOffset)fail(400);
 return {search,filter,offset:Number(raw)};
}
const integer=(v:unknown)=>{if(typeof v!=='number'||!Number.isSafeInteger(v)||v<0)throw Error('Invalid aggregate');return v;};
// Separate lateral aggregates prevent account × reference × territory join multiplication.
const model=`WITH eligible AS (
 SELECT t.id,t.name,t.slug,LOWER(COALESCE(t.status,'')) AS status FROM tenants t
 WHERE ($2::text IS NULL OR t.id::text=$2) AND ($3::text='' OR POSITION(LOWER($3::text) IN LOWER(COALESCE(t.name,'')||' '||COALESCE(t.slug,'')))>0)
), measured AS (
 SELECT e.*,a.accounts,a.administrators,m.locations,m.categories,s.territories,s.seniors65 FROM eligible e
 CROSS JOIN LATERAL (SELECT COUNT(*) FILTER(WHERE LOWER(u.status)='active')::int AS accounts,
 COUNT(*) FILTER(WHERE LOWER(u.status)='active' AND u.roles=ANY($1::text[]))::int AS administrators FROM users u WHERE u.tenant_id=e.id) a
 CROSS JOIN LATERAL (SELECT COUNT(*) FILTER(WHERE m.type='location')::int AS locations,
 COUNT(*) FILTER(WHERE m.type='service_category')::int AS categories FROM platform_master_records m WHERE m.tenant_id=e.id AND LOWER(m.status)='active') m
 CROSS JOIN LATERAL (SELECT COUNT(*)::int AS territories,COALESCE(SUM(c.seniors65),0)::int AS seniors65 FROM platform_territory_sales s JOIN platform_territory_catalog c ON c.id=s.territory_id WHERE s.tenant_id=e.id) s
), classified AS (
 SELECT *,((status='active' AND (administrators<$5::int OR locations<$6::int OR categories<$7::int)) OR (status='inactive' AND territories>0) OR status NOT IN ('active','inactive')) AS attention FROM measured
), filtered AS (
 SELECT * FROM classified WHERE $4::text='all' OR ($4='attention' AND attention) OR ($4 IN ('active','inactive') AND status=$4)
)`;
/** Read-only monitor: role and tenant scope are derived from the active session. */
export async function tenantOperations(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||!path.startsWith('/platform/operations'))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  if(path!=='/platform/operations')fail(404,'not_found');if(request.method!=='GET'){safe.set('allow','GET');fail(405,'method_not_allowed');}
  if(request.body||request.headers.has('x-tenant-id'))fail(400);const query=operationsQuery(new URL(request.url)),token=tokenFrom(request);if(!token)fail(401,'unauthorized');
  if(env.WORKSPACE_SOURCE_LIMIT){
   const allowed=await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('tenant-operations:'+(request.headers.get('cf-connecting-ip')??'unknown'))});
   if(!sourceLimitAllowed(allowed)){safe.set('retry-after','60');fail(429,'rate_limited');}
  }
  return await withDb(env,async db=>{
   await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
   try{
    const actor=privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 1",[await sha256(token)])).rows);if(!actor)fail(401,'unauthorized');const scope=operationsAccess(actor.roles);if(!scope)fail(403,'forbidden');
    const catalog=resultRows((await db.query('SELECT * FROM platform_territory_catalog')).rows,territoryPolicy.catalog.length);if(catalog.length!==territoryPolicy.catalog.length||!catalog.every(matchesCatalog))throw Error('Catalog mismatch');
    const params=[policy.managementRoles,scope==='global'?null:actor.tenant_id,query.search,query.filter,...['administrators','locations','categories'].map(k=>policy.checks.find(c=>c.count===k)!.minimum)];
    const aggregate=requiredRow((await db.query(model+` SELECT COUNT(*)::int AS total,COUNT(*) FILTER(WHERE status='active')::int AS active,COUNT(*) FILTER(WHERE status='inactive')::int AS inactive,COUNT(*) FILTER(WHERE attention)::int AS attention,COALESCE(SUM(territories),0)::int AS territories,COALESCE(SUM(seniors65),0)::int AS seniors65 FROM filtered`,params)).rows);
    const summary=Object.fromEntries(Object.entries(aggregate).map(([k,v])=>[k,integer(v)]));
    const rows=resultRows((await db.query(model+' SELECT * FROM filtered ORDER BY LOWER(name),id LIMIT $8 OFFSET $9',[...params,policy.pageSize,query.offset])).rows,policy.pageSize);
    const tenants=rows.map(row=>{
     const id=accountId(row.id);if(typeof row.name!=='string'||typeof row.slug!=='string')throw Error('Invalid tenant projection');
     const counts=Object.fromEntries(['accounts','administrators','locations','categories','territories','seniors65'].map(k=>[k,integer(row[k])]));
     const checks=policy.checks.map(c=>({key:c.key,labelKey:c.labelKey,present:counts[c.count]>=c.minimum}));
     const issues=row.status==='active'?policy.checks.filter(c=>counts[c.count]<c.minimum).map(c=>c.issue):row.status==='inactive'?(counts.territories>0?['inactive_territory']:[]):['unknown_status'];
     return {id,name:row.name,slug:row.slug,status:['active','inactive'].includes(String(row.status))?row.status:'unknown',counts,checks,issues,actions:policy.destinations};
    });
    return json({scope,source:policy.source,tenants,summary,pagination:{limit:policy.pageSize,offset:query.offset,total:summary.total,hasMore:query.offset+tenants.length<summary.total}},200,safe);
   }finally{await db.query('ROLLBACK');}
  });
 }catch(error){if(error instanceof GrowthFailure)return json({error:error.code},error.status,safe);return json({error:'unavailable'},503,safe);}
}
