import registry from './registry.json';
export {registry};
export type Pipeline='tenant'|'client';
export type Actor={id:string;roles:string;tenant_id:string};
export class GrowthFailure extends Error {constructor(readonly status:number,readonly code:string){super(code);}}
export const fail=(status:number,code='invalid_request'):never=>{throw new GrowthFailure(status,code);};
export const text=(v:unknown,max=150,empty=false):v is string=>typeof v==='string'&&v.length<=max&&(empty||v.trim().length>0)&&!/[\u0000-\u001f\u007f]/.test(v);
export function integer(v:unknown,max=100000000){if(typeof v!=='number'||!Number.isSafeInteger(v)||v<0||v>max)fail(400);return v as number;}
export function keys(v:Record<string,unknown>,allowed:string[]){if(Object.keys(v).some(k=>!allowed.includes(k)))fail(400);}
export const stages=(pipeline:Pipeline):string[]=>registry.pipelines[pipeline];
export function uuid(v:unknown):v is string{return typeof v==='string'&&/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(v);}
export function date(v:unknown){if(typeof v!=='string'||!/^\d{4}-\d{2}-\d{2}$/.test(v)||!Number.isFinite(Date.parse(v+'T00:00:00Z'))||new Date(v+'T00:00:00Z').toISOString().slice(0,10)!==v)fail(400);return v as string;}
export function timestamp(v:unknown,nullable=false):string|null {if(nullable&&(v===null||v===undefined))return null;if(typeof v!=='string'||!/^\d{4}-\d\d-\d\dT\d\d:\d\d(?::\d\d(?:\.\d{1,3})?)?Z$/.test(v)||!Number.isFinite(Date.parse(v)))fail(400);date((v as string).slice(0,10));return new Date(v as string).toISOString();}
export class GrowthPolicy {
 static read(actor:Actor){if(!actor.tenant_id||!registry.roles.includes(actor.roles))fail(403,'forbidden');}
 static staff(actor:Actor){return (registry.staffPolicies as Record<string,{scope:string;sources:string[];commands:string[]}>)[actor.roles];}
 static command(actor:Actor,method:string,entity?:string){GrowthPolicy.read(actor);const grant=(registry.permissions as Record<string,{view:boolean;create:boolean;edit:boolean}>)[actor.roles];const staff=GrowthPolicy.staff(actor);if(entity==='duplicates'&&!grant?.edit)fail(403,'forbidden');if(staff&&(!entity||!staff.commands.includes(entity+':'+method)))fail(403,'forbidden');if(!(method==='POST'?grant?.create:grant?.edit))fail(403,'forbidden');}
 static lead(actor:Actor,owner:unknown){const staff=GrowthPolicy.staff(actor);if(staff&&(staff.scope!=='assigned'||String(owner)!==actor.id))fail(404,'not_found');}
 static campaign(actor:Actor,source:unknown){const staff=GrowthPolicy.staff(actor);if(staff&&!staff.sources.includes(String(source)))fail(404,'not_found');}
 static canOwnCampaign(role:string,source:string){const grant=(registry.permissions as Record<string,{view:boolean;edit:boolean}>)[role];const staff=GrowthPolicy.staff({id:'',roles:role,tenant_id:''});return !!grant?.view&&!!grant?.edit&&(!staff||staff.scope==='campaigns'&&staff.sources.includes(source)&&staff.commands.includes('briefs:PUT'));}
 static capabilities(actor:Actor){const g=(registry.permissions as Record<string,{view:boolean;create:boolean;edit:boolean}>)[actor.roles],staff=GrowthPolicy.staff(actor);const can=(e:string,m:string)=>!!(m==='POST'?g.create:g.edit)&&(!staff||staff.commands.includes(e+':'+m));return {...g,manageCampaignMoney:GrowthPolicy.ownerAuthority(actor),manageTeam:registry.ownerPolicy.teamRoles.includes(actor.roles),viewLeads:!staff||staff.scope==='assigned',viewCampaigns:!staff||staff.scope==='campaigns',viewFunnels:!staff,createLead:can('leads','POST'),editLead:can('leads','PATCH'),editContact:can('contacts','PATCH'),manageDuplicates:!staff&&g.create&&g.edit,createCampaign:can('campaigns','POST'),editCampaign:can('campaigns','PATCH'),editBrief:can('briefs','PUT'),createTask:can('tasks','POST'),editTask:can('tasks','PATCH'),recordCall:can('calls','POST'),createAppointment:can('appointments','POST'),editAppointment:can('appointments','PATCH')};}
 static next(pipeline:Pipeline,stage:string){const order=stages(pipeline);return stage==='lost'?null:order[order.indexOf(stage)+1]??null;}
 static privilegedOperation(actor:Actor,method:string,entity:string|undefined,body:Record<string,unknown>){
  if(entity==='capacity'&&!GrowthPolicy.ownerAuthority(actor))fail(403,'forbidden');
  if(entity==='plan')GrowthPolicy.plan(actor);if(entity==='team')GrowthPolicy.team(actor);
  if(entity==='campaigns'&&!GrowthPolicy.ownerAuthority(actor)&&(method==='PATCH'||body.budgetCents!==0||body.spendCents!==0))fail(403,'forbidden');
  if(entity==='reviews'&&['approve','request_changes','reject'].includes(String(body.action))&&!GrowthPolicy.ownerAuthority(actor))fail(403,'forbidden');
  if(entity==='finance'&&!((registry.ownerPolicy.financeKinds as Record<string,string[]>)[actor.roles]??[]).includes(String(body.kind)))fail(403,'forbidden');
 }
 static ownerAuthority(actor:Actor){return !!actor.tenant_id&&registry.ownerPolicy.roles.includes(actor.roles)&&(registry.permissions as Record<string,{edit:boolean}>)[actor.roles]?.edit===true;}
 static team(actor:Actor){GrowthPolicy.read(actor);if(!registry.ownerPolicy.teamRoles.includes(actor.roles))fail(403,'forbidden');}
 static plan(actor:Actor){GrowthPolicy.read(actor);if(!registry.planRoles.includes(actor.roles))fail(403,'forbidden');}
}
export function planBody(v:Record<string,unknown>){
 keys(v,['start','end','targets','version']);const start=date(v.start),end=date(v.end),days=(Date.parse(end)-Date.parse(start))/86400000;
 if(days<0||days>=366)fail(400);
 if(!v.targets||typeof v.targets!=='object'||Array.isArray(v.targets))fail(400);
 const targets=v.targets as Record<string,unknown>;keys(targets,['tenant','client']);
 for(const pipeline of ['tenant','client'] as Pipeline[]){const counts=targets[pipeline];if(!Array.isArray(counts)||counts.length!==stages(pipeline).length)fail(400);for(let i=0;i<(counts as unknown[]).length;i++){integer((counts as unknown[])[i],1000000);if(i>0&&Number(counts[i])>Number(counts[i-1]))fail(400);}}
 return {start,end,targets,version:integer(v.version,2147483647)};
}
export function leadBody(v:Record<string,unknown>):Record<string,unknown>{
 keys(v,['pipeline','name','email','phone','source','reference','contactBasis','campaignId','ownerId','dueAt']);
 if(!['tenant','client'].includes(v.pipeline as string)||!text(v.name)||!text(v.reference,500)||!registry.sources.includes(v.source as string)||!['requested','business_prospect','not_requested'].includes(v.contactBasis as string))fail(400);
 const email=v.email??'',phone=v.phone??'';if(!text(email,254,true)||email&&!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email as string)||!text(phone,40,true)||phone&&!/^[+()\d .-]{5,40}$/.test(phone as string))fail(400);
 for(const field of ['campaignId','ownerId'])if(v[field]!=null&&!uuid(v[field]))fail(400);
 if(v.pipeline==='client'&&v.contactBasis==='business_prospect')fail(400);
 return {...v,name:(v.name as string).trim(),email:(email as string).trim().toLowerCase(),phone:(phone as string).trim(),dueAt:timestamp(v.dueAt,true)};
}
export function campaignBody(v:Record<string,unknown>,patch=false){keys(v,patch?['budgetCents','spendCents','version']:['name','source','reference','budgetCents','spendCents']);if(!patch&&(!text(v.name)||!text(v.reference,500)||!registry.sources.includes(v.source as string)))fail(400);integer(v.budgetCents);integer(v.spendCents);if(patch)integer(v.version,2147483647);return v;}
export function taskBody(v:Record<string,unknown>,patch=false){keys(v,patch?['version','evidence']:['name','ownerId','dueAt']);if(patch){integer(v.version,2147483647);if(!text(v.evidence,500))fail(400);}else{if(!text(v.name,200)||!uuid(v.ownerId))fail(400);timestamp(v.dueAt);}return v;}
export function patchLead(v:Record<string,unknown>){keys(v,['version','stage','ownerId','dueAt','evidence']);integer(v.version,2147483647);if(!('ownerId' in v)||!('dueAt' in v)||!text(v.evidence,500)||!text(v.stage,50)||v.ownerId!=null&&!uuid(v.ownerId))fail(400);timestamp(v.dueAt,true);return v;}

