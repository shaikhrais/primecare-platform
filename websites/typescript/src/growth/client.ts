import {registry} from '../../../../packages/shared/src/growth/contract';
import {BaseSessionClient} from '../infrastructure/http/base-session-client';
export class GrowthClient extends BaseSessionClient {
 constructor(gateway:string,token:string,private readonly ownerManaged=false){super(gateway,token);}
 protected readonly endpoint=registry.endpoint;
 protected accountChangedError(){return Error('account_changed');}
 protected async decodeResponse(response:Response){
  try{return await super.decodeResponse(response);}
  catch(error){if(this.ownerManaged&&!response.ok)throw Object.assign(Error('unavailable'),{status:response.status});throw error;}
 }
 protected rejectResponse(response:Response,value:unknown):never{
  const data=this.errorData(value);
  if(response.status===401&&!this.ownerManaged){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}
  throw Object.assign(Error(data.state==='unknown'||data.state==='sending'?'delivery_uncertain':typeof data.error==='string'?data.error:'error'),{status:response.status});
 }
 async list(offset:number,filters:Record<string,string>){const query=new URLSearchParams({offset:String(offset)});for(const [key,value] of Object.entries(filters))if(value)query.set(key,value);return this.request('?'+query);}
 async request(path='',method='GET',body?:unknown){
  return this.requestJson(path,method,body);
 }
 resetReportRetry(){this.clearRetryPrefix('POST/performance/email');}
 async blob(path:string){
  this.assertSession();
  let response:Response|undefined,blob:Blob;
  try {
   response=await fetch(this.gateway+registry.endpoint+path,{cache:'no-store',headers:{authorization:'Bearer '+this.token}});
   this.assertSession();
   blob=await response.blob();
  } catch(error) {
   if(this.ownerManaged&&response&&!response.ok)throw Object.assign(Error('unavailable'),{status:response.status});throw error;
  } finally {
   this.assertSession();
  }
  if(!response.ok){
   let error='unavailable';try{error=JSON.parse(await blob.text()).error??error;}catch{}
   // Error decoding is asynchronous too. Only the original session may be redirected.
   this.assertSession();
   if(response.status===401&&!this.ownerManaged){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}
   throw Object.assign(Error(error),{status:response.status});
  }
  if(response.headers.get('content-type')?.split(';')[0]!=='application/pdf')throw Error('unavailable');return blob;
 }

}
