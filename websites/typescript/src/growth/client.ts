import {registry} from '../../../../packages/shared/src/growth/contract';
import {BaseSessionClient} from '../infrastructure/http/base-session-client';
export class GrowthClient extends BaseSessionClient {
 protected readonly endpoint=registry.endpoint;
 protected accountChangedError(){return Error('account_changed');}
 protected rejectResponse(response:Response,value:unknown):never{
  const data=this.errorData(value);
  if(response.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}
  if(data.state==='unknown'||data.state==='sending')throw Error('delivery_uncertain');throw Error(typeof data.error==='string'?data.error:'error');
 }
 async list(offset:number,filters:Record<string,string>){const query=new URLSearchParams({offset:String(offset)});for(const [key,value] of Object.entries(filters))if(value)query.set(key,value);return this.request('?'+query);}
 async request(path='',method='GET',body?:unknown){
  return this.requestJson(path,method,body);
 }
 resetReportRetry(){this.clearRetryPrefix('POST/performance/email');}
 async blob(path:string){
  this.assertSession();
  const response=await fetch(this.gateway+registry.endpoint+path,{cache:'no-store',headers:{authorization:'Bearer '+this.token}}),blob=await response.blob();
  this.assertSession();
  if(!response.ok){if(response.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login?enable-semantics=true');}let error='unavailable';try{error=JSON.parse(await blob.text()).error??error;}catch{}throw Error(error);}
  if(response.headers.get('content-type')?.split(';')[0]!=='application/pdf')throw Error('unavailable');return blob;
 }

}
