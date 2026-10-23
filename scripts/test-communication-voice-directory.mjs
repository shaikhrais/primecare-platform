import {test} from 'node:test';
import assert from 'node:assert/strict';
import {VoiceExtensionService,PostgresVoiceDirectory} from '../cloudflare/workers/src/business-tasks/voice-directory.ts';
import {ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
import {PostgresCommunicationAccessPolicy} from '../cloudflare/workers/src/business-tasks/access-policy.ts';
const actor={id:'admin',tenantId:'tenant-a'},target='user-a';
const row=()=>({extension:'100001',tenantId:actor.tenantId,userId:target,published:false,active:true,tenantActive:true,userActive:true,version:1});
const atomic={run(){throw Error('Unused');},read(){throw Error('Unused');},inbox(){throw Error('Unused');}};
function fixture({change={},authorize=async()=>{},assignee=async()=>{}}={}){
 const calls=[];let committed=false;
 const registry={async assign(a,id,check){calls.push({a,id});const value={...row(),...change};await check(value);committed=true;return value;},async publish(a,id,version,published,check){const value={...row(),...change,published,version:version+1};await check(value);committed=true;return value;}};
 const policy={async assert(...args){calls.push(args);await authorize(...args);},assignee};
 return {service:new VoiceExtensionService(atomic,policy,registry),calls,committed:()=>committed};
}
test('extension assignment inherits shared authorization and defaults to unpublished',async()=>{
 const f=fixture();assert.ok(f.service instanceof ScopedServiceBase);
 const result=await f.service.assign(actor,target);assert.equal(result.published,false);assert.equal(result.tenantId,actor.tenantId);
 assert.equal(f.calls[1][1],'voice.extension.assign');assert.equal(f.calls[1][2].kind,'voice_destination');
});
test('denied assignment or target eligibility cannot commit',async()=>{
 for(const overrides of [{authorize:async()=>{throw Error('Denied');}},{assignee:async()=>{throw Error('Target denied');}}]){const f=fixture(overrides);await assert.rejects(f.service.assign(actor,target));assert.equal(f.committed(),false);}
});
test('cross-tenant, inactive tenant and inactive user cannot be assigned',async()=>{
 for(const change of [{tenantId:'tenant-b'},{tenantActive:false},{userActive:false}]){const f=fixture({change});await assert.rejects(f.service.assign(actor,target));assert.equal(f.committed(),false);}
});
test('publication authorization inspects the proposed publication state',async()=>{
 let inspected;const f=fixture({authorize:async(a,action,state)=>{inspected={action,state};}});
 const result=await f.service.publish(actor,target,1,true);assert.equal(result.published,true);assert.equal(result.version,2);assert.equal(inspected.action,'voice.extension.publish');assert.equal(inspected.state.published,true);
});
test('invalid publication version and input never commit',async()=>{
 for(const [version,published]of [[0,true],[1,'yes'],[Number.MAX_SAFE_INTEGER,true]]){const f=fixture();await assert.rejects(f.service.publish(actor,target,version,published));assert.equal(f.committed(),false);}
});
test('session directory rejects user IDs and raw bearer strings without querying',async()=>{
 let queries=0;const directory=new PostgresVoiceDirectory({async query(){queries++;throw Error('No query');},connect(){throw Error('No transaction');}});
 assert.equal(await directory.currentSession('user-a'),null);assert.equal(await directory.currentSession('Bearer secret'),null);assert.equal(queries,0);
});
test('session lookup handles ambiguity and filters current active membership in SQL',async()=>{
 let captured;const hash='a'.repeat(64);const directory=new PostgresVoiceDirectory({async query(sql,args){captured={sql,args};return {rows:[{id:hash,userId:target,tenantId:actor.tenantId,expiresAt:'9999999999999'}]};},connect(){}});
 const result=await directory.currentSession(hash);assert.equal(result.active,true);assert.equal(result.expiresAt,9999999999999);assert.deepEqual(captured.args,[hash]);assert.match(captured.sql,/LOWER\(t.status\)='active'/);assert.match(captured.sql,/s.expires_at>NOW\(\)/);
 const ambiguous=new PostgresVoiceDirectory({async query(){return {rows:[{},{}]};},connect(){}});assert.equal(await ambiguous.currentSession(hash),null);
});
test('invalid extension and lookup limit never reach database',async()=>{
 const directory=new PostgresVoiceDirectory({query(){assert.fail('Unexpected query');},connect(){}});
 await assert.rejects(directory.lookup('000000',2));await assert.rejects(directory.lookup('100001',1));await assert.rejects(directory.destinations({id:target,tenantId:'tenant-a'},1));
});
test('current native policy cannot silently activate unregistered Twilio actions',async()=>{
 const policy=new PostgresCommunicationAccessPolicy({connect(){assert.fail('Unregistered action queried live storage');}});
 for(const action of ['sms.queue','sms.deliver','sms.status.receive','voice.token','voice.call.connect','voice.call.answer','voice.task.propose','voice.task.execute','voice.voicemail.capture','voice.voicemail.notify','voice.voicemail.read','voice.extension.assign','voice.extension.publish'])await assert.rejects(policy.assert(actor,action,null),/Forbidden/);
});
