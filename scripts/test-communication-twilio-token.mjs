import {test} from 'node:test';
import assert from 'node:assert/strict';
import jwt from 'jsonwebtoken';
import {TwilioVoiceTokenService} from '../cloudflare/workers/src/business-tasks/twilio-token.ts';
import {ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
import {twilioVoiceIdentity} from '../packages/shared/src/communications/twilio-voice.mjs';
const configuration={accountSid:'AC'+'a'.repeat(32),apiKeySid:'SK'+'b'.repeat(32),apiKeySecret:'c'.repeat(32),applicationSid:'AP'+'d'.repeat(32),ttlSeconds:300};
const actor={id:'user-a',tenantId:'tenant-a'};
const session=()=>({id:'session-a',userId:actor.id,tenantId:actor.tenantId,expiresAt:Date.now()+600000,active:true});
const destination=()=>({extension:'100001',userId:actor.id,tenantId:actor.tenantId,published:true,active:true,tenantActive:true,userActive:true});
const store={run(){assert.fail('No persistence writes');},read(){assert.fail('No unrelated reads');},inbox(){assert.fail('No inbox reads');}};
function fixture({currentSession=async()=>session(),destinations=async()=>[destination()],authorize=async()=>{},config=configuration}={}){
 const calls=[];
 const policy={async assert(a,action,state){calls.push({a,action,state});await authorize(a,action,state);},async assignee(){assert.fail('No grant assignment');}};
 return {calls,service:new TwilioVoiceTokenService(store,policy,{currentSession,destinations},config)};
}
test('inherited service signs a bounded scoped JWT with official Twilio SDK',async()=>{
 const f=fixture();assert.ok(f.service instanceof ScopedServiceBase);
 const result=await f.service.issue('session-a');
 const claims=jwt.verify(result.token,configuration.apiKeySecret,{algorithms:['HS256'],issuer:configuration.apiKeySid,subject:configuration.accountSid});
 assert.equal(claims.grants.identity,await twilioVoiceIdentity({tenantId:actor.tenantId,userId:actor.id}));
 assert.deepEqual(claims.grants.voice,{incoming:{allow:true},outgoing:{application_sid:configuration.applicationSid}});
 assert.equal(claims.exp-claims.iat,300);assert.equal(result.ttlSeconds,300);
 assert.equal(f.calls.length,2);for(const call of f.calls){assert.deepEqual(call.a,actor);assert.equal(call.action,'voice.token');assert.equal(call.state,null);}
 assert.doesNotMatch(JSON.stringify(f.service),/cccccccc/);
});
test('short session bounds token lifetime and never rounds up',async()=>{
 const result=await fixture({currentSession:async()=>({...session(),expiresAt:Date.now()+5500})}).service.issue('session-a');
 assert.ok(result.ttlSeconds>=4&&result.ttlSeconds<=5);
});
test('missing, expired, inactive, changed and malformed sessions deny issuance',async()=>{
 for(const change of [null,{active:false},{expiresAt:Date.now()-1},{expiresAt:NaN},{id:'other'},{tenantId:''},{userId:'bad\u0000'}]){
  await assert.rejects(fixture({currentSession:async()=>change===null?null:{...session(),...change}}).service.issue('session-a'),/^Error: Voice unavailable$/);
 }
});
test('current destination must match the authenticated tenant and user',async()=>{
 for(const rows of [[],[destination(),destination()],...[{tenantId:'other'},{userId:'other'},{published:false},{active:false},{tenantActive:false},{userActive:false},{extension:'000000'}].map(change=>[{...destination(),...change}])]){
  await assert.rejects(fixture({destinations:async()=>rows}).service.issue('session-a'),/Voice unavailable/);
 }
});
test('permission denied initially or on final recheck never issues a token',async()=>{
 for(const failAt of [1,2]){let calls=0;await assert.rejects(fixture({authorize:async()=>{if(++calls===failAt)throw Error('PRIVATE POLICY');}}).service.issue('session-a'),/^Error: Voice unavailable$/);}
});
test('session revocation and tenant switch during signing preparation deny issuance',async()=>{
 for(const change of [null,{active:false},{tenantId:'other'},{userId:'other'},{expiresAt:Date.now()-1}]){
  let reads=0;await assert.rejects(fixture({currentSession:async()=>++reads===1?session():change===null?null:{...session(),...change}}).service.issue('session-a'),/Voice unavailable/);
 }
});
test('destination revocation or extension reassignment on recheck denies issuance',async()=>{
 for(const rows of [[],[{...destination(),published:false}],[{...destination(),extension:'100002'}]]){
  let reads=0;await assert.rejects(fixture({destinations:async()=>++reads===1?[destination()]:rows}).service.issue('session-a'),/Voice unavailable/);
 }
});
test('mutable directory rows cannot rewrite original session or destination snapshots',async()=>{
 const row=session();let reads=0;
 await assert.rejects(fixture({currentSession:async()=>{if(++reads>1)row.tenantId='other';return row;}}).service.issue('session-a'),/Voice unavailable/);
 const target=destination();reads=0;
 await assert.rejects(fixture({destinations:async()=>{if(++reads>1)target.extension='100002';return [target];}}).service.issue('session-a'),/Voice unavailable/);
});
test('infrastructure errors are generic and expose no provider or database details',async()=>{
 await assert.rejects(fixture({destinations:async()=>{throw Error('PRIVATE DATABASE');}}).service.issue('session-a'),/^Error: Voice unavailable$/);
});
test('untrusted request objects cannot select an identity, tenant, TTL or TwiML app',async()=>{
 for(const input of [{sessionId:'session-a',tenantId:'other'},'',null,'a b','x'.repeat(201)])await assert.rejects(fixture().service.issue(input),/Voice unavailable/);
});
test('configuration is snapshotted and rejects missing adapters, wrong SIDs and excessive lifetime',()=>{
 for(const change of [{accountSid:'bad'},{apiKeySid:'bad'},{apiKeySecret:'bad'},{applicationSid:'bad'},{ttlSeconds:0},{ttlSeconds:301},{ttlSeconds:1.5}])assert.throws(()=>fixture({config:{...configuration,...change}}));
 assert.throws(()=>new TwilioVoiceTokenService(store,{assert(){}},{},configuration));
});
