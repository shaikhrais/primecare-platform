import {test} from 'node:test';import assert from 'node:assert/strict';
import {VoiceTaskService,VoiceTaskBase,BoundVoiceApiTask} from '../cloudflare/workers/src/business-tasks/voice-tasks.ts';
import {ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
const callSid='CA'+'a'.repeat(32);
function fixture(){
 const rows=new Map();let executions=0,denied=false,confirmed=false,consumeCount=0,fail=false;
 const identity={actor:{id:'alice',tenantId:'tenant-a'},sessionId:'verified-session',authentication:'otp',active:true,expiresAt:Date.now()+300000};
 const repository={async create(i){assert.ok(!rows.has(i.id));rows.set(i.id,structuredClone(i));},async read(id){return structuredClone(rows.get(id)??null);},async claim(id,hash){const row=rows.get(id);if(row.status!=='proposed'||row.digest!==hash)return false;row.status='executing';return true;},async finish(id,status){assert.equal(rows.get(id).status,'executing');rows.get(id).status=status;}};
 const trust={async current(id){assert.equal(id,callSid);return structuredClone(identity);},async consumeConfirmation(input){consumeCount++;const row=rows.get(input.intentId);assert.equal(input.digest,row.digest);assert.equal(input.sessionId,identity.sessionId);if(!confirmed)return null;confirmed=false;return {approved:true,method:'dtmf',approvedAt:Date.now()};}};
 const task=new BoundVoiceApiTask('fixture.update',1,{validate(args){if(Object.keys(args).sort().join(',')!=='recordId,version'||typeof args.recordId!=='string'||!Number.isSafeInteger(args.version)||args.version<1)throw Error('Invalid task');return {...args};},describe(args){return `Update record ${args.recordId} at version ${args.version}`;},async execute(actor,args,key){executions++;assert.deepEqual(actor,{id:'alice',tenantId:'tenant-a'});assert.equal(args.recordId,'owned-record');assert.match(key,/^voice-task:/);if(fail)throw Error('private provider timeout');}});
 const service=new VoiceTaskService({run(){throw Error('unused');},read(){throw Error('unused');},inbox(){throw Error('unused');}},{async assert(actor,action,state){if(denied||actor.tenantId!==state.tenantId)throw Error('Denied');},async assignee(){throw Error('unused');}},repository,trust,[task]);
 return {service,task,rows,repository,trust,identity,confirm(){confirmed=true;},deny(){denied=true;},fail(){fail=true;},get executions(){return executions;},get consumeCount(){return consumeCount;}};
}
const args={recordId:'owned-record',version:1};
test('inherited gateway proposes exact summary without executing then needs independent confirmation',async()=>{
 const f=fixture();assert.ok(f.service instanceof ScopedServiceBase);assert.ok(f.task instanceof VoiceTaskBase);const proposal=await f.service.propose(callSid,'fixture.update',args);assert.match(proposal.summary,/owned-record/);assert.equal(f.executions,0);
 await assert.rejects(f.service.execute(callSid,proposal.intentId),/confirmation/);f.confirm();assert.deepEqual(await f.service.execute(callSid,proposal.intentId),{status:'completed'});assert.equal(f.executions,1);await assert.rejects(f.service.execute(callSid,proposal.intentId));assert.equal(f.executions,1);
});
test('caller ID, voice matching, expired identity and unlisted tools cannot grant execution',async()=>{
 for(const mutation of [f=>f.identity.authentication='voice-match',f=>f.identity.authentication='caller-id',f=>f.identity.active=false,f=>f.identity.expiresAt=Date.now()-1]){const f=fixture();mutation(f);await assert.rejects(f.service.propose(callSid,'fixture.update',args));assert.equal(f.executions,0);}
 const f=fixture();await assert.rejects(f.service.propose(callSid,'arbitrary.fetch',{url:'https://example.com'}));await assert.rejects(f.service.propose(callSid,'fixture.update',{...args,actor:{id:'admin'}}));
});
test('edited proposal, different session, cross-tenant identity or changed task version require new approval',async()=>{
 for(const mutate of [(f,p)=>f.rows.get(p.intentId).args.version=2,(f,p)=>f.rows.get(p.intentId).summary='Do something else',f=>f.identity.sessionId='replacement',f=>f.identity.actor.tenantId='tenant-b',f=>f.task.version=2]){const f=fixture(),p=await f.service.propose(callSid,'fixture.update',args);f.confirm();mutate(f,p);await assert.rejects(f.service.execute(callSid,p.intentId));assert.equal(f.executions,0);}
});
test('concurrent execution consumes one approval and executes once',async()=>{const f=fixture(),p=await f.service.propose(callSid,'fixture.update',args);f.confirm();const outcomes=await Promise.allSettled([f.service.execute(callSid,p.intentId),f.service.execute(callSid,p.intentId)]);assert.equal(outcomes.filter(r=>r.status==='fulfilled').length,1);assert.equal(f.executions,1);});
test('current revocation blocks execution; provider ambiguity is persisted without retry',async()=>{
 const denied=fixture(),p=await denied.service.propose(callSid,'fixture.update',args);denied.confirm();denied.deny();await assert.rejects(denied.service.execute(callSid,p.intentId));assert.equal(denied.executions,0);
 const failed=fixture(),q=await failed.service.propose(callSid,'fixture.update',args);failed.confirm();failed.fail();await assert.rejects(failed.service.execute(callSid,q.intentId),/outcome unknown/);assert.equal(failed.rows.get(q.intentId).status,'unknown');await assert.rejects(failed.service.execute(callSid,q.intentId));assert.equal(failed.executions,1);
});
test('transcript yes and stale confirmation cannot approve a task',async()=>{
 for(const proof of [{approved:true,method:'speech',approvedAt:Date.now()},{approved:true,method:'app',approvedAt:Date.now()-61000}]){const f=fixture(),p=await f.service.propose(callSid,'fixture.update',args);f.trust.consumeConfirmation=async()=>proof;await assert.rejects(f.service.execute(callSid,p.intentId));assert.equal(f.executions,0);}
});
