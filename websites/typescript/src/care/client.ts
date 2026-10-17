import {registry} from '../../../../packages/shared/src/care/contract';
import {BaseSessionClient} from '../infrastructure/http/base-session-client';
export class CareHttpError extends Error {constructor(readonly status:number,message:string){super(message);}}
export class CareClient extends BaseSessionClient {
 protected readonly endpoint=registry.endpoint;
 protected accountChangedError(){return new CareHttpError(401,'account_changed');}
 protected retryFingerprint(path:string,_method:string,serialized:string|undefined){return path+serialized;}
 protected rejectResponse(response:Response,value:any):never{throw new CareHttpError(response.status,typeof value.error==='string'?value.error:'unavailable');}
 async request(path='',body?:unknown){
  return this.requestJson(path,body?'POST':'GET',body);
 }
}
