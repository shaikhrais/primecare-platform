import {date,fail,integer,keys,uuid} from './contract';
export type CampaignBrief={ownerId:string;audience:string;offer:string;creative:string;landingUrl:string;pipeline:'tenant'|'client';targetLeads:number;start:string;end:string;version:number};
const paragraph=(v:unknown,max:number):v is string=>typeof v==='string'&&v.length<=max&&v.trim().length>0&&!/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(v);
export function briefBody(v:Record<string,unknown>):CampaignBrief{
 keys(v,['ownerId','audience','offer','creative','landingUrl','pipeline','targetLeads','start','end','version']);
 if(!uuid(v.ownerId)||!paragraph(v.audience,1000)||!paragraph(v.offer,1000)||!paragraph(v.creative,3000)||!['tenant','client'].includes(String(v.pipeline)))fail(400);
 if(typeof v.landingUrl!=='string'||v.landingUrl.length>2000||/[\s\u007f]/.test(v.landingUrl))fail(400);
 if(v.landingUrl){let url:URL;try{url=new URL(String(v.landingUrl));}catch{fail(400);}if(url!.protocol!=='https:'||url!.username||url!.password||!url!.hostname)fail(400);}
 const start=date(v.start),end=date(v.end),days=(Date.parse(end)-Date.parse(start))/86400000;
 if(days<0||days>=366)fail(400);const targetLeads=integer(v.targetLeads,1000000);if(!targetLeads)fail(400);
 const version=integer(v.version,2147483647);
 return {ownerId:String(v.ownerId).toLowerCase(),audience:String(v.audience).trim(),offer:String(v.offer).trim(),creative:String(v.creative).trim(),landingUrl:String(v.landingUrl),pipeline:v.pipeline as 'tenant'|'client',targetLeads,start,end,version};
}
