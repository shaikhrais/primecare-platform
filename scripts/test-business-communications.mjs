import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {BusinessWorkflowService} from '../cloudflare/workers/src/business-tasks/workflow.ts';
import {CommunicationService} from '../cloudflare/workers/src/business-tasks/communication.ts';
import {BusinessMailService} from '../cloudflare/workers/src/business-tasks/mail.ts';
import {PostgresAtomicStore} from '../cloudflare/workers/src/business-tasks/store.ts';
import {MemoryAtomicStore} from './fixtures/business-memory-store.mjs';
import {BusinessWorkspaceService} from '../cloudflare/workers/src/business-tasks/workspace.ts';
import {CommunicationCore} from '../cloudflare/workers/src/business-tasks/channels.ts';
import {CommunicationChannelBase,ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';

const definitions=JSON.parse(readFileSync('packages/shared/src/business/task-flows.json')).flows;
const a={id:'alice',tenantId:'fixture-a'},b={id:'bob',tenantId:'fixture-a'},c={id:'carol',tenantId:'fixture-a'};
const outsider={id:'outsider',tenantId:'fixture-b'};
const users=new Map([[a.id,a],[b.id,b],[c.id,c],[outsider.id,outsider],['inbound-mail',{id:'inbound-mail',tenantId:'fixture-a'}]]);
const revoked=new Set();
const policy={
 async assert(actor,action,state) {
  if(revoked.has(actor.id)||users.get(actor.id)?.tenantId!==actor.tenantId||state&&state.tenantId!==actor.tenantId)throw Error('Forbidden');
  if(state?.kind==='workflow'&&action==='workflow.read'&&![state.originatorId,state.ownerId,state.reviewerId].includes(actor.id))throw Error('Forbidden');
 },
 async assignee(actor,id) {if(users.get(id)?.tenantId!==actor.tenantId||revoked.has(id))throw Error('Invalid assignee');}
};
let pool,store;
if(process.env.BUSINESS_TEST_DATABASE_URL) {
 const {Pool}=await import('pg');pool=new Pool({connectionString:process.env.BUSINESS_TEST_DATABASE_URL});
 const schema='business_test_'+crypto.randomUUID().replaceAll('-','');
 await pool.query('CREATE SCHEMA '+schema);await pool.end();
 pool=new Pool({connectionString:process.env.BUSINESS_TEST_DATABASE_URL,options:'-c search_path='+schema});
 await pool.query(readFileSync('scripts/fixtures/business-communications.sql','utf8'));
 store=new PostgresAtomicStore(pool);
 after(async()=>{await pool.query('DROP SCHEMA '+schema+' CASCADE');await pool.end();});
 console.log('Storage: native PostgreSQL, isolated schema, production credentials unused');
} else {store=new MemoryAtomicStore();console.log('Storage: isolated memory fixture; no persistence acceptance credit');}
const workflow=new BusinessWorkflowService(store,policy,definitions);
const id=prefix=>prefix+':'+crypto.randomUUID();
const due='2026-12-01T15:00:00Z';
for(const definition of definitions) test(definition.id+': create, correction, resubmit, handoff, review and reread',async()=>{
 const task=id(definition.id);
 let result=await workflow.create(a,task,'create',definition.id,a.id,b.id,due);
 for(let index=0;index<definition.steps.length;index++) {
  const evidence=Object.fromEntries(definition.steps[index].requiredEvidence.map(key=>[key,'synthetic-reference:'+key]));
  await assert.rejects(workflow.act(a,task,'missing-'+index,result.version,'submit',{evidence:{}}),/Required evidence/);
  result=await workflow.act(a,task,'submit-'+index,result.version,'submit',{evidence});
  await assert.rejects(workflow.act(a,task,'self-'+index,result.version,'accept',{reason:'self review'}),/Review forbidden/);
  if(index===0) {
   result=await workflow.act(b,task,'return',result.version,'return',{reason:'Clarify reference'});
   assert.equal((await workflow.read(a,task)).status,'returned');
   result=await workflow.act(a,task,'resubmit',result.version,'submit',{evidence});
  }
  result=await workflow.act(b,task,'accept-'+index,result.version,'accept',{reason:'Verified source record',nextOwnerId:a.id,nextReviewerId:b.id,nextDueAt:due});
  const reloaded=await workflow.read(b,task);
  assert.equal(reloaded.status,index===definition.steps.length-1?'closed':'draft');
 }
 const record=await workflow.read(a,task);
 assert.equal(record.submissions.length,definition.steps.length+1);
 assert.equal(record.originalDueAt,due);
 await assert.rejects(workflow.act(a,task,'after-close',result.version,'submit',{}),/Closed task/);
 await assert.rejects(workflow.read(outsider,task),/Not found|Forbidden/);
 await assert.rejects(workflow.read(c,task),/Forbidden/);
});
test('workflow assignment, blocking, duplicate retry, stale write and revoked retry',async()=>{
 const task=id('concurrency');
 await assert.rejects(workflow.create(a,task,'bad','sales-target',outsider.id,b.id,due),/assignee/);
 const created=await workflow.create(a,task,'create','sales-target',a.id,b.id,due);
 assert.deepEqual(await workflow.create(a,task,'create','sales-target',a.id,b.id,due),created);
 await assert.rejects(workflow.create(a,task,'create','sales-target',a.id,b.id,'2026-12-02T15:00:00Z'),/Idempotency conflict/);
 const races=await Promise.allSettled(['first','second'].map(key=>workflow.act(a,task,key,created.version,'block',{reason:'Dependency unavailable'})));
 assert.equal(races.filter(r=>r.status==='fulfilled').length,1);
 assert.match(races.find(r=>r.status==='rejected').reason.message,/Version conflict/);
 const blocked=await workflow.read(a,task);assert.equal(blocked.status,'blocked');
 await workflow.act(a,task,'resume',blocked.version,'resume',{reason:'Dependency restored'});
 revoked.add(a.id);
 try {await assert.rejects(workflow.create(a,task,'create','sales-target',a.id,b.id,due),/Forbidden/);} finally {revoked.delete(a.id);}
});

const pictureRecords=new Map();let scans=0;
const pictures={
 async prepare(actor,threadId,bytes,mediaType) {scans++;const picture={id:id('picture'),tenantId:actor.tenantId,threadId,mediaType,size:bytes.length,status:'clean'};pictureRecords.set(picture.id,picture);return picture;},
 async get(actor,id) {const picture=pictureRecords.get(id);if(!picture||picture.tenantId!==actor.tenantId)throw Error('Picture unavailable');return picture;}
};
const limits={maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:1024,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384};
let clock=100000;
const communication=new CommunicationService(store,policy,pictures,limits,()=>clock);
test('missing communication bounds fail before accepting a conversation',()=>{
 assert.throws(()=>new CommunicationService(store,policy,pictures,{}),/configured limit/);
});
test('task inbox and linked conversation remain scoped to actual task participants',async()=>{
 const task=id('linked');await workflow.create(a,task,'create','sales-target',a.id,b.id,due);
 const workspace=new BusinessWorkspaceService(workflow,communication);
 await assert.rejects(workspace.openConversation(a,task,id('bad-thread'),'create',[a.id,c.id]),/participant/);
 await workspace.openConversation(a,task,id('good-thread'),'create',[a.id,b.id]);
 assert.ok((await workflow.inbox(b)).some(row=>row.id===task));
 assert.equal((await workflow.inbox(c)).some(row=>row.id===task),false);
 assert.equal((await workflow.inbox(outsider)).some(row=>row.id===task),false);
});
test('messages, clean pictures and read receipts persist and deny nonparticipants',async()=>{
 const thread=id('conversation');let result=await communication.create(a,thread,'create',[a.id,b.id],'synthetic-task');
 const png=new Uint8Array([137,80,78,71,13,10,26,10,0]);
 const picture=await communication.picture(a,thread,png,'image/png');
 result=await communication.message(a,thread,'message',result.version,'Hello',[picture.id]);
 assert.deepEqual(await communication.message(a,thread,'message',1,'Hello',[picture.id]),result);
 const record=await communication.read(b,thread);assert.equal(record.messages[0].text,'Hello');
 result=await communication.markRead(b,thread,'read',result.version,1);
 assert.equal((await communication.read(a,thread)).readThrough[b.id],1);
 await assert.rejects(communication.markRead(b,thread,'read-backwards',result.version,0),/read receipt/);
 await assert.rejects(communication.read(c,thread),/Not found/);
 await assert.rejects(communication.read(outsider,thread),/Not found/);
 await assert.rejects(communication.message(c,thread,'intruder',result.version,'private'),/Not found/);
});
test('picture gates reject SVG, mismatched types, oversized and cross-thread objects',async()=>{
 const thread=id('pictures');await communication.create(a,thread,'create',[a.id,b.id],'synthetic-task');
 const before=scans;
 for(const [bytes,type] of [[new TextEncoder().encode('<svg onload="alert(1)"/>'),'image/svg+xml'],[new Uint8Array(1025),'image/png'],[new Uint8Array([255,216,255]),'image/png']])await assert.rejects(communication.picture(a,thread,bytes,type),/picture/);
 assert.equal(scans,before);
 pictureRecords.set('foreign-picture',{id:'foreign-picture',tenantId:a.tenantId,threadId:'different',status:'clean'});
 await assert.rejects(communication.message(a,thread,'foreign-picture',1,'',['foreign-picture']),/Picture unavailable/);
 pictureRecords.set('unsafe-picture',{id:'unsafe-picture',tenantId:a.tenantId,threadId:thread,status:'quarantined'});
 await assert.rejects(communication.message(a,thread,'unsafe-picture',1,'',['unsafe-picture']),/Picture unavailable/);
 assert.equal((await communication.read(a,thread)).messages.length,0);
});
test('call invitation, accepted recipient, decline, expiry and ending are state guarded',async()=>{
 const thread=id('calls');let result=await communication.create(a,thread,'create',[a.id,b.id,c.id],'synthetic-task');
 result=await communication.call(a,thread,'invite',result.version,'invite','call-1',b.id);
 await assert.rejects(communication.call(a,thread,'self',result.version,'accept','call-1'),/Call conflict/);
 await assert.rejects(communication.call(c,thread,'third',result.version,'accept','call-1'),/Not found/);
 result=await communication.call(b,thread,'accept',result.version,'accept','call-1');
 await assert.rejects(communication.signal(c,thread,'signal-third',result.version,'call-1',{type:'offer',description:{type:'offer',sdp:'synthetic'}}),/Not found/);
 result=await communication.signal(a,thread,'offer',result.version,'call-1',{type:'offer',description:{type:'offer',sdp:'synthetic-offer'}});
 result=await communication.signal(b,thread,'answer',result.version,'call-1',{type:'answer',description:{type:'answer',sdp:'synthetic-answer'}});
 assert.equal((await communication.read(c,thread)).calls[0].signals.length,0);
 assert.equal((await communication.read(b,thread)).calls[0].signals.length,2);
 result=await communication.call(a,thread,'end',result.version,'end','call-1');
 result=await communication.call(a,thread,'invite2',result.version,'invite','call-2',b.id);
 result=await communication.call(b,thread,'decline',result.version,'decline','call-2');
 result=await communication.call(a,thread,'invite3',result.version,'invite','call-3',b.id);
 clock+=limits.ringMilliseconds;
 await assert.rejects(communication.call(b,thread,'late',result.version,'accept','call-3'),/Call conflict/);
 await communication.call(a,thread,'expire',result.version,'expire','call-3');
 assert.deepEqual((await communication.read(b,thread)).calls.map(call=>call.status),['ended','declined','missed']);
});

let sends=0,transportFails=false;const sent=[];
const mailboxes={async resolve(to){return to==='owned@example.invalid'?{tenantId:a.tenantId,mailboxId:'owned'}:null;},async recipient(actor,to){if(to!=='recipient@example.invalid')throw Error('Unapproved recipient');}};
const mail=new BusinessMailService(store,policy,mailboxes,{async send(message){sends++;sent.push(message);if(transportFails)throw Error('private-provider-detail');return {messageId:'synthetic-provider-'+sends};}},'sender@example.invalid',2048);
test('one inherited core serves different permitted users across all four channels',async()=>{
 const core=new CommunicationCore(communication,mail);
 for(const channel of Object.values(core.channels))assert.ok(channel instanceof CommunicationChannelBase);
 for(const service of [workflow,communication,mail])assert.ok(service instanceof ScopedServiceBase);
 const thread=id('shared-core');
 let result=await core.execute('message',a,{action:'create',id:thread,key:'create',members:[a.id,b.id],businessReference:'synthetic-core-task'});
 const picture=await core.execute('picture',a,{action:'upload',threadId:thread,bytes:new Uint8Array([137,80,78,71,13,10,26,10,0]),mediaType:'image/png'});
 result=await core.execute('message',b,{action:'send',id:thread,key:'reply',version:result.version,text:'Shared core reply',pictureIds:[picture.id]});
 result=await core.execute('message',a,{action:'mark_read',id:thread,key:'read',version:result.version,sequence:1});
 result=await core.execute('audio',a,{action:'invite',id:thread,key:'invite',version:result.version,callId:'core-call',recipientId:b.id});
 result=await core.execute('audio',b,{action:'accept',id:thread,key:'accept',version:result.version,callId:'core-call'});
 await core.execute('audio',b,{action:'end',id:thread,key:'end',version:result.version,callId:'core-call'});
 assert.equal((await core.execute('message',a,{action:'read',id:thread})).messages[0].authorId,b.id);
 const message=id('core-mail');
 result=await core.execute('email',b,{action:'queue',id:message,key:'queue',to:'recipient@example.invalid',subject:'Synthetic update',text:'Fixture'});
 assert.equal((await core.execute('email',b,{action:'deliver',id:message,key:'deliver',version:result.version})).status,'accepted');
 for(const channel of ['message','email'])await assert.rejects(core.execute(channel,outsider,{action:'read',id:channel==='message'?thread:message}),/Not found/);
 await assert.rejects(core.execute('picture',outsider,{action:'upload',threadId:thread,bytes:new Uint8Array([255,216,255]),mediaType:'image/jpeg'}),/Not found/);
 await assert.rejects(core.execute('audio',outsider,{action:'invite',id:thread,key:'foreign',version:1,callId:'bad',recipientId:a.id}),/Not found/);
 await assert.rejects(core.execute('message',a,{action:'read',id:thread,actorId:b.id}),/server context/);
 await assert.rejects(core.execute('email',a,{action:'receive',to:'owned@example.invalid'}),/Invalid email action/);
 assert.throws(()=>core.execute('__proto__',a,{}),/Unknown communication channel/);
});
test('shared scope base rejects cross-tenant state even with a permissive adapter',async()=>{
 let policyCalls=0;
 const permissive={async assert(){policyCalls++;},async assignee(){}};
 class Probe extends ScopedServiceBase {check(actor,state){return this.checkAccess(actor,'fixture.read',state,['fixture']);}}
 const probe=new Probe(store,permissive);
 await assert.rejects(probe.check(a,{id:'foreign',tenantId:outsider.tenantId,kind:'fixture',version:1}),/Not found/);
 assert.equal(policyCalls,0);
 assert.throws(()=>new Probe(store,null),/adapters required/);
});
test('same core supports a separate tenant without sharing its conversation',async()=>{
 const partner={id:'partner-b',tenantId:outsider.tenantId};users.set(partner.id,partner);
 const core=new CommunicationCore(communication,mail),thread=id('tenant-b');
 const result=await core.execute('message',outsider,{action:'create',id:thread,key:'create',members:[outsider.id,partner.id],businessReference:'synthetic-b'});
 await core.execute('message',partner,{action:'send',id:thread,key:'send',version:result.version,text:'Tenant B only'});
 assert.equal((await core.execute('message',outsider,{action:'read',id:thread})).messages.length,1);
 await assert.rejects(core.execute('message',a,{action:'read',id:thread}),/Not found/);
});
test('email queues once, escapes HTML and preserves accepted versus delivered distinction',async()=>{
 const message=id('outbound');let result=await mail.queue(a,message,'queue','recipient@example.invalid','Task update','<script>private</script>');
 const before=sends;
 const record=await mail.deliver(a,message,'deliver',result.version);
 assert.equal(record.status,'accepted');assert.equal(sends,before+1);assert.ok(sent.at(-1).html.includes('&lt;script&gt;'));
 await mail.deliver(a,message,'deliver',result.version);assert.equal(sends,before+1);
 await assert.rejects(mail.read(outsider,message),/Not found/);
 await assert.rejects(mail.queue(a,id('bad'),'queue','recipient@example.invalid','subject\r\nBcc: victim','text'),/Invalid input/);
 await assert.rejects(mail.queue(a,id('unapproved'),'queue','victim@example.invalid','subject','text'),/Unapproved recipient/);
});
test('ambiguous email errors cannot cause an automatic duplicate send',async()=>{
 const message=id('ambiguous');const result=await mail.queue(a,message,'queue','recipient@example.invalid','Task','text');
 const before=sends;transportFails=true;
 try {
  assert.equal((await mail.deliver(a,message,'deliver',result.version)).status,'unknown');
  await mail.deliver(a,message,'deliver',result.version);assert.equal(sends,before+1);
  const record=await mail.read(a,message);
  await assert.rejects(mail.deliver(a,message,'new-key',record.version),/already attempted/);
  assert.ok(!JSON.stringify(record).includes('private-provider-detail'));
 } finally {transportFails=false;}
});
test('inbound mail uses owned mailbox scope, deduplicates bytes and quarantines untrusted sender',async()=>{
 const envelope={from:'spoofed@example.invalid',to:'owned@example.invalid',raw:new TextEncoder().encode('From: forged@example.invalid\r\nSubject: test\r\n\r\nFixture '+crypto.randomUUID())};
 const received=await mail.receive(envelope);assert.deepEqual(await mail.receive(envelope),received);
 const record=await mail.read(b,received.id);assert.equal(record.status,'quarantined');assert.equal(record.senderIdentityVerified,false);
 assert.equal(Buffer.from(record.rawBase64,'base64').toString(),new TextDecoder().decode(envelope.raw));
 await assert.rejects(mail.receive({...envelope,to:'unknown@example.invalid'}),/Unknown mailbox/);
 await assert.rejects(mail.receive({...envelope,raw:new Uint8Array(2049)}),/inbound size/);
 await assert.rejects(mail.read(outsider,received.id),/Not found/);
});
if(pool)test('native transaction rollback includes aggregate, audit and idempotency receipt',async()=>{
 const aggregate=id('rollback');
 await pool.query("CREATE FUNCTION reject_fixture_event() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF NEW.event_type='fixture.fail' THEN RAISE EXCEPTION 'fixture rollback'; END IF; RETURN NEW; END $$");
 await pool.query('CREATE TRIGGER reject_fixture_event BEFORE INSERT ON business_work_events FOR EACH ROW EXECUTE FUNCTION reject_fixture_event()');
 const command={actor:a,id:aggregate,key:'rollback',expectedVersion:0,type:'fixture',payload:{}};
 await assert.rejects(store.run(command,async()=>{},async()=>({state:{id:aggregate,tenantId:a.tenantId,kind:'fixture',version:0},event:'fixture.fail'})),/fixture rollback/);
 assert.equal((await pool.query('SELECT COUNT(*)::int AS n FROM business_work_aggregates WHERE id=$1',[aggregate])).rows[0].n,0);
 assert.equal((await pool.query('SELECT COUNT(*)::int AS n FROM business_work_commands WHERE aggregate_id=$1',[aggregate])).rows[0].n,0);
 await pool.query('DROP TRIGGER reject_fixture_event ON business_work_events');
});
