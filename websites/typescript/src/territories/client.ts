import registry from '../../../../packages/shared/src/territories/registry.json';
export type Territory={id:string;number:number;code:string;name:string;fsas:string[];seniors65:number;population:number;status:'available'|'sold'|'reserve';canSell:boolean;version:number;allocation:null|{tenantId:string;tenantName:string;services:string[];reference:string;recordedAt:string}};
export type Board={canManage:boolean;source:typeof registry.source;territories:Territory[];tenants:{id:string;name:string;slug:string}[];summary:Record<'available'|'sold'|'reserve',{count:number;seniors65:number}>};
export class TerritoryClient{
 constructor(private gateway:string,private token:string,private actor:string){}
 async request(id?:string,body?:Record<string,unknown>):Promise<any>{
  const path=registry.endpoint+(id?'/'+encodeURIComponent(id)+'/sale':'');const headers:Record<string,string>={authorization:'Bearer '+this.token};let storage='';
  if(body){headers['content-type']='application/json';const digest=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(JSON.stringify(body)));storage='primecare-territory:'+this.actor+':'+path+':'+Array.from(new Uint8Array(digest)).map(n=>n.toString(16).padStart(2,'0')).join('');headers['idempotency-key']=sessionStorage.getItem(storage)??crypto.randomUUID();sessionStorage.setItem(storage,headers['idempotency-key']);}
  const response=await fetch(this.gateway.replace(/\/+$/,'')+path,{method:body?'POST':'GET',headers,cache:'no-store',...(body?{body:JSON.stringify(body)}:{})});const data=await response.json();
  if(response.ok){if(storage)sessionStorage.removeItem(storage);return data;}
  if(response.status===401){sessionStorage.removeItem('primecare_session');location.assign('/login');}
  if(response.status<500&&storage)sessionStorage.removeItem(storage);throw new Error(response.status===409?'conflict':'failed');
 }
}
