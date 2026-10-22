import {tokenFrom,sha256} from '../session-token.ts';
import type {Actor} from './store.ts';

type SessionDatabase={query(sql:string,values:string[]):Promise<{rows:Record<string,unknown>[]}>};
export class CommunicationSessionError extends Error {
 readonly status:401|403;
 constructor(status:401|403){super('Communication session denied');this.status=status;}
}
/** Resolves identity from current native sessions; never accepts client roles or identity. */
export class PostgresCommunicationSession {
 readonly database:SessionDatabase;
 constructor(database:SessionDatabase){
  if(typeof database?.query!=='function')throw Error('Session database required');
  this.database=database;
 }
 async authenticate(request:Request):Promise<Actor>{
  // The shared browser transport sends bearer credentials. Cookie-only mutations
  // require a separately registered CSRF contract and are deliberately denied.
  const token=request.headers.has('authorization')?tokenFrom(request):null;
  if(!token)throw new CommunicationSessionError(401);
  const {rows}=await this.database.query(`SELECT u.id::text AS id,u.tenant_id::text AS tenant_id
   FROM auth_sessions s JOIN users u ON u.id=s.user_id
   WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 2`,[await sha256(token)]);
  if(!Array.isArray(rows)||rows.length!==1)throw new CommunicationSessionError(401);
  const {id,tenant_id}=rows[0];
  const valid=(value:unknown):value is string=>typeof value==='string'&&value.length<=200&&value.trim()===value&&value.length>0&&!/[\u0000-\u001f\u007f]/.test(value);
  if(!valid(id)||!valid(tenant_id))throw new CommunicationSessionError(401);
  if(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==tenant_id)throw new CommunicationSessionError(403);
  return Object.freeze({id,tenantId:tenant_id});
 }
}
