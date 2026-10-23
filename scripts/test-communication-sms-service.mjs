import {test} from 'node:test';
import assert from 'node:assert/strict';
import {SmsNotificationService} from '../cloudflare/workers/src/business-tasks/sms.ts';
import {ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
import {MemoryAtomicStore} from './fixtures/business-memory-store.mjs';
const actor={id:'alice',tenantId:'tenant-a'},other={id:'bob',tenantId:'tenant-a'},foreign={id:'alice',tenantId:'tenant-b'};
const config={sender:'+15550001000',accountSid:'AC'+'a'.repeat(32),messagingServiceSid:'MG'+'b'.repeat(32),maxTextBytes:6400};
const sid='SM'+'c'.repeat(32),to='+15550002000';
function fixture({send=async()=>({messageSid:sid,status:'queued'}),recipient=async()=>{},assertion=async()=>{}}={}){
 const store=new MemoryAtomicStore(),calls=[];
 const policy={async assert(a,action,state){if(![actor.id,other.id,'sms-provider'].includes(a.id)||!['tenant-a','tenant-b'].includes(a.tenantId))throw Error('Denied');await assertion(a,action,state);},async assignee(){throw Error('No grants');}};
 const service=new SmsNotificationService(store,policy,{recipient},{async send(message){calls.push(message);return send(message);}},config);
 return {service,store,calls};
}
async function queued(f){await f.service.queue(actor,'sms-a','queue-a',to,'Fixture notification');}
test('shared inherited SMS outbox queues, claims once, reads acceptance and records delivery',async()=>{
 const f=fixture();assert.ok(f.service instanceof ScopedServiceBase);await queued(f);
 const result=await f.service.deliver(actor,'sms-a','deliver-a',1);assert.equal(result.status,'accepted');assert.equal(result.providerMessageId,sid);assert.deepEqual(result.observations,['queued']);assert.equal(f.calls.length,1);
 await f.service.observe({id:'sms-provider',tenantId:actor.tenantId},'sms-a',3,{...config,from:config.sender,to,messageSid:sid,status:'delivered',errorCode:null});
 assert.deepEqual((await f.service.read(actor,'sms-a')).delivery,{status:'delivered',delivered:true});
});
test('queue retries preserve identity and content; conflicting key cannot change recipient',async()=>{
 const f=fixture();await queued(f);await queued(f);assert.equal(f.store.events.length,1);
 await assert.rejects(f.service.queue(actor,'sms-a','queue-a','+15550009999','Fixture notification'),/Idempotency conflict/);
});
test('concurrent delivery and retries invoke transport only once',async()=>{
 const f=fixture();await queued(f);
 await Promise.allSettled([f.service.deliver(actor,'sms-a','deliver-a',1),f.service.deliver(actor,'sms-a','deliver-a',1),f.service.deliver(actor,'sms-a','another-claim',1)]);
 assert.equal(f.calls.length,1);await f.service.deliver(actor,'sms-a','deliver-a',1);assert.equal(f.calls.length,1);
});
test('ambiguous provider acceptance remains unknown and cannot be resent with another key',async()=>{
 const f=fixture({send:async()=>{throw Error('timeout');}});await queued(f);const result=await f.service.deliver(actor,'sms-a','deliver-a',1);assert.equal(result.status,'unknown');
 await f.service.deliver(actor,'sms-a','deliver-a',1);await assert.rejects(f.service.deliver(actor,'sms-a','new-key',3),/already attempted/);assert.equal(f.calls.length,1);
});
test('denied consent blocks queue and consent revoked after queue blocks send',async()=>{
 let allowed=false;const f=fixture({recipient:async()=>{if(!allowed)throw Error('Opted out');}});
 await assert.rejects(queued(f),/Opted out/);assert.equal(f.store.events.length,0);allowed=true;await queued(f);allowed=false;
 await assert.rejects(f.service.deliver(actor,'sms-a','deliver-a',1),/Opted out/);assert.equal(f.calls.length,0);
});
test('consent revoked after claim leaves a non-resendable state without provider submission',async()=>{
 let checks=0;const f=fixture({recipient:async()=>{if(++checks===3)throw Error('Opted out');}});await queued(f);
 await assert.rejects(f.service.deliver(actor,'sms-a','deliver-a',1),/Opted out/);assert.equal(f.calls.length,0);assert.equal((await f.service.read(actor,'sms-a')).status,'sending');
});
test('cross-tenant and other-owner reads and delivery fail before transport',async()=>{
 const f=fixture();await queued(f);for(const a of [other,foreign]){await assert.rejects(f.service.read(a,'sms-a'));await assert.rejects(f.service.deliver(a,'sms-a','deliver-a',1));}assert.equal(f.calls.length,0);
});
test('callback cannot select another receipt, number, service or tenant',async()=>{
 const f=fixture();await queued(f);await f.service.deliver(actor,'sms-a','deliver-a',1);
 const event={accountSid:config.accountSid,messagingServiceSid:config.messagingServiceSid,from:config.sender,to,messageSid:sid,status:'delivered',errorCode:null};
 for(const change of [{messageSid:'SM'+'d'.repeat(32)},{to:'+15550009999'},{accountSid:'AC'+'d'.repeat(32)},{messagingServiceSid:'MG'+'d'.repeat(32)}])await assert.rejects(f.service.observe({id:'sms-provider',tenantId:'tenant-a'},'sms-a',3,{...event,...change}));
 await assert.rejects(f.service.observe({id:'sms-provider',tenantId:'tenant-b'},'sms-a',3,event));
 assert.equal((await f.service.read(actor,'sms-a')).version,3);
});
test('current callback policy denial cannot change a delivery record',async()=>{
 const f=fixture({assertion:async(a,action)=>{if(action==='sms.status.receive')throw Error('Denied');}});await queued(f);await f.service.deliver(actor,'sms-a','deliver-a',1);
 await assert.rejects(f.service.observe({id:'sms-provider',tenantId:'tenant-a'},'sms-a',3,{accountSid:config.accountSid,messagingServiceSid:config.messagingServiceSid,from:config.sender,to,messageSid:sid,status:'delivered',errorCode:null}),/Denied/);
});
test('malformed input and failed draft authorization leave no queued record',async()=>{
 const f=fixture({assertion:async(a,action,state)=>{if(state?.to===to)throw Error('Draft denied');}});
 await assert.rejects(queued(f),/Draft denied/);await assert.rejects(f.service.queue(actor,'x','x','bad','text'),/Invalid SMS/);assert.equal(f.store.states.size,0);
});
