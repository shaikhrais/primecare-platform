import type {AtomicStore,AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import {VapiApiRequestAdapter,type VapiApiRequestOptions} from '../../../../packages/shared/src/communications/vapi-api-request.mjs';
import {TwilioPhoneAuthorizationAdapter,TwilioSpokenConfirmationAdapter} from '../../../../packages/shared/src/communications/twilio-phone-authorization.mjs';
import {PhoneOtpCallAuthorizationService,type CallAuthorizationPorts} from './call-authorization.ts';
import {PostgresPhoneCallGrantRepository,PostgresPhoneCallAccountDirectory,PostgresSpokenConfirmationRepository} from './call-authorization-postgres.ts';
import {SpokenVoiceTaskConfirmationService} from './voice-spoken-confirmations.ts';
import {VoiceTaskService,PostgresVoiceTaskRepository} from './voice-tasks.ts';
import {AppointmentBookingTask,type ReceptionAppointmentPorts} from './voice-reception-tasks.ts';
type Pool=ConstructorParameters<typeof PostgresPhoneCallGrantRepository>[0];
type Config={accountSid:string;sharedNumber:string};
/** One composition root for Twilio and Vapi. No routes, credentials, default
 * policy/grants, contact enrollment or live provider changes are installed.
 * Host bindings must enforce registered endpoints and pre-auth call/source quotas.
 */
export class PhoneCallOperationCore {
 readonly authorization:PhoneOtpCallAuthorizationService;readonly confirmations:SpokenVoiceTaskConfirmationService;readonly tasks:VoiceTaskService;
 readonly config:Readonly<Config>;readonly calls:CallAuthorizationPorts['calls'];readonly pool:Pool;
 constructor(options:{store:AtomicStore;policy:AccessPolicy;pool:Pool;config:Config;calls:CallAuthorizationPorts['calls'];provider:CallAuthorizationPorts['provider'];requestBooking:ReceptionAppointmentPorts['requestBooking']}){
  const {store,policy,pool,config,calls,provider,requestBooking}=options;
  this.config=Object.freeze({...config});this.calls=calls;this.pool=pool;
  this.authorization=new PhoneOtpCallAuthorizationService(store,policy,new PostgresPhoneCallGrantRepository(pool),{calls,provider,accounts:new PostgresPhoneCallAccountDirectory(pool)},config);
  const intents=new PostgresVoiceTaskRepository(pool);
  this.confirmations=new SpokenVoiceTaskConfirmationService(store,policy,this.authorization,intents,new PostgresSpokenConfirmationRepository(pool));
  this.tasks=new VoiceTaskService(store,policy,intents,this.confirmations,[new AppointmentBookingTask(requestBooking)]);
 }
 async pendingIntent(callSid:string){
  const identity=await this.authorization.current(callSid);if(!identity)throw Error('Verified call required');
  const rows=(await this.pool.query(`SELECT id FROM communication_voice_tasks WHERE status='proposed' AND intent->>'callSid'=$1 AND intent->>'sessionId'=$2
   AND intent->'actor'->>'id'=$3 AND intent->'actor'->>'tenantId'=$4 AND intent->>'taskId'='appointment.booking.request'
   AND (intent->>'expiresAt')::bigint>FLOOR(EXTRACT(EPOCH FROM clock_timestamp())*1000) LIMIT 2`,[callSid,identity.sessionId,identity.actor.id,identity.actor.tenantId])).rows;
  if(rows.length!==1)throw Error('One pending appointment proposal required');return rows[0].id as string;
 }
 vapi(options:Omit<VapiApiRequestOptions,'tasks'|'taskIds'>){return new VapiApiRequestAdapter({...options,tasks:this.tasks,taskIds:['appointment.booking.request']});}
 twilioAuthorization(options:Omit<ConstructorParameters<typeof TwilioPhoneAuthorizationAdapter>[0],'accountSid'|'sharedNumber'|'calls'|'authorization'>){return new TwilioPhoneAuthorizationAdapter({...options,...this.config,calls:this.calls,authorization:this.authorization});}
 twilioConfirmation(options:Omit<ConstructorParameters<typeof TwilioSpokenConfirmationAdapter>[0],'accountSid'|'sharedNumber'|'calls'|'confirmations'|'pendingIntent'>){return new TwilioSpokenConfirmationAdapter({...options,...this.config,calls:this.calls,confirmations:this.confirmations,pendingIntent:id=>this.pendingIntent(id)});}
}