export function canonical(value:unknown):string {const sort=(v:any):any=>Array.isArray(v)?v.map(sort):v&&typeof v==='object'?Object.fromEntries(Object.keys(v).sort().map(k=>[k,sort(v[k])])):v;return JSON.stringify(sort(value));}

export function teamBody(v:Record<string,unknown>){keys(v,['specialty','version']);if(!registry.specialties.includes(v.specialty as string))fail(400);integer(v.version,2147483647);return v;}
export function callBody(v:Record<string,unknown>):Record<string,unknown>{
 keys(v,['leadId','leadVersion','outcome','notes','dueAt']);
 if(!uuid(v.leadId)||!registry.callOutcomes.includes(v.outcome as string)||!text(v.notes,500)||!('dueAt' in v))fail(400);
 integer(v.leadVersion,2147483647);if(v.leadVersion===0)fail(400);
 const dueAt=timestamp(v.dueAt,true);if(dueAt&&Date.parse(dueAt)<=Date.now()||v.outcome==='callback_requested'&&!dueAt)fail(400);
 if(['do_not_contact','wrong_number'].includes(v.outcome as string)&&dueAt)fail(400);
 return {...v,dueAt};
}
export function appointmentBody(v:Record<string,unknown>,patch=false){
 keys(v,patch?['version','status','notes']:['leadId','ownerId','startsAt','duration','notes']);
 if(!text(v.notes,500))fail(400);
 if(patch){integer(v.version,2147483647);if(v.version===0||!['completed','cancelled','no_show'].includes(v.status as string))fail(400);return v;}
 if(!uuid(v.leadId)||!uuid(v.ownerId))fail(400);const startsAt=timestamp(v.startsAt)!;
 if(Date.parse(startsAt)<=Date.now())fail(400);integer(v.duration,180);if(Number(v.duration)<15)fail(400);
 return {...v,startsAt,endsAt:new Date(Date.parse(startsAt)+Number(v.duration)*60000).toISOString()};
}
