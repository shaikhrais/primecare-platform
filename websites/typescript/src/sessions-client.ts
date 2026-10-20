import {BaseSessionClient} from './infrastructure/http/base-session-client';
import policy from '../../../packages/shared/src/account-sessions.json';
export class SessionRequestError extends Error {constructor(readonly status:number){super('session_request_failed');}}
export type SessionRow={created_at:string;expires_at:string;current:boolean};
export type SessionPage={sessions:SessionRow[];pagination:{limit:number;offset:number;total:number;hasMore:boolean}};
const object=(v:unknown):v is Record<string,unknown>=>v!==null&&typeof v==='object'&&!Array.isArray(v);
const keys=(v:Record<string,unknown>,expected:string[])=>Object.keys(v).length===expected.length&&expected.every(k=>Object.hasOwn(v,k));
const integer=(v:unknown):v is number=>typeof v==='number'&&Number.isSafeInteger(v)&&v>=0;
const timestamp=(v:unknown):v is string=>typeof v==='string'&&/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$/.test(v)&&Number.isFinite(Date.parse(v))&&new Date(v).toISOString()===v;
/** Existing authenticated-self contract; no caller-selected user or tenant. */
export class SessionsClient extends BaseSessionClient {
 protected readonly endpoint=policy.endpoints.list;
 constructor(gateway:string,token:string){super(gateway.replace(/\/+$/,''),token);if(policy.endpoints.list!==policy.endpoints.revoke)throw new SessionRequestError(502);}
 protected accountChangedError(){return new SessionRequestError(409);}
 protected rejectResponse(response:Response,_value:unknown):never{throw new SessionRequestError(response.status);}
 async list(limit=25,offset=0):Promise<SessionPage>{
  if(!integer(limit)||limit<1||limit>100||!integer(offset)||offset>100000)throw new SessionRequestError(400);
  const value=await this.requestJson('?'+new URLSearchParams({limit:String(limit),offset:String(offset)}),'GET');
  if(!object(value)||!keys(value,['sessions','pagination'])||!Array.isArray(value.sessions)||!object(value.pagination))throw new SessionRequestError(502);
  const p=value.pagination;
  if(!keys(p,['limit','offset','total','hasMore'])||p.limit!==limit||p.offset!==offset||!integer(p.total)||p.hasMore!==(offset+limit<p.total)||value.sessions.length!==Math.min(limit,Math.max(0,p.total-offset)))throw new SessionRequestError(502);
  if(!value.sessions.every(row=>object(row)&&keys(row,['created_at','expires_at','current'])&&timestamp(row.created_at)&&timestamp(row.expires_at)&&typeof row.current==='boolean')||value.sessions.filter(row=>row.current).length>1)throw new SessionRequestError(502);
  return value as SessionPage;
 }
 async revokeAll():Promise<number>{
  const value=await this.requestJson('','DELETE');
  if(!object(value)||!keys(value,['status','revokedSessions'])||value.status!=='signed_out_all_devices'||!integer(value.revokedSessions))throw new SessionRequestError(502);
  return value.revokedSessions;
 }
}
