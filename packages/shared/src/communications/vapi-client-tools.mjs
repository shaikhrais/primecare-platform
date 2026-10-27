import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import pack from '../vapi-agent-tool-pack.json' with {type:'json'};
export const clientToolSchemas=Object.freeze({'client.service_history':{type:'object',additionalProperties:false,properties:{},required:[]},'client.onboarding_status':{type:'object',additionalProperties:false,properties:{},required:[]}});
const fail=code=>{throw Object.assign(Error(code),{code});};
const safeText=v=>v===null||typeof v==='string'&&v.length<=200&&!/[\u0000-\u001f\u007f]/.test(v);
/** Read-only projections from existing client-owner APIs. The host supplies its
 * current authenticated native transport; no client ID is accepted as an arg. */
export class VapiClientToolClient extends BoundedBinaryAdapterBase {
 #send;#scope;#initial;#agent;
 constructor({agentKey,fetch:send,currentScope}){super(262144);if(!Object.hasOwn(pack.agents,agentKey)||typeof send!=='function'||typeof currentScope!=='function')fail('tool_configuration_required');this.#send=send;this.#scope=currentScope;this.#initial=currentScope();this.#agent=agentKey;if(typeof this.#initial!=='string'||!this.#initial)fail('native_context_required');}
 #current(){if(this.#scope()!==this.#initial)fail('native_context_changed');}
 functionDefinitions(){return pack.agents[this.#agent].filter(key=>clientToolSchemas[key]).map(key=>({type:'function',function:{name:'primecare_'+key.replaceAll('.','_'),description:pack.tools.find(t=>t.key===key).description,parameters:structuredClone(clientToolSchemas[key])}}));}
 async #read(path){this.#current();const send=this.#send,r=await send('https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/client'+path,{method:'GET',redirect:'manual',headers:{accept:'application/json'}});this.#current();if(!r.ok){await r.body?.cancel();fail([401,403].includes(r.status)?'native_api_denied':'client_data_unavailable');}const body=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(r.body)));this.#current();if(!body||typeof body!=='object'||Array.isArray(body)||Object.hasOwn(body,'error'))fail('invalid_native_response');return body;}
 #list(body,key){if(!Array.isArray(body[key])||body[key].length>25||!body.pagination||!Number.isSafeInteger(body.pagination.total)||body.pagination.total<0||typeof body.pagination.hasMore!=='boolean')fail('invalid_native_response');return body[key];}
 async executeFunction(name,args={}){
  const key=Object.keys(clientToolSchemas).find(key=>'primecare_'+key.replaceAll('.','_')===name);
  if(!key||!pack.agents[this.#agent].includes(key)||!args||typeof args!=='object'||Array.isArray(args)||Object.keys(args).length)fail('invalid_tool_input');
  if(key==='client.service_history'){
   const body=await this.#read('/visits?limit=25&offset=0'),items=this.#list(body,'visits').map(row=>{if(!safeText(row.status)||typeof row.requested_start_at!=='string'||!Number.isFinite(Date.parse(row.requested_start_at))||!Number.isSafeInteger(row.duration_minutes)||row.duration_minutes<0)fail('invalid_native_response');return {status:row.status,requestedStartAt:row.requested_start_at,durationMinutes:row.duration_minutes};});
   return {records:items,total:body.pagination.total,hasMore:body.pagination.hasMore,source:'owned_client_visit_records',clinicalCompletionVerified:false};
  }
  const profile=await this.#read('/home/profile');if(!profile.profile||typeof profile.profile.id!=='string')fail('invalid_native_response');
  const consents=await this.#read('/consents?limit=25&offset=0'),authorizations=await this.#read('/service-authorizations?limit=25&offset=0');
  const consentStatuses=this.#list(consents,'consents').map(row=>{if(!safeText(row.form_type)||!safeText(row.status))fail('invalid_native_response');return {formType:row.form_type,status:row.status};});
  const authorizationStatuses=this.#list(authorizations,'authorizations').map(row=>{if(!safeText(row.status))fail('invalid_native_response');return {status:row.status};});
  this.#current();return {profileAvailable:true,consentStatuses,authorizationStatuses,hasMore:consents.pagination.hasMore||authorizations.pagination.hasMore,overallOnboardingComplete:null,clinicalEligibilityAssessed:false};
 }
}
