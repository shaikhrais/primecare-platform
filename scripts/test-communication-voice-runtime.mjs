import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {TwilioVoiceExtensionAdapter} from '../packages/shared/src/communications/twilio-voice.mjs';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
import catalog from '../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
const bundle=await build({entryPoints:['cloudflare/workers/src/business-tasks/voice-runtime.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {CommunicationVoiceWorker}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));

const origin='https://fixture.invalid';
function fixture(){
 const seen=[],closed=[];const adapter=name=>({async respond(request){seen.push({name,request});return new Response(name,{headers:{'cache-control':'no-store'}});}});
 const ports=Object.fromEntries(['native','voice','connect','voicemail','pairing','agent','smsStatus'].map(k=>[k,adapter(k)]));
 let opened=0,pairs=0;const client={close(){closed.push('client');}},server={send(){},close(){closed.push('server');},addEventListener(){},removeEventListener(){}};
 const upgrade={status:101};
 ports.relay={open(){opened++;return {close(){closed.push('session');}};}};
 ports.sockets={pair(){pairs++;return {client,server};},upgrade(){return upgrade;}};
 return {ports,seen,closed,upgrade,worker(){return new CommunicationVoiceWorker(origin,ports);},get opened(){return opened;},get pairs(){return pairs;}};
}
test('registered provider and app operations reach their separate adapters with the original request',async()=>{
 const f=fixture(),w=f.worker();
 const expected=['native','native','native','native','native','native','native','native','native','voice','voice','connect','voicemail','voicemail','voicemail','pairing','pairing','agent','agent'];
 for(const [i,op] of catalog.operations.entries()){
  if(op.key==='voice.relay')continue;
  const req=new Request(origin+op.path,{method:op.method,body:'fixture',headers:{'x-twilio-signature':'original-signature','authorization':'Bearer fixture'}});
  const result=await w.fetch(req,{});assert.equal(await result.text(),i===20?'smsStatus':expected[i]);assert.equal(f.seen.at(-1).request,req);
 }
 assert.equal(f.seen.length,20);assert.equal(f.opened,0);
});
test('unregistered paths, origin changes, method changes and query injection do not reach any adapter',async()=>{
 const f=fixture(),w=f.worker(),path='/v1/twilio/voice/agent';
 for(const [url,method,status] of [[origin+'/unregistered','POST',404],['https://attacker.invalid'+path,'POST',404],[origin+path,'GET',405],[origin+path+'?tenantId=other','POST',400],[origin+path+'#secret','POST',400]])assert.equal((await w.fetch(new Request(url,{method}),{})).status,status);
 assert.equal(f.seen.length,0);assert.equal(f.pairs,0);
});
test('real signed incoming adapter denies forged calls and returns the four-digit menu through the host',async()=>{
 const f=fixture(),token='b'.repeat(32),account='AC'+'a'.repeat(32),number='+15550001000',url=origin+'/v1/twilio/voice/incoming';
 f.ports.voice=new TwilioVoiceExtensionAdapter({accountSid:account,authToken:token,sharedNumber:number,numberVerified:true,incomingUrl:url,gatherUrl:origin+'/v1/twilio/voice/gather',maxWebhookBytes:4096,directory:{async lookup(){return [];}}});
 const w=f.worker(),params={AccountSid:account,CallSid:'CA'+'c'.repeat(32),To:number,From:'+15550002000',Direction:'inbound'};
 const req=signature=>new Request(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature},body:new URLSearchParams(params)});
 assert.equal((await w.fetch(req('forged'),{})).status,403);
 const response=await w.fetch(req(getExpectedTwilioSignature(token,url,params)),{});
 assert.equal(response.status,200);assert.match(await response.text(),/numDigits="4"/);
});
test('ordinary GET and unsigned upgrades cannot allocate WebSockets',async()=>{
 const f=fixture(),w=f.worker(),url=origin+'/v1/twilio/voice/relay';
 assert.equal((await w.fetch(new Request(url),{})).status,426);
 assert.equal((await w.fetch(new Request(url,{headers:{upgrade:'websocket'}}),{})).status,403);
 assert.equal(f.pairs,0);assert.equal(f.opened,0);
});
test('upgrade returns the original client response without JSON wrapping or compression',async()=>{
 const f=fixture(),w=f.worker();const request=new Request(origin+'/v1/twilio/voice/relay',{headers:{upgrade:'websocket','x-twilio-signature':'fixture-signature'}});
 assert.equal(await w.fetch(request,{}),f.upgrade);assert.equal(f.opened,1);assert.deepEqual(f.closed,[]);
});
test('signature rejection closes both allocated sockets without exposing the exception',async()=>{
 const f=fixture();f.ports.relay.open=()=>{throw Error('PRIVATE secret');};const w=f.worker();
 const response=await w.fetch(new Request(origin+'/v1/twilio/voice/relay',{headers:{upgrade:'websocket','x-twilio-signature':'forged'}}),{});
 assert.equal(response.status,403);assert.deepEqual(f.closed,['server','client']);assert.doesNotMatch(await response.text(),/PRIVATE/);
});
test('upgrade construction failure releases the registered session and both sockets',async()=>{
 for(const mode of ['throw','wrong-status']){const f=fixture();f.ports.sockets.upgrade=()=>{if(mode==='throw')throw Error('PRIVATE');return new Response('bad');};const response=await f.worker().fetch(new Request(origin+'/v1/twilio/voice/relay',{headers:{upgrade:'websocket','x-twilio-signature':'fixture'}}),{});assert.equal(response.status,403);assert.deepEqual(f.closed,['session','server','client']);}
});
test('missing dependencies fail at construction and adapter exceptions stay private',async()=>{
 for(const key of ['native','voice','connect','voicemail','pairing','agent','smsStatus','relay','sockets']){const f=fixture();delete f.ports[key];assert.throws(()=>f.worker());}
 for(const url of ['http://fixture.invalid',origin+'/',origin+'?token=x','https://user:pass@fixture.invalid'])assert.throws(()=>new CommunicationVoiceWorker(url,fixture().ports));
 const f=fixture();f.ports.agent.respond=async()=>{throw Error('PRIVATE database URL');};const response=await f.worker().fetch(new Request(origin+'/v1/twilio/voice/agent',{method:'POST'}),{});assert.equal(response.status,503);assert.doesNotMatch(await response.text(),/PRIVATE|database/);
});

test('contact routes are absent without explicit capability and dispatch only to supplied native contact adapter',async()=>{
 const f=fixture(),path='/v1/voice/contact/start';const req=()=>new Request(origin+path,{method:'POST',body:'{}'});
 assert.equal((await f.worker().fetch(req(),{})).status,404);
 f.ports.contact={async respond(request){assert.equal(new URL(request.url).pathname,path);return new Response('native-contact');}};
 assert.equal(await (await f.worker().fetch(req(),{})).text(),'native-contact');assert.equal(f.seen.length,0);
 assert.equal((await f.worker().fetch(new Request(origin+path),{})).status,405);
});
