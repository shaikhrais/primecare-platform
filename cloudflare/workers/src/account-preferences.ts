import {withDb,parseBody,bodyFailure,json,sha256,type Env} from './auth';
import pin from '../../../tools/governance-production/production-pin.json';
import contract from '../../../tools/governance-production/preference-sync-contract.json';
import {PreferenceFailure,preferenceRequest,preferenceScope,samePreferenceScope,canonicalPreference,type PreferenceSnapshot,type PreferenceScope} from '../../../packages/domain/src/preference_sync';
const table=(name:string)=>`"${pin.schema}"."${pin.tablePrefix}${name}"`;
const actorSql=`SELECT u.id,u.roles,u.tenant_id FROM public.auth_sessions s JOIN public.users u ON u.id=s.user_id JOIN public.tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND lower(u.status)='active' AND lower(t.status)='active' FOR SHARE OF u,s,t`;
async function quota(db:any,key:string,write:boolean,limit:number){
 const r=await db.query(`INSERT INTO public.account_preference_rate(key,bucket,reads,writes) VALUES($1,date_trunc('minute',clock_timestamp()),$2,$3) ON CONFLICT(key) DO UPDATE SET bucket=EXCLUDED.bucket,reads=CASE WHEN account_preference_rate.bucket=EXCLUDED.bucket THEN account_preference_rate.reads ELSE 0 END+EXCLUDED.reads,writes=CASE WHEN account_preference_rate.bucket=EXCLUDED.bucket THEN account_preference_rate.writes ELSE 0 END+EXCLUDED.writes RETURNING reads,writes`,[key,write?0:1,write?1:0]);
 if(Number(r.rows[0][write?'writes':'reads'])>limit)throw new PreferenceFailure('rate_limited',429);
}
/** Registered API 777. Off until an explicit reviewed runtime activation and metadata promotion. */
export async function accountPreferences(request:Request,env:Env & {PREFERENCE_SYNC_ENABLED?:string},path:string,headers:HeadersInit={}):Promise<Response|null>{
 if(env.SERVICE_NAME!=='auth'||path!=='/user/preferences')return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('content-type','application/json');
 if(request.method!=='POST'){safe.set('allow','POST');return json({error:'method_not_allowed'},405,safe);}
 if(env.PREFERENCE_SYNC_ENABLED!=='1')return json({error:'preference_sync_disabled'},503,safe);
 const authorization=request.headers.get('authorization');
 if(!authorization||!/^Bearer [A-Za-z0-9_-]{43}$/.test(authorization))return json({error:'unauthenticated'},401,safe);
 if(new URL(request.url).search||request.headers.has('x-tenant-id'))return json({error:'scope_override_forbidden'},400,safe);
 let raw:any;try{raw=await parseBody(request,73728);}catch(e){return bodyFailure(e,'invalid_request',safe);}
 try{return await withDb(env,async db=>{
  // Autocommit quotas survive rejected preference transactions. Only hashes are retained.
  await db.query("DELETE FROM public.account_preference_rate WHERE bucket<clock_timestamp()-interval '2 minutes'");
  await quota(db,await sha256('preferences:source:'+ (request.headers.get('cf-connecting-ip')??'unknown')),false,300);
  const tokenHash=await sha256(authorization.slice(7));
  const first=(await db.query(actorSql,[tokenHash])).rows;
  if(first.length!==1)throw new PreferenceFailure('unauthenticated',401);
  await quota(db,await sha256('preferences:account:'+first[0].id),raw?.action!=='read',raw?.action==='read'?120:30);
  await db.query('BEGIN');
  try{
   await db.query("SET LOCAL lock_timeout='5s'");await db.query("SET LOCAL statement_timeout='15s'");
   const actors=(await db.query(actorSql,[tokenHash])).rows;
   if(actors.length!==1)throw new PreferenceFailure('unauthenticated',401);
   const a=actors[0];if(a.id!==first[0].id)throw new PreferenceFailure('scope_changed',409);
   const scope=preferenceScope({tenantId:a.tenant_id,userId:a.id,role:a.roles,dataset:raw?.dataset});
   if(!samePreferenceScope(scope,preferenceScope(raw?.expectedScope)))throw new PreferenceFailure('scope_changed',409);
   const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
   if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw new PreferenceFailure('authority_unavailable',503);
   const endpoints=(await db.query('SELECT * FROM '+table('api_endpoints')+' WHERE id=777 FOR SHARE')).rows,e=endpoints[0];
   if(endpoints.length!==1||e.http_method!=='POST'||e.route_path!==contract.path||Number(e.auth_required)!==1||e.permission_key!==contract.permissionKey||e.service_name!=='auth'||e.rate_limit_key!==contract.rateLimitKey||e.implementation_status!=='implemented-unverified'||e.request_schema!==JSON.stringify(contract.requestSchema)||e.response_schema!==JSON.stringify(contract.responseSchema))throw new PreferenceFailure('contract_unavailable',503);
   const roles=(await db.query('SELECT id FROM '+table('roles')+' WHERE lower(role_code)=lower($1) AND active=1 FOR SHARE',[a.roles])).rows;
   if(roles.length!==1)throw new PreferenceFailure('forbidden',403);
   const grants=(await db.query('SELECT can_access,permission_key FROM '+table('api_permissions')+' WHERE api_id=777 AND role_id=$1 FOR SHARE',[roles[0].id])).rows;
   if(grants.length!==1||Number(grants[0].can_access)!==1||grants[0].permission_key!==contract.permissionKey)throw new PreferenceFailure('forbidden',403);
   const screens=(await db.query('SELECT s.id,s.screen_code FROM '+table('screens')+' s JOIN '+table('role_screen_permissions')+' p ON p.screen_id=s.id WHERE p.role_id=$1 AND p.can_view=1 AND s.active=1 FOR SHARE OF s,p',[roles[0].id])).rows;
   // No panel binding has been registered for API 777. Never infer permission from a DOM ID.
   const input=preferenceRequest(raw,{panelIds:[],screenIds:screens.map(s=>String(s.id))});
   if(input.kind==='workspace'&&!screens.some(s=>s.screen_code===input.resource))throw new PreferenceFailure('forbidden',403);
   const owner=[scope.tenantId,scope.userId,scope.role,scope.dataset],key=[...owner,input.kind,input.resource];
   // Actor lock serializes receipts across resources, including first-write races.
   await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[canonicalPreference(owner)]);
   const rows=(await db.query('SELECT revision,document FROM public.account_preference_documents WHERE tenant_id=$1 AND user_id=$2 AND actor_role=$3 AND dataset=$4 AND kind=$5 AND resource=$6 FOR UPDATE',key)).rows;
   const current:PreferenceSnapshot={version:1,scope,kind:input.kind,resource:input.resource,revision:rows.length?Number(rows[0].revision):0,document:rows.length?rows[0].document:null};
   if(input.action==='read'){await db.query('COMMIT');return json(current,200,safe);}
   await db.query("DELETE FROM public.account_preference_requests WHERE created_at<clock_timestamp()-interval '24 hours'");
   const fingerprint=await sha256(canonicalPreference(input));
   const receipts=(await db.query('SELECT fingerprint,response FROM public.account_preference_requests WHERE tenant_id=$1 AND user_id=$2 AND actor_role=$3 AND dataset=$4 AND request_id=$5',[...owner,input.requestId])).rows;
   if(receipts.length){if(receipts[0].fingerprint!==fingerprint)throw new PreferenceFailure('request_id_reused',409);await db.query('COMMIT');return json(receipts[0].response,200,safe);}
   const audit=async(action:string,revision:number,document:unknown)=>db.query('INSERT INTO public.account_preference_audit(id,tenant_id,user_id,actor_role,dataset,kind,resource,request_id,action,revision,document_digest) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)',[crypto.randomUUID(),...key,input.requestId,action,revision,await sha256(canonicalPreference(document))]);
   if(input.revision!==current.revision){await audit('conflict',current.revision,current.document);await db.query('COMMIT');return json({error:'revision_conflict',current},409,safe);}
   const next={...current,revision:current.revision+1,document:input.action==='write'?input.document!:null};
   await db.query('INSERT INTO public.account_preference_documents(tenant_id,user_id,actor_role,dataset,kind,resource,revision,document) VALUES($1,$2,$3,$4,$5,$6,$7,$8) ON CONFLICT(tenant_id,user_id,actor_role,dataset,kind,resource) DO UPDATE SET revision=EXCLUDED.revision,document=EXCLUDED.document,updated_at=clock_timestamp()',[...key,next.revision,next.document===null?null:JSON.stringify(next.document)]);
   await audit(input.action,next.revision,next.document);
   await db.query('INSERT INTO public.account_preference_requests(tenant_id,user_id,actor_role,dataset,request_id,fingerprint,response) VALUES($1,$2,$3,$4,$5,$6,$7)',[...owner,input.requestId,fingerprint,JSON.stringify(next)]);
   await db.query('DELETE FROM public.account_preference_requests WHERE (tenant_id,user_id,actor_role,dataset,request_id) IN (SELECT tenant_id,user_id,actor_role,dataset,request_id FROM public.account_preference_requests WHERE tenant_id=$1 AND user_id=$2 AND actor_role=$3 AND dataset=$4 ORDER BY created_at DESC,request_id DESC OFFSET 100)',owner);
   await db.query('COMMIT');return json(next,200,safe);
  }catch(e){await db.query('ROLLBACK');throw e;}
 });}catch(e){if(e instanceof PreferenceFailure){if(e.status===429)safe.set('retry-after','60');return json({error:e.code},e.status||400,safe);}return json({error:'preferences_unavailable'},503,safe);}
}
