import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import {isDeepStrictEqual} from 'node:util';
import {createHash} from 'node:crypto';
const org='9e1d8550-4b84-4472-a782-67557fe73944';
export const savedAgents=Object.freeze({reception:'9ba3014c-cfaa-4607-997c-b5347212be54',new_enquiry:'8d9123e9-ac5b-4b2c-abbf-0447b3fbc5ff',qualification:'07b2e8c6-d4a9-4284-bb2b-ffae589183b3',consultation:'16fc27f3-2c96-49b4-aa76-be6ee099c0ec',proposal:'322ff7af-f657-424e-91fc-47b7dfd66074',booking_recovery:'01231dfe-d02a-45a3-9faf-9eb2ebe14e75',onboarding:'469ed456-4e68-4d2f-b09e-6658bae5bfdd',retention:'d1985ae7-8e35-4a7e-8f08-6a6dace03632'});
export const voicemailPayload=Object.freeze({type:'voicemail',function:{name:'primecare_silent_voicemail',description:'Silently end when a voicemail system or auto-attendant is detected. Do not leave a message.'},messages:[]});
const fail=message=>{throw Error(message);};
/** Deployment-only provider adapter. Shares bounded transport inheritance; no
 * calls, phone changes, account grants, business writes or arbitrary resources. */
export class VapiAgentLibraryClient extends BoundedBinaryAdapterBase {
 #key;#fetch;
 constructor({apiKey,fetch:send=globalThis.fetch}){super(1048576);if(typeof apiKey!=='string'||apiKey.length<16||typeof send!=='function')fail('configuration_required');this.#key=apiKey;this.#fetch=send;}
 async request(path,method='GET',body){
  if(!/^\/(?:tool(?:\/[a-f0-9-]{36})?|assistant\/[a-f0-9-]{36}|phone-number\/3e9cee92-b463-47c8-9e1a-cdbf179cb675)$/.test(path)||!['GET','POST','PATCH'].includes(method)||method==='POST'&&path!=='/tool'||method==='PATCH'&&!path.startsWith('/assistant/'))fail('operation_denied');
  const send=this.#fetch;const r=await send('https://api.vapi.ai'+path,{method,redirect:'manual',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+this.#key,accept:'application/json',...(body?{'content-type':'application/json'}:{})},...(body?{body:JSON.stringify(body)}:{})});
  if(!r.ok||method==='POST'&&r.status!==201){await r.body?.cancel();fail([401,403].includes(r.status)?'authentication_denied':'provider_request_failed');}
  return JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(r.body)));
 }
 scope(row){if(!row||row.orgId!==org)fail('provider_scope_changed');return row;}
 async ensureVoicemail(){
  const rows=await this.request('/tool');if(!Array.isArray(rows)||rows.length>200)fail('invalid_inventory');
  const matches=rows.filter(x=>x.function?.name===voicemailPayload.function.name);if(matches.length>1)fail('ambiguous_voicemail_tool');
  let row=matches[0];if(row){this.scope(row);if(!Object.entries(voicemailPayload).every(([k,v])=>isDeepStrictEqual(row[k],v)))fail('existing_voicemail_preserved');}
  else row=this.scope(await this.request('/tool','POST',voicemailPayload));
  if(!/^[a-f0-9-]{36}$/.test(row.id??''))fail('invalid_tool_id');
  const saved=this.scope(await this.request('/tool/'+row.id));if(!Object.entries(voicemailPayload).every(([k,v])=>isDeepStrictEqual(saved[k],v)))fail('tool_readback_failed');return saved.id;
 }
 async update(agent,previousPromptHash,voicemailId){
  const id=savedAgents[agent.key];if(!id||!agent.prompt||agent.name.length>40)fail('agent_scope_required');
  const before=this.scope(await this.request('/assistant/'+id));
  if(before.id!==id||before.name!==agent.name||!before.model||!Array.isArray(before.model.messages))fail('agent_scope_changed');
  const systems=before.model.messages.filter(m=>m.role==='system');
  if(systems.length!==1||typeof systems[0].content!=='string'||systems[0].content!==agent.prompt&&createHash('sha256').update(systems[0].content).digest('hex')!==previousPromptHash)fail('unreviewed_prompt_preserved');
  // Unknown business capabilities must be reviewed before combining with scripts.
  if((before.model.toolIds??[]).some(x=>x!==voicemailId)||(before.model.tools??[]).some(x=>x.type!=='endCall')||(before.model.functions??[]).length||before.server?.url)fail('unreviewed_capabilities_preserved');
  const model=structuredClone(before.model);model.messages=model.messages.map(m=>m.role==='system'?{...m,content:agent.prompt}:m);
  if(!(model.tools??[]).some(x=>x.type==='endCall'))model.tools=[...(model.tools??[]),{type:'endCall'}];
  model.toolIds=[...new Set([...(model.toolIds??[]),voicemailId])];
  const artifactPlan={...(before.artifactPlan??{}),recordingEnabled:false,loggingEnabled:false,pcapEnabled:false,transcriptPlan:{...(before.artifactPlan?.transcriptPlan??{}),enabled:false}};
  const patch={model,firstMessage:agent.firstMessage,artifactPlan,voicemailMessage:''};
  const recheck=this.scope(await this.request('/assistant/'+id));if(!isDeepStrictEqual(recheck,before))fail('concurrent_change_preserved');
  if(!Object.entries(patch).every(([k,v])=>isDeepStrictEqual(before[k],v)))await this.request('/assistant/'+id,'PATCH',patch);
  const saved=this.scope(await this.request('/assistant/'+id));if(!Object.entries(patch).every(([k,v])=>isDeepStrictEqual(saved[k],v)))fail('assistant_readback_failed');
  // Provider-managed version receipt changes on PATCH; it is not a setting.
  const changedFields=Object.entries(before).filter(([k,v])=>!['updatedAt','latestVersion',...Object.keys(patch)].includes(k)&&!isDeepStrictEqual(saved[k],v)).map(([k])=>k);
  if(changedFields.length)throw Object.assign(Error('unrelated_setting_changed'),{changedFields});
  return {key:agent.key,id,scriptVersion:agent.scriptVersion,configurationReadback:true,tools:['endCall','voicemail'],businessToolsAttached:false,callTested:false};
 }
}
