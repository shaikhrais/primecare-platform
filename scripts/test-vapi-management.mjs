import {test} from 'node:test';
import assert from 'node:assert/strict';
import {VapiManagementClient} from '../packages/shared/src/communications/vapi-management.mjs';
const id='5ae2ab0c-fad0-454c-8cf7-64b81c91c850',org='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',key='private-vapi-fixture-key';
const assistant={id,orgId:org,name:'PrimeCare',firstMessage:'Hello',model:{messages:[{role:'system',content:'Test prompt'}]},artifactPlan:{recordingEnabled:false},maxDurationSeconds:600};
test('fixed provider reads return projections without embedded credentials',async()=>{
 const client=new VapiManagementClient({apiKey:key,async fetch(url,options){assert.equal(url,'https://api.vapi.ai/assistant/'+id);assert.equal(options.redirect,'error');assert.equal(options.headers.authorization,'Bearer '+key);return Response.json({...assistant,credential:key});}});
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
