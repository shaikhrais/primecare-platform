import {test} from 'node:test';import assert from 'node:assert/strict';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
import {TwilioVoicemailAdapter,TwilioVoicemailAudioAdapter,createTwilioRecordingVerifier} from '../packages/shared/src/communications/twilio-voicemail.mjs';
import {VoicemailService,BusinessMailVoicemailNotifier} from '../cloudflare/workers/src/business-tasks/voicemail.ts';
import {TwilioVoiceExtensionAdapter} from '../packages/shared/src/communications/twilio-voice.mjs';
const accountSid='AC'+'a'.repeat(32),authToken='b'.repeat(32),callSid='CA'+'c'.repeat(32),recordingSid='RE'+'d'.repeat(32);
const urls={dialCompleteUrl:'https://fixture.invalid/dial-complete',recordActionUrl:'https://fixture.invalid/record-action',recordingStatusUrl:'https://fixture.invalid/record-status'};
const destination={extension:'1001',tenantId:'tenant-a',userId:'alice',active:true,published:true,userActive:true,tenantActive:true};
function fixture(){
 const routes=new Map(),notices=new Map();let denied=false;const row={...destination},recording={sid:recordingSid,accountSid,callSid,status:'completed',source:'RecordVerb',duration:15};
 const mailbox={email:'alice@example.com',verified:true,active:true};let record=null,queued=false;
 const repository={async reserve(r){const prior=routes.get(r.callSid);if(prior)assert.deepEqual(prior,r);else routes.set(r.callSid,r);},async read(a,c){return a===accountSid?routes.get(c)??null:null;},async find(a,s){return a===accountSid&&record?.sid===s?routes.get(callSid):null;},async recording(r,s,d){if(record)assert.deepEqual(record,{sid:s,duration:d});record={sid:s,duration:d};},async notified(){queued=true;}};
 const policy={async assert(actor,action,state){if(denied||actor.tenantId!==state.tenantId)throw Error('denied');},async assignee(){throw Error('unused');}};
 const store={run(){throw Error('unused');},read(){throw Error('unused');},inbox(){throw Error('unused');}};
 const service=new VoicemailService(store,policy,repository,{directory:{async lookup(){return [row];}},recordings:{async fetch(){return {...recording};}},mailboxes:{async recipient(owner){assert.deepEqual(owner,{id:'alice',tenantId:'tenant-a'});return {...mailbox};}},notifications:{async enqueue(n){if(notices.has(n.key))assert.deepEqual(notices.get(n.key),n);else notices.set(n.key,n);}}},{accountSid,providerPrincipal:'voice-provider',playbackBaseUrl:'https://app.example.com/communication/voicemail/'});
 const adapter=new TwilioVoicemailAdapter({accountSid,authToken,maxWebhookBytes:4096,...urls,service});
 return {service,adapter,routes,notices,row,recording,mailbox,get queued(){return queued;},deny(){denied=true;}};
}
function request(url,params={},signature){const values={AccountSid:accountSid,CallSid:callSid,...params};const body=new URLSearchParams();for(const [k,v] of Object.entries(values))for(const value of Array.isArray(v)?v:[v])body.append(k,value);return new Request(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(authToken,url,values)},body});}
const complete={RecordingSid:recordingSid,RecordingStatus:'completed',RecordingDuration:'15',RecordingUrl:'https://attacker.invalid/audio',Email:'attacker@example.com',TenantId:'tenant-b'};
test('missed call offers bounded voicemail; answered and canceled calls never record',async()=>{
 const f=fixture();await f.service.prepare({callSid,destination});
 for(const status of ['busy','no-answer','failed']){const response=await f.adapter.respond(request(urls.dialCompleteUrl,{DialCallStatus:status}));assert.equal(response.status,200);const xml=await response.text();assert.match(xml,/<Record/);assert.match(xml,/maxLength="120"/);assert.match(xml,/transcribe="false"/);assert.match(xml,/recordingStatusCallback="https:\/\/fixture.invalid\/record-status"/);assert.match(xml,/will be recorded/);}
 for(const status of ['completed','canceled','ringing'])assert.doesNotMatch(await(await f.adapter.respond(request(urls.dialCompleteUrl,{DialCallStatus:status}))).text(),/<Record/);
});
test('only completed callback queues verified owner email; duplicates share durable key',async()=>{
 const f=fixture();await f.service.prepare({callSid,destination});
 assert.equal((await f.adapter.respond(request(urls.recordActionUrl,complete))).status,200);assert.equal(f.notices.size,0);
 assert.equal((await f.adapter.respond(request(urls.recordingStatusUrl,complete))).status,204);
 assert.equal((await f.adapter.respond(request(urls.recordingStatusUrl,complete))).status,204);
 assert.equal(f.notices.size,1);const notice=[...f.notices.values()][0];assert.equal(notice.to,'alice@example.com');assert.match(notice.text,/Sign in to listen: https:\/\/app.example.com\/communication\/voicemail\/RE/);assert.doesNotMatch(notice.text,/attacker|RecordingUrl/);assert.equal(f.queued,true);
});
test('unknown call, revoked target, unverified mailbox and canonical mismatch never email',async()=>{
 const unknown=fixture();assert.equal((await unknown.adapter.respond(request(urls.recordingStatusUrl,complete))).status,503);
 for(const mutate of [f=>f.row.published=false,f=>f.mailbox.verified=false,f=>f.recording.callSid='CA'+'e'.repeat(32),f=>f.recording.source='DialVerb',f=>f.deny()]){const f=fixture();await f.service.prepare({callSid,destination});mutate(f);assert.equal((await f.adapter.respond(request(urls.recordingStatusUrl,complete))).status,503);assert.equal(f.notices.size,0);}
});
test('signature failure and duplicate critical fields never notify',async()=>{
 const f=fixture();for(const req of [request(urls.recordingStatusUrl,complete,'invalid'),request(urls.recordingStatusUrl,{...complete,RecordingSid:[recordingSid,recordingSid]}),request(urls.recordingStatusUrl,{...complete,RecordingDuration:'121'})])assert.equal((await f.adapter.respond(req)).status,403);assert.equal(f.notices.size,0);
});
test('owner-only playback repeats authorization after private download',async()=>{
 const f=fixture();await f.service.prepare({callSid,destination});await f.service.completed({callSid,recordingSid,duration:15});
 for(const actor of [{id:'alice',tenantId:'tenant-b'},{id:'bob',tenantId:'tenant-a'}])await assert.rejects(f.service.read(actor,recordingSid));
 assert.equal((await f.service.read({id:'alice',tenantId:'tenant-a'},recordingSid)).recordingSid,recordingSid);
 await assert.rejects(f.service.audio({id:'alice',tenantId:'tenant-a'},recordingSid,{async download(){f.deny();return {bytes:new Uint8Array(12),contentType:'audio/wav'};}}));
});
test('inbound extension saves exact destination before Dial action is enabled',async()=>{
 const prepared=[];const incomingUrl='https://fixture.invalid/incoming',gatherUrl='https://fixture.invalid/gather';
 const adapter=new TwilioVoiceExtensionAdapter({accountSid,authToken,sharedNumber:'+15550001000',numberVerified:true,incomingUrl,gatherUrl,maxWebhookBytes:4096,directory:{async lookup(){return [destination];}},voicemail:{async prepare(r){prepared.push(r);}},dialCompleteUrl:urls.dialCompleteUrl});
 const response=await adapter.respond(request(gatherUrl,{To:'+15550001000',Direction:'inbound',Digits:'1001'}));assert.equal(response.status,200);assert.match(await response.text(),/action="https:\/\/fixture.invalid\/dial-complete"/);assert.equal(prepared[0].callSid,callSid);assert.equal(prepared[0].destination.userId,'alice');
});
test('inbound voicemail reservation cannot dial a destination revoked or reassigned while waiting',async()=>{
 for(const change of [{published:false},{userId:'another'},{tenantId:'other'},
  {active:false},{tenantActive:false},{userActive:false}]){
  let row={...destination},prepared=0;
  const incomingUrl='https://fixture.invalid/incoming',gatherUrl='https://fixture.invalid/gather';
  const adapter=new TwilioVoiceExtensionAdapter({accountSid,authToken,sharedNumber:'+15550001000',numberVerified:true,incomingUrl,gatherUrl,maxWebhookBytes:4096,
   directory:{async lookup(){return [row];}},voicemail:{async prepare(){prepared++;Object.assign(row,change);}},dialCompleteUrl:urls.dialCompleteUrl});
  const response=await adapter.respond(request(gatherUrl,{To:'+15550001000',Direction:'inbound',Digits:destination.extension}));
  assert.doesNotMatch(await response.text(),/<Dial|<Identity/);assert.equal(prepared,1);
 }
});
test('official recording verifier uses fixed account Recording resource',async()=>{
 const calls=[];const verifier=createTwilioRecordingVerifier({accountSid,apiKeySid:'SK'+'e'.repeat(32),apiKeySecret:'f'.repeat(32),httpClient:{async request(options){calls.push(options);return {statusCode:200,headers:{},body:JSON.stringify({sid:recordingSid,account_sid:accountSid,call_sid:callSid,status:'completed',source:'RecordVerb',duration:'15'})};}}});assert.equal((await verifier.fetch(recordingSid)).duration,15);assert.equal(calls[0].uri,`https://api.twilio.com/2010-04-01/Accounts/${accountSid}/Recordings/${recordingSid}.json`);await assert.rejects(verifier.fetch('../evil'));
});
test('private audio download bounds bytes, validates WAV and prohibits redirects',async()=>{
 const data=new Uint8Array(16);data.set(new TextEncoder().encode('RIFF'));data.set(new TextEncoder().encode('WAVE'),8);let options,address;
 const make=fetch=>new TwilioVoicemailAudioAdapter({accountSid,apiKeySid:'SK'+'e'.repeat(32),apiKeySecret:'f'.repeat(32),maxAudioBytes:32,fetch});
 const audio=make(async(url,o)=>{address=url;options=o;return new Response(data,{headers:{'content-type':'audio/wav'}});});assert.deepEqual((await audio.download(recordingSid)).bytes,data);assert.equal(options.redirect,'error');assert.ok(options.headers.authorization.startsWith('Basic '));assert.equal(address,`https://api.twilio.com/2010-04-01/Accounts/${accountSid}/Recordings/${recordingSid}.wav`);
 await assert.rejects(make(async()=>new Response(new Uint8Array(33),{headers:{'content-type':'audio/wav'}})).download(recordingSid));await assert.rejects(make(async()=>new Response('not wav',{headers:{'content-type':'audio/wav'}})).download(recordingSid));
});
test('mail notifier reuses existing inherited outbox command identity',async()=>{const args=[];const notifier=new BusinessMailVoicemailNotifier({async queue(...values){args.push(values);}});await notifier.enqueue({actor:{id:'provider',tenantId:'tenant-a'},key:'vm-key',to:'alice@example.com',subject:'New voicemail',text:'Sign in'});assert.equal(args[0][1],'vm-key');assert.equal(args[0][2],'vm-key');});
test('empty silent recording is acknowledged without email',async()=>{const f=fixture();const response=await f.adapter.respond(request(urls.recordingStatusUrl,{...complete,RecordingDuration:'0'}));assert.equal(response.status,204);assert.equal(f.notices.size,0);});
