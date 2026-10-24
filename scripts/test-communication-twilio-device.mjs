import {test} from 'node:test';
import assert from 'node:assert/strict';
import {EventEmitter} from 'node:events';
import {TwilioVoiceDevice} from '../packages/shared/src/communications/twilio-device.mjs';
import {CommunicationResourceBase} from '../packages/shared/src/communications/adapter-base.mjs';
function incoming(reject=()=>{}){const call=new EventEmitter();call.reject=reject;call.disconnect=()=>{};return call;}
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
 const first=setup();await first.resource.start();let rejected=0;first.device.emit('incoming',incoming(()=>rejected++));assert.equal(rejected,1);first.resource.close();
 let offered=0;const second=setup({onIncoming(){offered++;}});await second.resource.start();second.setScope('other');second.device.emit('incoming',incoming(()=>rejected++));assert.equal(offered,0);assert.equal(rejected,2);
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
test('outgoing connects with extensions only, rejects concurrent calls and releases ended call',async()=>{
 const {resource,device}=setup();const calls=[];device.connect=async options=>{calls.push(options);const call=new EventEmitter();call.disconnect=()=>{};return call;};
 await resource.start();const call=await resource.connect({callerExtension:'1001',targetExtension:'1002'});
 assert.deepEqual(calls,[{params:{CallerExtension:'1001',TargetExtension:'1002'}}]);
 await assert.rejects(resource.connect({callerExtension:'1001',targetExtension:'1003'}));
 call.emit('disconnect');assert.equal(call.eventNames().length,0);
 await resource.connect({callerExtension:'1001',targetExtension:'1003'});resource.close();
});
test('late outgoing call after logout is disconnected and never returned',async()=>{
 const pending=deferred();const {resource,device}=setup();device.connect=()=>pending.promise;
 await resource.start();const connecting=resource.connect({callerExtension:'1001',targetExtension:'1002'});resource.close();
 let disconnected=0;pending.resolve({disconnect(){disconnected++;}});await assert.rejects(connecting);assert.equal(disconnected,1);
});
test('outgoing SDK error disconnects the old media before another extension call can replace it',async()=>{
 const {resource,device}=setup(),calls=[];
 device.connect=async()=>{const call=new EventEmitter();call.ends=0;call.disconnect=()=>{call.ends++;call.emit('disconnect');};calls.push(call);return call;};
 await resource.start();const first=await resource.connect({callerExtension:'1001',targetExtension:'1002'});first.emit('error',Error('private provider detail'));
 assert.equal(first.ends,1);assert.equal(first.eventNames().length,0);assert.equal(resource.closed,false);
 const next=await resource.connect({callerExtension:'1001',targetExtension:'1003'});resource.close();assert.equal(next.ends,1);assert.equal(first.ends,1);assert.equal(next.eventNames().length,0);
});
test('outgoing error with failed SDK disconnect destroys the device and cannot escape a display failure',async()=>{
 const {resource,device}=setup();const call=new EventEmitter();call.disconnect=()=>{throw Error('private disconnect');};device.connect=async()=>call;
 await resource.start();await resource.connect({callerExtension:'1001',targetExtension:'1002'});resource.onState=()=>{throw Error('private display');};
 assert.doesNotThrow(()=>call.emit('error',Error('private provider')));assert.equal(resource.closed,true);assert.equal(device.destroyed,1);assert.equal(device.disconnected,1);assert.equal(call.eventNames().length,0);
});
test('phone numbers, identical extensions and outgoing calls before registration are denied',async()=>{
 const {resource,device}=setup();let calls=0;device.connect=async()=>{calls++;};
 await assert.rejects(resource.connect({callerExtension:'1001',targetExtension:'1002'}));
 await resource.start();for(const targetExtension of ['+15550001000','1001','sip:user@example.com'])await assert.rejects(resource.connect({callerExtension:'1001',targetExtension}));
 assert.equal(calls,0);resource.close();
});
test('managed ringing session rejects competing calls and is disposed with the device',async()=>{
 const managed=new CommunicationResourceBase();let offered=0;const {resource,device}=setup({onIncoming(){offered++;return managed;}});device.connect=async()=>{};await resource.start();let rejected=0;
 device.emit('incoming',incoming(()=>rejected++));await new Promise(r=>setImmediate(r));device.emit('incoming',incoming(()=>rejected++));assert.equal(offered,1);assert.equal(rejected,1);
 await assert.rejects(resource.connect({callerExtension:'1001',targetExtension:'1002'}));resource.close();assert.equal(managed.closed,true);
});

