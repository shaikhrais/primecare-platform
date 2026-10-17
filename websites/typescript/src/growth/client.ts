import {registry} from '../../../../packages/shared/src/growth/contract';
export class GrowthClient {
 private retries=new Map<string,string>();
 constructor(readonly gateway:string,readonly token:string){}
 async list(offset:number,filters:Record<string,string>){const query=new URLSearchParams({offset:String(offset)});for(const [key,value] of Object.entries(filters))if(value)query.set(key,value);return this.request('?'+query);}
 async request(path='',method='GET',body?:unknown){
  if(sessionStorage.getItem('primecare_session')!==this.token)throw Error('account_changed');
  const serialized=body===undefined?undefined:JSON.stringify(body),retry=method+path+serialized;
  if(method!=='GET'&&!this.retries.has(retry))this.retries.set(retry,crypto.randomUUID());
  const response=await fetch(this.gateway+registry.endpoint+path,{method,cache:'no-store',headers:{authorization:'Bearer '+this.token,...(method==='GET'?{}:{'content-type':'application/json','idempotency-key':this.retries.get(retry)!})},...(serialized===undefined?{}:{body:serialized})});
  const data=await response.json();if(sessionStorage.getItem('primecare_session')!==this.token)throw Error('account_changed');
  if(!response.ok){if(response.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}if(['unknown','sending'].includes(data.state))throw Error('delivery_uncertain');throw Error(typeof data.error==='string'?data.error:'error');}
  if(method!=='GET')this.retries.delete(retry);
  return data;
 }
 resetReportRetry(){for(const key of this.retries.keys())if(key.startsWith('POST/performance/email'))this.retries.delete(key);}
 async blob(path:string){
  if(sessionStorage.getItem('primecare_session')!==this.token)throw Error('account_changed');
  const response=await fetch(this.gateway+registry.endpoint+path,{cache:'no-store',headers:{authorization:'Bearer '+this.token}}),blob=await response.blob();
  if(sessionStorage.getItem('primecare_session')!==this.token)throw Error('account_changed');
  if(!response.ok){if(response.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}let error='unavailable';try{error=JSON.parse(await blob.text()).error??error;}catch{}throw Error(error);}
  if(response.headers.get('content-type')?.split(';')[0]!=='application/pdf')throw Error('unavailable');return blob;
 }

}
