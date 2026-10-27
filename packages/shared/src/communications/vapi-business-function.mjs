import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import {savedAgents} from './vapi-agent-library.mjs';
const uuid=v=>typeof v==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(v);
const id=v=>typeof v==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(v);
const hex=bytes=>Array.from(new Uint8Array(bytes),b=>b.toString(16).padStart(2,'0')).join('');
const digest=async s=>hex(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(s)));
const canonical=v=>Array.isArray(v)?'['+v.map(canonical).join(',')+']':v&&typeof v==='object'?'{'+Object.keys(v).sort().map(k=>JSON.stringify(k)+':'+canonical(v[k])).join(',')+'}':JSON.stringify(v);
function operationId(hash){const h=hash.slice(0,12)+'4'+hash.slice(13,16)+((parseInt(hash[16],16)&3)|8).toString(16)+hash.slice(17,32);return [h.slice(0,8),h.slice(8,12),h.slice(12,16),h.slice(16,20),h.slice(20)].join('-');}
const response=(body,status=200)=>Response.json(body,{status,headers:{'cache-control':'no-store','x-content-type-options':'nosniff'}});
/** Result-returning Vapi server protocol around the business runner. Existing
 * authentication/canonical-call resolution and durable journal are mandatory
 * host ports. This adapter never creates identity, mounts a URL or grants access. */
export class VapiBusinessFunctionAdapter extends BoundedBinaryAdapterBase {
 #authenticate;#authorize;#contexts;#journal;
 constructor({authenticate,authorize,contexts,journal}){super(65536);if(typeof authenticate!=='function'||typeof authorize!=='function'||typeof contexts?.current!=='function'||typeof journal?.begin!=='function'||typeof journal?.complete!=='function')throw Error('Existing trusted business host required');this.#authenticate=authenticate;this.#authorize=authorize;this.#contexts=contexts;this.#journal=journal;}
 async #current(callId,previous){
  const c=await this.#contexts.current(callId);
  if(!c||!id(c.scopeKey)||!Number.isSafeInteger(c.expiresAt)||c.expiresAt<=Date.now()||typeof c.runner?.functionDefinitions!=='function'||typeof c.runner?.executeFunction!=='function'||!Object.hasOwn(savedAgents,c.agentKey)||!(savedAgents[c.agentKey]===c.assistantId||c.agentKey==='reception'&&c.assistantId==='5ae2ab0c-fad0-454c-8cf7-64b81c91c850')||previous&&(c.scopeKey!==previous.scopeKey||c.assistantId!==previous.assistantId||c.agentKey!==previous.agentKey))throw Error('Business context unavailable');return c;
 }
 async #allowed(callId,previous,name){const c=await this.#current(callId,previous);if(await this.#authorize(c,name)!==true)throw Error('Business tool denied');return this.#current(callId,c);}
 async respond(request){
  let consumed=false;
  try{
   if(request.method!=='POST')return response({error:'method_not_allowed'},405);
   if(await this.#authenticate(request)!==true)return response({error:'unauthorized'},401);
   if(!/^application\/json(?:\s*;|$)/i.test(request.headers.get('content-type')??'')||request.headers.has('content-encoding'))return response({error:'invalid_tool_request'},400);
   consumed=true;let body;try{body=JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(request.body)));}catch{return response({error:'invalid_tool_request'},400);}
   const m=body?.message,list=m?.toolCallList,callId=m?.call?.id;
   if(m?.type!=='tool-calls'||!uuid(callId)||!Array.isArray(list)||!list.length||list.length>5||list.some(t=>!id(t?.id)||t.type!=='function'||!id(t.function?.name))||new Set(list.map(t=>t.id)).size!==list.length)return response({error:'invalid_tool_request'},400);
   const context=await this.#current(callId),names=new Set(context.runner.functionDefinitions().map(d=>d.function.name)),results=[];
   for(const tool of list){
    const unavailable=()=>({toolCallId:tool.id,error:'Business tool unavailable. Do not retry an uncertain change; check saved status.'});
    try{
     if(!names.has(tool.function.name))throw Error();let args=tool.function.arguments;
     if(typeof args==='string'){if(args.length>16384)throw Error();args=JSON.parse(args);}
     if(!args||typeof args!=='object'||Array.isArray(args)||new TextEncoder().encode(JSON.stringify(args)).length>16384||Object.keys(args).some(k=>['actor','tenantId','sessionId','token','credential','url','operationId','leadId','ownerId','version'].includes(k)))throw Error();
     await this.#allowed(callId,context,tool.function.name);
     const hash=await digest(canonical({callId,scope:context.scopeKey,name:tool.function.name,args})),key={callId,scopeKey:context.scopeKey,toolCallId:tool.id,digest:hash};
     const entry=await this.#journal.begin(key);await this.#allowed(callId,context,tool.function.name);
     if(entry?.status==='complete'){if(entry.digest!==hash||typeof entry.result!=='string'||new TextEncoder().encode(entry.result).length>8192)throw Error();results.push({toolCallId:tool.id,result:entry.result});continue;}
     if(entry?.status!=='new')throw Error();
     const op=operationId(await digest(canonical({callId,scope:context.scopeKey,toolCallId:tool.id}))),result=await context.runner.executeFunction(tool.function.name,structuredClone(args),op);
     const encoded=JSON.stringify(result);if(typeof encoded!=='string'||new TextEncoder().encode(encoded).length>8192)throw Error();
     await this.#allowed(callId,context,tool.function.name);await this.#journal.complete({...key,result:encoded});await this.#allowed(callId,context,tool.function.name);
     results.push({toolCallId:tool.id,result:encoded});
    }catch{results.push(unavailable());}
   }
   return response({results});
  }catch{return response({error:'business_tools_unavailable'},503);}finally{if(!consumed)try{await request.body?.cancel();}catch{}}
 }
}
