import Twilio from 'twilio/lib/rest/Twilio.js';
import {twilioSid,twilioApiKeySecret} from './twilio-webhook.mjs';
/** Server-only official SDK composition. No automatic retries of message creation.
 * httpClient is an infrastructure port for native hosting and isolated SDK tests.
 * Never populate credentials from a browser request or persist this client in logs.
 */
export function createTwilioSmsClient({accountSid,apiKeySid,apiKeySecret,httpClient}){
 if(!twilioSid('AC',accountSid)||!twilioSid('SK',apiKeySid)||!twilioApiKeySecret(apiKeySecret)||httpClient!==undefined&&typeof httpClient?.request!=='function')throw Error('SMS credentials required');
 const client=new Twilio(apiKeySid,apiKeySecret,{accountSid,autoRetry:false,maxRetries:0,timeout:10000,...(httpClient?{httpClient}:{})});
 // Expose only the required operation, not account administration or debug state.
 return Object.freeze({messages:Object.freeze({create:options=>client.messages.create(options)})});
}
