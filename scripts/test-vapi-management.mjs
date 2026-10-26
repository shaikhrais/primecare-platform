import {test} from 'node:test';
import assert from 'node:assert/strict';
import {VapiManagementClient} from '../packages/shared/src/communications/vapi-management.mjs';
const id='5ae2ab0c-fad0-454c-8cf7-64b81c91c850',org='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',key='private-vapi-fixture-key';
const assistant={id,orgId:org,name:'PrimeCare',firstMessage:'Hello',model:{messages:[{role:'system',content:'Test prompt'}]},artifactPlan:{recordingEnabled:false},maxDurationSeconds:600};
test('fixed provider reads return projections without embedded credentials',async()=>{
 const client=new VapiManagementClient({apiKey:key,async fetch(url,options){assert.equal(url,'https://api.vapi.ai/assistant/'+id);assert.equal(options.redirect,'manual');assert.equal(options.headers.authorization,'Bearer '+key);return Response.json({...assistant,credential:key});}});
 const row=await client.assistant(id);assert.equal(row.prompt,'Test prompt');assert.equal(row.recordingDisabled,true);assert.ok(!JSON.stringify(row).includes(key));
});
test('phone projection excludes Twilio auth token and server credentials',async()=>{
 const client=new VapiManagementClient({apiKey:key,async fetch(){return Response.json({id,orgId:org,number:'+12897994277',provider:'twilio',assistantId:id,twilioAuthToken:key,server:{url:'https://private.invalid',credentialId:key}});}});
 const phone=await client.phoneNumber(id);assert.equal(phone.serverConfigured,true);assert.ok(!JSON.stringify(phone).includes(key));assert.ok(!JSON.stringify(phone).includes('private.invalid'));
});
test('malformed IDs and missing keys cannot send requests',async()=>{
 assert.throws(()=>new VapiManagementClient({apiKey:''}));let calls=0;const client=new VapiManagementClient({apiKey:key,async fetch(){calls++;}});for(const invalid of ['../../call','https://evil.invalid',id+'?token=bad'])await assert.rejects(client.assistant(invalid));assert.equal(calls,0);
});
test('synthetic chat has no phone transport and rejects attached tools or webhooks',async()=>{
 for(const change of [{model:{...assistant.model,toolIds:['tool']}},{server:{url:'https://example.invalid'}}]){let calls=0;const client=new VapiManagementClient({apiKey:key,async fetch(){calls++;return Response.json({...assistant,...change});}});await assert.rejects(client.syntheticChat(id,'hello'),e=>e.code==='test_scope_changed');assert.equal(calls,1);}
 let body;const client=new VapiManagementClient({apiKey:key,async fetch(url,options){if(options.method==='GET')return Response.json(assistant);body=JSON.parse(options.body);return Response.json({assistantId:id,output:[{role:'assistant',content:'I am an automated assistant.'}]});}});const result=await client.syntheticChat(id,'Are you human?');assert.deepEqual(body,{assistantId:id,input:'Are you human?'});assert.equal(result.voiceVerified,false);assert.equal(result.businessActionsVerified,false);
});
test('payment, auth, oversized bodies and provider exceptions are redacted',async()=>{
 for(const status of [402,401,403,404,500]){const client=new VapiManagementClient({apiKey:key,async fetch(){return new Response(key,{status});}});await assert.rejects(client.assistant(id),e=>!String(e).includes(key)&&e.code===(status===402?'payment_required':[401,403].includes(status)?'authentication_denied':status===404?'resource_not_found':'provider_unavailable'));}
 for(const mode of ['oversized','throw']){const client=new VapiManagementClient({apiKey:key,async fetch(){if(mode==='throw')throw Error(key);return new Response('x'.repeat(524289));}});await assert.rejects(client.assistant(id),e=>!String(e).includes(key));}
});
test('wrong resource and tool output cannot masquerade as test success',async()=>{
 const wrong=new VapiManagementClient({apiKey:key,async fetch(){return Response.json({...assistant,id:org});}});await assert.rejects(wrong.assistant(id),e=>e.code==='invalid_provider_response');
 for(const output of [[{role:'tool',content:'booked'}],[{role:'assistant',content:key}]]){const client=new VapiManagementClient({apiKey:key,async fetch(url,options){return Response.json(options.method==='GET'?assistant:{assistantId:id,output});}});await assert.rejects(client.syntheticChat(id,'hello'),e=>e.code==='invalid_provider_response');}
});
test('duration repair patches only the verified assistant field and reads back; changed scope denies writes',async()=>{
 let maximum,patches=0;
 const client=new VapiManagementClient({apiKey:key,async fetch(url,options){assert.equal(url,'https://api.vapi.ai/assistant/'+id);if(options.method==='PATCH'){patches++;assert.deepEqual(JSON.parse(options.body),{maxDurationSeconds:600});maximum=600;}return Response.json({...assistant,maxDurationSeconds:maximum});}});
 const expected=await client.assistant(id);const saved=await client.setReceptionDuration(id,expected);assert.equal(saved.maxDurationSeconds,600);assert.equal(patches,1);
 await assert.rejects(client.setReceptionDuration(id,{...expected,orgId:id}),e=>e.code==='test_scope_changed');assert.equal(patches,1);
});
const phoneId='3e9cee92-b463-47c8-9e1a-cdbf179cb675',oldId='da0cd4c3-3c4c-404d-946c-1001f0ecd0fe';
const phone={id:phoneId,orgId:org,number:'+12897994277',provider:'twilio',assistantId:oldId};
test('reception assignment patches only assistantId, verifies persisted state and is idempotent',async()=>{
 let current={...phone},patches=0;
 const client=new VapiManagementClient({apiKey:key,async fetch(url,options){
  if(url.endsWith('/assistant/'+id))return Response.json(assistant);
  assert.equal(url,'https://api.vapi.ai/phone-number/'+phoneId);
  if(options.method==='PATCH'){patches++;assert.deepEqual(JSON.parse(options.body),{assistantId:id});current={...current,assistantId:id};}
  return Response.json({...current,twilioAuthToken:key});
 }});
 const expectedAssistant=await client.assistant(id),expectedPhone=await client.phoneNumber(phoneId);
 const result=await client.assignReception(phoneId,expectedPhone,expectedAssistant);
 assert.equal(result.changed,true);assert.equal(result.phone.assistantId,id);assert.ok(!JSON.stringify(result).includes(key));
 assert.equal((await client.assignReception(phoneId,result.phone,expectedAssistant)).changed,false);assert.equal(patches,1);
});
test('changed routing, tenant, prompt, recording, tools and overrides deny assignment before any write',async()=>{
 for(const [a,p] of [[assistant,{...phone,assistantId:org}],[assistant,{...phone,orgId:id}],[{...assistant,model:{messages:[{role:'system',content:'changed'}]}},phone],[{...assistant,artifactPlan:{recordingEnabled:true}},phone],[{...assistant,model:{...assistant.model,toolIds:['tool']}},phone],[assistant,{...phone,server:{url:'https://example.invalid'}}],[assistant,{...phone,squadId:org}],[assistant,{...phone,workflowId:org}]]){
  let patches=0;const client=new VapiManagementClient({apiKey:key,async fetch(url,options){if(options.method==='PATCH')patches++;return Response.json(url.includes('/assistant/')?a:p);}});
  const fixture=new VapiManagementClient({apiKey:key,async fetch(url){return Response.json(url.includes('/assistant/')?assistant:phone);}});
  await assert.rejects(client.assignReception(phoneId,await fixture.phoneNumber(phoneId),await fixture.assistant(id)),e=>e.code==='test_scope_changed');assert.equal(patches,0);
 }
});
test('ambiguous assignment failure is never retried and stale provider readback cannot report success',async()=>{
 for(const mode of ['timeout','stale']){
  let patches=0;const client=new VapiManagementClient({apiKey:key,async fetch(url,options){if(options.method==='PATCH'){patches++;if(mode==='timeout')throw Error('private failure');}return Response.json(url.includes('/assistant/')?assistant:phone);}});
  await assert.rejects(client.assignReception(phoneId,await client.phoneNumber(phoneId),await client.assistant(id)));assert.equal(patches,1);
 }
});
test('reusable tool inventory projects IDs and flags without credential or endpoint data',async()=>{
 const client=new VapiManagementClient({apiKey:key,async fetch(url){assert.equal(url,'https://api.vapi.ai/tool');return Response.json([{id,orgId:org,type:'apiRequest',name:'requestHelp',url:'https://private.invalid/path?secret='+key,headers:{authorization:key},credentialId:org,parameters:[{value:key}]}]);}});
 const rows=await client.tools();assert.equal(rows.length,1);assert.equal(rows[0].endpointConfigured,true);assert.equal(rows[0].credentialConfigured,true);assert.ok(!JSON.stringify(rows).includes(key));assert.equal(rows[0].endpointHost,'private.invalid');assert.ok(!JSON.stringify(rows).includes('/path')); 
 for(const rows of [{},[{id:'bad',orgId:org,type:'function'}],Array(201).fill({id,orgId:org,type:'endCall'})]){const malformed=new VapiManagementClient({apiKey:key,async fetch(){return Response.json(rows);}});await assert.rejects(malformed.tools(),e=>e.code==='invalid_provider_response');}
});
test('dedicated credential provisioning installs only scoped secret and returns a secret-free receipt',async()=>{
 let stored=null,creates=0,installs=0;
 const client=new VapiManagementClient({apiKey:key,async fetch(url,options){
  if(url.includes('/assistant/'))return Response.json(assistant);
  if(url.endsWith('/credential')&&options.method==='GET')return Response.json(stored?[stored]:[]);
  if(url.endsWith('/credential')&&options.method==='POST'){creates++;stored={...JSON.parse(options.body),id:org,orgId:assistant.orgId};}
  return Response.json(stored);
 }});
 const expected=await client.assistant(id);
 const install=async({credentialId,secret})=>{installs++;assert.equal(credentialId,org);assert.match(secret,/^[A-Za-z0-9_-]{43}$/);assert.notEqual(secret,key);};
 const receipt=await client.installToolCredential(expected,install);assert.equal(receipt.created,true);assert.ok(!JSON.stringify(receipt).includes(stored.authenticationPlan.token));
 assert.equal((await client.installToolCredential(expected,install)).created,false);assert.equal(creates,1);assert.equal(installs,2);
});
test('credential conflicts and ambiguous installs never overwrite credentials or expose private failures',async()=>{
 for(const mode of ['duplicate','wrong-org','redacted','install-failure']){
  let creates=0,installs=0;const credential={id:org,orgId:assistant.orgId,provider:'custom-credential',name:'PrimeCare Tools API 16534',authenticationPlan:{type:'bearer',token:'x'.repeat(43),headerName:'Authorization',bearerPrefixEnabled:true}};
  if(mode==='wrong-org')credential.orgId=id;if(mode==='redacted')delete credential.authenticationPlan.token;
  const client=new VapiManagementClient({apiKey:key,async fetch(url,options){if(url.includes('/assistant/'))return Response.json(assistant);if(options.method==='POST')creates++;return Response.json(mode==='duplicate'?[credential,credential]:[credential]);}});
  await assert.rejects(client.installToolCredential(await client.assistant(id),async()=>{installs++;throw Error('private installation failure '+key);}),error=>!String(error).includes(key));assert.equal(creates,0);assert.equal(installs,mode==='install-failure'?1:0);
 }
});

test('manual redirects fail closed without following or disclosing provider credentials',async()=>{let calls=0;const client=new VapiManagementClient({apiKey:key,fetch:async(_url,options)=>{calls++;assert.equal(options.redirect,'manual');return new Response(null,{status:302,headers:{location:'https://redirect.example.invalid'}});}});await assert.rejects(client.assistant(id),e=>e.code==='provider_unavailable');assert.equal(calls,1);});
