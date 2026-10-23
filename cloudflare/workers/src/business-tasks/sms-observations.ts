import type {SmsDeliveryObservation,SmsObservationStore} from '../../../../packages/shared/src/communications/twilio-sms.mjs';
import type {SmsNotificationService} from './sms.ts';
/** Durable thin receiver/reconciler. Invoke only behind TwilioSmsStatusAdapter.
 * The internal principal requires registered sms.status.receive permission.
 * The callback table deliberately has no caller-supplied tenant column.
 */
export class PostgresSmsObservationStore implements SmsObservationStore{
 readonly pool:any;readonly service:SmsNotificationService;readonly principal:string;
 constructor(pool:any,service:SmsNotificationService,principal:string){
  if(typeof pool?.connect!=='function'||typeof pool?.query!=='function'||typeof service?.observe!=='function'||typeof principal!=='string'||!principal.trim()||principal.length>200||/[\u0000-\u001f\u007f]/.test(principal))throw Error('SMS observation storage required');
  this.pool=pool;this.service=service;this.principal=principal;
 }
 async record(event:SmsDeliveryObservation):Promise<'recorded'|'duplicate'|'quarantined'>{
  // Whitelist and snapshot so caller mutation cannot alter the receipt hash or scope.
  const observation={accountSid:event.accountSid,messageSid:event.messageSid,messagingServiceSid:event.messagingServiceSid,from:event.from,to:event.to,status:event.status,errorCode:event.errorCode};
  if(observation.accountSid!==this.service.accountSid||observation.messagingServiceSid!==this.service.messagingServiceSid||observation.from!==this.service.sender||!/^SM[a-fA-F0-9]{32}$/.test(observation.messageSid))throw Error('SMS observation scope conflict');
  const digest=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(JSON.stringify(observation)))),byte=>byte.toString(16).padStart(2,'0')).join('');
  // Commit the receipt before calling the scoped service. Holding a pool
  // connection across service.run() could deadlock a busy or single-slot pool.
  const db=this.pool;
  {
   await db.query('INSERT INTO business_sms_callbacks(digest,observation) VALUES($1,$2) ON CONFLICT(digest) DO NOTHING',[digest,JSON.stringify(observation)]);
   const callback=(await db.query('SELECT processed FROM business_sms_callbacks WHERE digest=$1',[digest])).rows[0];
   if(callback.processed)return 'duplicate';
   for(let attempt=0;attempt<3;attempt++){
    const rows=(await db.query("SELECT state FROM business_sms_aggregates WHERE state->>'accountSid'=$1 AND state->>'providerMessageId'=$2 LIMIT 2",[observation.accountSid,observation.messageSid])).rows;
    if(!rows.length)return 'quarantined';
    if(rows.length!==1)throw Error('Ambiguous SMS receipt');
    const state=rows[0].state;
    if(state.from!==observation.from||state.to!==observation.to||state.messagingServiceSid!==observation.messagingServiceSid)throw Error('SMS receipt scope conflict');
    const actor=Object.freeze({id:this.principal,tenantId:state.tenantId});
    // Even duplicate status observations require current provider-service permission.
    await this.service.authorize(actor,'sms.status.receive',state);
    try{
     if(!state.observations.includes(observation.status))await this.service.observe(actor,state.id,state.version,observation);
     await db.query('UPDATE business_sms_callbacks SET processed=true WHERE digest=$1',[digest]);
     return 'recorded';
    }catch(error){if(!(error instanceof Error)||error.message!=='Version conflict'||attempt===2)throw error;}
   }
   throw Error('SMS observation unavailable');
  }
 }
 /** Run after receipts are committed and periodically by an approved worker.
  * Early callbacks remain durable until a provider-SID mapping exists.
  */
 async reconcile(limit=50){
  if(!Number.isSafeInteger(limit)||limit<1||limit>100)throw Error('Invalid reconciliation limit');
  const rows=(await this.pool.query('SELECT observation FROM business_sms_callbacks WHERE processed=false ORDER BY received_at,digest LIMIT $1',[limit])).rows;
  const result={recorded:0,duplicate:0,quarantined:0};
  for(const row of rows)result[await this.record(row.observation)]++;
  return result;
 }
}
