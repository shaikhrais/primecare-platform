import {test} from 'node:test';
import assert from 'node:assert/strict';
import {VapiCallReadClient,createVapiCanonicalCallDirectory} from '../packages/shared/src/communications/vapi-call-read.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
const id='11111111-1111-4111-8111-111111111111',org='22222222-2222-4222-8222-222222222222',assistant='33333333-3333-4333-8333-333333333333',phone='44444444-4444-4444-8444-444444444444',callSid='CA'+'a'.repeat(32),accountSid='AC'+'b'.repeat(32),number='+12897994277',key='private-vapi-test-key';
const raw=()=>({id,orgId:org,assistantId:assistant,phoneNumberId:phone,type:'inboundPhoneCall',status:'in-progress',phoneCallProvider:'twilio',phoneCallProviderId:callSid,transport:{provider:'twilio',accountSid,callSid,conversationType:'voice',callToken:key},startedAt:new Date(Date.now()-1000).toISOString(),messages:[{content:key}],artifact:{recordingUrl:'https://private.invalid/'+key}});
const client=read=>new VapiCallReadClient({apiKey:key,async fetch(url,options){assert.equal(url,'https://api.vapi.ai/call/'+id);assert.equal(options.method,'GET');assert.equal(options.redirect,'error');return Response.json(await read());}});
function fixture(){let source=raw(),twilioReads=0,vapiReads=0;const call={sid:callSid,accountSid,to:number,direction:'inbound',status:'in-progress',from:'+15550001001'};const vapi=client(()=>{vapiReads++;return source;});const options={vapi,twilio:{async fetch(sid){twilioReads++;assert.equal(sid,callSid);return structuredClone(call);}},orgId:org,assistantId:assistant,phoneNumberId:phone,accountSid,sharedNumber:number};return {source,call,options,vapi,get twilioReads(){return twilioReads;},get vapiReads(){return vapiReads;},directory:()=>createVapiCanonicalCallDirectory(options)};}
test('call reader inherits bounded base and returns lifecycle projection without transcript, tokens or URLs',async()=>{
 const c=client(raw);assert.ok(c instanceof BoundedBinaryAdapterBase);const row=await c.fetch(id);assert.equal(row.callSid,callSid);const serialized=JSON.stringify(row);for(const forbidden of [key,'recordingUrl','messages','callToken','private.invalid'])assert.ok(!serialized.includes(forbidden));
});
test('only two matching live provider reads plus independent Twilio validation can establish a short-lived call binding',async()=>{
 const f=fixture(),directory=f.directory();const result=await directory.current(id);assert.equal(result.active,true);assert.equal(result.callSid,callSid);assert.ok(result.expiresAt>Date.now()&&result.expiresAt<=Date.now()+10000);assert.equal(f.vapiReads,2);assert.equal(f.twilioReads,1);assert.ok(!('actor'in result));assert.ok(!('from'in result));await directory.current(id);assert.equal(f.vapiReads,4);assert.equal(f.twilioReads,2);
});
test('wrong org, assistant, number, transport, status or provider mapping cannot reach Twilio',async()=>{
 for(const change of [r=>r.orgId=assistant,r=>r.assistantId=phone,r=>r.phoneNumberId=assistant,r=>r.status='ended',r=>r.endedAt=new Date().toISOString(),r=>r.type='outboundPhoneCall',r=>r.phoneCallProvider='vonage',r=>r.transport.provider='vapi.sip',r=>r.transport.accountSid='AC'+'c'.repeat(32),r=>r.transport.callSid='CA'+'c'.repeat(32),r=>r.transport.conversationType='chat',r=>r.startedAt=new Date(Date.now()-601000).toISOString(),r=>r.startedAt=new Date(Date.now()+10000).toISOString()]){const f=fixture();change(f.source);assert.equal(await f.directory().current(id),null);assert.equal(f.twilioReads,0);}
});
test('Twilio account, number, direction and active status independently deny forged or ended calls',async()=>{
 for(const change of [c=>c.accountSid='AC'+'c'.repeat(32),c=>c.to='+15550001000',c=>c.direction='outbound-api',c=>c.status='completed',c=>c.sid='CA'+'c'.repeat(32)]){const f=fixture();change(f.call);assert.equal(await f.directory().current(id),null);assert.equal(f.vapiReads,1);}
});
test('call changes or provider failures during lookup cannot return a stale positive binding',async()=>{
 const f=fixture();f.options.twilio.fetch=async()=>{f.source.status='ended';return f.call;};assert.equal(await f.directory().current(id),null);
 const g=fixture();g.options.twilio.fetch=async()=>{throw Error(key);};assert.equal(await g.directory().current(id),null);
 const h=fixture();assert.equal(await h.directory().current('../../call'),null);assert.equal(h.vapiReads,0);
});
test('bad IDs, HTTP denials, oversized and malformed provider payloads fail without secret-bearing errors',async()=>{
 let calls=0;const c=new VapiCallReadClient({apiKey:key,async fetch(){calls++;throw Error(key);}});await assert.rejects(c.fetch('../call'),e=>e.code==='invalid_resource');assert.equal(calls,0);await assert.rejects(c.fetch(id),e=>!String(e).includes(key));
 for(const response of [()=>new Response(key,{status:401}),()=>new Response(key,{status:404}),()=>new Response('x'.repeat(524289)),()=>Response.json({...raw(),transport:{provider:{token:key}}}),()=>Response.json({...raw(),id:org}),()=>Response.json({...raw(),status:key}),()=>Response.json({...raw(),phoneCallProvider:key}),()=>Response.json({...raw(),transport:{provider:'twilio',conversationType:key}})]){const reader=new VapiCallReadClient({apiKey:key,async fetch(){return response();}});await assert.rejects(reader.fetch(id),e=>!String(e).includes(key));}
});

test('documented Twilio transport is authoritative when deprecated root provider fields are absent',async()=>{
 const f=fixture();delete f.source.phoneCallProvider;delete f.source.phoneCallProviderId;const result=await f.directory().current(id);assert.equal(result.callSid,callSid);assert.equal(f.twilioReads,1);
});
