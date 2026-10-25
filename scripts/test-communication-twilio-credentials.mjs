import {test} from 'node:test';import assert from 'node:assert/strict';
import {twilioApiKeySecret} from '../packages/shared/src/communications/twilio-webhook.mjs';
import {createTwilioContactEnrollmentClient} from '../packages/shared/src/communications/twilio-verify.mjs';
import {TwilioVerifyFetchClient} from '../packages/shared/src/communications/twilio-verify-fetch.mjs';
import {createTwilioSmsClient} from '../packages/shared/src/communications/twilio-sms-client.mjs';
import {createTwilioVoiceCallVerifier} from '../packages/shared/src/communications/twilio-connect.mjs';
import {createTwilioRecordingVerifier,TwilioVoicemailAudioAdapter} from '../packages/shared/src/communications/twilio-voicemail.mjs';
import {createTwilioSalesQualitySource} from '../packages/shared/src/communications/twilio-sales-quality.mjs';
import {TwilioVoiceTokenService} from '../cloudflare/workers/src/business-tasks/twilio-token.ts';
const accountSid='AC'+'a'.repeat(32),apiKeySid='SK'+'b'.repeat(32),serviceSid='VA'+'c'.repeat(32),sid='VE'+'d'.repeat(32),secret='Gz9Q'.repeat(8);
const unused=()=>{throw Error('No provider operation expected');};
test('API secrets are bounded opaque printable credentials, while whitespace and controls are rejected',()=>{
 for(const value of [secret,'a'.repeat(32),'Opaque-credential_1234567890'])assert.equal(twilioApiKeySecret(value),true);
 for(const value of [null,undefined,'','short','x'.repeat(513),secret+'\n',secret+' ',secret+'\u0000','é'.repeat(32)])assert.equal(twilioApiKeySecret(value),false);
});
test('native Verify preserves a non-hex secret exactly through official SDK Basic authentication',async()=>{
 let requests=0;const port=createTwilioContactEnrollmentClient({accountSid,apiKeySid,apiKeySecret:secret,serviceSid,phone:'+14165550101',purpose:'first-time-contact-enrollment',httpClient:new TwilioVerifyFetchClient({serviceSid,apiKeySid,apiKeySecret:secret,async fetch(url,options){requests++;assert.equal(options.headers.authorization,'Basic '+btoa(apiKeySid+':'+secret));return Response.json({sid,account_sid:accountSid,service_sid:serviceSid,to:'+14165550101',channel:'sms',status:url.endsWith('/VerificationCheck')?'approved':'pending'});}})});
 assert.equal((await port.start()).verificationSid,sid);assert.equal((await port.check(sid,'123456')).approved,true);assert.equal(requests,2);
});
test('all shared Twilio API-key adapters accept the same opaque secret without making provider requests',()=>{
 const config={accountSid,apiKeySid,apiKeySecret:secret,httpClient:{request:unused}};
 assert.ok(createTwilioSmsClient(config));assert.ok(createTwilioVoiceCallVerifier(config));assert.ok(createTwilioRecordingVerifier(config));
 assert.ok(new TwilioVoicemailAudioAdapter({...config,maxAudioBytes:1024,fetch:unused}));
 assert.ok(createTwilioSalesQualitySource({...config,serviceSid:'GA'+'a'.repeat(32),operatorSid:'LY'+'b'.repeat(32),rubricDigest:'a'.repeat(64),operatorConfigDigest:'b'.repeat(64)}));
 assert.ok(new TwilioVoiceTokenService({run:unused,read:unused,inbox:unused},{assert:unused,assignee:unused},{currentSession:unused,destinations:unused},{...config,applicationSid:'AP'+'c'.repeat(32),ttlSeconds:60}));
});
