import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createRequire} from 'node:module';
import {mkdtemp,writeFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
const bundle=await build({entryPoints:['cloudflare/workers/src/business-tasks/voice-composition.ts'],bundle:true,write:false,platform:'node',format:'cjs'});
const dir=await mkdtemp(join(tmpdir(),'primecare-voice-composition-')),file=join(dir,'host.cjs');
await writeFile(file,bundle.outputFiles[0].text);
const {createPostgresTwilioVoiceWorker}=createRequire(import.meta.url)(file);await rm(dir,{recursive:true,force:true});
const origin='https://fixture.invalid',account='AC'+'a'.repeat(32),token='b'.repeat(32),callSid='CA'+'c'.repeat(32);
function fixture(){
 const queries=[],requests=[];
 const d={origin,pool:{async query(sql){queries.push(sql);return {rows:[]};},async connect(){throw Error('Unexpected database transaction');}},
  policy:{async assert(){throw Error('Denied');},async assignee(){throw Error('Denied');}},
  recipients:{async recipient(){throw Error('Denied');}},providerPrincipal:'signed-voice-provider',
  configuration:{accountSid:account,authToken:token,apiKeySid:'SK'+'d'.repeat(32),apiKeySecret:'e'.repeat(32),applicationSid:'AP'+'f'.repeat(32),messagingServiceSid:'MG'+'1'.repeat(32),sharedNumber:'+15550001000',numberVerified:true,receptionExtension:'1000',incomingUrl:origin+'/v1/twilio/voice/incoming',gatherUrl:origin+'/v1/twilio/voice/gather',statusCallback:origin+'/v1/twilio/sms/status',aiPairingUrl:origin+'/v1/twilio/voice/pair',maxWebhookBytes:4096,maxTextBytes:6400,tokenTtlSeconds:120},
  verifyServiceSid:'VA'+'2'.repeat(32),requests:{async requestCallback(){throw Error('Denied');},async requestBooking(){throw Error('Denied');},async requestReschedule(){throw Error('Denied');}},
  mail:{async queue(){throw Error('Denied');}},mailboxes:{async recipient(){throw Error('Denied');}},playbackBaseUrl:'https://portal.invalid/voicemail/',maxAudioBytes:1048576,
  async fetch(){throw Error('Unexpected external fetch');},async nativeAuthorize(){throw Error('Denied');},appOrigins:['https://portal.invalid'],async agentAuthorize(){return false;},greeting:'PrimeCare automated assistant.',
  modelProvider:{apiKey:'fixture-model-key',model:'fixture-model',taskGuide:'Request tasks only.',async fetch(){throw Error('Unexpected model request');}},
  sockets:{pair(){throw Error('Unexpected socket allocation');},upgrade(){throw Error('Unexpected upgrade');}},
  httpClient:{async request(options){requests.push(options);assert.equal(options.method,'get');return {statusCode:200,headers:{},body:JSON.stringify({sid:callSid,account_sid:account,to:'+15550001000',direction:'inbound',status:'in-progress'})};}},
 };
 return {d,queries,requests};
}
function signed(path,changes={}){const url=origin+path,params={AccountSid:account,CallSid:callSid,To:'+15550001000',Direction:'inbound',...changes};return new Request(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':getExpectedTwilioSignature(token,url,params)},body:new URLSearchParams(params)});}
test('complete composition serves a signed menu and AI handoff without a database write or model call',async()=>{
 const f=fixture(),worker=createPostgresTwilioVoiceWorker(f.d);assert.deepEqual(f.queries,[]);assert.deepEqual(f.requests,[]);
 const menu=await worker.fetch(signed('/v1/twilio/voice/incoming'),{});assert.equal(menu.status,200);assert.match(await menu.text(),/four digit extension/);
 const ai=await worker.fetch(signed('/v1/twilio/voice/gather',{Digits:'1'}),{});assert.equal(ai.status,200);assert.match(await ai.text(),/https:\/\/fixture.invalid\/v1\/twilio\/voice\/pair/);
 assert.deepEqual(f.queries,[]);assert.deepEqual(f.requests,[]);
});
test('native authorization and provider authentication remain separate after composition',async()=>{
 const f=fixture(),w=createPostgresTwilioVoiceWorker(f.d);
 assert.equal((await w.fetch(new Request(origin+'/v1/voice/token',{method:'POST'}),{})).status,401);
 assert.equal((await w.fetch(new Request(origin+'/v1/twilio/voice/agent',{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':'forged'},body:'AccountSid='+account}),{})).status,403);
 assert.deepEqual(f.queries,[]);assert.deepEqual(f.requests,[]);
});
test('unverified canonical caller returns to fixed reception without exposing account data or starting a model',async()=>{
 const f=fixture(),w=createPostgresTwilioVoiceWorker(f.d);const response=await w.fetch(signed('/v1/twilio/voice/agent'),{}),xml=await response.text();assert.equal(response.status,200);assert.match(xml,/v1\/twilio\/voice\/gather/);assert.doesNotMatch(xml,/ConversationRelay|fixture-model-key|tenant/);assert.equal(f.requests.length,1);assert.equal(f.queries.length,1);assert.match(f.queries[0],/^SELECT /);
});
test('wrong signing URLs fail before creating an adapter or contacting a provider',()=>{
 for(const key of ['incomingUrl','gatherUrl','statusCallback','aiPairingUrl']){const f=fixture();f.d.configuration[key]=origin+'/wrong';assert.throws(()=>createPostgresTwilioVoiceWorker(f.d),/registered host paths/);assert.deepEqual(f.queries,[]);assert.deepEqual(f.requests,[]);}
});

test('composed enrollment routes require native bearer before session queries or SMS provider access',async()=>{
 const f=fixture(),w=createPostgresTwilioVoiceWorker(f.d);
 for(const action of ['status','start','check'])assert.equal((await w.fetch(new Request(origin+'/v1/voice/contact/'+action,{method:'POST',headers:{'content-type':'application/json'},body:'{}'}),{})).status,401);
 assert.deepEqual(f.requests,[]);assert.deepEqual(f.queries,[]);
});
