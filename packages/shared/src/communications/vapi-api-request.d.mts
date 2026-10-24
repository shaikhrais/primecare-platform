import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
export type VapiCanonicalCall={vapiCallId:string;callSid:string;orgId:string;assistantId:string;phoneNumberId:string;active:boolean;expiresAt:number};
export type VapiApiRequestOptions={
 url:string;orgId:string;assistantId:string;phoneNumberId:string;
 authenticate(request:Request):Promise<boolean>;authorize(request:Request):Promise<boolean>;admit(request:Request):Promise<boolean>;
 calls:{current(vapiCallId:string):Promise<VapiCanonicalCall|null>};
 claims:{claim(input:{vapiCallId:string;requestId:string;digest:string}):Promise<boolean>};
 tasks:{propose(callSid:string,taskId:string,args:unknown):Promise<{intentId:string;summary:string;expiresAt:number;requiresConfirmation:boolean}>;execute(callSid:string,intentId:string):Promise<{status:'completed'}>};
 taskIds:readonly string[];
};
/** Unmounted internal transport. Every trust, registration and durable claim port
 * is mandatory; supplying it does not register or authorize an endpoint. */
export class VapiApiRequestAdapter extends BoundedBinaryAdapterBase {
 constructor(options:VapiApiRequestOptions);
 respond(request:Request):Promise<Response>;
}
