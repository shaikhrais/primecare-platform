import {ScopedServiceBase,type AtomicStore,type AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import type {VerifiedCallSubject} from './vapi-call-identity.ts';
type Sql={query(text:string,values?:unknown[]):Promise<{rows:any[]}>};
type Pool=Sql&{connect():Promise<Sql&{release():void}>};
const sections=['appointments','service_history','onboarding_status'];
const text=(v:unknown,max=100):v is string=>typeof v==='string'&&v.length<=max&&!/[\u0000-\u001f\u007f]/.test(v);
function instant(v:unknown){const value=v instanceof Date?v.toISOString():v;if(typeof value!=='string'||!Number.isFinite(Date.parse(value)))throw Error('Client information unavailable');return new Date(value).toISOString();}
/** Administrative owner reads after current-call OTP. No native session is
 * created and no identity, tenant or client record ID is accepted from the model. */
export class VapiClientInformationService extends ScopedServiceBase {
 readonly pool:Pool;readonly identities:{current(callId:string):Promise<VerifiedCallSubject|null>};
 constructor(store:AtomicStore,policy:AccessPolicy,pool:Pool,identities:VapiClientInformationService['identities']){super(store,policy);if(typeof pool?.connect!=='function'||typeof identities?.current!=='function')throw Error('Verified client information ports required');this.pool=pool;this.identities=identities;}
 private async current(callId:string,previous?:VerifiedCallSubject){
  const s=await this.identities.current(callId);
  if(!s||s.callId!==callId||s.authentication!=='otp'||s.nativeSession!==false||s.businessActionApproved!==false||s.expiresAt<=Date.now()||!text(s.actor?.id,200)||!s.actor.id||!text(s.actor?.tenantId,200)||!s.actor.tenantId||!s.proofId||previous&&['proofId','callSid','verifiedAt','expiresAt'].some(k=>s[k as keyof VerifiedCallSubject]!==previous[k as keyof VerifiedCallSubject])||previous&&(s.actor.id!==previous.actor.id||s.actor.tenantId!==previous.actor.tenantId))throw Error('Current client verification required');
  await this.checkAccess(s.actor,'voice.client.read',{id:'voice-client:'+callId,tenantId:s.actor.tenantId,ownerId:s.actor.id,kind:'voice_client_information',version:1},['voice_client_information']);return s;
 }
 async read(callId:string,input:unknown){
  if(!/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(callId)||!input||typeof input!=='object'||Array.isArray(input)||Object.keys(input).join(',')!=='section'||!sections.includes(String((input as any).section)))throw Error('Invalid client information request');
  const section=(input as {section:string}).section,subject=await this.current(callId),db=await this.pool.connect();
  let result:unknown;
  try{
   await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='5s'");
   const profiles=(await db.query(`SELECT p.id FROM public.client_profiles p JOIN public.users u ON u.id::text=p.user_id::text AND u.tenant_id::text=p.tenant_id::text JOIN public.tenants t ON t.id::text=p.tenant_id::text WHERE p.user_id::text=$1 AND p.tenant_id::text=$2 AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2`,[subject.actor.id,subject.actor.tenantId])).rows;
   if(profiles.length!==1||!text(profiles[0].id,200)||!profiles[0].id)throw Error('Owned client profile unavailable');
   const values=[profiles[0].id,subject.actor.tenantId];
   if(section==='appointments'){
    const rows=(await db.query('SELECT service_type,start_at,end_at,status FROM public.bookings WHERE client_id::text=$1 AND tenant_id::text=$2 ORDER BY start_at DESC,id LIMIT 11',values)).rows;
    if(rows.length>11)throw Error();
    const appointments=rows.slice(0,10).map(row=>{if(!text(row.service_type)||!text(row.status,80))throw Error();const startsAt=instant(row.start_at),endsAt=instant(row.end_at);if(endsAt<=startsAt)throw Error();return {serviceType:row.service_type,startsAt,endsAt,status:row.status};});
    result={appointments,hasMore:rows.length>10,source:'owned_booking_records',bookingCreated:false};
   }else if(section==='service_history'){
    const rows=(await db.query('SELECT status,requested_start_at,duration_minutes FROM public.visits WHERE client_id::text=$1 AND tenant_id::text=$2 ORDER BY requested_start_at DESC,id LIMIT 11',values)).rows;
    if(rows.length>11)throw Error();
    const visits=rows.slice(0,10).map(row=>{if(!text(row.status,80)||!Number.isSafeInteger(row.duration_minutes)||row.duration_minutes<0)throw Error();return {status:row.status,requestedStartAt:instant(row.requested_start_at),durationMinutes:row.duration_minutes};});
    result={visits,hasMore:rows.length>10,source:'owned_visit_records',clinicalCompletionVerified:false};
   }else{
    const consents=(await db.query('SELECT form_type,status FROM public.consent_forms WHERE client_id::text=$1 AND tenant_id::text=$2 ORDER BY created_at DESC,id LIMIT 11',values)).rows;
    const authorizations=(await db.query('SELECT status FROM public.service_authorizations WHERE client_id::text=$1 AND tenant_id::text=$2 ORDER BY created_at DESC,id LIMIT 11',values)).rows;
    if(consents.length>11||authorizations.length>11)throw Error();
    result={profileAvailable:true,consentStatuses:consents.slice(0,10).map(r=>{if(!text(r.form_type)||!text(r.status,80))throw Error();return {formType:r.form_type,status:r.status};}),authorizationStatuses:authorizations.slice(0,10).map(r=>{if(!text(r.status,80))throw Error();return {status:r.status};}),hasMore:consents.length>10||authorizations.length>10,overallOnboardingComplete:null};
   }
   await this.current(callId,subject);await db.query('ROLLBACK');
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
  await this.current(callId,subject);
  if(new TextEncoder().encode(JSON.stringify(result)).length>8192)throw Error('Client information unavailable');return result;
 }
}
