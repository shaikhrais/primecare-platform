import catalog from './governance-api-registry.json';
import registry from './workspace-registry.json';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import {overview,visiblePages,type Actor} from './workspace';

type RecordRow=Record<string,unknown>;
type Query={limit:number;offset:number;search:string;app:string;role:string;screen:string};
const permissions=registry.permissions as Record<string,{inventory:boolean;organization:boolean}>;

/** Strict bounded query parser; duplicate/unknown fields cannot bypass limits. */
export function parseGovernanceQuery(url:URL):Query|null {
  const allowed=['limit','offset','search','app','role','screen'];
  if([...url.searchParams.keys()].some(k=>!allowed.includes(k)||url.searchParams.getAll(k).length!==1))return null;
  const limit=url.searchParams.get('limit')??'25',offset=url.searchParams.get('offset')??'0';
  if(!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000)return null;
  const screen=url.searchParams.get('screen')??'';
  if(screen.length>200||/[\u0000-\u001f]/.test(screen))return null;
  const search=url.searchParams.get('search')??'',app=url.searchParams.get('app')??'',role=url.searchParams.get('role')??'';
  if(search.length>200||app.length>40||role.length>80||/[\u0000-\u001f]/.test(search+app+role))return null;
  return {limit:Number(limit),offset:Number(offset),search,app,role,screen};
}
const pageRows=()=>registry.screens.map(p=>({screen:p.code,name:p.name,app:p.appCode,role:p.role,route:p.route,
  lifecycle:p.lifecycle,productionReady:p.productionReady,blockers:p.blockers,pendingActions:p.pendingActions}));

/** Registered evidence only. No test timestamps or healthy flags are invented. */
export function governanceRows(path:string):RecordRow[] {
  const pages=pageRows();
  if(path==='/page-blueprints')return registry.screens.map(p=>({
    screen:p.code,name:p.name,app:p.appCode,role:p.role,route:p.route,
    requirements:p.requirements,sections:p.sections,permissions:p.grants,apis:p.contracts,
    pendingActions:p.pendingActions,blockers:p.blockers,productionReady:p.productionReady,
    buildSteps:[
      {step:'requirements',instruction:'Use registered business purpose, user story and acceptance criteria; resolve missing requirements first.'},
      {step:'layout',instruction:'Render registered sections and elements in catalog order using approved shared components and test identifiers.'},
      {step:'permissions',instruction:'Use registered screen grants for presentation; enforce endpoint permissions and tenant isolation in the backend. Screen access alone does not authorize an API.'},
      {step:'bindings',instruction:'Use registered element apiUsage and linked API schemas. Missing or ambiguous element-to-endpoint mappings require governance registration; do not infer a mapping.'},
      {step:'validation',instruction:'Validate inputs and responses against registered schemas; handle loading, empty, permission, validation and backend error states.'},
      {step:'verification',instruction:'Complete pending actions and blockers, API tests, authenticated browser and accessibility checks before marking the page ready.'}
    ],bindingEvidence:'registered_only',elementBindingsVerified:false
  }));
  if(path==='/screen-health')return pages;
  if(path==='/page-progress')return [...new Set(pages.map(p=>p.app))].sort().map(app=>{
    const group=pages.filter(p=>p.app===app);
    return {app,total:group.length,created:group.filter(p=>p.lifecycle==='created').length,
      productionReady:group.filter(p=>p.productionReady).length,pagesWithBlockers:group.filter(p=>p.blockers.length).length};
  });
  if(path==='/role-coverage')return catalog.roles.map(r=>{
    const visible=visiblePages(r.code);
    return {role:r.code,name:r.name,landing:r.landing,authorizedPages:visible.length,
      landingAuthorized:visible.some(p=>p.route===r.landing)};
  });
  if(path==='/pending-tasks')return pages.flatMap(p=>[
    ...p.blockers.map((blocker,i)=>({id:`${p.screen}:blocker:${i}`,screen:p.screen,name:p.name,app:p.app,role:p.role,route:p.route,kind:'blocker',description:blocker,status:'pending'})),
    ...p.pendingActions.map(a=>({id:`${p.screen}:action:${a.key}`,screen:p.screen,name:p.name,app:p.app,role:p.role,route:p.route,kind:'business_action',description:a.label||a.key,status:a.status})),
  ]);
  if(path==='/api-contracts') {
    const contracts=new Map<string,RecordRow>();
    for(const p of registry.screens)for(const c of p.contracts) {
      const key=c.method+' '+c.route;
      const item=contracts.get(key)??{api:key,method:c.method,route:c.route,implementation:c.implementation,
        permission:c.permission,schemasComplete:c.schemas===1,recordedHealth:c.health??'unverified',lastRecordedTest:c.lastTested,
        screens:[],apps:[],roles:[]};
      for(const [field,value] of [['screens',p.code],['apps',p.appCode],['roles',p.role]] as const) {
        const values=item[field] as string[];if(!values.includes(value))values.push(value);
      }
      contracts.set(key,item);
    }
    return [...contracts.values()].sort((a,b)=>String(a.api).localeCompare(String(b.api)));
  }
  return [];
}
function paginate(rows:RecordRow[],query:Query,evidenceType:string) {
  const filtered=rows.filter(row=>(!query.screen||row.screen===query.screen)&&(!query.app||row.app===query.app||(row.apps as string[]|undefined)?.includes(query.app))&&
    (!query.role||row.role===query.role||(row.roles as string[]|undefined)?.includes(query.role))&&
    (!query.search||JSON.stringify(row).toLowerCase().includes(query.search.toLowerCase())));
  return {data:filtered.slice(query.offset,query.offset+query.limit),
    pagination:{limit:query.limit,offset:query.offset,total:filtered.length,hasMore:query.offset+query.limit<filtered.length},
    source:{catalogVersion:catalog.version,evidenceType}};
}

