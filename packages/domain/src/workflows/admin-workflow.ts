export const assignableRoles = ['client','employee','psw','rn','rpn','rmt','physio','scheduler','customer_support','intake'] as const;
export type Actor = {id:string; roles:string; tenant_id:string};
export class WorkflowFailure extends Error {
  constructor(public status:number, message:string){super(message);}
}
export abstract class BaseTenantWorkflow {
  constructor(protected actor:Actor){}
  protected authorize(role:string){
    if(this.actor.roles!==role || !this.actor.tenant_id)throw new WorkflowFailure(403,'Forbidden');
  }
}
export interface AdminRepository {
  audit(offset:number):Promise<{events:Record<string,unknown>[];total:number;offset:number;limit:number}>;
  organization():Promise<Record<string,unknown>>;
  users(offset:number):Promise<{users:Record<string,unknown>[];total:number;active:number;offset:number;limit:number}>;
  lockedAccount(id:string):Promise<{id:string;role:string}|null>;
  create(actorId:string,input:UserInput):Promise<Record<string,unknown>>;
  update(actorId:string,id:string,input:UserInput):Promise<Record<string,unknown>>;
}
export type UserInput={email:string;role:string;status?:string;password?:string};
export function validateUser(value:unknown,create:boolean):UserInput {
  if(!value||typeof value!=='object'||Array.isArray(value))throw new WorkflowFailure(400,'Invalid account fields');
  const v=value as Record<string,unknown>, keys=create?['email','role','password']:['email','role','status'];
  if(Object.keys(v).length!==3||Object.keys(v).some(k=>!keys.includes(k)))throw new WorkflowFailure(400,'Invalid account fields');
  const email=typeof v.email==='string'?v.email.trim().toLowerCase():'';
  if(email.length>254||! /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)||typeof v.role!=='string'||!assignableRoles.includes(v.role as typeof assignableRoles[number]))throw new WorkflowFailure(400,'Invalid email or role');
  if(create){
    if(typeof v.password!=='string'||v.password.length<12||new TextEncoder().encode(v.password).length>72)throw new WorkflowFailure(400,'Use a password of at least 12 characters and at most 72 UTF-8 bytes');
    return {email,role:v.role,password:v.password};
  }
  if(!['active','inactive'].includes(String(v.status)))throw new WorkflowFailure(400,'Invalid status');
  return {email,role:v.role,status:String(v.status)};
}
/** Business rules are independent of HTTP and UI. The caller owns the transaction. */
export class AdminWorkflow extends BaseTenantWorkflow {
  constructor(actor:Actor,private repository:AdminRepository){super(actor);}
  async read(offset:number){this.authorize('admin');if(!Number.isInteger(offset)||offset<0||offset>999999)throw new WorkflowFailure(400,'Invalid offset');return {organization:await this.repository.organization(),...await this.repository.users(offset),assignableRoles};}
  async readAudit(offset:number){this.authorize('admin');if(!Number.isInteger(offset)||offset<0||offset>999999)throw new WorkflowFailure(400,'Invalid offset');return this.repository.audit(offset);}
  async create(value:unknown){this.authorize('admin');return {user:await this.repository.create(this.actor.id,validateUser(value,true))};}
  async update(id:string,value:unknown){this.authorize('admin');if(id===this.actor.id)throw new WorkflowFailure(403,'Protected account');const input=validateUser(value,false);const target=await this.repository.lockedAccount(id);if(!target)throw new WorkflowFailure(404,'Account not found');if(!assignableRoles.includes(target.role as typeof assignableRoles[number]))throw new WorkflowFailure(403,'Protected account');return {user:await this.repository.update(this.actor.id,id,input)};}
}
