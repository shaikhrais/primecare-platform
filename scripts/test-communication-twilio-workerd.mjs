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
import {TwilioVoicemailAdapter,createTwilioRecordingVerifier} from './packages/shared/src/communications/twilio-voicemail.mjs';
import {VoiceTaskService,BoundVoiceApiTask} from './cloudflare/workers/src/business-tasks/voice-tasks.ts';
import {PostgresVoiceTaskConfirmationService} from './cloudflare/workers/src/business-tasks/voice-confirmations.ts';
import {createTwilioVoiceOtpClient} from './packages/shared/src/communications/twilio-verify.mjs';
import {VoiceOtpService} from './cloudflare/workers/src/business-tasks/voice-otp.ts';
import {TwilioOtpPairingAdapter} from './packages/shared/src/communications/twilio-otp-pairing.mjs';
import {TwilioVerifiedAgentAdapter} from './packages/shared/src/communications/twilio-agent-start.mjs';
const config=${JSON.stringify(config)};
export default {async fetch(request){
 let queries=0;const mode=request.headers.get('x-test-mode');
 const row={extension:'100001',tenantId:'tenant-a',userId:'user-a',published:true,active:true,tenantActive:true,userActive:true};
 if(mode==='otp-binding'){
  let row=null,active=true,sends=0,checks=0;const hash='a'.repeat(64),callSid='CA'+'c'.repeat(32);
  const repository={async issue(c,p,expiresAt){row={callSid:c,pairingHash:p,expiresAt,state:'issued'};},async begin(i){if(row.state!=='issued'||row.pairingHash!==i.pairingHash)return false;Object.assign(row,{state:'sending',nativeSessionHash:i.nativeSessionHash,userId:i.actor.id,tenantId:i.actor.tenantId,phone:i.contact.phone,contactVersion:i.contact.version});return true;},async sent(c,sid){row.state='pending';row.verificationSid=sid;},async unknown(){row.state='unknown';},async read(){return structuredClone(row);},async claimCheck(){if(row.state!=='pending')return false;row.state='checking';return true;},async checked(c,approved,grantId,expiresAt){row.state=approved?'verified':'pending';row.grantId=grantId;row.expiresAt=expiresAt;}};
  const service=new VoiceOtpService({run(){throw Error('write');},read(){throw Error('read');},inbox(){throw Error('inbox');}},{async assert(){},async assignee(){throw Error('grant');}},repository,{sessions:{async currentSession(id){return active?{id,userId:'fixture',tenantId:'tenant-a',active:true,expiresAt:Date.now()+600000}:null;}},calls:{async fetch(sid){return {sid,accountSid:config.accountSid,from:'+15550009999',to:config.sharedNumber,direction:'inbound',status:'in-progress'};}},contacts:{async current(){return {phone:'+15550002000',version:1};}},provider(){return {async start(){sends++;return {verificationSid:'VE'+'d'.repeat(32),status:'pending'};},async check(){checks++;return {approved:true};}};}},{accountSid:config.accountSid,sharedNumber:config.sharedNumber});
  const pair=await service.issue(callSid);await service.start(hash,callSid,pair.pairingCode);const wasUnverified=await service.current(callSid)===null;await service.check(hash,callSid,'123456');const verified=!!await service.current(callSid);active=false;return Response.json({wasUnverified,verified,revoked:await service.current(callSid)===null,sends,checks});
 }
 if(mode==='agent-start'||mode==='agent-denied')return new TwilioVerifiedAgentAdapter({...config,agentUrl:'https://fixture.invalid/agent',completeUrl:'https://fixture.invalid/agent-end',receptionUrl:'https://fixture.invalid/reception',socketUrl:'wss://fixture.invalid/agent-socket',greeting:'Automated assistant. Tasks require app approval.',calls:{async fetch(sid){return {sid,accountSid:config.accountSid,to:config.sharedNumber,direction:'inbound',status:'in-progress'};}},identities:{async current(){return {actor:{id:'fixture',tenantId:'tenant-a'},sessionId:'verified-session',authentication:'otp',active:true,expiresAt:Date.now()+120000};}},async authorize(){return mode==='agent-start';}}).respond(request);
 if(mode==='otp-pairing')return new TwilioOtpPairingAdapter({...config,pairingUrl:config.incomingUrl,waitUrl:config.gatherUrl,agentUrl:'https://fixture.invalid/agent',receptionUrl:'https://fixture.invalid/reception',service:{async issue(){return {pairingCode:'12345678',expiresAt:Date.now()+120000};},async current(){return null;},async pending(){return true;}}}).respond(request);
 if(mode==='otp'){
  let requests=0;const sid='VE'+'d'.repeat(32),serviceSid='VA'+'e'.repeat(32),phone='+15550001000';
  const client=createTwilioVoiceOtpClient({accountSid:config.accountSid,apiKeySid:'SK'+'d'.repeat(32),apiKeySecret:'e'.repeat(32),serviceSid,contact:{phone,verified:true},httpClient:{async request(options){requests++;const checking=options.uri.endsWith('/VerificationCheck');if(checking&&options.data.VerificationSid!==sid)throw Error('SID');if(!checking&&(options.data.To!==phone||options.data.Channel!=='sms'))throw Error('contact');return {statusCode:200,headers:{},body:JSON.stringify({sid,account_sid:config.accountSid,service_sid:serviceSid,to:phone,channel:'sms',status:checking?'approved':'pending'})};}}});
  const started=await client.start();const checked=await client.check(started.verificationSid,'123456');return Response.json({approved:checked.approved,requests});
 }
 if(mode==='confirmation'){
  const actor={id:'fixture',tenantId:'tenant-a'},intentId='11111111-1111-4111-8111-111111111111',callSid='CA'+'c'.repeat(32),digest='a'.repeat(64);let approvedAt=null,expiresAt=null,consumed=false;
  const intent={id:intentId,callSid,actor,sessionId:'fixture-session',taskId:'fixture.update',taskVersion:1,args:{version:1},summary:'Update fixture version 1',digest,expiresAt:Date.now()+120000,status:'proposed'};
  const service=new PostgresVoiceTaskConfirmationService({run(){throw Error('write');},read(){throw Error('read');},inbox(){throw Error('inbox');}},{async assert(){},async assignee(){throw Error('grant');}},{async query(sql,values){if(sql.startsWith('INSERT')){approvedAt=values[6];expiresAt=values[7];return {rows:[{intent_id:intentId,expires_at:expiresAt}]};}if(approvedAt!==null&&!consumed){consumed=true;return {rows:[{approved_at:approvedAt}]};}return {rows:[]};}},{async current(){return {actor,sessionId:'fixture-session',authentication:'otp',active:true,expiresAt:Date.now()+300000};}},{async read(){return intent;}});
  const preview=await service.preview(actor,intentId);await service.approve(actor,intentId,preview.digest);const input={callSid,intentId,digest,actor,sessionId:'fixture-session'};
  return Response.json({first:await service.consumeConfirmation(input),second:await service.consumeConfirmation(input)});
 }
 if(mode==='voice-task'||mode==='voice-task-denied'){
  let saved=null,executions=0;
  const repository={async create(row){saved=structuredClone(row);},async read(){return structuredClone(saved);},async claim(){if(saved.status!=='proposed')return false;saved.status='executing';return true;},async finish(id,status){saved.status=status;}};
  const service=new VoiceTaskService({run(){throw Error('write');},read(){throw Error('read');},inbox(){throw Error('inbox');}},{async assert(){},async assignee(){throw Error('grant');}},repository,{async current(){return {actor:{id:'fixture',tenantId:'tenant-a'},sessionId:'fixture-session',authentication:mode==='voice-task-denied'?'voice-match':'otp',active:true,expiresAt:Date.now()+300000};},async consumeConfirmation(){return {approved:true,method:'app',approvedAt:Date.now()};}},[new BoundVoiceApiTask('fixture.update',1,{validate(args){if(args.version!==1)throw Error('input');return {version:1};},describe(){return 'Update fixture version 1';},async execute(){executions++;}})]);
  try{const proposal=await service.propose('CA'+'c'.repeat(32),'fixture.update',{version:1});await service.execute('CA'+'c'.repeat(32),proposal.intentId);return Response.json({executions,status:saved.status});}catch{return new Response(null,{status:403});}
 }
 if(mode==='voicemail'){
  const recordings=createTwilioRecordingVerifier({accountSid:config.accountSid,apiKeySid:'SK'+'d'.repeat(32),apiKeySecret:'e'.repeat(32),httpClient:{async request(){return {statusCode:200,headers:{},body:JSON.stringify({sid:'RE'+'d'.repeat(32),account_sid:config.accountSid,call_sid:'CA'+'c'.repeat(32),status:'completed',source:'RecordVerb',duration:'15'})};}}});
  return new TwilioVoicemailAdapter({...config,dialCompleteUrl:config.incomingUrl,recordActionUrl:config.gatherUrl,recordingStatusUrl:'https://fixture.invalid/record-status',service:{async fallback(callSid,status){return status==='no-answer';},async completed(input){const row=await recordings.fetch(input.recordingSid);if(row.callSid!==input.callSid||row.duration!==input.duration)throw Error('mismatch');}}}).respond(request);
 }
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
 const adapter=new TwilioVoiceExtensionAdapter({...config,...(mode==='reception'?{receptionExtension:'100099'}:{}),directory:{async lookup(extension){queries++;if(mode==='reception')return extension==='100099'?[{...row,extension:'100099',userId:'receptionist'}]:[];if(mode==='unknown'||mode==='revoked'&&queries>1)return [];return mode==='duplicate'?[row,row]:[row];}}});
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
 const vm=await send({stage:'incoming',mode:'voicemail',params:{DialCallStatus:'no-answer'}});assert.equal(vm.status,200);assert.match(await vm.text(),/<Record[^>]*maxLength="120"/);checks++;
 const answered=await send({stage:'incoming',mode:'voicemail',params:{DialCallStatus:'completed'}});assert.doesNotMatch(await answered.text(),/<Record/);checks++;
 const vmUrl='https://fixture.invalid/record-status',vmParams={AccountSid:config.accountSid,CallSid:'CA'+'c'.repeat(32),RecordingSid:'RE'+'d'.repeat(32),RecordingDuration:'15',RecordingStatus:'completed'};
 const savedVm=await runtime.dispatchFetch(vmUrl,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-test-mode':'voicemail','x-twilio-signature':getExpectedTwilioSignature(config.authToken,vmUrl,vmParams)},body:new URLSearchParams(vmParams).toString()});assert.equal(savedVm.status,204);checks++;
 const reception=await send({mode:'reception',params:{Digits:'0'}});assert.equal(reception.status,200);assert.match(await reception.text(),/<Dial/);checks++;
 const taskResult=await(await send({mode:'voice-task'})).json();assert.equal(taskResult.executions,1);assert.equal(taskResult.status,'completed');checks++;
 assert.equal((await send({mode:'voice-task-denied'})).status,403);checks++;
 const confirmationResult=await(await send({mode:'confirmation'})).json();assert.equal(confirmationResult.first.method,'app');assert.equal(confirmationResult.second,null);checks++;
 const otpResult=await(await send({mode:'otp'})).json();assert.equal(otpResult.approved,true);assert.equal(otpResult.requests,2);checks++;
 const boundOtp=await(await send({mode:'otp-binding'})).json();assert.deepEqual(boundOtp,{wasUnverified:true,verified:true,revoked:true,sends:1,checks:1});checks++;
 const pairPrompt=await send({stage:'incoming',mode:'otp-pairing'});assert.equal(pairPrompt.status,200);assert.match(await pairPrompt.text(),/<Pause length="10"/);checks++;
 const agentUrl='https://fixture.invalid/agent',agentParams={AccountSid:config.accountSid,CallSid:'CA'+'c'.repeat(32),To:config.sharedNumber,Direction:'inbound'};
 for(const mode of ['agent-start','agent-denied']){const reply=await runtime.dispatchFetch(agentUrl,{method:'POST',headers:{'content-type':'application/x-www-form-urlencoded','x-test-mode':mode,'x-twilio-signature':getExpectedTwilioSignature(config.authToken,agentUrl,agentParams)},body:new URLSearchParams(agentParams).toString()});assert.equal(reply.status,200);const xml=await reply.text();if(mode==='agent-start')assert.match(xml,/<ConversationRelay url="wss:\/\/fixture.invalid\/agent-socket"/);else{assert.match(xml,/fixture.invalid\/reception/);assert.doesNotMatch(xml,/ConversationRelay/);}checks++;}
 await mkdir('test-results/communication-twilio',{recursive:true});
 await writeFile('test-results/communication-twilio/workerd.json',JSON.stringify({sourceCommit:process.env.GITHUB_SHA,checks,passed:true,engine:'workerd',sdk:'twilio@6.2.0',compatibilityFlags:['nodejs_compat'],officialSignatureValidation:true,officialTwimlBuilder:true,directory:'synthetic',liveProviderVerified:false,numbersPurchased:0,extensionsAssigned:0,callsPlaced:0,production:false},null,2));
 console.log('WORKERD_COMMUNICATION_TWILIO_PASS '+checks);
}finally{await runtime.dispose();}
