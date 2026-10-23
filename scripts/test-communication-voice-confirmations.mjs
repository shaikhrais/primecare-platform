import {test} from 'node:test';import assert from 'node:assert/strict';
import {PostgresVoiceTaskConfirmationService} from '../cloudflare/workers/src/business-tasks/voice-confirmations.ts';
import {ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
const actor={id:'alice',tenantId:'tenant-a'},callSid='CA'+'a'.repeat(32),intentId='11111111-1111-4111-8111-111111111111',hash='b'.repeat(64);
function fixture(){
 let denied=false;const queries=[];
 const identity={actor:{...actor},sessionId:'otp-session',authentication:'otp',active:true,expiresAt:Date.now()+300000};
 const intent={id:intentId,callSid,actor:{...actor},sessionId:'otp-session',taskId:'fixture.update',taskVersion:1,args:{version:1},summary:'Update owned fixture at version 1',digest:hash,expiresAt:Date.now()+120000,status:'proposed'};
 const pool={async query(sql,params){queries.push({sql,params});return {rows:sql.startsWith('INSERT')?[{intent_id:intentId,expires_at:params[7]}]:[{approved_at:Date.now()}]};}};
 const service=new PostgresVoiceTaskConfirmationService({run(){throw Error('unused');},read(){throw Error('unused');},inbox(){throw Error('unused');}},{async assert(a,action,state){assert.deepEqual(a,actor);assert.equal(action,'voice.task.confirm');assert.equal(state.kind,'voice_task');if(denied)throw Error('Denied');},async assignee(){throw Error('unused');}},pool,{async current(){return structuredClone(identity);}},{async read(){return structuredClone(intent);}});
 return {service,queries,identity,intent,pool,deny(){denied=true;}};
}
test('inherited app preview returns exact server summary without approving or executing',async()=>{const f=fixture();assert.ok(f.service instanceof ScopedServiceBase);assert.deepEqual(await f.service.preview(actor,intentId),{intentId,summary:f.intent.summary,digest:hash,expiresAt:f.intent.expiresAt});assert.equal(f.queries.length,0);});
test('only native owner in same tenant and verified call session can approve',async()=>{
 for(const owner of [{id:'bob',tenantId:'tenant-a'},{id:'alice',tenantId:'tenant-b'}]){const f=fixture();await assert.rejects(f.service.approve(owner,intentId,hash));assert.equal(f.queries.length,0);}
 for(const mutate of [f=>f.identity.sessionId='replacement',f=>f.identity.authentication='voice-match',f=>f.identity.active=false,f=>f.intent.status='executing',f=>f.intent.expiresAt=Date.now()-1,f=>f.deny()]){const f=fixture();mutate(f);await assert.rejects(f.service.approve(actor,intentId,hash));assert.equal(f.queries.length,0);}
});
test('changed displayed digest and malformed proposal ID cannot approve',async()=>{const f=fixture();await assert.rejects(f.service.approve(actor,intentId,'c'.repeat(64)),/changed/);await assert.rejects(f.service.approve(actor,'arbitrary',hash));assert.equal(f.queries.length,0);});
test('app approval binds exact actor session call and digest with a maximum one minute lifetime',async()=>{const f=fixture();await f.service.approve(actor,intentId,hash);const args=f.queries[0].params;assert.deepEqual(args.slice(0,6),[intentId,hash,callSid,'otp-session','alice','tenant-a']);assert.equal(args[7]-args[6],60000);});
test('consumption validates current context again and cannot use a different call or session',async()=>{const f=fixture();const input={callSid,intentId,digest:hash,actor,sessionId:'otp-session'};assert.equal(await f.service.consumeConfirmation({...input,callSid:'CA'+'d'.repeat(32)}),null);assert.equal(await f.service.consumeConfirmation({...input,sessionId:'other'}),null);assert.equal(f.queries.length,0);assert.equal((await f.service.consumeConfirmation(input)).method,'app');});
test('empty database result fails approval or returns no consumed proof',async()=>{const f=fixture();f.pool.query=async()=>({rows:[]});await assert.rejects(f.service.approve(actor,intentId,hash),/expired or consumed/);assert.equal(await f.service.consumeConfirmation({callSid,intentId,digest:hash,actor,sessionId:'otp-session'}),null);});
