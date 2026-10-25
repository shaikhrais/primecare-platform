import type {InboundSmsEvent,SmsInboundStore} from '../../../../packages/shared/src/communications/twilio-sms-inbound.mjs';

/** Durable provider inbox, deliberately unassigned to any PrimeCare tenant.
 * The host must bind a verified channel link and current permissions before
 * consuming a pending event. This repository grants no account authority.
 */
export class PostgresSmsInboundStore implements SmsInboundStore {
 readonly pool:{query(sql:string,values:unknown[]):Promise<{rows:any[]}>};
 constructor(pool:PostgresSmsInboundStore['pool']){
  if(typeof pool?.query!=='function')throw Error('SMS inbox store required');this.pool=pool;
 }
 async accept(event:InboundSmsEvent):Promise<'recorded'|'duplicate'|'quarantined'> {
  // Snapshot before the first await; do not let an adapter mutate persisted data.
  const value=structuredClone(event);
  if(!value||Object.keys(value).sort().join(',')!=='accountSid,channel,control,from,mediaCount,messageSid,messagingServiceSid,provider,text,to'||
   value.provider!=='twilio'||value.channel!=='sms'||!/^AC[a-fA-F0-9]{32}$/.test(value.accountSid)||!/^SM[a-fA-F0-9]{32}$/.test(value.messageSid)||
   !/^MG[a-fA-F0-9]{32}$/.test(value.messagingServiceSid)||![value.from,value.to].every(x=>typeof x==='string'&&/^\+[1-9][0-9]{1,14}$/.test(x))||
   typeof value.text!=='string'||value.text.length>1600||new TextEncoder().encode(value.text).length>6400||/[\u0000\u000b\u000c]/.test(value.text)||
   !Number.isInteger(value.mediaCount)||value.mediaCount<0||value.mediaCount>10||!value.text.trim()&&!value.mediaCount||
   ![null,'STOP','START','HELP'].includes(value.control))throw Error('Invalid SMS inbox event');
  const disposition=value.control?'control':value.mediaCount?'quarantined':'pending';
  // Canonical tuple makes the hash independent of object property order.
  const payload=JSON.stringify([value.provider,value.channel,value.accountSid,value.messageSid,value.messagingServiceSid,value.from,value.to,value.text,value.mediaCount,value.control]);
  const digest=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(payload))),x=>x.toString(16).padStart(2,'0')).join('');
  // One statement is atomic across connections and survives a restart. A reused
  // SID with a different payload yields zero rows and never overwrites content.
  const row=(await this.pool.query(`INSERT INTO business_sms_inbox AS inbox
    (account_sid,message_sid,fingerprint,event,disposition) VALUES($1,$2,$3,$4,$5)
    ON CONFLICT(account_sid,message_sid) DO UPDATE SET duplicate_count=inbox.duplicate_count+1
    WHERE inbox.fingerprint=EXCLUDED.fingerprint
    RETURNING duplicate_count,disposition`,[value.accountSid,value.messageSid,digest,JSON.stringify(value),disposition])).rows[0];
  if(!row||!Number.isSafeInteger(row.duplicate_count)||row.duplicate_count<0||!['pending','control','quarantined'].includes(row.disposition))throw Error('SMS inbox persistence conflict');
  if(row.duplicate_count>0)return 'duplicate';
  return row.disposition==='pending'?'recorded':'quarantined';
 }
}
