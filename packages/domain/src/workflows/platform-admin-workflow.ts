import catalog from '../../../contracts/admin-master-categories.json';
import {BaseTenantWorkflow,WorkflowFailure,normalizeAccountFilters,validateUser,assignableRoles,type Actor,type UserInput} from './admin-workflow';
export const masterCategories:readonly string[]=catalog.categories;
export type MasterInput={tenantId:string|null;category:string;code:string;labels:Record<string,string>;status:string};
export interface PlatformAdminRepository {
 tenants(offset:number):Promise<Record<string,unknown>>;
 createTenant(actorId:string,name:string,slug:string):Promise<Record<string,unknown>>;
 accounts(tenantId:string,offset:number,search:string,status:string):Promise<Record<string,unknown>>;
 createAccount(actorId:string,tenantId:string,input:UserInput):Promise<Record<string,unknown>>;
 updateAccount(actorId:string,tenantId:string,id:string,input:UserInput):Promise<Record<string,unknown>>;
 masters(category:string,tenantId:string|null,offset:number):Promise<Record<string,unknown>>;
 createMaster(actorId:string,input:MasterInput):Promise<Record<string,unknown>>;
 updateMaster(actorId:string,id:string,labels:Record<string,string>,status:string):Promise<Record<string,unknown>>;
 monitor():Promise<Record<string,unknown>>;
 audit(offset:number):Promise<Record<string,unknown>>;
}
function fields(value:unknown,keys:string[]){
 if(!value||typeof value!=='object'||Array.isArray(value))throw new WorkflowFailure(400,'Invalid fields');
 const data=value as Record<string,unknown>;
 if(Object.keys(data).length!==keys.length||Object.keys(data).some(k=>!keys.includes(k)))throw new WorkflowFailure(400,'Invalid fields');
 return data;
}
function text(value:unknown,max:number){if(typeof value!=='string'||!value.trim()||value.trim().length>max||/[\u0000-\u001f\u007f]/.test(value))throw new WorkflowFailure(400,'Invalid text');return value.trim();}
function uuid(value:unknown){if(typeof value!=='string'||!/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value))throw new WorkflowFailure(400,'Invalid tenant or record');return value.toLowerCase();}
function labels(value:unknown){const data=fields(value,['en','es','fr']);return Object.fromEntries(['en','es','fr'].map(language=>[language,text(data[language],150)]));}
function status(value:unknown){if(value!=='active'&&value!=='inactive')throw new WorkflowFailure(400,'Invalid status');return value;}
/** Explicit user-defined policy: active role=admin has platform-wide control.
 * Legacy workspace operations remain tenant-bound. No client header grants scope. */
export class PlatformAdminWorkflow extends BaseTenantWorkflow {
 constructor(actor:Actor,private repository:PlatformAdminRepository){super(actor);}
 private check(offset=0){this.authorize('admin');if(!Number.isInteger(offset)||offset<0||offset>999999)throw new WorkflowFailure(400,'Invalid offset');}
 async tenants(offset:number){this.check(offset);return this.repository.tenants(offset);}
 async createTenant(value:unknown){this.check();const data=fields(value,['name','slug']),name=text(data.name,150),slug=text(data.slug,63);if(!/^[a-z0-9](?:[a-z0-9-]{1,61}[a-z0-9])$/.test(slug))throw new WorkflowFailure(400,'Invalid tenant slug');return {tenant:await this.repository.createTenant(this.actor.id,name,slug)};}
 async accounts(tenantId:string,offset:number,search:string='',status:string=''){this.check(offset);const filter=normalizeAccountFilters(search,status);return this.repository.accounts(uuid(tenantId),offset,filter.search,filter.status);}
 async createAccount(value:unknown){this.check();const data=fields(value,['tenantId','email','role','password']);const tenantId=uuid(data.tenantId),input=validateUser({email:data.email,role:data.role,password:data.password},true);return {user:await this.repository.createAccount(this.actor.id,tenantId,input)};}
 async updateAccount(id:string,value:unknown){this.check();const data=fields(value,['tenantId','email','role','status']);const tenantId=uuid(data.tenantId),input=validateUser({email:data.email,role:data.role,status:data.status},false);return {user:await this.repository.updateAccount(this.actor.id,tenantId,uuid(id),input)};}
 async masters(category:string,tenantId:string|null,offset:number){this.check(offset);if(!masterCategories.includes(category))throw new WorkflowFailure(400,'Unknown master category');return this.repository.masters(category,tenantId===null?null:uuid(tenantId),offset);}
 async createMaster(value:unknown){this.check();const data=fields(value,['tenantId','category','code','labels','status']);if(typeof data.category!=='string'||!masterCategories.includes(data.category))throw new WorkflowFailure(400,'Unknown master category');const code=text(data.code,64);if(!/^[a-z0-9][a-z0-9_-]*$/.test(code))throw new WorkflowFailure(400,'Invalid master code');return {record:await this.repository.createMaster(this.actor.id,{tenantId:data.tenantId===null?null:uuid(data.tenantId),category:data.category,code,labels:labels(data.labels),status:status(data.status)})};}
 async updateMaster(id:string,value:unknown){this.check();const data=fields(value,['labels','status']);return {record:await this.repository.updateMaster(this.actor.id,uuid(id),labels(data.labels),status(data.status))};}
 async monitor(){this.check();return {...await this.repository.monitor(),categories:masterCategories,assignableRoles};}
 async audit(offset:number){this.check(offset);return this.repository.audit(offset);}
}
