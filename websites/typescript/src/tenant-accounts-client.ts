import {BaseSessionClient} from './infrastructure/http/base-session-client';
import catalog from '../../../packages/shared/src/tenant-account-reads.json';
export class TenantAccountError extends Error{constructor(readonly status:number){super('account_read_failed');}}
export type AccountRow={id:string;email:string;roles:string|null;status:string|null;updated_at:string|null;canModify:boolean};
export type PageInfo={limit:number;offset:number;total:number;hasMore:boolean};
export type AccountPage={users:AccountRow[];assignableRoles:string[];pagination:PageInfo};
export type ReadMode='details'|'sessions'|'managementAudit'|'creationAudit';
export type ReadView={rows:Record<string,unknown>[];pagination:PageInfo|null};
const object=(v:unknown):v is Record<string,unknown>=>v!==null&&typeof v==='object'&&!Array.isArray(v);
const keys=(v:Record<string,unknown>,k:string[])=>Object.keys(v).length===k.length&&k.every(x=>Object.hasOwn(v,x));
const integer=(v:unknown):v is number=>typeof v==='number'&&Number.isSafeInteger(v)&&v>=0;
const identifier=(v:unknown):v is string=>typeof v==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(v);
const timestamp=(v:unknown)=>typeof v==='string'&&/^\d{4}-\d{2}-\d{2}T/.test(v)&&Number.isFinite(Date.parse(v));
function account(v:unknown,nullable=false):v is AccountRow{
 return object(v)&&keys(v,['id','email','roles','status','updated_at','canModify'])&&identifier(v.id)&&typeof v.email==='string'&&!!v.email&&(typeof v.roles==='string'||nullable&&v.roles===null)&&(typeof v.status==='string'||nullable&&v.status===null)&&(v.updated_at===null||timestamp(v.updated_at))&&typeof v.canModify==='boolean';
}
function page(v:unknown,limit:number,offset:number,length:number):PageInfo{
 if(!object(v)||!keys(v,['limit','offset','total','hasMore'])||v.limit!==limit||v.offset!==offset||!integer(v.total)||v.hasMore!==(offset+limit<v.total)||length!==Math.min(limit,Math.max(0,v.total-offset)))throw new TenantAccountError(502);
 return v as PageInfo;
}
const roles=(v:unknown):v is string[]=>Array.isArray(v)&&v.every(x=>typeof x==='string'&&!!x)&&new Set(v).size===v.length;
const safeState=(v:unknown)=>object(v)&&keys(v,['role','status','sessionCount'])&&(v.role===null||typeof v.role==='string')&&(v.status===null||v.status==='active'||v.status==='inactive')&&(v.sessionCount===null||integer(v.sessionCount));
/** Existing CEO same-tenant GET contracts. All URLs are generated from registered API paths. */
export class TenantAccountsClient extends BaseSessionClient{
 protected readonly endpoint='';
 constructor(gateway:string,token:string){super(gateway.replace(/\/+$/,''),token);}
 protected accountChangedError(){return new TenantAccountError(409);}
 protected rejectResponse(response:Response,_v:unknown):never{throw new TenantAccountError(response.status);}
 async list(search='',offset=0,limit=25):Promise<AccountPage>{
  if(search.length>200||!integer(offset)||offset>100000||!integer(limit)||limit<1||limit>100)throw new TenantAccountError(400);
  const value=await this.requestJson(catalog.operations.list.path+'?'+new URLSearchParams({search,limit:String(limit),offset:String(offset)}),'GET');
  if(!object(value)||!keys(value,['users','assignableRoles','pagination'])||!Array.isArray(value.users)||!value.users.every(v=>account(v))||!roles(value.assignableRoles)||new Set(value.users.map(x=>x.id)).size!==value.users.length)throw new TenantAccountError(502);
  return {...value,pagination:page(value.pagination,limit,offset,value.users.length)} as AccountPage;
 }
 async read(mode:ReadMode,userId:string,offset=0,limit=25):Promise<ReadView>{
  if(!identifier(userId)||!integer(offset)||offset>100000||!integer(limit)||limit<1||limit>100||!['details','sessions','managementAudit','creationAudit'].includes(mode))throw new TenantAccountError(400);
  let path=catalog.operations[mode].path.replace('{userId}',encodeURIComponent(userId));
  if(mode!=='details')path+='?'+new URLSearchParams({limit:String(limit),offset:String(offset),...(['managementAudit','creationAudit'].includes(mode)?{userId}:{})});
  const value=await this.requestJson(path,'GET');
  if(!object(value))throw new TenantAccountError(502);
  if(mode==='details'){
   if(!keys(value,['user','assignableRoles'])||!account(value.user,true)||value.user.id!==userId||!roles(value.assignableRoles))throw new TenantAccountError(502);
   return {rows:[value.user],pagination:null};
  }
  if(mode==='sessions'){
   if(!keys(value,['userId','sessions','pagination'])||value.userId!==userId||!Array.isArray(value.sessions)||!value.sessions.every(s=>object(s)&&keys(s,['created_at','expires_at'])&&timestamp(s.created_at)&&timestamp(s.expires_at)))throw new TenantAccountError(502);
   return {rows:value.sessions,pagination:page(value.pagination,limit,offset,value.sessions.length)};
  }
  if(!keys(value,['events','pagination'])||!Array.isArray(value.events)||!value.events.every(e=>object(e)&&keys(e,mode==='creationAudit'?['id','actorUserId','targetUserId','created_at','action']:['id','actorUserId','targetUserId','created_at','action','previous','current'])&&identifier(e.id)&&identifier(e.actorUserId)&&e.targetUserId===userId&&timestamp(e.created_at)&&(mode==='creationAudit'?e.action==='account_created':['sessions_revoked','account_updated'].includes(String(e.action))&&safeState(e.previous)&&safeState(e.current))))throw new TenantAccountError(502);
  return {rows:value.events,pagination:page(value.pagination,limit,offset,value.events.length)};
 }
}
