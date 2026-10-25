import {test} from 'node:test';import assert from 'node:assert/strict';import {readFileSync} from 'node:fs';
import {internalCallGatewayServices,assertOwnedInternalCallTarget,validOwnedTurnKey,recoverableUnusedTurnKey,turnCreateResult} from './internal-call-deployment-plan.mjs';
const config=JSON.parse(readFileSync('cloudflare/workers/src/business-tasks/internal-call-deployment.json'));
const names=['auth','client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting'];
const settings=()=>({bindings:[...names.map(s=>({name:s.replaceAll('-','_').toUpperCase(),type:'service',service:'primecare-'+s+'-api'})),{name:'VOICE_CONTACT',type:'service',service:'primecare-voice-contact-api'},{name:'JWT_SECRET',type:'secret_text'}]});
test('calling deployment preserves existing thirteen service targets and encrypted gateway secret',()=>{const s=settings(),before=structuredClone(s),services=internalCallGatewayServices(s,config);assert.deepEqual(s,before);assert.equal(services.length,14);assert.ok(services.some(b=>b.binding==='VOICE_CONTACT'));assert.equal(services.filter(b=>b.binding==='INTERNAL_CALLS').length,1);s.bindings.push({name:'INTERNAL_CALLS',type:'service',service:config.workerName});assert.deepEqual(internalCallGatewayServices(s,config),services);});
test('unexpected gateway ownership, duplicate targets and unknown secrets preserve existing deployment',()=>{for(const mutation of [s=>s.bindings[0].service='foreign',s=>s.bindings.push(s.bindings[0]),s=>s.bindings.push({name:'OTHER',type:'secret_text'}),s=>s.bindings.push({name:'INTERNAL_CALLS',type:'service',service:'foreign'})]){const s=settings();mutation(s);assert.throws(()=>internalCallGatewayServices(s,config),/preserved/);}});
test('calling Worker must be absent or owned with only known bindings',()=>{assertOwnedInternalCallTarget(null,config);const s={bindings:[{name:'INTERNAL_CALL_OWNER',text:config.owner},{name:'TURN_KEY_TOKEN',type:'secret_text'}]};assertOwnedInternalCallTarget(s,config);assert.throws(()=>assertOwnedInternalCallTarget({bindings:[]},config),/preserved/);assert.throws(()=>assertOwnedInternalCallTarget({bindings:[...s.bindings,{name:'OTHER'}]},config),/preserved/);});

test('TURN response validation accepts provider-compatible bounded keys without assuming fixed token length',()=>{
 const key={name:config.turnKeyName,uid:'a'.repeat(32),key:'b'.repeat(96)};assert.equal(validOwnedTurnKey(key,config),true);
 for(const altered of [{...key,name:'foreign'},{...key,uid:'../foreign'},{...key,key:'bad\nsecret'},{...key,key:'b'.repeat(513)}])assert.equal(validOwnedTurnKey(altered,config),false);
});
test('recovery is restricted to the exact failed unused first-provisioning checkpoint',()=>{
 const input={key:{name:config.turnKeyName,uid:'a'.repeat(32)},worker:{bindings:[{name:'INTERNAL_CALL_OWNER',text:config.owner},{name:'INTERNAL_CALL_SOURCE',text:'b2b89613f2af779beb3b84ed9d513ff4b8741a6a'}]},gateway:{bindings:[]}};assert.equal(recoverableUnusedTurnKey(input,config),true);
 for(const change of [x=>x.key.name='foreign',x=>x.worker.bindings[0].text='foreign',x=>x.worker.bindings.push({name:'TURN_KEY_TOKEN',type:'secret_text'}),x=>x.worker.bindings[1].text='other-source',x=>x.gateway.bindings.push({name:config.gatewayBinding})]){const next=structuredClone(input);change(next);assert.equal(recoverableUnusedTurnKey(next,config),false);}
});

test('one-time TURN bearer is retained from either documented result or live envelope without ambiguity',()=>{
 const result={name:config.turnKeyName,uid:'a'.repeat(32)},key='b'.repeat(64);
 assert.equal(turnCreateResult({result,key}).key,key);assert.equal(turnCreateResult({result:{...result,key}}).key,key);
 assert.throws(()=>turnCreateResult({result:{...result,key},key:'different'}),/invalid_turn_key/);
});

test('observed Cloudflare result.secret bearer is accepted but conflicting secret and key are rejected',()=>{
 const result={name:config.turnKeyName,uid:'a'.repeat(32),secret:'b'.repeat(64)};
 assert.equal(validOwnedTurnKey(turnCreateResult({result}),config),true);
 assert.throws(()=>turnCreateResult({result:{...result,key:'different'}}),/invalid_turn_key/);
});
