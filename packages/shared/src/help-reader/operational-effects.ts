import policy from './operational-policy.json';
import {HelpReadFailure,helpScope,helpInteger,type HelpActor} from './protocol';
import type {HelpReadEffects} from './service';

type Quota=Readonly<{allowed:boolean;retryAfterSeconds:number}>;
type Audit=Readonly<{tenantId:string;userId:string;action:'list'|'read';locale:'en'|'fr'|'es';returned:number}>;
/** Host ports must use shared durable storage, server time and registered policy.
 * Quota is an atomic tenant/user reservation, independent of the reader transaction.
 * Audit expiry requires a separately verified purge schedule; this port is no scheduler.
 */
export type HelpOperationalStore=Readonly<{
 verifyPolicy:(expected:Readonly<{apiId:number;key:string;maxReads:number;windowSeconds:number;auditRetentionSeconds:number}>)=>Promise<boolean>;
 reserveRead:(scope:HelpActor,key:string,maxReads:number,windowSeconds:number)=>Promise<Quota>;
 appendAudit:(event:Audit,retentionSeconds:number)=>Promise<void>;
}>;

/** Unmounted policy adapter. Never substitutes a local counter or audit no-op. */
export function createHelpOperationalEffects(store:HelpOperationalStore,isCurrent:()=>boolean):HelpReadEffects{
 const verifyPolicy=store?.verifyPolicy,reserveRead=store?.reserveRead,appendAudit=store?.appendAudit;
 if(typeof verifyPolicy!=='function'||typeof reserveRead!=='function'||typeof appendAudit!=='function'||typeof isCurrent!=='function')throw new HelpReadFailure('unavailable',503);
 const verify=verifyPolicy.bind(store),reserve=reserveRead.bind(store),append=appendAudit.bind(store);
 const expected=Object.freeze({apiId:policy.apiId,key:policy.key,maxReads:policy.maxReads,windowSeconds:policy.windowSeconds,auditRetentionSeconds:policy.auditRetentionSeconds});
 const current=()=>{let active:boolean;try{active=isCurrent();}catch{throw new HelpReadFailure('conflict',409);}if(active!==true)throw new HelpReadFailure('conflict',409);};
 const verified=async()=>{current();if(await verify(expected)!==true)throw new HelpReadFailure('unavailable',503);current();};
 const safe=async(run:()=>Promise<void>,allowRateLimit=false)=>{try{await run();}catch(error){current();if(error instanceof HelpReadFailure&&((error.code==='conflict'&&error.status===409)||(allowRateLimit&&error.code==='rate_limited'&&error.status===429)))throw error;throw new HelpReadFailure('unavailable',503);}};
 return Object.freeze({
  isCurrent:()=>{current();return true;},
  consumeQuota:async(actor:HelpActor,key:string)=>safe(async()=>{
   const scope=helpScope(actor);if(key!==expected.key)throw new HelpReadFailure('unavailable',503);
   await verified();const result=await reserve(scope,expected.key,expected.maxReads,expected.windowSeconds);current();
   if(!result||typeof result.allowed!=='boolean'||!helpInteger(result.retryAfterSeconds,result.allowed?0:1,result.allowed?0:expected.windowSeconds))throw new HelpReadFailure('unavailable',503);
   if(!result.allowed)throw new HelpReadFailure('rate_limited',429);
  },true),
  auditRead:async(actor:HelpActor,event:Parameters<HelpReadEffects['auditRead']>[1])=>safe(async()=>{
   const scope=helpScope(actor);
   if(!event||!['list','read'].includes(event.action)||!['en','fr','es'].includes(event.locale)||!helpInteger(event.returned,0,100)||(event.action==='read'&&event.returned!==1))throw new HelpReadFailure('unavailable',503);
   // Project approved metadata before any await; never forward caller-owned objects.
   const audit:Audit=Object.freeze({tenantId:scope.tenantId,userId:scope.userId,action:event.action,locale:event.locale as Audit['locale'],returned:event.returned});
   await verified();await append(audit,expected.auditRetentionSeconds);current();
  })
 });
}
