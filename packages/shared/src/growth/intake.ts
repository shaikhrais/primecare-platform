import {registry,GrowthPolicy,keys,text,uuid,integer,fail,leadBody,type Actor} from './contract';
export function canManageIntake(actor:Actor){const g=(registry.permissions as Record<string,{create:boolean;edit:boolean}>)[actor.roles];return !!g?.create&&!!g.edit&&registry.intakePolicy.managerRoles.includes(actor.roles)&&!GrowthPolicy.staff(actor);}
export function canReceiveEnquiry(role:string){const g=(registry.permissions as Record<string,{view:boolean}>)[role],staff=GrowthPolicy.staff({id:'',tenant_id:'',roles:role});return !!g?.view&&(!staff||staff.scope==='assigned');}
export function intakeLinkBody(v:Record<string,unknown>,patch=false):Record<string,unknown>{
 keys(v,patch?['active','version']:['name','pipeline','ownerId','campaignId','source','attribution','routingMode']);
 if(patch){if(typeof v.active!=='boolean'||integer(v.version,2147483646)<1)fail(400);}
 else if(!text(v.name,100)||!['client','tenant'].includes(String(v.pipeline))||!uuid(v.ownerId)||v.campaignId!==null&&!uuid(v.campaignId))fail(400);
 if(patch)return v;
 const source=String(v.source??'website'),attribution=v.attribution??'';
 if(!registry.intakePolicy.sources.includes(source)||!text(attribution,200,source==='website'))fail(400);
 const routingMode=v.routingMode??'direct';if(typeof routingMode!=='string'||!registry.intakePolicy.routingModes.includes(routingMode)||routingMode==='territory'&&v.pipeline!=='client')fail(400);
 return {...v,source,attribution:String(attribution).trim(),routingMode};
}
export function enquiryBody(v:Record<string,unknown>,routingMode='direct'){
 keys(v,['name','email','phone','consent','consentVersion','website',...(routingMode==='territory'?['postalCode','service','sharingConsent','sharingConsentVersion']:[])]);
 if(routingMode==='territory'&&(v.sharingConsent!==true||v.sharingConsentVersion!==registry.intakePolicy.sharingConsentVersion||typeof v.postalCode!=='string'||v.postalCode.length>7||! /^[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTVWXYZ] ?\d[ABCEGHJ-NPRSTVWXYZ]\d$/i.test(v.postalCode)||typeof v.service!=='string'||!['psw','home_care'].includes(v.service)))fail(400);
 if(typeof v.email!=='string'||typeof v.phone!=='string')fail(400);
 if(v.consent!==true||v.consentVersion!==registry.intakePolicy.consentVersion||v.website!=='')fail(400);
 const lead=leadBody({name:v.name,email:v.email,phone:v.phone,pipeline:'client',source:'website',reference:'Website enquiry',contactBasis:'requested',ownerId:null,campaignId:null,dueAt:null});
 if(!lead.email&&!lead.phone||lead.phone&&String(lead.phone).replace(/\D/g,'').length<5)fail(400);
 return {name:lead.name,email:lead.email,phone:lead.phone,consentVersion:String(v.consentVersion),...(routingMode==='territory'?{postalCode:String(v.postalCode).toUpperCase().replace(/ /g,''),service:String(v.service),sharingConsentVersion:String(v.sharingConsentVersion)}:{})};
}