/** Batched governance API: token and tenant checks precede metadata access.
 * Authorization derives from existing catalog authority or screen grants.
 * All reads use a read-only transaction and responses disable caching. */
export async function governanceApi(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
  if(env.SERVICE_NAME!=='governance')return null;
  const binding=catalog.bindings.find(b=>b.path===path);if(!binding)return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
  const token=request.headers.has('authorization')?tokenFrom(request):null;
  if(!token)return json({error:'No session'},401,safe);
  const query=parseGovernanceQuery(new URL(request.url));if(!query||request.body!==null)return json({error:'Invalid query'},400,safe);
  try {
    if(env.WORKSPACE_SOURCE_LIMIT) {
      const key=await sha256('governance-api:'+(request.headers.get('cf-connecting-ip')??'unknown'));
      if(!(await env.WORKSPACE_SOURCE_LIMIT.limit({key})).success){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    }
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try {
        const actor=(await db.query(`SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id
          WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1`,[await sha256(token)])).rows[0] as Actor|undefined;
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safe);
        const granted=binding.gate==='inventory'?permissions[actor.roles]?.inventory===true:
          binding.gate==='organization'?permissions[actor.roles]?.organization===true:
          visiblePages(actor.roles).some(p=>p.code===binding.screen);
        if(!granted)return json({error:'Forbidden'},403,safe);
        if(path==='/overview')return json(paginate([await overview(db,actor)],query,'live_tenant_data'),200,safe);
        if(path==='/organization-map') {
          const counts=(await db.query("SELECT roles AS role,COUNT(*)::int AS count FROM users WHERE tenant_id::text=$1 AND LOWER(status)='active' GROUP BY roles ORDER BY roles",[String(actor.tenant_id)])).rows;
          const rows=catalog.hierarchy.map(r=>({...r,activeAccounts:Number(counts.find(c=>c.role===r.role)?.count??0),inheritsPermissions:false}));
          return json(paginate(rows,query,'approved_reporting_and_live_tenant_counts'),200,safe);
        }
        return json(paginate(governanceRows(path),query,'registered_governance'),200,safe);
      }finally {await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Governance data unavailable'},503,safe);}
}
