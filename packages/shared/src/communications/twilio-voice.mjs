import VoiceResponse from 'twilio/lib/twiml/VoiceResponse.js';
import {TwilioSignedFormAdapter,twilioPublicUrl as publicUrl} from './twilio-webhook.mjs';
import requirement from '../../../../tools/governance-production/twilio-voice-requirement.json' with {type:'json'};

const extensionPattern=/^[1-9][0-9]{5}$/;
const sid=(prefix,value)=>typeof value==='string'&&new RegExp('^'+prefix+'[a-fA-F0-9]{32}$').test(value);
const identifier=value=>typeof value==='string'&&/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(value);
const e164=value=>typeof value==='string'&&/^\+[1-9][0-9]{1,14}$/.test(value);
const headers={'cache-control':'no-store','x-content-type-options':'nosniff'};
const failure=status=>Response.json({error:status===503?'unavailable':'invalid_provider_request'},{status,headers});
const xml=response=>new Response(response.toString(),{headers:{...headers,'content-type':'application/xml; charset=utf-8'}});
function unavailable(){const response=new VoiceResponse();response.say('This extension is unavailable.');response.hangup();return xml(response);}
function destination(rows,extension){
 if(!Array.isArray(rows)||rows.length!==1)return null;
 const row=rows[0];
 if(!row||row.extension!==extension||!identifier(row.tenantId)||!identifier(row.userId)||row.published!==true||row.active!==true||row.tenantActive!==true||row.userActive!==true)return null;
 // Snapshot before hashing or another current-directory lookup suspends.
 return Object.freeze({extension,tenantId:row.tenantId,userId:row.userId});
}
/** Same identity function must be used by a separately authorized Voice SDK token issuer. */
export async function twilioVoiceIdentity({tenantId,userId}){
 if(!identifier(tenantId)||!identifier(userId))throw Error('Invalid voice identity');
 const source=new TextEncoder().encode(tenantId.length+':'+tenantId+userId.length+':'+userId);
 const digest=new Uint8Array(await crypto.subtle.digest('SHA-256',source));
 return 'primecare_'+Array.from(digest,byte=>byte.toString(16).padStart(2,'0')).join('');
}
/** Internal provider adapter, not a mounted endpoint or a native-user channel.
 * Requires governed webhook/token mounting, extension publication and live acceptance.
 */
export class TwilioVoiceExtensionAdapter extends TwilioSignedFormAdapter {
 constructor({accountSid,authToken,sharedNumber,numberVerified,incomingUrl,gatherUrl,directory,maxWebhookBytes,voicemail,dialCompleteUrl,receptionExtension}){
  super({accountSid,authToken,webhookUrls:[incomingUrl,gatherUrl],maxWebhookBytes});
  const incoming=publicUrl(incomingUrl),gather=publicUrl(gatherUrl);
  if(!sid('AC',accountSid)||typeof authToken!=='string'||!/^[a-fA-F0-9]{32}$/.test(authToken)||!e164(sharedNumber)||numberVerified!==true||new URL(incoming).origin!==new URL(gather).origin||incomingUrl===gatherUrl||typeof directory?.lookup!=='function'||requirement.rules.extensionDigits!==6)throw Error('Twilio voice configuration required');
  if((voicemail===undefined)!==(dialCompleteUrl===undefined)||voicemail!==undefined&&(typeof voicemail?.prepare!=='function'||new URL(publicUrl(dialCompleteUrl)).origin!==new URL(incoming).origin||[incomingUrl,gatherUrl].includes(dialCompleteUrl)))throw Error('Voicemail routing configuration required');
  if(receptionExtension!==undefined&&!extensionPattern.test(receptionExtension))throw Error('Published reception extension required');
  Object.defineProperties(this,{voicemail:{value:voicemail},configuration:{value:Object.freeze({accountSid,authToken,sharedNumber,incomingUrl,gatherUrl,dialCompleteUrl,receptionExtension})},directory:{value:directory}});
 }
 async respond(request){
  const config=this.configuration;
  const checked=await this.validate(request);if(checked.response)return checked.response;
  const params=checked.params;
  if(params.AccountSid!==config.accountSid||params.To!==config.sharedNumber||params.Direction!=='inbound'||!sid('CA',params.CallSid))return failure(403);
  if(request.url===config.incomingUrl){
   if(Object.hasOwn(params,'Digits'))return unavailable();
   const response=new VoiceResponse();response.gather({input:'dtmf',numDigits:6,finishOnKey:'#',timeout:5,action:config.gatherUrl,method:'POST',actionOnEmptyResult:true}).say(config.receptionExtension?'If you know the six digit extension, enter it now. Otherwise press zero followed by pound, or stay on the line for reception.':'Enter the six digit extension.');response.hangup();return xml(response);
  }
  if(params.Digits!==undefined&&typeof params.Digits!=='string')return unavailable();
  if(!config.receptionExtension&&(typeof params.Digits!=='string'||!extensionPattern.test(params.Digits)))return unavailable();
  try{
   let extension=typeof params.Digits==='string'&&extensionPattern.test(params.Digits)?params.Digits:config.receptionExtension;
   let first=destination(await this.directory.lookup(extension,2),extension);
   if(!first&&config.receptionExtension&&extension!==config.receptionExtension){extension=config.receptionExtension;first=destination(await this.directory.lookup(extension,2),extension);}
   if(!first)return unavailable();
   const identity=await twilioVoiceIdentity(first);
   const current=destination(await this.directory.lookup(extension,2),extension);
   if(!current||current.tenantId!==first.tenantId||current.userId!==first.userId)return unavailable();
   if(this.voicemail){
    await this.voicemail.prepare({callSid:params.CallSid,destination:current});
    // Reservation may suspend on storage. It cannot preserve an extension's
    // publication or ownership after the directory changes during that wait.
    const latest=destination(await this.directory.lookup(extension,2),extension);
    if(!latest||latest.tenantId!==first.tenantId||latest.userId!==first.userId)return unavailable();
   }
   const response=new VoiceResponse();response.dial({callerId:config.sharedNumber,answerOnBridge:true,timeout:20,...(this.voicemail?{action:config.dialCompleteUrl,method:'POST'}:{})}).client().identity(identity);response.hangup();return xml(response);
  }catch{return failure(503);}
 }
}
