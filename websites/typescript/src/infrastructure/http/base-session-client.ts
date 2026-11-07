/** Session-bound JSON transport. Domain clients retain endpoint and error policy. */
export abstract class BaseSessionClient {
 private readonly retries=new Map<string,string>();
 constructor(readonly gateway:string,readonly token:string){}
 protected abstract readonly endpoint:string;
 protected abstract accountChangedError():Error;
 protected abstract rejectResponse(response:Response,value:unknown):never;
 protected decodeResponse(response:Response):Promise<any>{return response.json();}
 protected errorData(value:unknown):Record<string,unknown>{
  return value!==null&&typeof value==='object'&&!Array.isArray(value)?value as Record<string,unknown>:{};
 }

 protected assertSession(){
  if(sessionStorage.getItem('primecare_session')!==this.token)throw this.accountChangedError();
 }
 protected retryFingerprint(path:string,method:string,serialized:string|undefined){return method+path+serialized;}
 protected clearRetryPrefix(prefix:string){for(const key of this.retries.keys())if(key.startsWith(prefix))this.retries.delete(key);}

 protected async requestJson(path:string,method:string,body?:unknown,expectedStatus?:number,requestId?:string){
  this.assertSession();
  let chargeId='';if(this.endpoint.startsWith('/v1/governance/care')&&!this.endpoint.endsWith('/additional-charge')){try{const charge=JSON.parse(sessionStorage.getItem('primecare_care_charge')||'null');if(charge?.token===this.token&&typeof charge.id==='string')chargeId=charge.id;}catch{}}
  const serialized=body===undefined?undefined:JSON.stringify(body),key=chargeId+this.retryFingerprint(path,method,serialized),mutation=method!=='GET';
  if(requestId!==undefined&&(!mutation||!/^[A-Za-z0-9_-]{16,100}$/.test(requestId)))throw Error('Invalid persisted request identity');
  if(mutation&&requestId===undefined&&!this.retries.has(key))this.retries.set(key,crypto.randomUUID());
  let response:Response,value:Awaited<ReturnType<Response['json']>>;
  try {
   response=await fetch(this.gateway+this.endpoint+path,{method,cache:'no-store',headers:{authorization:'Bearer '+this.token,...(chargeId?{'x-requested-with':'primecare:psw-coordinator:'+chargeId}:{}),...(mutation?{'content-type':'application/json','idempotency-key':requestId??this.retries.get(key)!}:{})},...(serialized===undefined?{}:{body:serialized})});
   this.assertSession();
   value=await this.decodeResponse(response);
  } finally {
   // Rejected requests belong to their original account just as successful ones do.
   // Check before domain error policy can redraw stale data or sign out a newer session.
   this.assertSession();
  }
  if(!response.ok)this.rejectResponse(response,value);
  if(expectedStatus!==undefined&&response.status!==expectedStatus)this.rejectResponse(new Response(null,{status:502}),value);
  if(mutation&&requestId===undefined)this.retries.delete(key);
  return value;
 }
}
