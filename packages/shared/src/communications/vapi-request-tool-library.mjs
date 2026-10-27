import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import definition from '../../../../tools/governance-production/vapi-contracts-registration.json' with {type:'json'};
const orgId='9e1d8550-4b84-4472-a782-67557fe73944';
const uuid=v=>typeof v==='string'&&/^[a-f0-9-]{36}$/i.test(v);
const fail=code=>{throw Error(code);};
function subset(a,b){return Array.isArray(b)?Array.isArray(a)&&a.length===b.length&&b.every((v,i)=>subset(a[i],v)):b&&typeof b==='object'?!!a&&Object.entries(b).every(([k,v])=>subset(a[k],v)):a===b;}
export function requestToolPayloads(credentialId){
 if(!uuid(credentialId))fail('existing_tool_credential_required');
 const names=['primecare_callback_request','primecare_booking_request','primecare_reschedule_request','primecare_execute_request'];
 const op=definition.operations[0];if(op.path!=='/v1/vapi/voice/tasks'||op.method!=='POST')fail('registered_request_contract_required');
 return op.request.oneOf.map((schema,i)=>{
  const body=structuredClone(schema),action=body.properties.action.const,taskId=body.properties.taskId?.const;delete body.properties.action;delete body.properties.taskId;body.required=body.required.filter(k=>!['action','taskId'].includes(k));
  return {type:'apiRequest',name:names[i],description:i===3?'Execute an exact previously approved PrimeCare request intent. A request completion is not a confirmed appointment.':'Propose the exact '+['callback','booking','rescheduling'][i]+' request for independent approval. Do not claim it is saved or confirmed from a proposal.',method:'POST',url:'https://primecare-vapi-tools-api.itpro-mohammed.workers.dev'+op.path,credentialId,headers:{type:'object',properties:{'Content-Type':{type:'string',value:'application/json'},'x-primecare-vapi-call-id':{type:'string',value:'{{ call.id }}'}}},body,parameters:[{key:'action',value:action},...(taskId?[{key:'taskId',value:taskId}]:[])]};
 });
}
/** Save registered request tools without modifying credentials or attaching them
 * to callers before the independent business runtime is verified. */
export class VapiRequestToolLibraryClient extends BoundedBinaryAdapterBase {
 #key;#send;
 constructor({apiKey,fetch:send=globalThis.fetch}){super(1048576);if(typeof apiKey!=='string'||apiKey.length<16||typeof send!=='function')fail('configuration_required');this.#key=apiKey;this.#send=send;}
 async #request(path,method='GET',body){if(!/^\/(?:tool|credential)(?:\/[a-f0-9-]{36})?$/.test(path)||!['GET','POST'].includes(method)||method==='POST'&&path!=='/tool')fail('operation_denied');const send=this.#send,r=await send('https://api.vapi.ai'+path,{method,redirect:'manual',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+this.#key,accept:'application/json',...(body?{'content-type':'application/json'}:{})},...(body?{body:JSON.stringify(body)}:{})});if(!r.ok||method==='POST'&&r.status!==201){await r.body?.cancel();throw Object.assign(Error([401,403].includes(r.status)?'authentication_denied':'provider_request_failed'),{httpStatus:r.status});}return JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(r.body)));}
 async ensure(){
  const credentials=await this.#request('/credential');if(!Array.isArray(credentials)||credentials.length>200)fail('invalid_credential_inventory');const matches=credentials.filter(c=>c.name==='PrimeCare Tools API 16534');if(matches.length!==1)fail('existing_tool_credential_required');
  const c=await this.#request('/credential/'+matches[0].id);if(c.orgId!==orgId||c.name!=='PrimeCare Tools API 16534'||!uuid(c.id)||c.provider!=='custom-credential'||c.authenticationPlan?.type!=='bearer'||c.authenticationPlan.headerName!=='Authorization'||c.authenticationPlan.bearerPrefixEnabled!==true)fail('existing_tool_credential_preserved');
  const tools=await this.#request('/tool');if(!Array.isArray(tools)||tools.length>200)fail('invalid_tool_inventory');const receipts=[];
  for(const payload of requestToolPayloads(c.id)){
   const found=tools.filter(t=>t.name===payload.name||t.function?.name===payload.name);if(found.length>1)fail('ambiguous_request_tool');let row=found[0];
   if(row){if(row.orgId!==orgId||!subset(row,payload)||row.server)fail('edited_request_tool_preserved');}
   else{row=await this.#request('/tool','POST',payload);tools.push(row);}
   if(row.orgId!==orgId||!uuid(row.id))fail('provider_scope_changed');const saved=await this.#request('/tool/'+row.id);if(saved.orgId!==orgId||!subset(saved,payload)||saved.server)fail('request_tool_readback_failed');
   receipts.push({name:payload.name,id:saved.id,type:'apiRequest',configurationReadback:true,attached:false,liveBusinessRuntimeVerified:false});
  }
  return {tools:receipts,credentialChanged:false,businessToolsAttached:false};
 }
}
