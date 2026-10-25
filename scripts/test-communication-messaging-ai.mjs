import {test} from 'node:test';
import assert from 'node:assert/strict';
import {MessagingAiReplyService,MessagingAiReplyChannel} from '../packages/shared/src/communications/messaging-ai.ts';
import {ScopedServiceBase,CommunicationChannelBase} from '../packages/shared/src/communications/service-base.ts';
import {MemoryAtomicStore} from './fixtures/business-memory-store.mjs';
const actor={id:'alice',tenantId:'fixture-a'},other={id:'bob',tenantId:'fixture-a'},foreign={id:'alice',tenantId:'fixture-b'};
function fixture(){
 const store=new MemoryAtomicStore(),calls=[],outgoing=[];let denied=false,linkVersion=1;
 const link={id:'verified-link',version:1,actorId:actor.id,tenantId:actor.tenantId,conversationId:'thread',provider:'twilio',channel:'sms',address:'+15550002000'};
 const ports={links:{async resolve(a,conversationId){if(denied||a.id!==actor.id||a.tenantId!==actor.tenantId||conversationId!=='thread')throw Error('Link denied');return {...link,version:linkVersion};}},model:{async reply(input){calls.push(input);return 'Reception can help you with your request.';}},outbox:{async queue(a,input){outgoing.push({actor:a,...input});return {id:input.id,status:'queued'};}}};
 const policy={async assert(a){if(denied||a.id!==actor.id||a.tenantId!==actor.tenantId)throw Error('Policy denied');},async assignee(){throw Error('No assignment authority');}};
 const service=new MessagingAiReplyService(store,policy,ports),channel=new MessagingAiReplyChannel(service);
 return {service,channel,ports,calls,outgoing,store,revoke(){denied=true;},changeLink(){linkVersion++;},link};
}
const input={conversationId:'thread',eventId:'provider-event',text:'Can reception help?'};
test('link comparison survives JSONB key ordering but still rejects extra or changed fields',async()=>{
 const f=fixture();await f.service.queue(actor,input.eventId,'receive',input);
 const saved=[...f.store.states.values()][0];saved.link=Object.fromEntries(Object.entries(saved.link).reverse());
 assert.equal((await f.service.read(actor,input.eventId)).status,'pending');
 saved.link.extra='forged';await assert.rejects(f.service.read(actor,input.eventId),/link changed/);delete saved.link.extra;
 saved.link.address='+15550009999';await assert.rejects(f.service.read(actor,input.eventId),/link changed/);
});
test('shared inherited channel queues, generates and queues a reply with server-resolved address',async()=>{
 const f=fixture();assert.ok(f.service instanceof ScopedServiceBase);assert.ok(f.channel instanceof CommunicationChannelBase);
 await f.channel.execute(actor,{action:'queue',id:input.eventId,key:'receive',input});
 const ready=await f.channel.execute(actor,{action:'generate',id:input.eventId,key:'generate',version:1});assert.equal(ready.status,'ready');assert.equal(ready.version,3);
 const queued=await f.channel.execute(actor,{action:'queue_reply',id:input.eventId,key:'send',version:3});assert.equal(queued.status,'queued');assert.equal(queued.outboxId,'ai-reply:provider-event');assert.equal(queued.version,5);
 assert.equal(f.calls.length,1);assert.equal(Object.hasOwn(f.calls[0],'tools'),false);assert.deepEqual(f.outgoing,[{actor,id:'ai-reply:provider-event',link:f.link,text:ready.reply}]);assert.equal(Object.hasOwn(queued,'delivered'),false);
});
test('duplicate inbound, concurrent model claim and repeated queue claim do not duplicate work',async()=>{
 const f=fixture();await Promise.all([f.service.queue(actor,input.eventId,'receive',input),f.service.queue(actor,input.eventId,'receive',input)]);
 await Promise.all([f.service.generate(actor,input.eventId,'generate',1),f.service.generate(actor,input.eventId,'generate',1)]);assert.equal(f.calls.length,1);
 await Promise.all([f.service.queueReply(actor,input.eventId,'send',3),f.service.queueReply(actor,input.eventId,'send',3)]);assert.equal(f.outgoing.length,1);
 await assert.rejects(f.service.queue(actor,'different-id','receive',input),/durable inbound event/);
 await assert.rejects(f.service.queue(actor,input.eventId,'receive',{...input,text:'Changed input'}),/Idempotency conflict/);
});
test('identity overrides, cross-user and cross-tenant reads never reach model or outbox',async()=>{
 const f=fixture();await assert.rejects(f.channel.execute(actor,{action:'read',id:input.eventId,tenantId:'forged'}),/server context/);
 await assert.rejects(f.service.queue(actor,input.eventId,'receive',{...input,actorId:'forged'}),/Invalid reply input/);
 await f.service.queue(actor,input.eventId,'receive',input);
 for(const a of [other,foreign]){await assert.rejects(f.service.read(a,input.eventId));await assert.rejects(f.service.generate(a,input.eventId,'generate',1));}
 assert.equal(f.calls.length,0);assert.equal(f.outgoing.length,0);
});
test('revoked account or changed link blocks duplicate retries and reply generation',async()=>{
 for(const change of ['revoke','changeLink']){
  const f=fixture();await f.service.queue(actor,input.eventId,'receive',input);f[change]();
  await assert.rejects(f.service.queue(actor,input.eventId,'receive',input));await assert.rejects(f.service.generate(actor,input.eventId,'generate',1));assert.equal(f.calls.length,0);
 }
});
test('revocation while model is pending never persists or queues its response',async()=>{
 const f=fixture();await f.service.queue(actor,input.eventId,'receive',input);
 f.ports.model.reply=async()=>{f.revoke();return 'Private answer';};await assert.rejects(f.service.generate(actor,input.eventId,'generate',1));assert.equal(f.outgoing.length,0);
 const state=[...f.store.states.values()][0];assert.equal(state.reply,null);assert.equal(state.status,'generating');
});
test('model failure and invalid output are terminal for automatic generation',async()=>{
 for(const reply of [async()=>{throw Error('PRIVATE PROVIDER FAILURE');},async()=>'',async()=>({text:'forged'}),async()=>'x'.repeat(1601)]){
  const f=fixture();f.ports.model.reply=reply;await f.service.queue(actor,input.eventId,'receive',input);
  const state=await f.service.generate(actor,input.eventId,'generate',1);assert.equal(state.status,'generation_failed');assert.equal(state.reply,null);
  await assert.rejects(f.service.generate(actor,input.eventId,'retry',3),/already attempted/);assert.equal(f.outgoing.length,0);
 }
});
test('link change after generation blocks outbox queue',async()=>{
 const f=fixture();await f.service.queue(actor,input.eventId,'receive',input);await f.service.generate(actor,input.eventId,'generate',1);f.changeLink();await assert.rejects(f.service.queueReply(actor,input.eventId,'send',3),/link changed/);assert.equal(f.outgoing.length,0);
});
test('uncertain outbox acceptance does not automatically resend',async()=>{
 const f=fixture();let attempts=0;f.ports.outbox.queue=async()=>{attempts++;throw Error('Unknown queue result');};
 await f.service.queue(actor,input.eventId,'receive',input);await f.service.generate(actor,input.eventId,'generate',1);
 await assert.rejects(f.service.queueReply(actor,input.eventId,'send',3));assert.equal((await f.service.queueReply(actor,input.eventId,'send',3)).status,'queueing');
 await assert.rejects(f.service.queueReply(actor,input.eventId,'retry',4),/not ready/);assert.equal(attempts,1);
});
test('all messaging providers use the same inherited service and current link checks',async()=>{
 for(const [provider,channel,address]of [['twilio','sms','+15550002000'],['twilio','whatsapp','whatsapp:+15550002000'],['telegram','telegram','12345']]){
  const f=fixture();Object.assign(f.link,{provider,channel,address});await f.service.queue(actor,input.eventId,'receive',input);await f.service.generate(actor,input.eventId,'generate',1);await f.service.queueReply(actor,input.eventId,'send',3);assert.equal(f.outgoing[0].link.channel,channel);
 }
});
