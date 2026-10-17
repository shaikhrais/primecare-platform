import {registry} from '../../../../packages/shared/src/care/contract';
export class CareHttpError extends Error {constructor(readonly status:number,message:string){super(message);}}
export class CareClient {
 private retries=new Map<string,string>();
 constructor(readonly gateway:string,readonly token:string){}
 async request(path='',body?:unknown){
  if(sessionStorage.getItem('primecare_session')!==this.token)throw new CareHttpError(401,'account_changed');
  const serialized=body===undefined?undefined:JSON.stringify(body),fingerprint=path+serialized;
  if(body&&!this.retries.has(fingerprint))this.retries.set(fingerprint,crypto.randomUUID());
  const r=await fetch(this.gateway+registry.endpoint+path,{method:body?'POST':'GET',cache:'no-store',headers:{authorization:'Bearer '+this.token,...(body?{'content-type':'application/json','idempotency-key':this.retries.get(fingerprint)!}:{})},...(serialized?{body:serialized}:{})});
  const value=await r.json();if(sessionStorage.getItem('primecare_session')!==this.token)throw new CareHttpError(401,'account_changed');
  if(!r.ok)throw new CareHttpError(r.status,typeof value.error==='string'?value.error:'unavailable');
  if(body)this.retries.delete(fingerprint);return value;
 }
}
