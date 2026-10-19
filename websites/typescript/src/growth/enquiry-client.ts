import {registry} from '../../../../packages/shared/src/growth/contract';
export class EnquiryClient{
 private key=crypto.randomUUID();private fingerprint='';
 constructor(readonly gateway:string,readonly publicKey:string){}
 async request(body?:unknown){
  const serialized=body===undefined?undefined:JSON.stringify(body);
  if(serialized&&this.fingerprint&&this.fingerprint!==serialized)this.key=crypto.randomUUID();
  if(serialized)this.fingerprint=serialized;
  const response=await fetch(this.gateway+registry.endpoint+'/enquiries/'+this.publicKey,{method:serialized?'POST':'GET',cache:'no-store',credentials:'omit',headers:serialized?{'content-type':'application/json','idempotency-key':this.key}:{},...(serialized?{body:serialized}:{})});
  if(!response.ok)throw Error('enquiry_error');return response.json();
 }
}
