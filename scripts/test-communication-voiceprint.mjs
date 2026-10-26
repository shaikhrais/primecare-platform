import {test} from 'node:test';import assert from 'node:assert/strict';
import {AculabVoiceprintProvider,VoiceprintProviderBase} from '../packages/shared/src/communications/voiceprint-provider.mjs';
import {VoiceprintRecognitionService,VoiceprintRecognitionChannel} from '../packages/shared/src/communications/voiceprint-recognition.ts';
import {CommunicationChannelBase,ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
import {wav} from './fixtures/business-voiceprint-audio.mjs';
const actor={id:'alice',tenantId:'tenant-a'},callSid='CA'+'a'.repeat(32),config={cloudId:'1-2-0',username:'fixture@example.test',groupKey:'fixture-group-secret-1234',sensitivity:1};
function transport(){const calls=[];let reply={transaction_id:'receipt-1',application_instance_id:'vb-1',verified:true,confidence:1.25};const provider=new AculabVoiceprintProvider({...config,fetch:async(url,options)=>{calls.push({url,options});return Response.json(reply);}});return {provider,calls,reply:value=>reply=value};}
function storeFixture(){const rows=new Map(),commands=new Map();return {rows,async read(a,id,authorize){const s=rows.get(id);if(!s||s.tenantId!==a.tenantId)throw Error('Not found');await authorize(structuredClone(s));return structuredClone(s);},async inbox(){throw Error('unused');},async run(c,authorize,apply){const s=rows.get(c.id)??null;await authorize(s&&structuredClone(s));const key=c.id+':'+c.key;if(commands.has(key))return commands.get(key);if((s?.version??0)!==c.expectedVersion)throw Error('Version conflict');const change=await apply(s&&structuredClone(s));change.state.version=c.expectedVersion+1;rows.set(c.id,structuredClone(change.state));const result=change.result??{id:c.id,version:change.state.version};commands.set(key,result);return structuredClone(result);}};}
function fixture(){const t=transport(),store=storeFixture();let fresh=true,live=true,allowed=true,takes=0;const used=new Set();
 const service=new VoiceprintRecognitionService(store,{async assert(a,action,state){if(!allowed||a.id!==actor.id||a.tenantId!==state.tenantId)throw Error('Denied');},async assignee(){throw Error('unused');}},{authority:{async assertFresh(a){if(!fresh||a.id!==actor.id)throw Error('Fresh proof required');}},calls:{async assertCandidate(id,a){if(!live||id!==callSid||a.id!==actor.id)throw Error('Call unavailable');}},captures:{async take(id,call,attempt){if(used.has(id))throw Error('Capture consumed');used.add(id);takes++;return {id,callSid:call,capturedAt:Date.now(),bytes:wav()};}},provider:t.provider});
 const channel=new VoiceprintRecognitionChannel(service,{actor,callSid});return {...t,store,service,channel,revokeProof(){fresh=false;},endCall(){live=false;},deny(){allowed=false;},get takes(){return takes;}};
}
const subject='pc-'+crypto.randomUUID(),signal=()=>new AbortController().signal;
test('real provider adapter pins URL, uploads WAV, enables PAD and keeps provider identifiers outside public output',async()=>{
 const f=transport();assert.ok(f.provider instanceof VoiceprintProviderBase);assert.equal((await f.provider.enroll({subject,audio:wav(),signal:signal()})).enrolled,true);
 assert.deepEqual(await f.provider.verify({subject,audio:wav(),signal:signal()}),{matched:true,spoofed:false,receipt:'receipt-1'});
 const {url,options}=f.calls[1],u=new URL(url);assert.equal(u.origin,'https://ws-1-2-0.aculabcloud.net');assert.equal(u.searchParams.get('enable_pad'),'true');assert.equal(u.searchParams.get('text_dependent'),'true');assert.equal(u.searchParams.get('sensitivity'),'1');assert.equal(options.method,'PUT');assert.equal(options.redirect,'manual');assert.equal(options.body.length,wav().length);assert.ok(!url.includes(config.groupKey));assert.match(options.headers.authorization,/^Basic /);
});
test('provider positive verdict cannot override replay/synthetic flags or missing/invalid scores',async()=>{
 for(const attack of [{type:'TypeA'},{type:'TypeB'},{type:'TypeC'},null]){const f=transport();f.reply({transaction_id:'r',verified:true,confidence:2,pad_detected:attack});assert.deepEqual(await f.provider.verify({subject,audio:wav(),signal:signal()}),{matched:false,spoofed:true,receipt:'r'});}
 const f=transport();f.reply({transaction_id:'r',verified:true,confidence:0.9});assert.equal((await f.provider.verify({subject,audio:wav(),signal:signal()})).matched,false);
 f.reply({transaction_id:'r',verified:true});await assert.rejects(f.provider.verify({subject,audio:wav(),signal:signal()}));
});
test('malformed audio, foreign subject, aborted requests and weakening sensitivity fail before provider I/O',async()=>{
 const f=transport();for(const audio of [new Uint8Array(44),wav(1),new Uint8Array(2000000)])await assert.rejects(f.provider.verify({subject,audio,signal:signal()}));
 await assert.rejects(f.provider.verify({subject:'alice',audio:wav(),signal:signal()}));const c=new AbortController();c.abort();await assert.rejects(f.provider.verify({subject,audio:wav(),signal:c.signal}));assert.equal(f.calls.length,0);
 assert.throws(()=>new AculabVoiceprintProvider({...config,sensitivity:-1}));assert.throws(()=>new AculabVoiceprintProvider({...config,cloudId:'evil.example'}));f.provider.close();await assert.rejects(f.provider.enroll({subject,audio:wav(),signal:signal()}));
});
test('inherited service enrolls with explicit consent and recognizes through actual HTTP adapter contract',async()=>{
 const f=fixture(),id=crypto.randomUUID();assert.ok(f.service instanceof ScopedServiceBase);assert.ok(f.channel instanceof CommunicationChannelBase);
 assert.deepEqual(await f.channel.execute(actor,{action:'enroll',id,captureId:crypto.randomUUID(),consent:true}),{id,version:2,enrolled:true});
 const attempt=crypto.randomUUID(),response=await f.channel.execute(actor,{action:'verify',profileId:id,id:attempt,captureId:crypto.randomUUID()});assert.deepEqual(response,{attemptId:attempt,matched:true,requiresAuthorization:true});
 assert.equal(f.store.rows.get(attempt).status,'matched');assert.ok(!JSON.stringify([...f.store.rows.values()]).includes('bytes'));assert.ok(!JSON.stringify(response).includes('pc-'));assert.equal(f.calls.length,2);
});
test('enrollment requires independent fresh proof, consent and canonical live account; identity overrides are rejected',async()=>{
 for(const mutate of [f=>f.revokeProof(),f=>f.endCall(),f=>f.deny()]){const f=fixture();mutate(f);await assert.rejects(f.channel.execute(actor,{action:'enroll',id:crypto.randomUUID(),captureId:crypto.randomUUID(),consent:true}));assert.equal(f.calls.length,0);}
 const f=fixture();for(const extra of [{actorId:'bob'},{tenantId:'other'},{callSid:'forged'},{consent:false}])await assert.rejects(f.channel.execute(actor,{action:'enroll',id:crypto.randomUUID(),captureId:crypto.randomUUID(),consent:true,...extra}));assert.equal(f.calls.length,0);
});
test('a positive biometric response never mints a voice-task identity; spoofing rejects recognition',async()=>{
 const f=fixture(),id=crypto.randomUUID();await f.channel.execute(actor,{action:'enroll',id,captureId:crypto.randomUUID(),consent:true});
 f.reply({transaction_id:'r',verified:true,confidence:3,pad_detected:{type:'TypeC'}});const r=await f.channel.execute(actor,{action:'verify',profileId:id,id:crypto.randomUUID(),captureId:crypto.randomUUID()});assert.equal(r.matched,false);assert.equal(r.requiresAuthorization,true);assert.equal(typeof f.service.current,'undefined');
});
test('durable claim prevents repeat provider enrollment and verification after ambiguous outcomes',async()=>{
 const f=fixture(),id=crypto.randomUUID(),input={action:'enroll',id,captureId:crypto.randomUUID(),consent:true};await f.channel.execute(actor,input);await assert.rejects(f.channel.execute(actor,input));assert.equal(f.calls.length,1);
 const attempt={action:'verify',profileId:id,id:crypto.randomUUID(),captureId:crypto.randomUUID()};f.reply({error:{text:'private secret'}});assert.equal((await f.channel.execute(actor,attempt)).matched,false);await assert.rejects(f.channel.execute(actor,attempt));assert.equal(f.calls.length,2);assert.equal(f.store.rows.get(attempt.id).status,'unknown');
});
test('revocation blocks recognition before remote deletion and reports uncertain provider deletion honestly',async()=>{
 const f=fixture(),id=crypto.randomUUID();await f.channel.execute(actor,{action:'enroll',id,captureId:crypto.randomUUID(),consent:true});f.reply({error:{text:'remote unavailable'}});
 assert.deepEqual(await f.channel.execute(actor,{action:'revoke',id,version:2}),{revoked:true,providerDeletionConfirmed:false});assert.equal(f.store.rows.get(id).status,'revoked');await assert.rejects(f.channel.execute(actor,{action:'verify',profileId:id,id:crypto.randomUUID(),captureId:crypto.randomUUID()}));await assert.rejects(f.channel.execute(actor,{action:'revoke',id,version:2}));assert.equal(f.calls.length,2);
});
test('native fetch port is called without an object receiver and redirects never release a verdict',async()=>{
 let requests=0;
 const provider=new AculabVoiceprintProvider({...config,fetch:async function(url,options){assert.equal(this,undefined);assert.equal(options.redirect,'manual');requests++;return new Response(null,{status:302,headers:{location:'https://foreign.invalid'}});}});
 await assert.rejects(provider.verify({subject,audio:wav(),signal:signal()}),/unavailable/);assert.equal(requests,1);provider.close();
});
