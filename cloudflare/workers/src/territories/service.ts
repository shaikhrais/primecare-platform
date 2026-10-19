import registry from '../../../../packages/shared/src/territories/registry.json';
import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from '../auth';
import {privilegedActor} from '../auth-projection';
import {optionalRow,requiredRow} from '../database-results';
import {canonical,keys,fail,GrowthFailure,text} from '../../../../packages/shared/src/growth/contract';
export const territoryAccess=(role:string)=>Object.hasOwn(registry.roles,role)?(registry.roles as Record<string,string>)[role]:undefined;
export function matchesCatalog(row:Record<string,unknown>):boolean{
 const approved=registry.catalog.find(c=>c.id===row.id);
 if(!approved)return false;
 return registry.allocationIntegrity.catalogFields.every(field=>canonical(row[field==='order'?'number':field])===canonical((approved as Record<string,unknown>)[field]));
}
/** Allocation state is computed here, never trusted from map colors or client roles. */
export async function territoryAdministration(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
 if(env.SERVICE_NAME!=='governance'||!path.startsWith('/platform/territories'))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try{
  const match=/^\/platform\/territories(?:\/(PC-REG-[TR]\d{4})\/sale)?$/.exec(path);if(!match)fail(404,'not_found');
  const id=match[1],read=!id&&request.method==='GET';if(!read&&!(id&&request.method==='POST'))fail(405,'method_not_allowed');
  if(new URL(request.url).search||request.headers.has('x-tenant-id'))fail(400);const token=tokenFrom(request);if(!token)fail(401,'unauthorized');
  let body:Record<string,unknown>={};if(!read){try{body=await parseBody(request);}catch(error){return bodyFailure(error,'invalid_request',safe);}keys(body,['version','tenantId','services','reference','confirmed']);
   if(body.version!==0||!text(body.tenantId,200)||!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(body.tenantId as string)||!text(body.reference,200)||(body.reference as string).trim().length<3||body.confirmed!==true||!Array.isArray(body.services)||body.services.length<1||body.services.length>2||new Set(body.services).size!==body.services.length||!body.services.every(s=>registry.services.includes(s)))fail(400);
  }else if(request.body)fail(400);
  const key=request.headers.get('idempotency-key');if(!read&&(!key||!/^[A-Za-z0-9_-]{16,100}$/.test(key)))fail(400);
  return await withDb(env,async db=>{
   const session=async(lock=false)=>privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active'"+(lock?' FOR SHARE OF u,s,t':' LIMIT 1'),[await sha256(token!)])).rows);
   const authorize=(a:ReturnType<typeof privilegedActor>)=>{if(!a)fail(401,'unauthorized');const access=territoryAccess(a.roles);if(!access||!read&&access!=='global')fail(403,'forbidden');return a;};let actor=authorize(await session());
   if(!read){const r=requiredRow((await db.query("INSERT INTO platform_administration_rate(actor_id,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(actor_id) DO UPDATE SET attempts=CASE WHEN platform_administration_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE platform_administration_rate.attempts+1 END,window_start=CASE WHEN platform_administration_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE platform_administration_rate.window_start END RETURNING attempts",[actor.id])).rows);if(Number(r.attempts)>30)fail(429,'rate_limited');}
   await db.query(read?'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY':'BEGIN');let committed=false;
   try{
    actor=authorize(await session(!read));const manage=territoryAccess(actor.roles)==='global';
    if(read){
     const rows=(await db.query(`SELECT c.*,s.tenant_id,s.services,s.reference,s.version,s.recorded_at,t.name AS tenant_name FROM platform_territory_catalog c LEFT JOIN platform_territory_sales s ON s.territory_id=c.id LEFT JOIN tenants t ON t.id=s.tenant_id ${manage?'':'WHERE s.tenant_id::text=$1'} ORDER BY c.number`,manage?[]:[actor.tenant_id])).rows;
     // Deployment must not silently display an incomplete or mismatched geographic catalog.
     if((manage&&rows.length!==registry.catalog.length)||rows.some((r:any)=>!matchesCatalog(r)))throw Error('Catalog migration missing or mismatched');
     const territories=rows.map((r:any)=>({id:r.id,number:r.number,code:r.code,name:r.name,fsas:r.fsas,seniors65:r.seniors65,population:r.population,status:r.is_reserve?'reserve':r.tenant_id?'sold':'available',version:r.version??0,canSell:manage&&!r.is_reserve&&!r.tenant_id,allocation:r.tenant_id?{tenantId:r.tenant_id,tenantName:r.tenant_name,services:r.services,reference:r.reference,recordedAt:r.recorded_at}:null}));
     const sum=(status:string)=>territories.filter((r:any)=>r.status===status).reduce((a:any,r:any)=>({count:a.count+1,seniors65:a.seniors65+r.seniors65}),{count:0,seniors65:0});
     return json({canManage:manage,source:registry.source,territories,tenants:manage?(await db.query("SELECT id,name,slug FROM tenants WHERE LOWER(status)='active' ORDER BY name,id")).rows:[],summary:{available:sum('available'),sold:sum('sold'),reserve:sum('reserve')}},200,safe);
    }
    const hash=await sha256(canonical({path,body}));await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['territory:'+actor.id+':'+key]);
    const replay=optionalRow((await db.query('SELECT request_hash,response,status FROM platform_administration_requests WHERE actor_id=$1 AND idempotency_key=$2',[actor.id,key])).rows);if(replay){if(replay.request_hash!==hash)fail(409,'conflict');return json(replay.response,Number(replay.status),safe);}
    if(!registry.catalog.some(c=>c.id===id))fail(404,'not_found');
    const area=optionalRow((await db.query('SELECT * FROM platform_territory_catalog WHERE id=$1 FOR UPDATE',[id])).rows);if(!area||!matchesCatalog(area))throw Error('Catalog migration missing or mismatched');if(area.is_reserve)fail(409,'reserve_not_for_sale');
    if(optionalRow((await db.query('SELECT territory_id FROM platform_territory_sales WHERE territory_id=$1',[id])).rows))fail(409,'territory_already_sold');
    const tenant=optionalRow((await db.query("SELECT id,name FROM tenants WHERE id::text=$1 AND LOWER(status)='active' FOR SHARE",[body.tenantId])).rows);if(!tenant)fail(409,'tenant_unavailable');
    const sale=requiredRow((await db.query('INSERT INTO platform_territory_sales(territory_id,tenant_id,actor_id,services,reference) VALUES($1,$2,$3,$4,$5) RETURNING territory_id,tenant_id,services,reference,version,recorded_at',[id,tenant.id,actor.id,body.services,(body.reference as string).trim()])).rows);
    if(sale.territory_id!==id||sale.tenant_id!==tenant.id||sale.version!==1)throw Error('Invalid sale result');
    await db.query("INSERT INTO platform_territory_audit(actor_id,tenant_id,territory_id,action,previous_state,current_state) VALUES($1,$2,$3,'territory_sold',$4,$5)",[actor.id,tenant.id,id,JSON.stringify({status:'available',version:0}),JSON.stringify({...sale,status:'sold'})]);
    const result={territoryId:id,status:'sold',version:1};await db.query('INSERT INTO platform_administration_requests(actor_id,idempotency_key,request_hash,response,status) VALUES($1,$2,$3,$4,201)',[actor.id,key,hash,JSON.stringify(result)]);await db.query('COMMIT');committed=true;return json(result,201,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){if(error instanceof GrowthFailure)return json({error:error.code},error.status,safe);if((error as {code?:string}).code==='23505')return json({error:'conflict'},409,safe);return json({error:'unavailable'},503,safe);}
}
