import assert from 'node:assert/strict';
import {builtinModules} from 'node:module';
import {mkdir,writeFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {Miniflare} from 'miniflare';
const account='AC'+'a'.repeat(32),key='SK'+'b'.repeat(32),secret='c'.repeat(32),service='VA'+'d'.repeat(32),sid='VE'+'e'.repeat(32);
const env={DB_URL:'synthetic-only',VOICE_CONTACT_ORIGIN:'https://fixture.invalid',VOICE_GATEWAY_ORIGIN:'https://gateway.invalid',VOICE_CONTACT_SOURCE:'a'.repeat(40),TWILIO_ACCOUNT_SID:account,TWILIO_API_KEY_SID:key,TWILIO_API_KEY_SECRET:secret,TWILIO_VERIFY_SERVICE_SID:service};
const built=await build({stdin:{resolveDir:process.cwd(),contents:`
import {VoiceContactEnrollmentWorker} from './cloudflare/workers/src/business-tasks/voice-contact-worker.ts';
import {TwilioVerifyFetchClient} from './packages/shared/src/communications/twilio-verify-fetch.mjs';
import {createTwilioContactEnrollmentClient} from './packages/shared/src/communications/twilio-verify.mjs';
const env={...${JSON.stringify(env)},VOICE_CONTACT_LIMIT:{async limit(){return {success:true};}}};
const worker=new VoiceContactEnrollmentWorker({openPool(){return {async query(){return {rows:[]};},async connect(){throw Error('unused');},async end(){}};}});
export default {async fetch(request){
 if(new URL(request.url).pathname==='/fixture-sdk'){
  let requests=0;
  const transport=new TwilioVerifyFetchClient({serviceSid:env.TWILIO_VERIFY_SERVICE_SID,apiKeySid:env.TWILIO_API_KEY_SID,apiKeySecret:env.TWILIO_API_KEY_SECRET,async fetch(url,options){requests++;const checking=url.endsWith('/VerificationCheck');return Response.json({sid:'${sid}',account_sid:env.TWILIO_ACCOUNT_SID,service_sid:env.TWILIO_VERIFY_SERVICE_SID,to:'+14165550101',channel:'sms',status:checking?'approved':'pending'},{status:checking?200:201});}});
  const client=createTwilioContactEnrollmentClient({accountSid:env.TWILIO_ACCOUNT_SID,apiKeySid:env.TWILIO_API_KEY_SID,apiKeySecret:env.TWILIO_API_KEY_SECRET,serviceSid:env.TWILIO_VERIFY_SERVICE_SID,phone:'+14165550101',purpose:'first-time-contact-enrollment',httpClient:transport});
  const challenge=await client.start();return Response.json({approved:(await client.check(challenge.verificationSid,'123456')).approved,requests});
 }
 return worker.fetch(request,env);
}};`},bundle:true,write:false,format:'esm',platform:'neutral',mainFields:['module','main'],external:['node:*',...builtinModules],banner:{js:'import {createRequire} from "node:module";const require=createRequire("/worker.js");'}});
const runtime=new Miniflare({modules:true,script:built.outputFiles[0].text,compatibilityDate:'2026-07-30',compatibilityFlags:['nodejs_compat']});
try{
 const post=(path,headers={})=>runtime.dispatchFetch('https://fixture.invalid'+path,{method:'POST',headers:{'content-type':'application/json','cf-connecting-ip':'192.0.2.1',...headers},body:'{}'});
 assert.equal((await post('/v1/voice/contact/status')).status,401);
 assert.equal((await post('/v1/voice/contact/status',{authorization:'Bearer '+'n'.repeat(43)})).status,401);
 assert.equal((await post('/v1/voice/contact/status',{origin:'https://foreign.invalid'})).status,403);
 assert.equal((await post('/v1/voice/otp/start')).status,404);
 const sdk=await runtime.dispatchFetch('https://fixture.invalid/fixture-sdk');assert.equal(sdk.status,200);assert.deepEqual(await sdk.json(),{approved:true,requests:2});
 await mkdir('test-results/voice-contact-native',{recursive:true});await writeFile('test-results/voice-contact-native/workerd.json',JSON.stringify({engine:'workerd',checks:5,passed:true,provider:'official-SDK-with-synthetic-fetch',smsSent:false,liveDatabaseVerified:false,sourceCommit:process.env.GITHUB_SHA},null,2)+'\n');console.log('Native contact workerd: five checks passed; no real provider traffic');
}finally{await runtime.dispose();}
