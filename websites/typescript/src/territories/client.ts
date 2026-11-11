import registry from '../../../../packages/shared/src/territories/registry.json';
export type Territory={id:string;number:number;code:string;name:string;fsas:string[];seniors65:number;population:number;status:'available'|'sold'|'reserve';canSell:boolean;version:number;allocation:null|{tenantId:string;tenantName:string;services:string[];reference:string;recordedAt:string}};
export type Board={canManage:boolean;source:typeof registry.source;territories:Territory[];tenants:{id:string;name:string;slug:string}[];summary:Record<'available'|'sold'|'reserve',{count:number;seniors65:number}>};
export class TerritoryClient{
 constructor(private gateway:string,private token:string,private actor:string){}
 assertSession(){if(sessionStorage.getItem('primecare_session')!==this.token)throw Error('account_changed');}
 private async readForSession<T>(read:()=>Promise<T>,current:()=>void):Promise<T>{current();try{return await read();}finally{current();}}
 // Controllers defer settlement until their consuming continuation still owns the view.
 // Existing request(id, body) callers retain the ordinary payload/error contract.
 async request(id?:string,body?:Record<string,unknown>,deferSettlement=false,assertOwner:()=>void=()=>{}):Promise<any>{
  const current=()=>{this.assertSession();assertOwner();};current();
  const path=registry.endpoint+(id?'/'+encodeURIComponent(id)+'/sale':'');const headers:Record<string,string>={authorization:'Bearer '+this.token};let storage='';
  const serialized=body?JSON.stringify(body):undefined;
  if(body){headers['content-type']='application/json';const digest=await this.readForSession(()=>crypto.subtle.digest('SHA-256',new TextEncoder().encode(serialized)),current);current();storage='primecare-territory:'+this.actor+':'+path+':'+Array.from(new Uint8Array(digest)).map(n=>n.toString(16).padStart(2,'0')).join('');headers['idempotency-key']=sessionStorage.getItem(storage)??crypto.randomUUID();sessionStorage.setItem(storage,headers['idempotency-key']);}
  const response=await this.readForSession(()=>fetch(this.gateway.replace(/\/+$/,'')+path,{method:body?'POST':'GET',headers,cache:'no-store',...(body?{body:serialized}:{})}),current);current();
  // A 401 body is untrusted and unnecessary. Authentication still settles only
  // when the current caller consumes its receipt, never before that boundary.
  const data=response.status===401?undefined:await this.readForSession(()=>response.json(),current);current();
  const forgetPending=()=>{if(storage&&sessionStorage.getItem(storage)===headers['idempotency-key'])sessionStorage.removeItem(storage);};
  const consume=()=>{
   current();
   if(response.ok){forgetPending();return data;}
   if(response.status===401){
    // Storage can be unavailable; its cleanup must not suppress login navigation.
    try{sessionStorage.removeItem('primecare_session');}catch{}
    location.assign('/login');
   }
   if(response.status<500)forgetPending();
   throw new Error(response.status===409?'conflict':'failed');
  };
  return deferSettlement?{consume}:consume();
 }
}
