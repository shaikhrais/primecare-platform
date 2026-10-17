import {registry,GrowthPolicy,date,keys,fail,text,integer,type Actor} from './contract';
export function canReport(actor:Actor,email=false){const g=(registry.permissions as Record<string,{view:boolean;create:boolean}>)[actor.roles];return !!g?.view&&(!email||!!g.create)&&!GrowthPolicy.staff(actor)&&(email?registry.reportPolicy.emailRoles:registry.reportPolicy.roles).includes(actor.roles);}
export function reportOptions(v:Record<string,unknown>,email=false){
 keys(v,email?['start','end','locale','to','confirmed']:['start','end','locale']);
 const now=new Date(),start=date(v.start??new Date(Date.UTC(now.getUTCFullYear(),now.getUTCMonth(),1)).toISOString().slice(0,10)),end=date(v.end??new Date(Date.UTC(now.getUTCFullYear(),now.getUTCMonth()+1,0)).toISOString().slice(0,10)),locale=v.locale??'en';
 if(Date.parse(end)<Date.parse(start)||(Date.parse(end)-Date.parse(start))/86400000>registry.reportPolicy.maxDays||!['en','fr','es'].includes(String(locale)))fail(400);
 if(email&&(v.confirmed!==true||!text(v.to,254)||! /^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$/.test(String(v.to))))fail(400);
 return {start,end,locale:locale as 'en'|'fr'|'es',...(email?{to:String(v.to).trim()}: {})};
}

export function deliveryResolution(v:Record<string,unknown>){keys(v,['version','decision','evidence']);const version=integer(v.version,2147483646);if(!version||!['accepted','not_sent'].includes(String(v.decision))||!text(v.evidence,500))fail(400);return {version,decision:String(v.decision),evidence:String(v.evidence).trim()};}
