import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {savedAgents} from './vapi-agent-library.mjs';
const org='9e1d8550-4b84-4472-a782-67557fe73944';
const uuid=v=>typeof v==='string'&&/^[a-f0-9-]{36}$/i.test(v);
const hash=s=>createHash('sha256').update(s).digest('hex');
const fail=code=>{throw Error(code);};
const subset=(actual,expected)=>Array.isArray(expected)?Array.isArray(actual)&&actual.length===expected.length&&expected.every((x,i)=>subset(actual[i],x)):expected&&typeof expected==='object'?!!actual&&Object.entries(expected).every(([k,v])=>subset(actual[k],v)):isDeepStrictEqual(actual,expected);
/** Deployment-only native Query Tool provisioning. No credential mutations,
 * callers, business records, arbitrary URLs, file replacement or blind retries. */
export class VapiPublicKnowledgeClient extends BoundedBinaryAdapterBase {
 #key;#send;
 constructor({apiKey,fetch:send=globalThis.fetch}){super(1048576);if(typeof apiKey!=='string'||apiKey.length<16||typeof send!=='function')fail('configuration_required');this.#key=apiKey;this.#send=send;}
 async #request(path,method='GET',body){
  if(!(/^\/(?:file|tool)(?:\/[a-f0-9-]{36})?$/.test(path)||/^\/chat(?:\/[A-Za-z0-9_-]{1,100})?$/.test(path))||!['GET','POST'].includes(method)||method==='POST'&&!['/file','/tool','/chat'].includes(path))fail('operation_denied');
  const send=this.#send,response=await send('https://api.vapi.ai'+path,{method,redirect:'manual',signal:AbortSignal.timeout(20000),headers:{authorization:'Bearer '+this.#key,accept:'application/json',...(body&&!(body instanceof FormData)?{'content-type':'application/json'}:{})},...(body?{body:body instanceof FormData?body:JSON.stringify(body)}:{})});
  if(!response.ok||method==='POST'&&path!=='/chat'&&response.status!==201){await response.body?.cancel();throw Object.assign(Error([401,403].includes(response.status)?'authentication_denied':'provider_request_failed'),{httpStatus:response.status});}
  return JSON.parse(new TextDecoder('utf-8',{fatal:true}).decode(await this.readBoundedBody(response.body)));
 }
 #scope(row){if(!row||row.orgId!==org||!uuid(row.id))fail('provider_scope_changed');return row;}
 async ensure(text){
  if(typeof text!=='string'||!text.trim()||new TextEncoder().encode(text).length>300000)fail('public_knowledge_required');
  const digest=hash(text),filename='primecare-info-'+digest.slice(0,12)+'.txt';
  const files=await this.#request('/file');if(!Array.isArray(files)||files.length>200)fail('invalid_file_inventory');
  const matches=files.filter(f=>f.originalName===filename||f.name===filename);if(matches.length>1)fail('ambiguous_public_file');
  let file=matches[0];
  if(file){this.#scope(file);if(file.metadata?.primecareSha256!==digest)fail('edited_public_file_preserved');}
  else{const form=new FormData();form.set('file',new Blob([text],{type:'text/plain'}),filename);form.set('metadata',JSON.stringify({primecareSha256:digest,scope:'public-enquiry-information'}));file=this.#scope(await this.#request('/file','POST',form));}
  for(let i=0;i<30;i++){file=this.#scope(await this.#request('/file/'+file.id));if(file.status==='done')break;if(file.status!=='processing')fail('knowledge_file_failed');if(i<29)await new Promise(r=>setTimeout(r,1000));}
  if(file.status!=='done'||file.metadata?.primecareSha256!==digest)fail('knowledge_file_not_ready');
  // The URL is returned by the authenticated provider file read, never a caller.
  const url=new URL(file.url);if(url.protocol!=='https:'||url.username||url.password||!['auth.vapi.ai','storage.vapi.ai','jtuyprjjgxbgmtjiykoa.supabase.co'].includes(url.hostname)||url.hostname==='jtuyprjjgxbgmtjiykoa.supabase.co'&&!url.pathname.startsWith('/storage/v1/object/'))throw Object.assign(Error('unsupported_file_storage_preserved'),{storageHost:url.hostname});
  const send=this.#send,readback=await send(url.href,{method:'GET',redirect:'manual',signal:AbortSignal.timeout(15000)});
  if(!readback.ok){await readback.body?.cancel();fail('knowledge_readback_failed');}
  const bytes=await this.readBoundedBody(readback.body);if(hash(bytes)!==digest)fail('knowledge_content_mismatch');
  const payload={type:'query',function:{name:'primecare_service_information'},knowledgeBases:[{provider:'google',name:'primecare-public-enquiries',description:'Approved PSW and home-care enquiry categories and administrative limits. No prices, availability, patient records or clinical guidance.',fileIds:[file.id]}]};
  const tools=await this.#request('/tool');if(!Array.isArray(tools)||tools.length>200)fail('invalid_tool_inventory');const found=tools.filter(t=>t.function?.name===payload.function.name);if(found.length>1)fail('ambiguous_public_query');
  let tool=found[0];if(tool){this.#scope(tool);if(!subset(tool,payload)||tool.server)fail('edited_query_preserved');}else tool=this.#scope(await this.#request('/tool','POST',payload));
  tool=this.#scope(await this.#request('/tool/'+tool.id));if(!subset(tool,payload)||tool.server)fail('query_readback_failed');
  return Object.freeze({toolId:tool.id,fileId:file.id,contentSha256:digest,contentReadback:true,configurationReadback:true});
 }
 async probe(assistantId){
  if(!Object.values(savedAgents).includes(assistantId))fail('chat_probe_scope_required');
  const chat=await this.#request('/chat','POST',{assistantId,input:'This is a public-information test. Use the service information query tool to name the listed PrimeCare enquiry categories. Does that source provide prices or confirmed appointment availability? Do not access accounts, save records, call or message anyone.'});
  if(chat.orgId!==org||chat.assistantId!==assistantId||typeof chat.id!=='string'||! /^[A-Za-z0-9_-]{1,100}$/.test(chat.id))fail('chat_probe_scope_changed');
  const saved=await this.#request('/chat/'+chat.id);if(saved.id!==chat.id||saved.orgId!==org||saved.assistantId!==assistantId)fail('chat_readback_failed');
  const messages=[...(saved.messages??[]),...(saved.output??[])],calls=messages.flatMap(m=>m.tool_calls??[]).filter(t=>t.function?.name==='primecare_service_information'),ids=new Set(calls.map(t=>t.id));
  const results=messages.filter(m=>m.role==='tool'&&ids.has(m.tool_call_id)&&typeof m.content==='string');
  const answer=messages.filter(m=>m.role==='assistant'&&typeof m.content==='string').map(m=>m.content).join(' ');
  const categories=s=>/\bpsw\b/i.test(s)&&/home[ _-]*care/i.test(s);
  const result={chatId:chat.id,assistantId,chatReadback:true,queryInvoked:calls.length>0,queryResultReceived:results.length>0,sourceCategoriesReturned:results.some(m=>categories(m.content)),answerMatchesCategories:categories(answer),unapprovedPriceDetected:/(?:CAD|USD|\$)\s*\d/i.test(answer),callsStarted:false,smsSent:false,businessWrites:false};
  if(!result.queryInvoked||!result.queryResultReceived||!result.sourceCategoriesReturned||!result.answerMatchesCategories||result.unapprovedPriceDetected)throw Object.assign(Error('public_query_acceptance_failed'),{acceptance:result});
  return result;
 }

}
