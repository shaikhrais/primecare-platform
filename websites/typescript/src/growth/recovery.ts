export const growthScope=(data:any)=>JSON.stringify([data?.identity?.userId,data?.identity?.tenantId,data?.identity?.role]);
export type GrowthReceipt={scope:string;control:string;path:string;method:string;body:any;result:any;accepted:boolean;before:any;drafts:Map<string,Record<string,string>>};
const positive=(value:unknown):value is number=>Number.isSafeInteger(value)&&Number(value)>0;
const baseline=(value:unknown):value is number=>Number.isSafeInteger(value)&&Number(value)>=0;
const record=(value:any)=>value!==null&&typeof value==='object'&&!Array.isArray(value);
const flags=(value:any,keys:string[])=>keys.every(key=>value?.[key]===undefined||typeof value[key]==='boolean');
/** Validate consumed collection shapes before any privileged presentation is committed. */
export function validateGrowth(data:any){
 const rows=(value:any)=>Array.isArray(value)&&value.every(record);
 if(!record(data)||!record(data.identity)||!['userId','tenantId','role'].every(k=>typeof data.identity[k]==='string'&&data.identity[k])
  ||!record(data.capabilities)||Object.values(data.capabilities).some(v=>typeof v!=='boolean')||!record(data.plan)||!baseline(data.plan.version)
  ||!record(data.plan.targets)||!['tenant','client'].every(k=>Array.isArray(data.plan.targets[k]))||!record(data.funnels)||!['tenant','client'].every(k=>rows(data.funnels[k]))
  ||!record(data.stats)||!record(data.activity)||!['leads','campaigns','tasks','owners','team','callQueue','calls','appointments','alerts','duplicates','reportDeliveries','priorities','sourcePerformance'].every(k=>rows(data[k])))throw Error('unavailable');
 if(['canEditPlan','canReport','canManageIntake','canOpenAdmin','canReviewLook'].some(key=>data[key]!==undefined&&typeof data[key]!=='boolean')
  ||data.business&&(!record(data.business)||typeof data.business.canBusiness!=='boolean'))throw Error('unavailable');
 if(data.leads.some((lead:any)=>!flags(lead,['canEditContact']))||data.campaigns.some((campaign:any)=>!flags(campaign,['canEditBrief'])||!flags(campaign.readiness,['canConfirm','schemaReady']))||!flags(data.business,['careReady']))throw Error('unavailable');
 for(const key of ['leads','campaigns','tasks','appointments','reportDeliveries','callQueue'])if(data[key].some((item:any)=>typeof item.id!=='string'||!item.id||!positive(item.version)))throw Error('unavailable');
 if(data.tasks.some((task:any)=>!Array.isArray(task.actions)||task.actions.some((action:any)=>typeof action!=='string'))
  ||data.campaigns.some((campaign:any)=>!rows(campaign.briefOwners)||!rows(campaign.reviewHistory)||!Array.isArray(campaign.reviewActions)||campaign.brief&&(!record(campaign.brief)||!positive(campaign.brief.version))||campaign.readiness&&(!record(campaign.readiness)||!rows(campaign.readiness.gates)||campaign.readiness.capacity&&!positive(campaign.readiness.capacity.version))))throw Error('unavailable');
 if(data.team.some((member:any)=>!positive(member.version))||data.duplicates.some((pair:any)=>!positive(pair.a_version)||!positive(pair.b_version)||!baseline(pair.review_version)))throw Error('unavailable');
 if(data.canManageIntake&&(!['intakeLinks','intakeOwners','intakeCampaigns'].every(k=>rows(data[k]))||data.intakeLinks.some((link:any)=>!positive(link.version))))throw Error('unavailable');
 if(data.business?.canBusiness&&(!['partnerLeads','clientLeads','partners','handoffs','entries'].every(k=>rows(data.business[k]))||data.business.partners.some((partner:any)=>!positive(partner.version))||!record(data.business.summary)||!Array.isArray(data.business.financeKinds)||data.business.marketing&&typeof data.business.marketing.period?.start!=='string'))throw Error('unavailable');
}
export function validateGrowthReport(value:any){if(!record(value)||!Array.isArray(value.columns)||!value.columns.every((c:any)=>record(c)&&typeof c.key==='string')||!Array.isArray(value.rows)||!value.rows.every(record))throw Error('unavailable');return value;}

/** Acknowledgement is not a list refresh. Release only on scoped, evidenced reflection.
 * Unobservable duplicate decisions remain GET-only for this owner; absence in
 * a paginated list is not proof. Email terminal acknowledgement presentation is
 * handled separately by the renderer. This memory is deliberately not durable.
 */
export function growthReflected(receipt:GrowthReceipt,next:any){
 if(!receipt.accepted||receipt.scope!==growthScope(next))return false;
 const {path,body,result,before}=receipt;
 if(!record(result))return false;
 const versioned=(item:any,old:unknown)=>baseline(old)&&positive(result.version)&&result.version>old&&positive(item?.version)&&item.version>=result.version;
 const create=(items:any[],previous:any[])=>typeof result.id==='string'&&result.id&&!previous.some(item=>item.id===result.id)&&items.some(item=>item.id===result.id);
 if(path==='/performance/email'||path==='/duplicates')return false;
 if(path==='/plan')return versioned(next.plan,body.version);
 if(path==='/finance')return create(next.business?.entries??[],before.business?.entries??[]);
 if(path==='/handoffs')return create(next.business?.handoffs??[],before.business?.handoffs??[]);
 if(path==='/calls')return create(next.calls,before.calls)&&next.calls.some((call:any)=>call.id===result.id&&call.lead_id===body.leadId)&&positive(body.leadVersion)&&positive(result.leadVersion)&&result.leadVersion>body.leadVersion&&[...next.leads,...next.callQueue].some((lead:any)=>lead.id===body.leadId&&positive(lead.version)&&lead.version>=result.leadVersion);
 const parts=path.split('/').filter(Boolean),entity=parts[0],id=parts.at(-1);
 const collection=(data:any):any[]=>({leads:data.leads,contacts:data.leads,campaigns:data.campaigns,tasks:data.tasks,'task-actions':data.tasks,appointments:data.appointments,'intake-links':data.intakeLinks,onboarding:data.business?.partners,team:data.team,performance:data.reportDeliveries}[entity]??[]);
 if(['briefs','reviews','capacity'].includes(entity)){
  if(result.id!==id)return false;
  const campaign=next.campaigns.find((item:any)=>item.id===id);return versioned(entity==='capacity'?campaign?.readiness?.capacity:campaign?.brief,body.version);
 }
 const items=collection(next),previous=collection(before);
 if(!parts[1]){
  if(entity==='onboarding')return versioned(items.find(item=>item.id===result.id),previous.find(item=>item.id===result.id)?.version??0);
  return create(items,previous)&&positive(result.version)&&items.some(item=>item.id===result.id&&positive(item.version)&&item.version>=result.version);
 }
 if(result.id!==id)return false;
 return versioned(items.find(item=>(entity==='team'?item.member_id:item.id)===id),body.version);
}