test('logout owns and rejects a pending incoming offer before host UI resolves',async()=>{
 const pending=deferred();const {resource,device}=setup({onIncoming:()=>pending.promise});await resource.start();let rejected=0;
 const call=incoming(()=>rejected++);device.emit('incoming',call);resource.close();assert.equal(rejected,1);assert.equal(call.eventNames().length,0);
 const late=new CommunicationResourceBase();pending.resolve(late);await new Promise(r=>setImmediate(r));assert.equal(late.closed,true);assert.equal(rejected,1);
});
test('scope change during incoming UI creation closes both device and late panel',async()=>{
 const pending=deferred(),late=new CommunicationResourceBase();const {resource,device,setScope}=setup({onIncoming:()=>pending.promise});await resource.start();let rejected=0;
 device.emit('incoming',incoming(()=>rejected++));setScope('other');pending.resolve(late);await new Promise(r=>setImmediate(r));assert.ok(resource.closed);assert.ok(late.closed);assert.equal(rejected,1);
});
test('canceled pending offer cannot replace or close a newer managed call',async()=>{
 const first=deferred(),second=new CommunicationResourceBase();let offered=0;const {resource,device}=setup({onIncoming:()=>++offered===1?first.promise:second});await resource.start();
 const call=incoming();device.emit('incoming',call);call.emit('cancel');assert.equal(call.eventNames().length,0);device.emit('incoming',incoming());
 const late=new CommunicationResourceBase();first.resolve(late);await new Promise(r=>setImmediate(r));assert.ok(late.closed);assert.equal(second.closed,false);assert.equal(resource.closed,false);
 let rejected=0;device.emit('incoming',incoming(()=>rejected++));assert.equal(rejected,1);assert.equal(offered,2);resource.close();assert.ok(second.closed);
});
test('rejection of old UI promise leaves a newer incoming call available',async()=>{
 let reject;const pending=new Promise((resolve,r)=>reject=r),second=new CommunicationResourceBase();let offered=0;const {resource,device}=setup({onIncoming:()=>++offered===1?pending:second});await resource.start();
 const first=incoming();device.emit('incoming',first);first.emit('cancel');device.emit('incoming',incoming());reject(Error('private UI failure'));await new Promise(r=>setImmediate(r));assert.equal(resource.closed,false);assert.equal(second.closed,false);resource.close();
});
test('missing or failed incoming UI does not leave an unowned ringing call',async()=>{
 for(const onIncoming of [()=>undefined,()=>{throw Error('private');},async()=>{throw Error('private');}]){
  const {resource,device}=setup({onIncoming});await resource.start();let rejected=0;const call=incoming(()=>rejected++);device.emit('incoming',call);await new Promise(r=>setImmediate(r));assert.equal(rejected,1);assert.equal(call.eventNames().length,0);resource.close();
 }
});
test('pending incoming call blocks outgoing connections and error disconnects accepted media',async()=>{
 const pending=deferred();const {resource,device}=setup({onIncoming:()=>pending.promise});let outgoing=0;device.connect=async()=>{outgoing++;};await resource.start();const call=incoming();let disconnected=0;call.disconnect=()=>disconnected++;
 device.emit('incoming',call);await assert.rejects(resource.connect({callerExtension:'1001',targetExtension:'1002'}));assert.equal(outgoing,0);call.emit('accept');call.emit('error',Error('private'));assert.equal(disconnected,1);assert.equal(call.eventNames().length,0);pending.resolve(new CommunicationResourceBase());await new Promise(r=>setImmediate(r));resource.close();
});
test('a canceled offer with a later UI failure does not unregister the device',async()=>{
 let reject;const pending=new Promise((resolve,r)=>reject=r);const {resource,device}=setup({onIncoming:()=>pending});await resource.start();const call=incoming();device.emit('incoming',call);call.emit('cancel');reject(Error('late UI error'));await new Promise(r=>setImmediate(r));assert.equal(resource.closed,false);resource.close();
});
