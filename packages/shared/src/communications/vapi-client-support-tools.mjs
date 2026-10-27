import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import catalogue from '../vapi-client-support-tools.json' with {type:'json'};
import registered from './registered-contracts.json' with {type:'json'};
const id=v=>typeof v==='string'&&!!v.trim()&&v.length<=200&&!/[\u0000-\u001f\u007f]/.test(v);
const uuid=v=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/i.test(v);
const version=v=>Number.isSafeInteger(v)&&v>0;
const fail=code=>{throw Object.assign(Error(code),{code});};
const schema={type:'object',additionalProperties:false,properties:{message:{type:'string',minLength:1,maxLength:1000}},required:['message']};
/** Optional native server handler. OTP alone supplies neither its native fetch,
 * conversation binding, approved staff recipient nor independent confirmation. */
export class VapiClientSupportToolClient extends BoundedBinaryAdapterBase {
 #send;#scope;#initial;#agent;#support;
 constructor({agentKey,fetch:send,currentScope,support}){
  super(1048576);
  const api=registered.apis.find(a=>a.id===catalogue.apiId);
  if(!api||api.path!==catalogue.path||api.method!=='POST'||api.permission!=='role_screen_permissions'||!Object.hasOwn(catalogue.roles,agentKey)||typeof send!=='function'||typeof currentScope!=='function')fail('support_configuration_required');
  this.#send=send;this.#scope=currentScope;this.#initial=currentScope();this.#agent=agentKey;
  if(typeof this.#initial!=='string'||!this.#initial)fail('native_context_required');
  if(support!==undefined){if(!support||['actorId','tenantId','conversationId','recipientId'].some(k=>!id(support[k]))||support.actorId===support.recipientId||typeof support.confirm!=='function')fail('support_configuration_required');this.#support=Object.freeze({...support});}
 }
 #current(){if(this.#scope()!==this.#initial)fail('native_context_changed');}
 functionDefinitions(){if(!this.#support)return [];return catalogue.roles[this.#agent].map(key=>({type:'function',function:{name:catalogue.tools[key].name,description:catalogue.tools[key].description,parameters:structuredClone(schema)}}));}
 async #request(body){
  this.#current();const send=this.#send,response=await send('https://primecare-api-gateway.itpro-mohammed.workers.dev'+catalogue.path,{method:'POST',redirect:'manual',signal:AbortSignal.timeout(15000),headers:{accept:'application/json','content-type':'application/json'},body:JSON.stringify(body)});try{this.#current();}catch(error){await response.body?.cancel();throw error;}
  if(!response.ok){await response.body?.cancel();fail([401,403].includes(response.status)?'native_api_denied':response.status===409?'native_api_conflict':'support_api_unavailable');}
  const result=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(response.body)));this.#current();if(!result||typeof result!=='object'||Array.isArray(result)||Object.hasOwn(result,'error'))fail('invalid_support_response');return result;
 }
 async #snapshot(){const s=this.#support,row=await this.#request({action:'read',id:s.conversationId});if(row.id!==s.conversationId||row.tenantId!==s.tenantId||row.kind!=='conversation'||!version(row.version)||!Array.isArray(row.members)||!row.members.includes(s.actorId)||!row.members.includes(s.recipientId)||!Array.isArray(row.messages)||row.messages.length>1000)fail('support_conversation_unavailable');return row;}
 #receipt(row,key,text){const messages=row.messages.filter(m=>m.id===key);if(!messages.length)return null;if(messages.length!==1||messages[0].authorId!==this.#support.actorId||messages[0].text!==text||!Array.isArray(messages[0].pictureIds)||messages[0].pictureIds.length||!Number.isSafeInteger(messages[0].sequence)||messages[0].sequence<1||!Number.isFinite(Date.parse(messages[0].sentAt)))fail('support_readback_mismatch');return {saved:true,messageId:key,recordKind:'client_requested_message',clinicalChartUpdated:false,expertReplyVerified:false};}
 async executeFunction(name,input,operationId){
  const key=catalogue.roles[this.#agent].find(k=>catalogue.tools[k].name===name);
  if(!this.#support||!key||!input||typeof input!=='object'||Array.isArray(input)||Object.keys(input).join(',')!=='message'||typeof input.message!=='string'||!input.message.trim()||input.message.length>1000||/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(input.message)||!uuid(operationId))fail('invalid_support_input');
  const text=catalogue.tools[key].prefix+input.message.trim(),messageKey='voice_'+key.replaceAll('.','_')+'_'+operationId.replaceAll('-',''),before=await this.#snapshot(),existing=this.#receipt(before,messageKey,text);
  if(existing)return {...existing,replayed:true};
  const confirmation=Object.freeze({kind:key,conversationId:this.#support.conversationId,recipientId:this.#support.recipientId,text,version:before.version});
  if(await this.#support.confirm(confirmation)!==true)fail('independent_confirmation_required');this.#current();
  const current=await this.#snapshot();if(current.version!==before.version)fail('native_api_conflict');
  let attempted=false;
  try{this.#current();attempted=true;const receipt=await this.#request({action:'send',id:this.#support.conversationId,key:messageKey,version:before.version,text,pictureIds:[]});if(receipt.id!==this.#support.conversationId||receipt.version!==before.version+1)fail('support_readback_mismatch');const saved=await this.#snapshot(),projected=this.#receipt(saved,messageKey,text);if(!projected||saved.version<receipt.version)fail('support_readback_mismatch');this.#current();return {...projected,replayed:false};}
  catch(error){if(['native_api_denied','native_api_conflict'].includes(error?.code))throw error;if(attempted)fail('tool_result_unknown_check_status');throw error;}
 }
}
