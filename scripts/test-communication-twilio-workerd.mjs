// Actual workerd and official SDK signatures/XML. Directory and credentials are
// synthetic; returned TwiML is never sent to Twilio or used to make a phone call.
import assert from 'node:assert/strict';
import {builtinModules} from 'node:module';
import {mkdir,writeFile} from 'node:fs/promises';
import {Miniflare} from 'miniflare';
import {build} from 'esbuild';
import {getExpectedTwilioSignature} from 'twilio/lib/webhooks/webhooks.js';
import jwt from 'jsonwebtoken';
import {twilioVoiceIdentity} from '../packages/shared/src/communications/twilio-voice.mjs';
const builtin=new Set(builtinModules.map(name=>name.replace(/^node:/,'')));
const config={accountSid:'AC'+'a'.repeat(32),authToken:'b'.repeat(32),sharedNumber:'+15550001000',numberVerified:true,incomingUrl:'https://fixture.invalid/provider?stage=incoming',gatherUrl:'https://fixture.invalid/provider?stage=extension',maxWebhookBytes:4096};
const bundle=await build({stdin:{contents:`
import {TwilioVoiceExtensionAdapter} from './packages/shared/src/communications/twilio-voice.mjs';
import {TwilioVoiceTokenService} from './cloudflare/workers/src/business-tasks/twilio-token.ts';
import {TwilioSmsStatusAdapter,TwilioSmsTransport,smsDeliveryProjection} from './packages/shared/src/communications/twilio-sms.mjs';
import {TwilioExtensionConnectAdapter,createTwilioVoiceCallVerifier} from './packages/shared/src/communications/twilio-connect.mjs';
import {TwilioExtensionConnectService} from './cloudflare/workers/src/business-tasks/twilio-connect.ts';
import {twilioVoiceIdentity} from './packages/shared/src/communications/twilio-voice.mjs';
const config=${JSON.stringify(config)};
export default {async fetch(request){
 let queries=0;const mode=request.headers.get('x-test-mode');
 const row={extension:'100001',tenantId:'tenant-a',userId:'user-a',published:true,active:true,tenantActive:true,userActive:true};
 if(mode==='connect'||mode==='connect-denied'){
  const from='client:'+await twilioVoiceIdentity(row);
  const verifier=createTwilioVoiceCallVerifier({accountSid:config.accountSid,apiKeySid:'SK'+'d'.repeat(32),apiKeySecret:'e'.repeat(32),httpClient:{async request(){return {statusCode:200,headers:{},body:JSON.stringify({sid:'CA'+'c'.repeat(32),account_sid:config.accountSid,from,direction:'inbound',status:'in-progress'})};}}});
  const service=new TwilioExtensionConnectService({run(){throw Error('write');},read(){throw Error('read');},inbox(){throw Error('inbox');}},{async assert(){if(mode==='connect-denied')throw Error('denied');},async assignee(){throw Error('grant');}},{async lookup(extension){return [{...row,extension,userId:extension==='100001'?'user-a':'user-b'}];}},verifier,config.accountSid);
  return new TwilioExtensionConnectAdapter({...config,webhookUrl:config.incomingUrl,service}).respond(request);
 }
 if(mode==='sms'||mode==='sms-store-error'){
  const adapter=new TwilioSmsStatusAdapter({...config,webhookUrl:config.incomingUrl,sender:config.sharedNumber,messagingServiceSid:'MG'+'a'.repeat(32),store:{async record(event){if(mode==='sms-store-error')throw Error('PRIVATE');if(Object.hasOwn(event,'TenantId'))throw Error('scope');return 'recorded';}}});return adapter.respond(request);
 }
 if(mode==='sms-send'){
  const sender=new TwilioSmsTransport({...config,sender:config.sharedNumber,messagingServiceSid:'MG'+'a'.repeat(32),statusCallback:config.incomingUrl,maxTextBytes:6400,client:{messages:{async create(options){return {sid:'SM'+'a'.repeat(32),accountSid:config.accountSid,messagingServiceSid:options.messagingServiceSid,from:options.from,to:options.to,status:'queued'};}}}});
  return Response.json({receipt:await sender.send({to:'+15550002000',text:'fixture'}),projection:smsDeliveryProjection(['delivered','queued'])});
 }
 if(mode==='token'||mode==='token-denied'){
  const service=new TwilioVoiceTokenService({run(){throw Error('write');},read(){throw Error('read');},inbox(){throw Error('inbox');}},{async assert(){if(mode==='token-denied')throw Error('denied');},async assignee(){throw Error('grant');}},{async currentSession(id){return {id,userId:row.userId,tenantId:row.tenantId,expiresAt:Date.now()+600000,active:true};},async destinations(){return [row];}},{accountSid:config.accountSid,apiKeySid:'SK'+'d'.repeat(32),apiKeySecret:'e'.repeat(32),applicationSid:'AP'+'f'.repeat(32),ttlSeconds:300});
  try{return Response.json(await service.issue('fixture-session'));}catch{return new Response(null,{status:403});}
 }
 const adapter=new TwilioVoiceExtensionAdapter({...config,directory:{async lookup(){queries++;if(mode==='unknown'||mode==='revoked'&&queries>1)return [];return mode==='duplicate'?[row,row]:[row];}}});
 const response=await adapter.respond(request);response.headers.set('x-test-queries',String(queries));return response;
}};`,resolveDir:process.cwd()},bundle:true,format:'esm',platform:'neutral',mainFields:['module','main'],external:['node:*',...builtin],banner:{js:'import {createRequire} from "node:module";const require=createRequire("/worker.js");'},write:false});
const runtime=new Miniflare({modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-07-30',compatibilityFlags:['nodejs_compat']});let checks=0;
async function send({stage='extension',params={},signature,mode,body}={}){
 const url=stage==='incoming'?config.incomingUrl:config.gatherUrl;
 const values={AccountSid:config.accountSid,CallSid:'CA'+'c'.repeat(32),To:config.sharedNumber,Direction:'inbound',...(stage==='extension'?{Digits:'100001'}:{}),...params};
 return runtime.dispatchFetch(url,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-twilio-signature':signature??getExpectedTwilioSignature(config.authToken,url,values),...(mode?{'x-test-mode':mode}:{})},body:body??new URLSearchParams(values).toString()});
}
try{
 const prompt=await send({stage:'incoming'});assert.equal(prompt.status,200);assert.match(await prompt.text(),/<Gather/);assert.equal(prompt.headers.get('x-test-queries'),'0');checks++;
 const dial=await send();assert.equal(dial.status,200);assert.match(await dial.text(),/<Identity>primecare_[a-f0-9]{64}<\/Identity>/);assert.equal(dial.headers.get('x-test-queries'),'2');checks++;
 const invalid=await send({signature:'invalid'});assert.equal(invalid.status,403);assert.equal(invalid.headers.get('x-test-queries'),'0');checks++;
 const foreign=await send({params:{To:'+15550009999'}});assert.equal(foreign.status,403);assert.equal(foreign.headers.get('x-test-queries'),'0');checks++;
 for(const mode of ['unknown','duplicate','revoked']){const denied=await send({mode});assert.equal(denied.status,200);assert.doesNotMatch(await denied.text(),/<Dial/);checks++;}
 const bad=await send({body:'x=%FF'});assert.equal(bad.status,400);assert.equal(bad.headers.get('x-test-queries'),'0');checks++;
 const token=await send({mode:'token'});assert.equal(token.status,200);
 const claims=jwt.verify((await token.json()).token,'e'.repeat(32),{algorithms:['HS256'],issuer:'SK'+'d'.repeat(32),subject:config.accountSid});
 assert.equal(claims.exp-claims.iat,300);assert.equal(claims.grants.voice.outgoing.application_sid,'AP'+'f'.repeat(32));assert.equal(claims.grants.voice.incoming.allow,true);checks++;
 assert.equal((await send({mode:'token-denied'})).status,403);checks++;
 const smsParams={AccountSid:config.accountSid,MessageSid:'SM'+'a'.repeat(32),MessagingServiceSid:'MG'+'a'.repeat(32),MessageStatus:'delivered',From:config.sharedNumber,To:'+15550002000',TenantId:'forged'};
 const sms=async(mode,signature)=>runtime.dispatchFetch(config.incomingUrl,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-test-mode':mode,'x-twilio-signature':signature??getExpectedTwilioSignature(config.authToken,config.incomingUrl,smsParams)},body:new URLSearchParams(smsParams).toString()});
 assert.equal((await sms('sms')).status,204);checks++;
 assert.equal((await sms('sms','forged')).status,403);checks++;
 assert.equal((await sms('sms-store-error')).status,503);checks++;
 const smsSend=await (await send({mode:'sms-send'})).json();assert.equal(smsSend.receipt.status,'queued');assert.deepEqual(smsSend.projection,{status:'delivered',delivered:true});checks++;
 const connectParams={From:'client:'+await twilioVoiceIdentity({tenantId:'tenant-a',userId:'user-a'}),CallerExtension:'100001',TargetExtension:'100002'};
 const connected=await send({stage:'incoming',mode:'connect',params:connectParams});assert.equal(connected.status,200);assert.match(await connected.text(),/<Identity>primecare_[a-f0-9]{64}<\/Identity>/);checks++;
 assert.equal((await send({stage:'incoming',mode:'connect-denied',params:connectParams})).status,503);checks++;
 await mkdir('test-results/communication-twilio',{recursive:true});
 await writeFile('test-results/communication-twilio/workerd.json',JSON.stringify({sourceCommit:process.env.GITHUB_SHA,checks,passed:true,engine:'workerd',sdk:'twilio@6.2.0',compatibilityFlags:['nodejs_compat'],officialSignatureValidation:true,officialTwimlBuilder:true,directory:'synthetic',liveProviderVerified:false,numbersPurchased:0,extensionsAssigned:0,callsPlaced:0,production:false},null,2));
 console.log('WORKERD_COMMUNICATION_TWILIO_PASS '+checks);
}finally{await runtime.dispose();}
