import {test} from 'node:test';
import assert from 'node:assert/strict';
import {PostgresSmsMessagingRepository,PostgresSmsConsentInboxStore,linkBoundSmsRecipientPolicy,linkBoundSmsTransport} from '../cloudflare/workers/src/business-tasks/sms-links.ts';
import {PostgresSmsInboundStore} from '../cloudflare/workers/src/business-tasks/sms-inbound.ts';
const actor={id:'alice',tenantId:'tenant-a'},config={accountSid:'AC'+'a'.repeat(32),messagingServiceSid:'MG'+'b'.repeat(32),sharedNumber:'+15550001000'};
const link={id:crypto.randomUUID(),version:1,actorId:actor.id,tenantId:actor.tenantId,conversationId:'thread',provider:'twilio',channel:'sms',address:'+15550002000'};
test('storage adapters require a native pool, pinned sender configuration and explicit policy factory',()=>{
 for(const pool of [{},{query(){}},{connect(){}}])assert.throws(()=>new PostgresSmsMessagingRepository(pool,config,()=>({})),/unavailable/);
 const pool={async query(){},async connect(){}};
 for(const c of [{...config,accountSid:'bad'},{...config,messagingServiceSid:'bad'},{...config,sharedNumber:'whatsapp:+15550001000'}])assert.throws(()=>new PostgresSmsMessagingRepository(pool,c,()=>({})),/unavailable/);
 assert.throws(()=>new PostgresSmsMessagingRepository(pool,config),/unavailable/);
 assert.ok(new PostgresSmsConsentInboxStore(pool) instanceof PostgresSmsInboundStore);
});
test('native binding rejects identity/phone overrides and missing explicit consent before database access',async()=>{
 let calls=0;const repo=new PostgresSmsMessagingRepository({async query(){calls++;},async connect(){calls++;throw Error('Database reached');}},config,()=>({}));
 const context={actor,sessionHash:'a'.repeat(64)},input={id:crypto.randomUUID(),conversationId:'thread',consent:true};
 for(const bad of [{...input,phone:link.address},{...input,actorId:'forged'},{...input,tenantId:'forged'},{...input,consent:false},{...input,id:'bad'}])await assert.rejects(repo.bind(context,bad),/unavailable/);
 await assert.rejects(repo.bind({...context,sessionHash:'bad'},input),/unavailable/);assert.equal(calls,0);
});
test('link recipient wrapper preserves country/quota policy and rejects stale links and changed recipients',async()=>{
 let policy=0,reads=0;let current={...link};const repo={async resolve(){reads++;return current;}},base={async recipient(){policy++;}};
 const wrapped=linkBoundSmsRecipientPolicy(repo,link,base);await wrapped.recipient(actor,link.address);assert.equal(policy,1);assert.equal(reads,1);
 await assert.rejects(wrapped.recipient({...actor,tenantId:'foreign'},link.address));await assert.rejects(wrapped.recipient(actor,'+15550009999'));assert.equal(policy,1);
 current={...link,id:crypto.randomUUID()};await assert.rejects(wrapped.recipient(actor,link.address),/unavailable/);
 const denied=linkBoundSmsRecipientPolicy(repo,link,{async recipient(){throw Error('Quota denied');}});await assert.rejects(denied.recipient(actor,link.address),/Quota denied/);
});
test('account scope is snapshotted before acquiring a delayed native connection',async()=>{
 let release;const connection=new Promise(r=>release=r),calls=[];
 const db={async query(sql,values){calls.push(values);return {rows:[{id:link.id,version:1,phone:link.address,state:{id:'thread',tenantId:actor.tenantId,kind:'conversation',version:1}}]};},release(){}};
 const repo=new PostgresSmsMessagingRepository({query:db.query,async connect(){return connection;}},config,()=>({async assert(a){assert.deepEqual(a,actor);assert.ok(Object.isFrozen(a));},async assignee(){}}));
 const mutable={...actor},pending=repo.resolve(mutable,'thread');mutable.id='mallory';mutable.tenantId='foreign';release(db);
 assert.equal((await pending).actorId,actor.id);assert.deepEqual(calls[0].slice(0,3),[actor.tenantId,actor.id,'thread']);
});
test('captured link cannot be rewritten by a caller and transport delegates only a guarded exact destination',async()=>{
 const expected={...link},sent=[];let guarded;
 const wrapped=linkBoundSmsTransport({async guardSend(l,work){guarded=l;return work();}},expected,{async send(message){sent.push(message);return 'accepted-fixture';}});
 expected.address='+15550009999';assert.equal(await wrapped.send({to:link.address,text:'Hello'}),'accepted-fixture');assert.equal(guarded.address,link.address);
 await assert.rejects(wrapped.send({to:'+15550009999',text:'Wrong address'}));await assert.rejects(wrapped.send({to:link.address,text:'Hello',actorId:'forged'}));assert.deepEqual(sent,[{to:link.address,text:'Hello'}]);
});
test('denied send guard never invokes a provider or retries unknown submissions',async()=>{
 let sent=0;const denied=linkBoundSmsTransport({async guardSend(){throw Error('STOP');}},link,{async send(){sent++;}});await assert.rejects(denied.send({to:link.address,text:'Hello'}),/STOP/);assert.equal(sent,0);
 const unknown=linkBoundSmsTransport({async guardSend(l,work){return work();}},link,{async send(){sent++;throw Error('Acceptance unknown');}});await assert.rejects(unknown.send({to:link.address,text:'Hello'}),/Acceptance unknown/);assert.equal(sent,1);
});
