import Twilio from 'twilio/lib/rest/Twilio.js';
import {twilioSid,twilioApiKeySecret} from './twilio-webhook.mjs';
/** Server-only provider port, not an authenticated caller/session broker.
 * The host must resolve this contact from current verified account records,
 * authorize/rate-limit and claim a durable send attempt before start(), then
 * persist the returned verification SID against the exact call/user/tenant.
 * Never construct it from a model-supplied phone or expose it as an AI tool.
 */
function createSmsVerificationPort({accountSid,apiKeySid,apiKeySecret,serviceSid,phone,codeLength=6,httpClient}){
 if(!twilioSid('AC',accountSid)||!twilioSid('SK',apiKeySid)||!twilioSid('VA',serviceSid)||!twilioApiKeySecret(apiKeySecret)||typeof phone!=='string'||phone.trim()!==phone||!/^\+[1-9][0-9]{1,14}$/.test(phone)||!Number.isSafeInteger(codeLength)||codeLength<4||codeLength>10||httpClient!==undefined&&typeof httpClient?.request!=='function')throw Error('OTP configuration required');
 const client=new Twilio(apiKeySid,apiKeySecret,{accountSid,autoRetry:false,maxRetries:0,timeout:10000,...(httpClient?{httpClient}:{})});
 const service=client.verify.v2.services(serviceSid);
 function receipt(row,expectedSid){
  if(!row||!twilioSid('VE',row.sid)||expectedSid!==undefined&&row.sid!==expectedSid||row.accountSid!==accountSid||row.serviceSid!==serviceSid||row.to!==phone||row.channel!=='sms'||!['pending','approved','canceled','max_attempts_reached','deleted','failed','expired'].includes(row.status))throw Error('OTP receipt invalid');
  return row;
 }
 return Object.freeze({
  async start(){
   try{const row=receipt(await service.verifications.create({to:phone,channel:'sms'}));if(row.status!=='pending')throw Error('Unexpected OTP state');return Object.freeze({verificationSid:row.sid,status:'pending'});}
   catch{throw Error('OTP send outcome unknown; do not resend automatically');}
  },
  async check(verificationSid,code){
   // Copy primitive values before crossing the provider boundary. No status,
   // destination, tenant, custom code or arbitrary SDK options are forwarded.
   if(!twilioSid('VE',verificationSid)||typeof code!=='string'||code.length!==codeLength||!new RegExp('^[0-9]{'+codeLength+'}$').test(code))throw Error('OTP verification unavailable');
   try{
    const row=receipt(await service.verificationChecks.create({verificationSid,code}),verificationSid);
    return Object.freeze({approved:row.status==='approved'});
   }catch{throw Error('OTP verification unavailable');}
  },
 });
}

/** Existing call step-up still requires a previously verified account contact. */
export function createTwilioVoiceOtpClient(options){
 if(options?.contact?.verified!==true)throw Error('OTP configuration required');
 return createSmsVerificationPort({...options,phone:options.contact.phone});
}
/** Separate first-time enrollment capability. The native scoped service must
 * authenticate a recent app session, enforce consent/policy and atomically claim
 * user/phone quotas before invoking it. It never marks the input phone verified.
 * No caller/model can select provider credentials, URLs or arbitrary SDK options. */
export function createTwilioContactEnrollmentClient(options){
 if(options?.purpose!=='first-time-contact-enrollment'||options.codeLength!==undefined&&options.codeLength!==6)throw Error('Enrollment configuration required');
 return createSmsVerificationPort({...options,codeLength:6});
}
