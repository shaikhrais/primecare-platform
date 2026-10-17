import {registry,keys,fail,text,uuid,integer,date,type Actor} from './contract';
export function canBusiness(actor:Actor){return !!(registry.permissions as Record<string,{view:boolean;create:boolean;edit:boolean}>)[actor.roles]?.view&&registry.businessPolicy.roles.includes(actor.roles);}
export function businessBody(entity:string,v:Record<string,unknown>,patch=false){
 if(entity==='onboarding'){
  keys(v,patch?['version','evidence']:['leadId','businessKind','identityChecked','agreementChecked','insuranceChecked','evidence']);
  if(!text(v.evidence,500))fail(400);
  if(patch){if(!integer(v.version,2147483646))fail(400);}
  else if(!uuid(v.leadId)||!registry.businessPolicy.businessKinds.includes(String(v.businessKind))||v.identityChecked!==true||v.agreementChecked!==true||v.insuranceChecked!==true)fail(400);
 }else if(entity==='handoffs'){
  keys(v,['leadId','visitId','evidence']);if(!uuid(v.leadId)||!uuid(v.visitId)||!text(v.evidence,500))fail(400);
 }else{
  keys(v,['kind','reference','amountCents','date','leadId','invoiceId','category','evidence']);
  if(!['invoice','payment','refund','expense'].includes(String(v.kind))||!text(v.reference,100)||!text(v.evidence,500)||!integer(v.amountCents,registry.businessPolicy.maxCents))fail(400);const day=date(v.date);if(day>new Date().toISOString().slice(0,10))fail(400);
  if(v.kind==='invoice'&&(!uuid(v.leadId)||v.invoiceId!==null||v.category!==null)||['payment','refund'].includes(String(v.kind))&&(v.leadId!==null||!uuid(v.invoiceId)||v.category!==null)||v.kind==='expense'&&(v.leadId!==null||v.invoiceId!==null||!registry.businessPolicy.expenseCategories.includes(String(v.category))))fail(400);
 }
 return v;
}
