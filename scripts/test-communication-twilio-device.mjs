import {test} from 'node:test';
import assert from 'node:assert/strict';
import {EventEmitter} from 'node:events';
import {TwilioVoiceDevice} from '../packages/shared/src/communications/twilio-device.mjs';
import {CommunicationResourceBase} from '../packages/shared/src/communications/adapter-base.mjs';
const deferred=()=>{let resolve;const promise=new Promise(r=>resolve=r);return {promise,resolve};};
class Device extends EventEmitter {
 destroyed=0;disconnected=0;updates=[];
 async register(){this.emit('registered');}
 updateToken(token){this.updates.push(token);}
 destroy(){this.destroyed++;}
 disconnectAll(){this.disconnected++;}
}
function setup(extra={}){let scope='session-a',requests=0;const device=new Device();const resource=new TwilioVoiceDevice({createDevice:()=>device,currentScope:()=>scope,fetchToken:async()=>{requests++;return {token:'secret-fixture',identity:'tenant-user',ttlSeconds:300};},...extra});return {resource,device,setScope:s=>scope=s,requests:()=>requests};}
test('inherited device waits for registered event and owns cleanup once',async()=>{
 const {resource,device}=setup();assert.ok(resource instanceof CommunicationResourceBase);
 await resource.start();assert.equal(resource.state,'registered');resource.close();resource.close();
 assert.equal(device.destroyed,1);assert.equal(device.disconnected,1);assert.equal(device.eventNames().length,0);
});
test('register promise resolution alone is not registration',async()=>{
 const {resource,device}=setup();device.register=async()=>{};
 const started=resource.start();await new Promise(r=>setImmediate(r));assert.equal(resource.state,'registering');
 device.emit('registered');await started;resource.close();
});
test('logout during token request aborts and never constructs device',async()=>{
 const pending=deferred();let created=0,signal;
 const {resource}=setup({createDevice:()=>{created++;return new Device();},fetchToken:args=>{signal=args.signal;return pending.promise;}});
 const started=resource.start();resource.close();assert.equal(signal.aborted,true);
 pending.resolve({token:'late',identity:'user',ttlSeconds:300});await assert.rejects(started);assert.equal(created,0);
});
test('tenant change during refresh cannot install new token',async()=>{
 const {resource,device,setScope}=setup();await resource.start();const pending=deferred();resource.fetchToken=()=>pending.promise;
 const refreshed=resource.refresh();setScope('tenant-b');pending.resolve({token:'other',identity:'tenant-user',ttlSeconds:300});
 await assert.rejects(refreshed);assert.deepEqual(device.updates,[]);assert.equal(resource.closed,true);
});
test('concurrent token renewals share one request',async()=>{
 const {resource,device,requests}=setup();await resource.start();await Promise.all([resource.refresh(),resource.refresh()]);
 assert.equal(requests(),2);assert.equal(device.updates.length,1);resource.close();
});
test('identity change or denied renewal destroys the device',async()=>{
 for(const fetchToken of [async()=>({token:'wrong',identity:'other',ttlSeconds:300}),async()=>{throw Error('private provider detail');}]){
  const {resource,device}=setup();await resource.start();resource.fetchToken=fetchToken;
  await assert.rejects(resource.refresh(),/^Error: Voice token unavailable$/);assert.equal(device.destroyed,1);
 }
});
test('SDK errors and unregistration close registration and active resources',async()=>{
 for(const event of ['error','unregistered','destroyed']){const {resource,device}=setup();await resource.start();device.emit(event,Error('private'));assert.equal(resource.closed,true);}
});
test('incoming defaults to reject and tenant change rejects before host callback',async()=>{
 const first=setup();await first.resource.start();let rejected=0;first.device.emit('incoming',{reject(){rejected++;}});assert.equal(rejected,1);first.resource.close();
 let offered=0;const second=setup({onIncoming(){offered++;}});await second.resource.start();second.setScope('other');second.device.emit('incoming',{reject(){rejected++;}});assert.equal(offered,0);assert.equal(rejected,2);
});
test('registration failure and timeout release device and listeners',async()=>{
 for(const register of [async()=>{throw Error('private');},async()=>{}]){const {resource,device}=setup({registrationTimeoutMs:100});device.register=register;await assert.rejects(resource.start(),/^Error: Voice device unavailable$/);assert.equal(device.destroyed,1);assert.equal(device.eventNames().length,0);}
});
test('expiry closes device even without an SDK expiry notification',async t=>{
 t.mock.timers.enable({apis:['Date','setTimeout'],now:10000});
 const {resource,device}=setup({fetchToken:async()=>({token:'short',identity:'user',ttlSeconds:1})});await resource.start();
 t.mock.timers.tick(1001);assert.equal(resource.closed,true);assert.equal(device.destroyed,1);
});
test('renewal after close is rejected without requesting credentials',async()=>{
 const {resource,requests}=setup();await resource.start();resource.close();await assert.rejects(resource.refresh());assert.equal(requests(),1);
});
