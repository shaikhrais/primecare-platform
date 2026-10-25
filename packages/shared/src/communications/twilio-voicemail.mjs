import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import Twilio from 'twilio/lib/rest/Twilio.js';
import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {TwilioSignedFormAdapter,twilioPublicUrl,twilioSid,twilioApiKeySecret,twilioFailure} from './twilio-webhook.mjs';
const xml=response=>new Response(response.toString(),{headers:{'content-type':'application/xml; charset=utf-8','cache-control':'no-store','x-content-type-options':'nosniff'}});
export function createTwilioRecordingVerifier({accountSid,apiKeySid,apiKeySecret,httpClient}){
 if(!twilioSid('AC',accountSid)||!twilioSid('SK',apiKeySid)||!twilioApiKeySecret(apiKeySecret)||httpClient!==undefined&&typeof httpClient?.request!=='function')throw Error('Recording credentials required');
 const client=new Twilio(apiKeySid,apiKeySecret,{accountSid,autoRetry:false,maxRetries:0,timeout:10000,...(httpClient?{httpClient}:{})});
 return Object.freeze({async fetch(sid){if(!twilioSid('RE',sid))throw Error('Recording unavailable');try{const row=await client.recordings(sid).fetch();return Object.freeze({sid:row.sid,accountSid:row.accountSid,callSid:row.callSid,status:row.status,source:row.source,duration:Number(row.duration)});}catch{throw Error('Recording unavailable');}}});
}
/** Separate exact signed endpoints. Recording action never triggers email; only
 * a completed recording-status callback may notify after canonical verification.
 */
export class TwilioVoicemailAdapter extends TwilioSignedFormAdapter {
 constructor({accountSid,authToken,dialCompleteUrl,recordActionUrl,recordingStatusUrl,maxWebhookBytes,service}){
  // One inherited validator per endpoint preserves the shared two-URL boundary.
  super({accountSid,authToken,webhookUrls:[dialCompleteUrl,recordActionUrl],maxWebhookBytes});
  const urls=[dialCompleteUrl,recordActionUrl,recordingStatusUrl].map(twilioPublicUrl);
  if(new Set(urls).size!==3||new Set(urls.map(u=>new URL(u).origin)).size!==1||['fallback','completed'].some(key=>typeof service?.[key]!=='function'))throw Error('Voicemail configuration required');
  this.statusValidator=new TwilioSignedFormAdapter({accountSid,authToken,webhookUrl:recordingStatusUrl,maxWebhookBytes});this.urls=Object.freeze({dialCompleteUrl,recordActionUrl,recordingStatusUrl});this.service=service;
 }
 async respond(request){
  const isStatus=request.url===this.urls.recordingStatusUrl;
  const checked=await(isStatus?this.statusValidator:this).validate(request);if(checked.response)return checked.response;
  const p=checked.params;if(!twilioSid('CA',p.CallSid))return twilioFailure(403);
  try{
   if(isStatus){
    if(p.RecordingStatus==='completed'&&twilioSid('RE',p.RecordingSid)&&p.RecordingDuration==='0')return new Response(null,{status:204,headers:{'cache-control':'no-store'}});
    if(p.RecordingStatus!=='completed'||!twilioSid('RE',p.RecordingSid)||typeof p.RecordingDuration!=='string'||! /^(?:[1-9][0-9]?|1[01][0-9]|120)$/.test(p.RecordingDuration))return twilioFailure(403);
    await this.service.completed({callSid:p.CallSid,recordingSid:p.RecordingSid,duration:Number(p.RecordingDuration)});return new Response(null,{status:204,headers:{'cache-control':'no-store'}});
   }
   const response=new VoiceResponse();
   if(request.url===this.urls.dialCompleteUrl){
    if(typeof p.DialCallStatus!=='string')return twilioFailure(403);
    if(await this.service.fallback(p.CallSid,p.DialCallStatus)){
     response.say('The person is unavailable. After the beep, leave a voice message. Your message will be recorded. Press pound when finished.');
     response.record({action:this.urls.recordActionUrl,method:'POST',maxLength:120,timeout:5,finishOnKey:'#',playBeep:true,trim:'trim-silence',transcribe:false,recordingStatusCallback:this.urls.recordingStatusUrl,recordingStatusCallbackMethod:'POST',recordingStatusCallbackEvent:['completed']});
    }
   }
   response.hangup();return xml(response);
  }catch{return twilioFailure(503);}
 }
}

/** Private bounded download; construct the Twilio URL from validated SIDs. Never
 * fetch a callback RecordingUrl, follow redirects, or put credentials in links.
 */
export class TwilioVoicemailAudioAdapter extends BoundedBinaryAdapterBase {
 #account;#key;#secret;#fetch;
 constructor({accountSid,apiKeySid,apiKeySecret,maxAudioBytes,fetch:fetchPort}){
  super(maxAudioBytes);
  if(!twilioSid('AC',accountSid)||!twilioSid('SK',apiKeySid)||!twilioApiKeySecret(apiKeySecret)||typeof fetchPort!=='function'||maxAudioBytes>8*1024*1024)throw Error('Private voicemail audio configuration required');
  this.#account=accountSid;this.#key=apiKeySid;this.#secret=apiKeySecret;this.#fetch=fetchPort;
 }
 async download(recordingSid){
  if(!twilioSid('RE',recordingSid))throw Error('Voicemail audio unavailable');
  try{
   const response=await this.#fetch(`https://api.twilio.com/2010-04-01/Accounts/${this.#account}/Recordings/${recordingSid}.wav`,{method:'GET',redirect:'error',cache:'no-store',signal:AbortSignal.timeout(10000),headers:{authorization:'Basic '+btoa(this.#key+':'+this.#secret)}});
   if(response.status!==200||!/^audio\/(?:wav|x-wav)(?:;|$)/i.test(response.headers.get('content-type')??'')){try{await response.body?.cancel();}catch{}throw Error('Invalid audio');}
   const bytes=await this.readBoundedBody(response.body);
   if(bytes.length<12||String.fromCharCode(...bytes.subarray(0,4))!=='RIFF'||String.fromCharCode(...bytes.subarray(8,12))!=='WAVE')throw Error('Invalid WAV');
   return {bytes,contentType:'audio/wav'};
  }catch{throw Error('Voicemail audio unavailable');}
 }
}
