import type {TwilioSmsClient} from './twilio-sms.mjs';
export function createTwilioSmsClient(options:{accountSid:string;apiKeySid:string;apiKeySecret:string;httpClient?:{request(options:unknown):Promise<{statusCode:number;body:string;headers?:Record<string,string>}>}}):TwilioSmsClient;
