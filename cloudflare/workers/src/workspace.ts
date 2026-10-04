import registry from './workspace-registry.json';
import {json, withDb, tokenFrom, sha256, type Env} from './auth';
import type {Client} from 'pg';

export type Actor = {id:string;roles:string;tenant_id:string};
export function visiblePages(role:string) {
  return registry.screens.filter(s=>s.renderer!=='account' && s.grants.some(g=>g.role===role && g.view===1));
}
export function pageAccess(role:string,code:string) {
  const page=registry.screens.find(s=>s.code===code);
  return !page ? 404 : visiblePages(role).some(s=>s.code===code) ? 200 : 403;
}
const catalogPermissions = registry.permissions as Record<string,{inventory:boolean;organization:boolean}>;

export async function overview(db:Client,actor:Actor) {
  const organization=catalogPermissions[actor.roles]?.organization===true;
  const accounts=organization ? (await db.query(
    "SELECT roles AS role,COUNT(*)::int AS count FROM users WHERE tenant_id::text=$1 AND LOWER(status)='active' GROUP BY roles ORDER BY roles",[String(actor.tenant_id)])).rows : [{role:actor.roles,count:1}];
  const sessionCount=(await db.query(
    `SELECT COUNT(*)::int AS count FROM auth_sessions s JOIN users u ON u.id=s.user_id
     WHERE s.expires_at>NOW() AND LOWER(u.status)='active' AND ${organization ? 'u.tenant_id::text=$1' : 'u.id::text=$1'}`,
    [String(organization?actor.tenant_id:actor.id)])).rows[0].count;
  const activity=organization ? (await db.query(
    `SELECT action,created_at FROM auth_account_audit WHERE tenant_id::text=$1
     UNION ALL SELECT action,created_at FROM tenant_configuration_audit WHERE tenant_id=$1
     ORDER BY created_at DESC LIMIT 20`,[String(actor.tenant_id)])).rows : [];
  const metrics: {code:string;available:boolean;count?:number}[]=[];
  if(organization) {
    // Never read an unscoped table. Missing tenant bindings are unavailable,
    // rather than a fabricated zero or a global healthcare record count.
    for(const table of ['clients','providers','visits','invoices','schedules']) {
      const fields=(await db.query(`SELECT a.attname FROM pg_attribute a WHERE
        a.attrelid=to_regclass($1) AND a.attnum>0 AND NOT a.attisdropped`,[table])).rows.map(r=>r.attname);
      if(!fields.includes('tenant_id')) {metrics.push({code:table,available:false});continue;}
      const result=await db.query(`SELECT COUNT(*)::int AS count FROM "${table}" WHERE tenant_id::text=$1`,[String(actor.tenant_id)]);
      metrics.push({code:table,available:true,count:result.rows[0].count});
    }
  }
  return {activeAccounts:accounts.reduce((total,r)=>total+Number(r.count),0),activeSessions:sessionCount,
    accountRoles:accounts,activity,metrics,scope:organization?'organization':'personal'};
}

/** GET /v1/governance/workspace: active session, tenant validation and
 * database-governed grants; no mutation or synthetic business data. */
export async function workspace(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
  if(env.SERVICE_NAME!=='governance' || path!=='/workspace')return null;
  const safeHeaders=new Headers(headers);safeHeaders.set('cache-control','no-store');
  if(request.method!=='GET')return json({error:'Method not allowed'},405,safeHeaders);
  const token=request.headers.has('authorization')?tokenFrom(request):null;
  if(!token)return json({error:'No session'},401,safeHeaders);
  const code=new URL(request.url).searchParams.get('screen');
  if(code!==null && !/^[A-Za-z0-9_]{1,160}$/.test(code))return json({error:'Invalid screen code'},400,safeHeaders);
  try {
    if(env.WORKSPACE_SOURCE_LIMIT) {
      const source=request.headers.get('cf-connecting-ip')??'unknown';
      const allowed=await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('workspace:'+source)});
      if(!allowed.success){safeHeaders.set('retry-after','60');return json({error:'Too many workspace requests'},429,safeHeaders);}
    }
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try {
        const actor=(await db.query(`SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id
          WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1`,[await sha256(token)])).rows[0] as Actor|undefined;
        if(!actor)return json({error:'Invalid session'},401,safeHeaders);
        if(!actor.tenant_id || (request.headers.has('x-tenant-id') && request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safeHeaders);
        if(code) {const status=pageAccess(String(actor.roles),code);if(status!==200)return json({error:status===404?'Page not found':'Forbidden'},status,safeHeaders);}
        const screens=visiblePages(String(actor.roles));
        const inventory=(catalogPermissions[String(actor.roles)]?.inventory ? registry.screens : screens).map(
          ({id,code,name,route,appCode,role,renderer,lifecycle,productionReady,blockers,requirements,contracts,pendingActions})=>
          ({id,code,name,route,appCode,role,renderer,lifecycle,productionReady,blockers,requirements,contracts,pendingActions}));
        const data=await overview(db,actor);
        return json({identity:{userId:String(actor.id),role:String(actor.roles)},
          landing:(registry.landings as Record<string,string>)[String(actor.roles)],screens,
          screen:code?screens.find(s=>s.code===code):null,inventory,
          actions:registry.screens.filter(s=>s.code==='MAINTENANCE_CONFIGURATION' && s.grants.some(g=>g.role===String(actor.roles)&&g.view===1)),
          resources:registry.resources,overview:data,generatedFrom:'governance.db'},200,safeHeaders);
      } finally {await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Workspace unavailable'},503,safeHeaders);}
}
