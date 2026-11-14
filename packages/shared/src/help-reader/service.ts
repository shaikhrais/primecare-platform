import pin from '../../../../tools/governance-production/production-pin.json';
import contract from '../../../../tools/governance-production/pc10-help-reader-contract.json';

import {HelpReadFailure,helpRequest,helpResponse,helpId as id,helpText as text,helpInteger as integer,type HelpActor as Actor} from './protocol';
export {HelpReadFailure} from './protocol';
type Database={query:(sql:string,values?:unknown[])=>Promise<{rows:any[]}>};
export type HelpReadEffects={
 /** Mandatory host adapters. This service supplies no quota amount, audit storage or permissive fallback. */
 consumeQuota:(actor:Actor,key:string)=>Promise<void>;
 auditRead:(actor:Actor,event:Readonly<{action:'list'|'read';locale:string;returned:number}>)=>Promise<void>;
 isCurrent:()=>boolean;
};
const table=(name:string)=>`"${pin.schema}"."${pin.tablePrefix}${name}"`;
const sessionSql=`SELECT u.id,u.roles,u.tenant_id FROM public.auth_sessions s JOIN public.users u ON u.id=s.user_id JOIN public.tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>CURRENT_TIMESTAMP AND lower(u.status)='active' AND lower(t.status)='active' FOR SHARE OF s,u,t`;
const published=`tenant_id=$1 AND locale=$2 AND publication_state='published' AND published_at<=CURRENT_TIMESTAMP`;
function article(row:any,detail:boolean){
 const revision=typeof row.revision==='string'&&/^[1-9][0-9]*$/.test(row.revision)?Number(row.revision):row.revision;
 if(!id(row.id)||!integer(revision,1,Number.MAX_SAFE_INTEGER)||!text(row.question,1,500)||!text(row.category,1,100)||!text(detail?row.answer:row.summary,detail?1:0,detail?5000:1000))throw new HelpReadFailure('unavailable',503);
 return Object.freeze({id:row.id,revision,title:row.question,category:row.category,...(detail?{body:row.answer}:{summary:row.summary})});
}
/** Unmounted registered API794 reader. A host must supply real quota/audit and captured-session adapters before exposure. */
export async function readPublishedHelp(db:Database,tokenHash:string,raw:unknown,effects:HelpReadEffects){
 const request=helpRequest(raw);
 if(typeof tokenHash!=='string'||!/^[0-9a-f]{64}$/.test(tokenHash))throw new HelpReadFailure('unauthenticated',401);
 if(!effects||typeof effects.consumeQuota!=='function'||typeof effects.auditRead!=='function'||typeof effects.isCurrent!=='function')throw new HelpReadFailure('unavailable',503);
 const current=()=>{if(effects.isCurrent()!==true)throw new HelpReadFailure('conflict',409);};
 let begun=false;
 try{
  current();await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ');begun=true;
  await db.query("SET LOCAL statement_timeout='15s'");await db.query("SET LOCAL lock_timeout='5s'");
  const authority=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
  if(authority.length!==1||authority[0].manifest_sha256!==pin.manifestSha256)throw new HelpReadFailure('unavailable',503);
  const actors=(await db.query(sessionSql,[tokenHash])).rows;current();
  if(actors.length!==1)throw new HelpReadFailure('unauthenticated',401);
  const a=actors[0];if(!id(a.id)||!id(a.tenant_id))throw new HelpReadFailure('unavailable',503);
  if(a.roles!=='psw')throw new HelpReadFailure('forbidden',403);
  const actor:Actor=Object.freeze({tenantId:a.tenant_id,userId:a.id,role:'psw',dataset:'live'});
  const endpoints=(await db.query('SELECT * FROM '+table('api_endpoints')+' WHERE id=794 FOR SHARE')).rows,e=endpoints[0];
  if(endpoints.length!==1||e.http_method!==contract.method||e.route_path!==contract.path||Number(e.auth_required)!==1||e.permission_key!==contract.permissionKey||e.rate_limit_key!==contract.rateLimitKey||e.service_name!==contract.service||e.implementation_status!=='implemented-unverified'||e.request_schema!==JSON.stringify(contract.requestSchema)||e.response_schema!==JSON.stringify(contract.responseSchema))throw new HelpReadFailure('unavailable',503);
  const roles=(await db.query('SELECT id FROM '+table('roles')+" WHERE id=51 AND role_code='psw' AND active=1 FOR SHARE")).rows;
  const grants=(await db.query('SELECT can_access,permission_key FROM '+table('api_permissions')+' WHERE api_id=794 AND role_id=51 AND permission_key=$1 FOR SHARE',[contract.permissionKey])).rows;
  if(roles.length!==1||grants.length!==1||Number(grants[0].can_access)!==1||grants[0].permission_key!==contract.permissionKey)throw new HelpReadFailure('forbidden',403);
  const screens=(await db.query('SELECT s.id FROM '+table('screens')+' s JOIN '+table('role_screen_permissions')+' p ON p.screen_id=s.id JOIN '+table('role_screen_map')+" m ON m.screen_id=s.id AND m.role_id=p.role_id WHERE s.id=685 AND s.screen_code='psw_help_support' AND s.route_path='/generated/psw-help-support' AND s.active=1 AND p.role_id=51 AND p.can_view=1 FOR SHARE OF s,p,m")).rows;
  const links=(await db.query('SELECT id,purpose FROM '+table('screen_api_links')+' WHERE screen_id=685 AND api_id=794 FOR SHARE')).rows;
  if(screens.length!==1||links.length!==1||links[0].purpose!==contract.linkPurpose)throw new HelpReadFailure('forbidden',403);
  current();await effects.consumeQuota(actor,contract.rateLimitKey);current();
  let response:any,returned:number;
  if(request.action==='read'){
   const rows=(await db.query('SELECT id,revision,question,category,answer FROM public.faqs WHERE '+published+' AND id=$3',[actor.tenantId,request.locale,request.articleId])).rows;
   if(!rows.length)throw new HelpReadFailure('not_found',404);
   if(rows.length!==1)throw new HelpReadFailure('unavailable',503);
   response={version:1,locale:request.locale,action:'read',scope:actor,article:article(rows[0],true)};returned=1;
  }else{
   // Bound literal search: %, _ and backslash have no wildcard meaning.
   const where=published+" AND (strpos(lower(question),lower($3))>0 OR strpos(lower(summary),lower($3))>0)";
   const counts=(await db.query('SELECT COUNT(*)::text AS total FROM public.faqs WHERE '+where,[actor.tenantId,request.locale,request.query])).rows;
   const total=counts.length===1&&typeof counts[0].total==='string'&&/^(0|[1-9][0-9]*)$/.test(counts[0].total)?Number(counts[0].total):NaN;
   if(!integer(total,0,Number.MAX_SAFE_INTEGER))throw new HelpReadFailure('unavailable',503);
   const rows=(await db.query('SELECT id,revision,question,category,summary FROM public.faqs WHERE '+where+' ORDER BY id LIMIT $4 OFFSET $5',[actor.tenantId,request.locale,request.query,request.limit,request.offset])).rows;
   if(rows.length>request.limit||rows.length>Math.max(0,total-request.offset))throw new HelpReadFailure('unavailable',503);
   const items=rows.map(row=>article(row,false));if(new Set(items.map(row=>row.id)).size!==items.length)throw new HelpReadFailure('unavailable',503);
   response={version:1,locale:request.locale,action:'list',scope:actor,items,offset:request.offset,limit:request.limit,total};returned=items.length;
  }
  current();await effects.auditRead(actor,Object.freeze({action:request.action,locale:request.locale,returned}));current();
  const result=helpResponse(response,request,actor);await db.query('COMMIT');begun=false;current();return result;
 }catch(error){
  let rollbackFailed=false;if(begun){try{await db.query('ROLLBACK');}catch{rollbackFailed=true;}}
  if(!rollbackFailed&&error instanceof HelpReadFailure)throw error;throw new HelpReadFailure('unavailable',503);
 }
}
