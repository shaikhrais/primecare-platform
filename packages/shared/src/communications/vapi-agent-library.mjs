import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import {isDeepStrictEqual} from 'node:util';
import {createHash} from 'node:crypto';
const org='9e1d8550-4b84-4472-a782-67557fe73944';
import targets from '../vapi-agent-targets.json' with {type:'json'};
import callback from '../vapi-callback-tool-bindings.json' with {type:'json'};
export const savedAgents=Object.freeze(targets);
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
 async update(agent,previousPromptHash,voicemailId,knowledgeId,verification){
  const id=savedAgents[agent.key];if(!id||!agent.prompt||agent.name.length>40||!knowledgeId)fail('agent_scope_required');
  const before=this.scope(await this.request('/assistant/'+id));
  if(!knowledgeId||before.id!==id||before.name!==agent.name||!before.model||!Array.isArray(before.model.messages))fail('agent_scope_changed');
  if(verification&&(verification.toolId!=='764dd85f-fafd-45c1-9352-45867ed94371'||typeof verification.instruction!=='string'||!verification.instruction.trim()||typeof verification.attach!=='boolean'))fail('verification_configuration_required');
  if(verification?.clientInformationId&&!/^[a-f0-9-]{36}$/i.test(verification.clientInformationId))fail('client_information_configuration_required');
  const hasVerification=!!verification&&(before.model.toolIds??[]).includes(verification.toolId);
  const prompt=agent.prompt+((hasVerification||verification?.attach)?'\n\n'+verification.instruction:'');
  const systems=before.model.messages.filter(m=>m.role==='system');
  if(systems.length!==1||typeof systems[0].content!=='string'||systems[0].content!==prompt&&systems[0].content!==agent.prompt&&(!verification?.previousInstruction||systems[0].content!==(agent.prompt+'\n\n'+verification.previousInstruction))&&createHash('sha256').update(systems[0].content).digest('hex')!==previousPromptHash)fail('unreviewed_prompt_preserved');
  // Unknown business capabilities must be reviewed before combining with scripts.
  if((before.model.toolIds??[]).some(x=>![voicemailId,knowledgeId,...(verification?[verification.toolId,...(verification.clientInformationId?[verification.clientInformationId]:[])]:[])].includes(x))||(before.model.tools??[]).some(x=>x.type!=='endCall')||(before.model.functions??[]).length||before.server?.url)fail('unreviewed_capabilities_preserved');
  const model=structuredClone(before.model);model.messages=model.messages.map(m=>m.role==='system'?{...m,content:prompt}:m);
  if(!(model.tools??[]).some(x=>x.type==='endCall'))model.tools=[...(model.tools??[]),{type:'endCall'}];
  model.toolIds=[...new Set([...(model.toolIds??[]),voicemailId,knowledgeId,...(verification?.attach?[verification.toolId,...(verification.clientInformationId?[verification.clientInformationId]:[])]:[])])];
  const artifactPlan={...(before.artifactPlan??{}),recordingEnabled:false,loggingEnabled:false,pcapEnabled:false,transcriptPlan:{...(before.artifactPlan?.transcriptPlan??{}),enabled:false}};
  const patch={model,firstMessage:agent.firstMessage,artifactPlan,voicemailMessage:''};
  const recheck=this.scope(await this.request('/assistant/'+id));if(!isDeepStrictEqual(recheck,before))fail('concurrent_change_preserved');
  if(!Object.entries(patch).every(([k,v])=>isDeepStrictEqual(before[k],v)))await this.request('/assistant/'+id,'PATCH',patch);
  const saved=this.scope(await this.request('/assistant/'+id));if(!Object.entries(patch).every(([k,v])=>isDeepStrictEqual(saved[k],v)))fail('assistant_readback_failed');
  // Provider-managed version receipt changes on PATCH; it is not a setting.
  const changedFields=Object.entries(before).filter(([k,v])=>!['updatedAt','latestVersion',...Object.keys(patch)].includes(k)&&!isDeepStrictEqual(saved[k],v)).map(([k])=>k);
  if(changedFields.length)throw Object.assign(Error('unrelated_setting_changed'),{changedFields});
  return {key:agent.key,id,scriptVersion:agent.scriptVersion,configurationReadback:true,tools:['endCall','voicemail','query',...(hasVerification||verification?.attach?['phoneVerification']:[])],phoneVerificationAttached:hasVerification||verification?.attach===true,clientInformationAttached:!!verification?.clientInformationId&&model.toolIds.includes(verification.clientInformationId),businessToolsAttached:true,businessWriteToolsAttached:false,callTested:false};
 }
 async updateActiveReception(agent,verificationInstruction,voicemailId,previousPromptHash,knowledgeId,verification){
  const id='5ae2ab0c-fad0-454c-8cf7-64b81c91c850',verificationId='764dd85f-fafd-45c1-9352-45867ed94371';
  const before=this.scope(await this.request('/assistant/'+id));
  if(!knowledgeId||before.id!==id||before.name!=='PrimeCare Reception - 4277'||agent.key!=='reception'||!Array.isArray(before.model?.messages)||!before.model.messages.some(m=>m.role==='system'&&(m.content===verificationInstruction||verification?.previousInstruction&&m.content===verification.previousInstruction))||!(before.model.toolIds??[]).includes(verificationId)||before.server?.url)fail('active_reception_scope_changed');
  const callbackIds=[callback.proposeToolId,callback.executeToolId],hasCallback=callbackIds.some(x=>before.model.toolIds.includes(x));
  if(hasCallback&&(!callbackIds.every(x=>before.model.toolIds.includes(x))||before.model.messages.filter(m=>m.role==='system'&&m.content===callback.instruction).length!==1))fail('unreviewed_callback_configuration_preserved');
  if(before.model.toolIds.some(x=>![verificationId,voicemailId,knowledgeId,...(hasCallback?callbackIds:[]),...(verification?.clientInformationId?[verification.clientInformationId]:[])].includes(x))||(before.model.tools??[]).some(x=>x.type!=='endCall')||(before.model.functions??[]).length)fail('unreviewed_capabilities_preserved');
  const prefix='PrimeCare reception role script version ',marker=prefix+agent.scriptVersion+'\n',content=marker+agent.prompt;
  const managed=before.model.messages.filter(m=>m.role==='system'&&typeof m.content==='string'&&m.content.startsWith(prefix));
  if(managed.length>1||managed.length===1&&managed[0].content!==content&&(!managed[0].content.startsWith(prefix+(agent.scriptVersion-1)+'\n')||createHash('sha256').update(managed[0].content.slice((prefix+(agent.scriptVersion-1)+'\n').length)).digest('hex')!==previousPromptHash))fail('unreviewed_prompt_preserved');
  const model=structuredClone(before.model);model.messages=model.messages.map(m=>m.role==='system'&&verification?.previousInstruction&&m.content===verification.previousInstruction?{...m,content:verificationInstruction}:m);if(!managed.length)model.messages.push({role:'system',content});else model.messages=model.messages.map(m=>m.role==='system'&&typeof m.content==='string'&&m.content.startsWith(prefix)?{...m,content}:m);
  if(!(model.tools??[]).some(x=>x.type==='endCall'))model.tools=[...(model.tools??[]),{type:'endCall'}];
  model.toolIds=[...new Set([...model.toolIds,voicemailId,knowledgeId,...(verification?.attach&&verification.clientInformationId?[verification.clientInformationId]:[])])];
  const patch={model,voicemailMessage:''};
  const recheck=this.scope(await this.request('/assistant/'+id));if(!isDeepStrictEqual(recheck,before))fail('concurrent_change_preserved');
  if(!Object.entries(patch).every(([k,v])=>isDeepStrictEqual(before[k],v)))await this.request('/assistant/'+id,'PATCH',patch);
  const saved=this.scope(await this.request('/assistant/'+id));if(!Object.entries(patch).every(([k,v])=>isDeepStrictEqual(saved[k],v)))fail('assistant_readback_failed');
  const changedFields=Object.entries(before).filter(([k,v])=>!['updatedAt','latestVersion',...Object.keys(patch)].includes(k)&&!isDeepStrictEqual(saved[k],v)).map(([k])=>k);
  if(changedFields.length)throw Object.assign(Error('unrelated_setting_changed'),{changedFields});
  return {id,configurationReadback:true,verificationToolPreserved:true,publicServiceToolAttached:true,roleScriptVersion:agent.scriptVersion,callTested:false};
 }
}
