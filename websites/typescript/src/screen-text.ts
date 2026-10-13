export type Catalog={screen:string;version:number;locales:Record<string,Record<string,string>>};

/** One live resource cache per gateway; failed refreshes retain the last usable text. */
export class LiveScreenText {
 private catalogs=new Map<string,Catalog>();private listeners=new Set<()=>void>();private timer:ReturnType<typeof setInterval>|null=null;
 constructor(readonly gateway:string){}
 private url(path=''){return this.gateway.replace(/\/+$/,'')+'/v1/governance/screen-text'+path;}
 async request(path='',method='GET',body?:unknown):Promise<any>{
  const headers:Record<string,string>={};const token=sessionStorage.getItem('primecare_session');if(token)headers.authorization='Bearer '+token;
  if(body)headers['content-type']='application/json';
  const response=await fetch(this.url(path),{method,headers,cache:'no-store',...(body?{body:JSON.stringify(body)}:{})});
  const data=await response.json();if(!response.ok)throw Object.assign(new Error(data.error??'Text request failed'),{status:response.status});return data;
 }
 async refresh():Promise<void>{
  const manifest=await this.request();let changed=false;
  for(const row of manifest.screens){if(this.catalogs.get(row.id)?.version===row.version)continue;
   const catalog:Catalog=await this.request('/'+row.id);if(catalog.screen!==row.id||!Number.isSafeInteger(catalog.version)||!catalog.locales?.en)throw Error('Invalid text catalog');
   this.catalogs.set(row.id,catalog);changed=true;}
  if(changed)this.listeners.forEach(listener=>listener());
 }
 text(screen:string,language:string,key:string,fallback:string){return this.catalogs.get(screen)?.locales[language]?.[key]??fallback;}
 async save(screen:string,version:number,locales:Catalog['locales']):Promise<Catalog>{const catalog=await this.request('/'+screen,'PUT',{version,locales});this.catalogs.set(screen,catalog);this.listeners.forEach(listener=>listener());return catalog;}
 subscribe(listener:()=>void){this.listeners.add(listener);if(!this.timer){void this.refresh().catch(()=>{});this.timer=setInterval(()=>{if(document.visibilityState==='visible')void this.refresh().catch(()=>{});},30000);}
  return ()=>{this.listeners.delete(listener);if(!this.listeners.size&&this.timer){clearInterval(this.timer);this.timer=null;}};}
}
const stores=new Map<string,LiveScreenText>();
export function liveScreenText(gateway:string){let store=stores.get(gateway);if(!store){store=new LiveScreenText(gateway);stores.set(gateway,store);}return store;}
