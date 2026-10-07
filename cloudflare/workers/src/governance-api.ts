import {sourceLimitAllowed} from './source-limit-result';
import catalog from './governance-api-registry.json';
import execution from './api-execution-inventory.json';
import registry from './workspace-registry.json';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import {overview,visiblePages,workspaceRoleCounts,type Actor} from './workspace';

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
  if(path==='/api-execution-status')return execution.data;
  const gaps:Record<string,string>={'/api-missing-permissions':'permission','/api-missing-request-schemas':'requestSchema','/api-missing-response-schemas':'responseSchema','/api-unlinked-screens':'screenLink'};
  if(gaps[path])return execution.data.filter(row=>row.missingContractFields.includes(gaps[path]));
  if(path==='/api-verification-summary')return verificationSummary(execution.data);
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
  if(path==='/page-progress')return pageProgressSummary(pages);
  if(path==='/role-coverage')return roleCoverageRows();
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
/** Use the same operation scope for lists and counts. Aggregate only after filtering. */
export function filterGovernanceRows(rows:RecordRow[],query:Query):RecordRow[] {
  return rows.filter(row=>(!query.screen||row.screen===query.screen||(row.screens as string[]|undefined)?.includes(query.screen))&&(!query.app||row.app===query.app||(row.apps as string[]|undefined)?.includes(query.app))&&
    (!query.role||row.role===query.role||(row.roles as string[]|undefined)?.includes(query.role))&&
    (!query.search||JSON.stringify(row).toLowerCase().includes(query.search.toLowerCase())));
}
export function roleCoverageRows(scope:{app?:string;screen?:string}={}):RecordRow[] {
  return catalog.roles.map(role=>{
    const visible=visiblePages(role.code).filter(page=>(!scope.app||page.appCode===scope.app)&&(!scope.screen||page.code===scope.screen));
    return {role:role.code,name:role.name,landing:role.landing,authorizedPages:visible.length,
      landingAuthorized:visible.some(page=>page.route===role.landing)};
  });
}
export function pageProgressSummary(rows:RecordRow[]):RecordRow[] {
  return [...new Set(rows.map(row=>String(row.app)))].sort().map(app=>{
    const group=rows.filter(row=>row.app===app);
    return {app,total:group.length,created:group.filter(row=>row.lifecycle==='created').length,
      productionReady:group.filter(row=>row.productionReady===true).length,
      pagesWithBlockers:group.filter(row=>(row.blockers as unknown[]).length>0).length};
  });
}
export function verificationSummary(rows:RecordRow[]):RecordRow[] {
  const states=['blocked','unit_fixtures_recorded','verification_pending'];
  return states.flatMap(verificationState=>{
    const group=rows.filter(row=>row.verificationState===verificationState);
    if(!group.length)return [];
    return [{verificationState,operations:group.length,
      contractGaps:Object.fromEntries(['permission','requestSchema','responseSchema','screenLink'].map(field=>[field,group.filter(row=>(row.missingContractFields as string[]).includes(field)).length])),
      postgresVerified:false,productionVerified:false}];
  });
}
export function serviceVerificationSummary(rows:RecordRow[]):RecordRow[] {
 const services=['auth','client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting'];
 return [...services,'unassigned'].map(service=>{const group=rows.filter(row=>service==='unassigned'?!services.includes(String(row.service)):row.service===service);return {service,gatewayBound:service!=='unassigned',declaredOperations:group.length,verificationStates:Object.fromEntries(['blocked','unit_fixtures_recorded','verification_pending'].map(state=>[state,group.filter(row=>row.verificationState===state).length])),contractGaps:Object.fromEntries(['permission','requestSchema','responseSchema','screenLink'].map(field=>[field,group.filter(row=>(row.missingContractFields as string[]).includes(field)).length])),unmappedServiceLabels:[...new Set(group.map(row=>row.service))],evidenceScope:'registered_operation_metadata',postgresVerified:false,productionVerified:false};});
}
function paginate(rows:RecordRow[],query:Query,evidenceType:string) {
  const filtered=filterGovernanceRows(rows,query);
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
      if(!sourceLimitAllowed(await env.WORKSPACE_SOURCE_LIMIT.limit({key}))){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
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
          const counts=workspaceRoleCounts((await db.query("SELECT roles AS role,COUNT(*)::int AS count FROM users WHERE tenant_id::text=$1 AND LOWER(status)='active' GROUP BY roles ORDER BY roles",[String(actor.tenant_id)])).rows);
          const rows=catalog.hierarchy.map(r=>({...r,activeAccounts:counts.find(c=>c.role===r.role)?.count??0,inheritsPermissions:false}));
          return json(paginate(rows,query,'approved_reporting_and_live_tenant_counts'),200,safe);
        }
        if(path==='/role-coverage') {
          return json(paginate(roleCoverageRows(query),{...query,app:'',screen:''},'registered_governance'),200,safe);
        }
        if(path==='/page-progress') {
          const groups=pageProgressSummary(filterGovernanceRows(pageRows(),query));
          return json(paginate(groups,{...query,search:'',app:'',role:'',screen:''},'registered_governance'),200,safe);
        }
        if(path==='/api-service-status') {const groups=serviceVerificationSummary(filterGovernanceRows(execution.data,query));return json(paginate(groups,{...query,search:'',app:'',role:'',screen:''},'registered_governance'),200,safe);}
        if(path==='/api-verification-summary') {
          const groups=verificationSummary(filterGovernanceRows(execution.data,query));
          // Scope filters apply to operation records, not the aggregated group labels.
          return json(paginate(groups,{...query,search:'',app:'',role:'',screen:''},'registered_governance'),200,safe);
        }
        return json(paginate(governanceRows(path),query,'registered_governance'),200,safe);
      }finally {await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Governance data unavailable'},503,safe);}
}
