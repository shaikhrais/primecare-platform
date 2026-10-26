export class VapiManagementError extends Error {code:string;httpStatus?:number;constructor(code:string);}
export class VapiManagementClient {
 constructor(options:{apiKey:string;fetch?:typeof fetch});
 tools():Promise<any[]>;
 assistant(id:string):Promise<any>;
 phoneNumber(id:string):Promise<any>;
 installToolCredential(expectedAssistant:any,install:(value:{credentialId:string;secret:string})=>Promise<void>):Promise<any>;
 setReceptionDuration(id:string,expected:any):Promise<any>;
 assignReception(phoneId:string,expectedPhone:any,expectedAssistant:any):Promise<any>;
 syntheticChat(id:string,input:string):Promise<{answer:string;scope:string;voiceVerified:boolean;businessActionsVerified:boolean}>;
}
