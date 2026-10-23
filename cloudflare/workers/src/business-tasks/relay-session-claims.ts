import type {RelayClaimInput,RelaySessionClaims} from '../../../../packages/shared/src/communications/twilio-relay-session.mjs';
import {verifiedAgentIdentity} from '../../../../packages/shared/src/communications/twilio-agent-start.mjs';
import {twilioSid} from '../../../../packages/shared/src/communications/twilio-webhook.mjs';
/** Native one-use provider session ledger. No deletion/reopening on disconnect. */
export class PostgresRelaySessionClaims implements RelaySessionClaims {
 readonly pool:any;constructor(pool:any){if(typeof pool?.query!=='function')throw Error('Relay database required');this.pool=pool;}
 async claim(input:RelayClaimInput){
  const r=structuredClone(input),identity=verifiedAgentIdentity(r.identity),now=Date.now();
  if(!twilioSid('CA',r.callSid)||!twilioSid('VX',r.providerSessionId)||!Number.isSafeInteger(r.expiresAt)||r.expiresAt<=now||r.expiresAt>Math.min(identity.expiresAt,now+120000))throw Error('Relay claim unavailable');
  const claimId=crypto.randomUUID();
  const result=await this.pool.query(`INSERT INTO communication_relay_sessions(call_sid,claim_id,provider_session_id,identity_session_id,user_id,tenant_id,started_at,expires_at)
   VALUES($1,$2,$3,$4,$5,$6,$7,$8) ON CONFLICT DO NOTHING RETURNING claim_id`,[r.callSid,claimId,r.providerSessionId,identity.sessionId,identity.actor.id,identity.actor.tenantId,now,r.expiresAt]);
  return result.rows.length===1?String(result.rows[0].claim_id):null;
 }
 async finish(claimId:string){if(typeof claimId!=='string'||claimId.length!==36||!/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(claimId))throw Error('Relay claim unavailable');await this.pool.query('UPDATE communication_relay_sessions SET ended_at=COALESCE(ended_at,$2) WHERE claim_id=$1',[claimId,Date.now()]);}
}
