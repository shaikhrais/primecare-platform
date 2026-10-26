import {VapiManagementClient,VapiManagementError} from './vapi-management.mjs';
const uuid=v=>typeof v==='string'&&/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(v);
const fail=code=>{throw new VapiManagementError(code);};
const text=(v,max)=>typeof v==='string'&&v.trim().length>0&&v.length<=max&&!/[\u0000-\u0008\u000b\u000c\u000e-\u001f]/.test(v);
const canonical=v=>JSON.stringify(v,(_,x)=>x&&typeof x==='object'&&!Array.isArray(x)?Object.fromEntries(Object.entries(x).sort(([a],[b])=>a.localeCompare(b))):x);
/** Server-owned policy and catalogue. Browser input never supplies URLs, credentials,
 * tenant identity or provider payloads. Inherits the existing management boundary. */
export class VapiAdminClient extends VapiManagementClient {
 #key;#fetch;#org;#template;#catalog;
 constructor({apiKey,orgId,templateId,catalog=[],fetch:request=globalThis.fetch}){
  super({apiKey,fetch:request});if(!uuid(orgId)||!uuid(templateId)||!Array.isArray(catalog)||catalog.length>100)fail('configuration_required');
  this.#key=apiKey;this.#fetch=request;this.#org=orgId;this.#template=templateId;this.#catalog=structuredClone(catalog);
 }
 async #request(path,body,method='GET'){
  try{const r=await this.#fetch('https://api.vapi.ai'+path,{method,redirect:'error',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+this.#key,accept:'application/json',...(body?{'content-type':'application/json'}:{})},...(body?{body:JSON.stringify(body)}:{})});
   if(!r.ok){await r.body?.cancel();fail([401,403].includes(r.status)?'authentication_denied':r.status===404?'resource_not_found':r.status===400?'invalid_configuration':'provider_unavailable');}
   if(method==='POST'&&r.status!==201)fail('unverified_write');
   return JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(r.body)));
  }catch(e){if(e instanceof VapiManagementError)throw e;fail('provider_unavailable');}
 }
 #scope(row){if(!row||row.orgId!==this.#org||!uuid(row.id))fail('scope_denied');return row;}
 #agent(row){this.#scope(row);if(JSON.stringify([row.name,row.firstMessage,row.model?.messages]).includes(this.#key))fail('invalid_provider_response');return {id:row.id,name:typeof row.name==='string'?row.name.slice(0,200):'Unnamed',firstMessage:typeof row.firstMessage==='string'?row.firstMessage.slice(0,4000):'',prompt:Array.isArray(row.model?.messages)?row.model.messages.filter(m=>m.role==='system'&&typeof m.content==='string').map(m=>m.content).join('\n').slice(0,65536):'',toolIds:Array.isArray(row.model?.toolIds)?row.model.toolIds.filter(uuid):[],updatedAt:typeof row.updatedAt==='string'?row.updatedAt:null};}
 async inventory(){
  const agents=await this.#request('/assistant');if(!Array.isArray(agents)||agents.length>200)fail('invalid_provider_response');
  const tools=(await this.tools()).filter(t=>t.orgId===this.#org);
  return {assistants:agents.filter(a=>a?.orgId===this.#org).map(a=>this.#agent(a)),tools:tools.map(({id,type,name,credentialConfigured})=>({id,type,name,credentialConfigured})),catalog:this.#catalog.map(c=>({key:c.key,name:c.name,enabled:c.enabled===true})),routingChanged:false};
 }
 async createAgent(input){
  if(!input||Object.keys(input).some(k=>!['name','firstMessage','prompt'].includes(k))||!text(input.name,40)||!text(input.firstMessage,4000)||!text(input.prompt,32000))fail('invalid_configuration');
  const template=this.#scope(await this.#request('/assistant/'+this.#template));
  if(!template.model||!text(template.model.provider,100)||!text(template.model.model,200))fail('configuration_required');
  // Use verified template model selection, without copying tools, URLs, credentials or deprecated voice IDs.
  const body={name:input.name.trim(),firstMessage:input.firstMessage,model:{provider:template.model.provider,model:template.model.model,messages:[{role:'system',content:input.prompt}],tools:[{type:'endCall'}]},artifactPlan:{recordingEnabled:false},maxDurationSeconds:600};
  const created=this.#scope(await this.#request('/assistant',body,'POST'));
  const saved=this.#scope(await this.#request('/assistant/'+created.id));
  if(saved.name!==body.name||saved.firstMessage!==body.firstMessage||canonical(saved.model?.messages)!==canonical(body.model.messages)||!saved.model?.tools?.some(t=>t.type==='endCall')||saved.artifactPlan?.recordingEnabled!==false)fail('unverified_write');
  return {assistant:this.#agent(saved),verified:true,routingChanged:false};
 }
 #entry(key){const matches=this.#catalog.filter(c=>c.key===key&&c.enabled===true);if(matches.length!==1)fail('capability_not_ready');const c=matches[0];if(!text(c.name,64)||! /^[a-zA-Z0-9_-]+$/.test(c.name)||!uuid(c.credentialId)||!['GET','POST','PUT','PATCH','DELETE'].includes(c.method))fail('configuration_required');let u;try{u=new URL(c.url);}catch{fail('configuration_required');}if(u.protocol!=='https:'||u.username||u.password||u.search||u.hash)fail('configuration_required');return c;}
 #payload(c){return {type:'apiRequest',name:c.name,description:c.description,url:c.url,method:c.method,credentialId:c.credentialId,...(c.body?{body:c.body}:{})};}
 #matches(row,payload){return Object.entries(payload).every(([k,v])=>canonical(row[k])===canonical(v));}
 async createTool(key){const c=this.#entry(key),payload=this.#payload(c);const inventory=await this.tools();const matches=inventory.filter(t=>t.orgId===this.#org&&t.name===c.name);if(matches.length>1)fail('scope_denied');
  if(matches.length===1){const row=this.#scope(await this.#request('/tool/'+matches[0].id));if(!this.#matches(row,payload))fail('scope_denied');return {toolId:row.id,verified:true,reused:true};}
  const created=this.#scope(await this.#request('/tool',payload,'POST'));const row=this.#scope(await this.#request('/tool/'+created.id));if(!this.#matches(row,payload))fail('unverified_write');return {toolId:row.id,verified:true,reused:false};
 }
 async attach(assistantId,toolId,key,attached=true){
  if(!uuid(assistantId)||!uuid(toolId)||typeof attached!=='boolean')fail('invalid_resource');const c=this.#entry(key),tool=this.#scope(await this.#request('/tool/'+toolId));if(!this.#matches(tool,this.#payload(c)))fail('scope_denied');
  const before=this.#scope(await this.#request('/assistant/'+assistantId));if(!before.model||typeof before.model!=='object'||before.model.toolIds!==undefined&&!Array.isArray(before.model.toolIds))fail('invalid_provider_response');
  const model=structuredClone(before.model),ids=model.toolIds??[];model.toolIds=attached?[...new Set([...ids,toolId])]:ids.filter(id=>id!==toolId);
  if(canonical(model)!==canonical(before.model))await this.#request('/assistant/'+assistantId,{model},'PATCH');
  const saved=this.#scope(await this.#request('/assistant/'+assistantId));if(canonical(saved.model)!==canonical(model))fail('unverified_write');return {assistant:this.#agent(saved),verified:true,routingChanged:false};
 }
}
