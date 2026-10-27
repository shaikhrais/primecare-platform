import {BoundedBinaryAdapterBase} from '../../../../packages/shared/src/communications/adapter-base.mjs';
import {VapiCallReadClient,createVapiCanonicalCallDirectory} from '../../../../packages/shared/src/communications/vapi-call-read.mjs';
import targets from '../../../../packages/shared/src/vapi-agent-targets.json' with {type:'json'};
import {VapiVerifiedCallIdentityService,DurableVapiCallProofRepository,type CallIdentityPorts} from './vapi-call-identity.ts';
import {PostgresAtomicStore} from './store.ts';
import {registeredMetadataValue as v} from './endpoint-policy.ts';
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};
import verification from '../../../../tools/governance-production/vapi-verification-registration.json' with {type:'json'};
type Pool=ConstructorParameters<typeof PostgresAtomicStore>[0];
export type VerifiedRuntimeEnvironment={VAPI_PRIVATE_API_KEY:string;TWILIO_ACCOUNT_SID:string;TWILIO_API_KEY_SID:string;TWILIO_API_KEY_SECRET:string;VERIFICATIONS:DurableObjectNamespace};
export const vapiReceptionScope=Object.freeze({orgId:'9e1d8550-4b84-4472-a782-67557fe73944',assistantId:'5ae2ab0c-fad0-454c-8cf7-64b81c91c850',phoneNumberId:'3e9cee92-b463-47c8-9e1a-cdbf179cb675',sharedNumber:'+12897994277'});
/** Read-only Twilio transport. No call/SMS creation or recording APIs. */
class CurrentTwilioCallClient extends BoundedBinaryAdapterBase {
 readonly env:VerifiedRuntimeEnvironment;readonly send:typeof fetch;
 constructor(env:VerifiedRuntimeEnvironment,send:typeof fetch){super(65536);this.env=Object.freeze({...env});this.send=send;if(!/^AC[a-f0-9]{32}$/i.test(env.TWILIO_ACCOUNT_SID)||!/^SK[a-f0-9]{32}$/i.test(env.TWILIO_API_KEY_SID)||!env.TWILIO_API_KEY_SECRET)throw Error('Call reader configuration required');}
 async fetch(id:string){
  if(!/^CA[a-f0-9]{32}$/i.test(id))throw Error('Call reference required');
  const r=await this.send('https://api.twilio.com/2010-04-01/Accounts/'+this.env.TWILIO_ACCOUNT_SID+'/Calls/'+id+'.json',{redirect:'manual',headers:{authorization:'Basic '+btoa(this.env.TWILIO_API_KEY_SID+':'+this.env.TWILIO_API_KEY_SECRET),accept:'application/json'},signal:AbortSignal.timeout(10000)});
  if(!r.ok){await r.body?.cancel();throw Error('Call unavailable');}
  const row=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(r.body!)));
  return {sid:row.sid,accountSid:row.account_sid,from:row.from,to:row.to,direction:row.direction,status:row.status};
 }
}
/** Shared call proof consumer. Cannot issue codes, enroll phones, create a
 * native login or approve business actions. Only live inbound shared-number calls.
 */
export function createPostgresVapiVerifiedRuntime(pool:Pool,env:VerifiedRuntimeEnvironment,send:typeof fetch=fetch){
 const twilio=new CurrentTwilioCallClient(env,send),calls=createVapiCanonicalCallDirectory({...vapiReceptionScope,assistantIds:[vapiReceptionScope.assistantId,...Object.values(targets)],accountSid:env.TWILIO_ACCOUNT_SID,vapi:new VapiCallReadClient({apiKey:env.VAPI_PRIVATE_API_KEY,fetch:send}),twilio});
 const current:CallIdentityPorts['current']=async callId=>{
  const call=await calls.current(callId);if(!call)return null;
  const raw=await twilio.fetch(call.callSid);
  if(raw.sid!==call.callSid||raw.accountSid!==env.TWILIO_ACCOUNT_SID||raw.direction!=='inbound'||raw.status!=='in-progress'||raw.to!==vapiReceptionScope.sharedNumber||!/^\+[1-9][0-9]{6,14}$/.test(raw.from??''))return null;
  const rows=(await pool.query(`SELECT c.user_id,c.tenant_id,c.version::float8 AS version FROM public.communication_voice_verified_contacts c JOIN public.users u ON u.id::text=c.user_id AND u.tenant_id::text=c.tenant_id JOIN public.tenants t ON t.id=u.tenant_id WHERE c.phone=$1 AND c.revoked_at IS NULL AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2`,[raw.from])).rows;
  if(rows.length!==1)return null;
  return {actor:{id:rows[0].user_id,tenantId:rows[0].tenant_id},phone:raw.from,version:rows[0].version,callId,callSid:call.callSid};
 };
 const policy={async assert(actor:any,action:string,state:any){
  if(action!=='voice.sms.spoken.verify'||state?.kind!=='voice_auth'||state.ownerId!==actor.id||state.tenantId!==actor.tenantId)throw Error('Call proof denied');
  const rows=(await pool.query(`SELECT ${v('a','id')} AS id,${v('a','permission_key')} AS permission,${v('a','auth_required')} AS auth FROM "${pin.schema}".govt_api_endpoints a WHERE ${v('a','http_method')}='POST' AND ${v('a','route_path')}=$1 AND ${v('a','service_name')}='governance' AND EXISTS(SELECT 1 FROM "${pin.schema}".govt_source_manifest WHERE manifest_sha256=$2) LIMIT 2`,[verification.operations[0].path,pin.manifestSha256])).rows;
  if(rows.length!==1||rows[0].id!=='16565'||rows[0].permission!==verification.operations[0].permission||rows[0].auth!=='1')throw Error('Call proof registration unavailable');
 },async assignee(){throw Error('Denied');}};
 const proofs=new DurableVapiCallProofRepository(env.VERIFICATIONS);
 return Object.freeze({calls,identities:new VapiVerifiedCallIdentityService(new PostgresAtomicStore(pool,'business_sms'),policy,{current,proof:c=>proofs.read(c)})});
}
