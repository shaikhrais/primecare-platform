import test from 'node:test';
import assert from 'node:assert/strict';
import {VapiAdminClient} from '../packages/shared/src/communications/vapi-admin.mjs';
import {handleVapiAdmin} from '../packages/shared/src/communications/vapi-admin-http.mjs';
const org='10000000-0000-4000-8000-000000000000',id='20000000-0000-4000-8000-000000000000',toolId='30000000-0000-4000-8000-000000000000',secret='synthetic-secret-never-export';
const model={provider:'openai',model:'test-model',messages:[{role:'system',content:'test'}],tools:[{type:'endCall'}],temperature:0.2,toolIds:[]};
const agent=()=>({id,orgId:org,name:'Test',firstMessage:'Hello',model:structuredClone(model),artifactPlan:{recordingEnabled:false}});
const entry={key:'test',name:'test_api',enabled:true,url:'https://example.invalid/approved',method:'POST',credentialId:toolId,description:'Test approved capability',body:{type:'object',properties:{},additionalProperties:false}};
function client(fn,catalog=[entry]){return new VapiAdminClient({apiKey:secret,orgId:org,templateId:id,catalog,fetch:async(url,options)=>{assert.ok(url.startsWith('https://api.vapi.ai/'));assert.equal(options.redirect,'error');return fn(url.replace('https://api.vapi.ai',''),options);}});}
test('inventory projects private provider objects and filters other organizations',async()=>{
 const c=client((path)=>Response.json(path==='/assistant'?[{...agent(),twilioAuthToken:secret,server:{url:'https://private.invalid'}},{...agent(),orgId:toolId}]:[{id:toolId,orgId:org,type:'apiRequest',name:'test_api',url:entry.url,headers:{authorization:secret},credentialId:toolId}]));
 const result=await c.inventory();assert.equal(result.assistants.length,1);assert.ok(!JSON.stringify(result).includes(secret));assert.ok(!JSON.stringify(result).includes('private.invalid'));assert.ok(!JSON.stringify(result).includes(entry.url));
});
test('agent creation validates inputs before transport, reads back saved fields and endCall',async()=>{
 let created,posts=0;const c=client((path,o)=>{if(o.method==='POST'){posts++;created={...agent(),...JSON.parse(o.body)};return Response.json(created,{status:201});}return Response.json(created??agent());});
 await assert.rejects(c.createAgent({name:'x',firstMessage:'Hi',prompt:'x',url:'https://evil.invalid'}));assert.equal(posts,0);
 const result=await c.createAgent({name:'New agent',firstMessage:'AI speaking',prompt:'Only answer general questions.'});assert.equal(result.verified,true);assert.equal(posts,1);assert.equal(created.model.tools[0].type,'endCall');assert.equal(created.model.temperature,undefined);assert.equal(created.voice,undefined);
});
test('unverified save fails without retry',async()=>{let posts=0;const c=client((path,o)=>{if(o.method==='POST'){posts++;return Response.json(agent(),{status:201});}return Response.json(agent());});await assert.rejects(c.createAgent({name:'New',firstMessage:'Hello',prompt:'changed'}),e=>e.code==='unverified_write');assert.equal(posts,1);});
test('approved tool creation reuses exact matching resource; rejects altered endpoint',async()=>{
 const tool={id:toolId,orgId:org,type:'apiRequest',...entry};delete tool.key;delete tool.enabled;
 const c=client(path=>Response.json(path==='/tool'?[tool]:tool));assert.equal((await c.createTool('test')).reused,true);
 await assert.rejects(c.createTool('arbitrary'),e=>e.code==='capability_not_ready');
 const wrong=client(path=>Response.json(path==='/tool'?[tool]:{...tool,url:'https://evil.invalid'}));await assert.rejects(wrong.createTool('test'),e=>e.code==='scope_denied');
});
test('attachment preserves entire model and unrelated inline tools',async()=>{
 let current=agent(),patches=0;const tool={id:toolId,orgId:org,type:'apiRequest',name:entry.name,description:entry.description,url:entry.url,method:entry.method,credentialId:toolId,body:entry.body};
 const c=client((path,o)=>{if(path.startsWith('/tool/'))return Response.json(tool);if(o.method==='PATCH'){patches++;current.model=JSON.parse(o.body).model;}return Response.json(current);});
 await c.attach(id,toolId,'test');assert.equal(patches,1);assert.deepEqual({...current.model,toolIds:[]},model);await c.attach(id,toolId,'test');assert.equal(patches,1);await c.attach(id,toolId,'test',false);assert.equal(patches,2);assert.deepEqual(current.model,model);
});
test('foreign organization and provider errors never expose secret',async()=>{for(const response of [()=>Response.json({...agent(),orgId:toolId}),()=>new Response(secret,{status:401})]){const c=client(response);await assert.rejects(c.createAgent({name:'New',firstMessage:'Hi',prompt:'test'}),e=>!String(e).includes(secret));}});
const request=(path,body,headers={})=>new Request('https://primecare.invalid/v1/governance/platform/vapi/'+path,{method:body?'POST':'GET',headers:{...(body?{'content-type':'application/json','idempotency-key':'synthetic-request-12345'}:{}),...headers},...(body?{body:JSON.stringify(body)}:{})});
test('HTTP rejects denied session before provider access and missing configuration',async()=>{
 const denied=await handleVapiAdmin(request('inventory'),{authorize:async()=>{throw {status:403};},client:{inventory(){throw Error('Must not call');}}});assert.equal(denied.status,403);
 assert.equal((await handleVapiAdmin(request('inventory'),{authorize:async()=>{}})).status,503);
});
test('HTTP rejects unknown fields and replays durable receipts without duplicate mutation',async()=>{
 let writes=0,checks=0;const ports={authorize:async()=>{checks++;},client:{createTool:async()=>{writes++;return {toolId,verified:true};}},claim:async()=>({body:{toolId,verified:true},status:200}),complete:async()=>{}};
 assert.equal((await handleVapiAdmin(request('tools',{key:'test',url:'evil'}),ports)).status,400);
 assert.equal((await handleVapiAdmin(request('tools',{key:'test'}),ports)).status,200);assert.equal(writes,0);
 ports.claim=async()=>null;assert.equal((await handleVapiAdmin(request('tools',{key:'test'}),ports)).status,200);assert.equal(writes,1);assert.equal(checks,5);
});
test('durable pending receipt blocks ambiguous write retry',async()=>{const r=await handleVapiAdmin(request('tools',{key:'test'}),{authorize:async()=>{},client:{},claim:async()=>({body:{error:'reconciliation_required'},status:409})});assert.equal(r.status,409);});
