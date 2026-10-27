import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import registry from '../growth/registry.json' with {type:'json'};
import pack from '../vapi-agent-tool-pack.json' with {type:'json'};
const uuid=v=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/i.test(v);
const text=(v,n=500)=>typeof v==='string'&&v.length<=n&&!/[\u0000-\u001f\u007f]/.test(v);
const exact=(v,keys)=>v&&typeof v==='object'&&!Array.isArray(v)&&Object.keys(v).every(k=>keys.includes(k));
const version=v=>Number.isSafeInteger(v)&&v>0;
const fail=code=>{throw Object.assign(Error(code),{code});};
const project=l=>Object.freeze({id:l.id,pipeline:l.pipeline,stage:l.stage,version:l.version});
/** Native staff API transport, not an authentication implementation or a mounted
 * Vapi function server. The host supplies its EXISTING authenticated fetch and
 * current scope. Model input cannot choose a token, tenant, URL, lead or owner.
 * Growth APIs retain their own role/tenant/current-session/idempotency rules. */
export class VapiGrowthToolClient extends BoundedBinaryAdapterBase {
 #send;#scope;#initial;#context;
 constructor({agentKey,fetch:send,currentScope,leadId,ownerId,appointmentId,search=''}){
  super(1048576);
  if(!Object.hasOwn(pack.agents,agentKey)||typeof send!=='function'||typeof currentScope!=='function'||leadId!==undefined&&!uuid(leadId)||ownerId!==undefined&&!uuid(ownerId)||appointmentId!==undefined&&!uuid(appointmentId)||!text(search,100))fail('tool_configuration_required');
  this.#send=send;this.#scope=currentScope;this.#initial=currentScope();if(!text(this.#initial,200)||!this.#initial)fail('native_context_required');
  this.#context=Object.freeze({agentKey,leadId,ownerId,appointmentId,search});
 }
 #current(){if(this.#scope()!==this.#initial)fail('native_context_changed');}
 async #request(method,suffix,body,key){
  this.#current();const send=this.#send;
  const response=await send('https://primecare-api-gateway.itpro-mohammed.workers.dev'+registry.endpoint+suffix,{method,redirect:'manual',headers:{accept:'application/json',...(body?{'content-type':'application/json','idempotency-key':key}:{})},...(body?{body:JSON.stringify(body)}:{})});
  this.#current();if(!response.ok){await response.body?.cancel();fail([401,403].includes(response.status)?'native_api_denied':response.status===409?'native_api_conflict':'native_api_unavailable');}
  let result;try{result=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(response.body)));}catch{fail('invalid_native_response');}
  this.#current();if(!result||typeof result!=='object'||Array.isArray(result)||Object.hasOwn(result,'error'))fail('invalid_native_response');return result;
 }
 async #snapshot(q=this.#context.search,id=this.#context.leadId){
  for(let offset=0;offset<500;offset+=100){const p=new URLSearchParams({offset:String(offset)});if(q)p.set('q',q);const snapshot=await this.#request('GET','?'+p);
   if(!Array.isArray(snapshot.leads)||snapshot.leads.length>100)fail('invalid_native_response');
   const found=snapshot.leads.filter(l=>l.id===id);if(found.length>1)fail('ambiguous_lead');
   if(found.length){const lead=found[0];if(!uuid(lead.id)||!version(lead.version)||!registry.pipelines[lead.pipeline]||![...registry.pipelines[lead.pipeline],'lost'].includes(lead.stage))fail('invalid_native_response');return {snapshot,lead};}
   if(snapshot.leads.length<100)break;
  }fail('bound_lead_unavailable');
 }
 async execute(key,input={},operationId){
  if(!exact(input,[])&&(!input||typeof input!=='object'||Array.isArray(input)))fail('invalid_tool_input');
  const allowed={
   'lead.lookup':[],'lead.contact_preferences':[],
   'lead.create':['name','email','phone','source','reference','contactBasis','dueAt'],
   'lead.advance':['evidence','dueAt'],'lead.followup':['outcome','notes','dueAt'],
   'lead.suppress':['notes'],'lead.contact_update':['name','email','phone','evidence'],
   'consultation.create':['startsAt','duration','notes'],'consultation.update':['status','notes']
  };
  if(!pack.agents[this.#context.agentKey].includes(key)||!Object.hasOwn(allowed,key)||!exact(input,allowed[key]))fail('invalid_tool_input');
  input=structuredClone(input);const encoded=new TextEncoder().encode(JSON.stringify(input));if(encoded.length>16384)fail('invalid_tool_input');this.validateBytes(encoded);this.#current();
  if(key==='lead.create'){
   if(!this.#context.ownerId||!text(input.name,150)||!input.name.trim()||!text(input.email??'',254)||!text(input.phone??'',40)||!registry.sources.includes(input.source)||!text(input.reference)||!['requested','not_requested'].includes(input.contactBasis))fail('invalid_tool_input');
   const body={...input,pipeline:'client',ownerId:this.#context.ownerId,campaignId:null,dueAt:input.dueAt??null};
   return this.#save(key,'POST','/leads',body,operationId,async receipt=>{const {lead}=await this.#snapshot(input.name,receipt.id);if(lead.version!==receipt.version||lead.name!==input.name.trim()||lead.pipeline!=='client'||lead.contact_basis!==input.contactBasis||lead.email!==(input.email??'').trim().toLowerCase()||lead.phone!==(input.phone??'').trim())fail('readback_mismatch');return project(lead);});
  }
  if(!this.#context.leadId)fail('bound_lead_required');const {lead,snapshot}=await this.#snapshot();
  if(key==='lead.lookup')return project(lead);
  if(key==='lead.contact_preferences')return Object.freeze({...project(lead),suppressed:lead.contact_blocked===true,requestedContact:lead.contact_basis==='requested',outboundAuthorizationRequired:true});
  if(key==='lead.advance'){
   const next=registry.pipelines[lead.pipeline][registry.pipelines[lead.pipeline].indexOf(lead.stage)+1];
   if(lead.stage==='lost'||!next||lead.nextStage!==next||!text(input.evidence)||!input.evidence.trim())fail('stage_change_unavailable');
   const body={version:lead.version,stage:next,ownerId:lead.owner_id,dueAt:input.dueAt??lead.due_at??null,evidence:input.evidence};
   return this.#save(key,'PATCH','/leads/'+lead.id,body,operationId,async r=>{const {lead:l}=await this.#snapshot();if(l.version!==r.version||l.stage!==next)fail('readback_mismatch');return project(l);});
  }
  if(key==='lead.followup'||key==='lead.suppress'){
   const outcome=key==='lead.suppress'?'do_not_contact':input.outcome;
   if(!registry.callOutcomes.includes(outcome)||!text(input.notes)||!input.notes.trim())fail('invalid_tool_input');
   const body={leadId:lead.id,leadVersion:lead.version,outcome,notes:input.notes,dueAt:key==='lead.suppress'?null:input.dueAt??null};
   return this.#save(key,'POST','/calls',body,operationId,async r=>{const {lead:l,snapshot:s}=await this.#snapshot();const calls=s.calls?.filter(c=>c.id===r.id&&c.lead_id===lead.id&&c.outcome===outcome);if(!version(r.leadVersion)||l.version!==r.leadVersion||calls?.length!==1||outcome==='do_not_contact'&&l.contact_blocked!==true)fail('readback_mismatch');return Object.freeze({id:r.id,leadVersion:l.version,outcome,suppressionSaved:outcome==='do_not_contact'});});
  }
  if(key==='lead.contact_update'){
   if(!text(input.name,150)||!text(input.email,254)||!text(input.phone,40)||!text(input.evidence)||!input.evidence.trim())fail('invalid_tool_input');
   return this.#save(key,'PATCH','/contacts/'+lead.id,{...input,version:lead.version},operationId,async r=>{const {lead:l}=await this.#snapshot();if(l.version!==r.version||l.name!==input.name.trim()||l.email!==input.email.trim().toLowerCase()||l.phone!==input.phone.trim())fail('readback_mismatch');return Object.freeze({id:r.id,version:r.version});});
  }
  if(!text(input.notes)||!input.notes.trim())fail('invalid_tool_input');
  if(key==='consultation.create'){
   if(!this.#context.ownerId||typeof input.startsAt!=='string'||!Number.isFinite(Date.parse(input.startsAt))||Date.parse(input.startsAt)<=Date.now()||!Number.isInteger(input.duration)||input.duration<15||input.duration>180)fail('invalid_tool_input');
   return this.#save(key,'POST','/appointments',{...input,leadId:lead.id,ownerId:this.#context.ownerId},operationId,r=>this.#appointment(r,'scheduled',{startsAt:input.startsAt,duration:input.duration,ownerId:this.#context.ownerId}));
  }
  const appt=snapshot.appointments?.filter(a=>a.id===this.#context.appointmentId&&a.lead_id===lead.id);
  if(appt?.length!==1||!version(appt[0].version)||!['completed','cancelled','no_show'].includes(input.status))fail('bound_appointment_required');
  return this.#save(key,'PATCH','/appointments/'+this.#context.appointmentId,{...input,version:appt[0].version},operationId,r=>this.#appointment(r,input.status));
 }
 async #appointment(receipt,status,expected){const {snapshot}=await this.#snapshot();const rows=snapshot.appointments?.filter(a=>a.id===receipt.id&&a.lead_id===this.#context.leadId&&a.version===receipt.version&&a.status===status);if(rows?.length!==1||expected&&(Date.parse(rows[0].starts_at)!==Date.parse(expected.startsAt)||Date.parse(rows[0].ends_at)!==Date.parse(expected.startsAt)+expected.duration*60000||rows[0].owner_id!==expected.ownerId))fail('readback_mismatch');return Object.freeze({id:receipt.id,version:receipt.version,status,kind:'crm_coordination',clinicalBookingConfirmed:false});}
 async #save(tool,method,path,body,operationId,verify){
  if(!uuid(operationId))fail('stable_operation_id_required');const key='voice_'+tool.replaceAll('.','_')+'_'+operationId.replaceAll('-','');
  let attempted=false;
  try{this.#current();attempted=true;const receipt=await this.#request(method,path,body,key);if(!uuid(receipt.id)||method==='PATCH'&&receipt.id!==path.split('/').at(-1)||!version(receipt.version??receipt.leadVersion))fail('invalid_native_response');const result=await verify(receipt);this.#current();return Object.freeze({saved:true,...result});}
  catch(error){if(['native_api_denied','native_api_conflict'].includes(error?.code))throw error;if(attempted)fail('tool_result_unknown_check_status');throw error;}
 }
}
