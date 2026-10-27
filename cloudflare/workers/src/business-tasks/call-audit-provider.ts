import {uuid,safeWord,hash,type AuditPayload} from './call-audit.ts';
import agents from '../../../../packages/shared/src/vapi-agent-targets.json' with {type:'json'};
export const orgId='9e1d8550-4b84-4472-a782-67557fe73944',phoneId='3e9cee92-b463-47c8-9e1a-cdbf179cb675',sharedNumber='+12897994277';
export const assistantIds=['5ae2ab0c-fad0-454c-8cf7-64b81c91c850',...Object.values(agents)];
export type AuditEnv={DB_URL:string;VAPI_PRIVATE_API_KEY:string;TWILIO_ACCOUNT_SID:string;TWILIO_API_KEY_SID:string;TWILIO_API_KEY_SECRET:string};
export async function providerJson(url:string,authorization:string){
 const r=await fetch(url,{headers:{authorization,accept:'application/json'},redirect:'manual',signal:AbortSignal.timeout(12000)});
 if(!r.ok){await r.body?.cancel();throw Error('provider_read_failed');}
 if(Number(r.headers.get('content-length')??0)>4194304)throw Error('provider_response_limit');
 const reader=r.body!.getReader();const chunks:Uint8Array[]=[];let bytes=0;try{while(true){const {value,done}=await reader.read();if(done)break;bytes+=value.length;if(bytes>4194304)throw Error('provider_response_limit');chunks.push(value);}}finally{await reader.cancel();}
 const all=new Uint8Array(bytes);let offset=0;for(const c of chunks){all.set(c,offset);offset+=c.length;}return JSON.parse(new TextDecoder().decode(all));
}
export async function canonicalSnapshot(id:string,env:AuditEnv):Promise<AuditPayload>{
 if(!uuid(id))throw Error('invalid_call_reference');
 const c=await providerJson('https://api.vapi.ai/call/'+id,'Bearer '+env.VAPI_PRIVATE_API_KEY);
 if(c.id!==id||c.orgId!==orgId||c.phoneNumberId!==phoneId||!assistantIds.includes(c.assistantId)||!['inboundPhoneCall','outboundPhoneCall'].includes(c.type))throw Error('call_scope_mismatch');
 const sid=c.phoneCallProviderId??c.transport?.callSid;
 if(!/^CA[a-f0-9]{32}$/i.test(sid??'')||!/^AC[a-f0-9]{32}$/i.test(env.TWILIO_ACCOUNT_SID))throw Error('call_provider_mismatch');
 const t=await providerJson('https://api.twilio.com/2010-04-01/Accounts/'+env.TWILIO_ACCOUNT_SID+'/Calls/'+sid+'.json','Basic '+btoa(env.TWILIO_API_KEY_SID+':'+env.TWILIO_API_KEY_SECRET));
 if(t.sid!==sid||t.account_sid!==env.TWILIO_ACCOUNT_SID||!(c.type==='inboundPhoneCall'?t.direction==='inbound'&&t.to===sharedNumber:t.direction==='outbound-api'&&t.from===sharedNumber))throw Error('call_provider_mismatch');
 return {kind:'call_snapshot',source:'vapi_twilio_readback',at:new Date(c.updatedAt??c.createdAt).toISOString(),callId:id,callSid:sid,assistantId:c.assistantId,phoneNumberId:phoneId,orgId,from:t.from,to:t.to,direction:t.direction,status:safeWord(c.status),startedAt:c.startedAt??undefined,endedAt:c.endedAt??undefined,endedReason:safeWord(c.endedReason),providerMatched:true};
}
export async function snapshotKey(snapshot:AuditPayload){return 'snapshot:'+await hash(snapshot);}
