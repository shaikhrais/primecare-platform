import {marketingEstimate} from '../../../../packages/shared/src/growth/marketing';
import {canBusiness} from '../../../../packages/shared/src/growth/business';
import {fail,registry} from '../../../../packages/shared/src/growth/contract';
import {requiredRow} from '../database-results';
import type {GrowthRepository} from './repository';
import type {ReportResult} from '../reporting';

export async function marketingStatement(repo:GrowthRepository,options:{start:string;end:string;locale:'en'|'fr'|'es'}):Promise<ReportResult>{
 if(!canBusiness(repo.actor))fail(403,'forbidden');
 const amounts=requiredRow((await repo.db.query("SELECT COALESCE(SUM(amount_cents) FILTER(WHERE kind='payment'),0)::text AS payments,COALESCE(SUM(amount_cents) FILTER(WHERE kind='refund'),0)::text AS refunds FROM growth_finance_entries WHERE tenant_id::text=$1 AND record_date >= $2::date AND record_date <= $3::date",[repo.actor.tenant_id,options.start,options.end])).rows);
 const estimate=marketingEstimate((BigInt(String(amounts.payments))-BigInt(String(amounts.refunds))).toString()),l=registry.locales[options.locale];
 const decimal=new Intl.NumberFormat(options.locale).formatToParts(1.1).find(p=>p.type==='decimal')!.value;
 const money=(value:string)=>{const cents=BigInt(value),abs=cents<0n?-cents:cents;return 'CAD '+(cents<0n?'-':'')+new Intl.NumberFormat(options.locale,{maximumFractionDigits:0}).format(abs/100n).replace(/[\u00a0\u202f]/g,' ')+decimal+(abs%100n).toString().padStart(2,'0');};
 const rows=[['marketing_payments',String(amounts.payments)],['marketing_refunds',String(amounts.refunds)],['marketing_recorded',estimate.netReceiptsCents],['marketing_eligible',estimate.eligibleReceiptsCents],['marketing_contribution',estimate.contributionCents],['marketing_advertising',estimate.advertisingCents],['marketing_management',estimate.managementCents]].map(([key,value])=>({item:l[key as keyof typeof l],value:money(value),kind:'amount'}));
 rows.push({item:l.marketing_statement_note,value:l.marketing_proposal,kind:'note'},{item:l.marketing_period,value:options.start+' / '+options.end,kind:'note'},{item:l.marketing_model,value:estimate.policyVersion,kind:'note'},{item:l.marketing_rounding,value:l.marketing_gate,kind:'note'});
 return {id:'growth_marketing_statement',title:l.marketing_statement,locale:options.locale,columns:[{key:'item',label:l.marketing_item},{key:'value',label:l.marketing_value}],rows,generatedAt:new Date().toISOString(),scope:repo.actor.tenant_id+'; '+options.start.slice(0,7)+' UTC',classification:l.marketing_statement,source:'Recorded finance entries; recalculated proposal; not billable'};
}
