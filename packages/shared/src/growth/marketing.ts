import {registry,keys,fail} from './contract';

export function marketingStatementOptions(v:Record<string,unknown>,now=new Date()){
 keys(v,['month','locale']);const month=v.month??now.toISOString().slice(0,7),locale=v.locale??'en';
 if(typeof month!=='string'||!/^\d{4}-(0[1-9]|1[0-2])$/.test(month)||month<registry.centralMarketingPolicy.statement.minMonth||month>now.toISOString().slice(0,7)||!['en','fr','es'].includes(String(locale)))fail(400);
 const period=marketingPeriod(new Date(month+'-01T00:00:00Z'));
 return {start:period.start,end:new Date(Date.parse(period.endExclusive+'T00:00:00Z')-86400000).toISOString().slice(0,10),locale:locale as 'en'|'fr'|'es',to:undefined};
}

export function marketingPeriod(now=new Date()){
 if(!Number.isFinite(now.getTime()))throw Error('Invalid marketing period');
 const start=new Date(Date.UTC(now.getUTCFullYear(),now.getUTCMonth(),1)).toISOString().slice(0,10);
 const endExclusive=new Date(Date.UTC(now.getUTCFullYear(),now.getUTCMonth()+1,1)).toISOString().slice(0,10);
 return {start,endExclusive};
}

/** Forecast only. This does not create an obligation, invoice or fund balance. */
export function marketingEstimate(netReceiptsCents:string){
 if(typeof netReceiptsCents!=='string'||netReceiptsCents.length>80||!/^\-?\d+$/.test(netReceiptsCents))throw Error('Invalid recorded receipts');
 const p=registry.centralMarketingPolicy;
 if(![p.totalBasisPoints,p.advertisingBasisPoints,p.managementBasisPoints].every(n=>Number.isSafeInteger(n)&&n>=0&&n<=10000)||p.totalBasisPoints!==p.advertisingBasisPoints+p.managementBasisPoints)throw Error('Invalid marketing policy');
 const net=BigInt(netReceiptsCents),base=net>0n?net:0n;
 const rounded=(basisPoints:number)=>(base*BigInt(basisPoints)+5000n)/10000n;
 const total=rounded(p.totalBasisPoints),management=rounded(p.managementBasisPoints);
 return {policyVersion:p.version,status:p.status,currency:p.currency,basis:p.basis,netReceiptsCents:net.toString(),eligibleReceiptsCents:base.toString(),contributionCents:total.toString(),advertisingCents:(total-management).toString(),managementCents:management.toString(),billable:false};
}
