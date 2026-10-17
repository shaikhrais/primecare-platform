/** Session-bound JSON transport. Domain clients retain endpoint and error policy. */
export abstract class BaseSessionClient {
 private readonly retries=new Map<string,string>();
 constructor(readonly gateway:string,readonly token:string){}
 protected abstract readonly endpoint:string;
 protected abstract accountChangedError():Error;
 protected abstract rejectResponse(response:Response,value:unknown):never;
 protected errorData(value:unknown):Record<string,unknown>{
  return value!==null&&typeof value==='object'&&!Array.isArray(value)?value as Record<string,unknown>:{};
 }

 protected assertSession(){
  if(sessionStorage.getItem('primecare_session')!==this.token)throw this.accountChangedError();
 }
 protected retryFingerprint(path:string,method:string,serialized:string|undefined){return method+path+serialized;}
 protected clearRetryPrefix(prefix:string){for(const key of this.retries.keys())if(key.startsWith(prefix))this.retries.delete(key);}

 protected async requestJson(path:string,method:string,body?:unknown){
  this.assertSession();
  const serialized=body===undefined?undefined:JSON.stringify(body),key=this.retryFingerprint(path,method,serialized),mutation=method!=='GET';
  if(mutation&&!this.retries.has(key))this.retries.set(key,crypto.randomUUID());
  const response=await fetch(this.gateway+this.endpoint+path,{method,cache:'no-store',headers:{authorization:'Bearer '+this.token,...(mutation?{'content-type':'application/json','idempotency-key':this.retries.get(key)!}:{})},...(serialized===undefined?{}:{body:serialized})});
  const value=await response.json();
  this.assertSession();
  if(!response.ok)this.rejectResponse(response,value);
  if(mutation)this.retries.delete(key);
  return value;
 }
}
