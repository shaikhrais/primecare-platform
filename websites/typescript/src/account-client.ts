import {BaseSessionClient} from './infrastructure/http/base-session-client';

export class AccountRequestError extends Error {
 constructor(readonly status:number){super('account_request_failed');}
}

/** Registered current-account mutation; the UI commits only confirmed results. */
export class AccountClient extends BaseSessionClient {
 protected readonly endpoint='/v1/user';
 constructor(gateway:string,token:string){super(gateway.replace(/\/+$/,''),token);}
 protected accountChangedError(){return new AccountRequestError(409);}
 protected rejectResponse(response:Response,_value:unknown):never{throw new AccountRequestError(response.status);}
 async changePassword(currentPassword:string,newPassword:string):Promise<void>{
  const value=await this.requestJson('/change-password','POST',{currentPassword,newPassword});
  const data=this.errorData(value);
  if(data.status!=='password_changed'||data.reauthenticationRequired!==true)throw new AccountRequestError(502);
 }
}
