export function createTwilioVoiceOtpClient(options:{accountSid:string;apiKeySid:string;apiKeySecret:string;serviceSid:string;contact:{phone:string;verified:true};codeLength?:number;httpClient?:{request(options:unknown):Promise<unknown>}}):Readonly<{
 start():Promise<Readonly<{verificationSid:string;status:'pending'}>>;
 check(verificationSid:string,code:string):Promise<Readonly<{approved:boolean}>>;
}>;
