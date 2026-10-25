import {BaseSessionClient} from './infrastructure/http/base-session-client';
export class InternalCallRequestError extends Error {constructor(readonly status:number){super('call_request_failed');}}
/** Same session-bound transport used by existing account clients. */
export class InternalCallClient extends BaseSessionClient {
 protected readonly endpoint='/v1/calls';
 protected accountChangedError(){return new InternalCallRequestError(401);}
 protected rejectResponse(response:Response):never{throw new InternalCallRequestError(response.status);}
 directory(after?:string){return this.requestJson('/directory','POST',after?{after}:{});}
 extension(published:boolean){return this.requestJson('/extension','POST',{published});}
 dial(extension:string,requestId:string){return this.requestJson('/dial','POST',{extension,requestId});}
 command(body:unknown){return this.requestJson('/command','POST',body);}
 read(id:string){return this.command({action:'read',id});}
 media(id:string,callId:string){return this.requestJson('/media','POST',{id,callId});}
}
