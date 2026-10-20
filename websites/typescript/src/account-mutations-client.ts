import {BaseSessionClient} from './infrastructure/http/base-session-client';
import catalog from '../../../packages/shared/src/account-mutations.json';
import type {AccountRow} from './tenant-accounts-client';
export class AccountMutationError extends Error{constructor(readonly status:number){super('account_mutation_failed');}}
export type CreatedAccount={id:string;email:string;roles:string;status:string;tenant_id:string};
export const creationActor=(role:string)=>Object.hasOwn(catalog.actors,role)?catalog.actors[role as keyof typeof catalog.actors]:null;
const object=(v:unknown):v is Record<string,unknown>=>v!==null&&typeof v==='object'&&!Array.isArray(v);
const keys=(v:Record<string,unknown>,expected:string[])=>Object.keys(v).length===expected.length&&expected.every(k=>Object.hasOwn(v,k));
const identifier=(v:unknown):v is string=>typeof v==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(v);
function user(value:unknown):value is CreatedAccount{return object(value)&&keys(value,['id','email','roles','status','tenant_id'])&&identifier(value.id)&&identifier(value.tenant_id)&&typeof value.email==='string'&&!!value.email&&typeof value.roles==='string'&&['active','inactive'].includes(String(value.status));}
/** Existing actor policies come from the production-generated catalogue; server is authoritative. */
export class AccountMutationsClient extends BaseSessionClient{
 protected readonly endpoint='';
 constructor(gateway:string,token:string,readonly actorRole:string){super(gateway.replace(/\/+$/,''),token);}
 protected accountChangedError(){return new AccountMutationError(409);}
 protected rejectResponse(response:Response,_v:unknown):never{throw new AccountMutationError(response.status);}
 async create(email:string,password:string,role:string):Promise<CreatedAccount>{
  email=email.trim().toLowerCase();const actor=creationActor(this.actorRole);
  if(!actor||!actor.targets.includes(role))throw new AccountMutationError(403);
  if(!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)||email.length>254||password.length<12||new TextEncoder().encode(password).length>72)throw new AccountMutationError(400);
  const v=await this.requestJson(catalog.operations.create.path,'POST',{email,password,role},201);
  if(!object(v)||!keys(v,['user'])||!user(v.user)||v.user.email!==email||v.user.roles!==role||v.user.status!=='active')throw new AccountMutationError(502);
  return v.user;
 }
 async save(target:AccountRow,role:string,status:string):Promise<CreatedAccount>{
  if(!catalog.operations.save.actors.includes(this.actorRole)||!target.canModify)throw new AccountMutationError(403);
  if(!identifier(target.id)||!catalog.actors.ceo.targets.includes(role)||!['active','inactive'].includes(status))throw new AccountMutationError(400);
  const v=await this.requestJson(catalog.operations.save.path,'POST',{id:target.id,role,status},200);
  if(!object(v)||!keys(v,['user'])||!user(v.user)||v.user.id!==target.id||v.user.email!==target.email||v.user.roles!==role||v.user.status!==status)throw new AccountMutationError(502);
  return v.user;
 }
 async revoke(target:AccountRow):Promise<number>{
  if(!catalog.operations.revoke.actors.includes(this.actorRole)||!target.canModify)throw new AccountMutationError(403);
  if(!identifier(target.id))throw new AccountMutationError(400);
  const v=await this.requestJson(catalog.operations.revoke.path.replace('{userId}',encodeURIComponent(target.id)),'DELETE',undefined,200);
  if(!object(v)||!keys(v,['userId','revokedSessions'])||v.userId!==target.id||typeof v.revokedSessions!=='number'||!Number.isSafeInteger(v.revokedSessions)||v.revokedSessions<0)throw new AccountMutationError(502);
  return v.revokedSessions;
 }
}
