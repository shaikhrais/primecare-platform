import registry from '../../../../packages/shared/src/tenant-operations.json';
export type OperationsLocale='en'|'fr'|'es';
export type Destination='accounts'|'masters'|'territories';
export type TenantRow={id:string;name:string;slug:string;status:'active'|'inactive'|'unknown';counts:Record<'accounts'|'administrators'|'locations'|'categories'|'territories'|'seniors65',number>;checks:{key:string;labelKey:string;present:boolean}[];issues:string[];actions:Destination[]};
export type Overview={scope:'global'|'own';source:typeof registry.source;tenants:TenantRow[];summary:Record<'total'|'active'|'inactive'|'attention'|'territories'|'seniors65',number>;pagination:{limit:number;offset:number;total:number;hasMore:boolean}};
export type Filters={search:string;filter:string;offset:number};
export class OperationsClient{
 constructor(private gateway:string,private token:string){}
 assertSession(){if(sessionStorage.getItem('primecare_session')!==this.token)throw Error('account_changed');}
 private async readForSession<T>(read:()=>Promise<T>,current:()=>void):Promise<T>{current();try{return await read();}finally{current();}}
 async read(filters:Filters,assertOwner:()=>void=()=>{}):Promise<Overview>{
  const current=()=>{this.assertSession();assertOwner();};current();
  const query=new URLSearchParams({search:filters.search,filter:filters.filter,offset:String(filters.offset)});
  const response=await this.readForSession(()=>fetch(this.gateway.replace(/\/+$/,'')+registry.endpoint+'?'+query,{headers:{authorization:'Bearer '+this.token},cache:'no-store'}),current);current();
  if(response.status===401){
   // Storage can be unavailable; its cleanup must not suppress login navigation.
   try{sessionStorage.removeItem('primecare_session');}catch{}
   location.assign('/login');throw Error('forbidden');
  }
  if(!response.ok)throw Error(response.status===403?'forbidden':'failed');const data=await this.readForSession(()=>response.json(),current);current();return data;
 }
}
