export type Catalog={screen:string;version:number;locales:Record<string,Record<string,string>>};

const parameters=(text:string)=>JSON.stringify([...text.matchAll(/\{([A-Za-z][A-Za-z0-9_]*)\}/g)].map(m=>m[1]).sort());
export function validTextCatalog(value:unknown):value is Catalog {
 if(!value||typeof value!=='object')return false;
 const c=value as Catalog;
 if(typeof c.screen!=='string'||!/^[a-z][a-z0-9_]{0,79}$/.test(c.screen)||!Number.isSafeInteger(c.version)||c.version<0||!c.locales)return false;
 const keys=Object.keys(c.locales.en??{}).sort();if(!keys.length)return false;
 return ['en','fr','es'].every(language=>{
  const entries=c.locales[language];return entries&&typeof entries==='object'&&!Array.isArray(entries)&&JSON.stringify(Object.keys(entries).sort())===JSON.stringify(keys)&&Object.values(entries).every(text=>typeof text==='string'&&text.trim().length>0&&text.length<=2000)&&keys.every(key=>parameters(entries[key])===parameters(c.locales.en[key]));
 });
}

const validHistory=(h:any)=>h&&typeof h.created_at==='string'&&Number.isSafeInteger(h.version)&&validTextCatalog({screen:h.screen,version:h.version,locales:h.locales})&&validTextCatalog({screen:h.screen,version:h.version,locales:h.previous_locales});

/** Download once, keep JSON in local device storage, update only on request. */
export class LiveScreenText {
 private catalogs=new Map<string,Catalog>();private listeners=new Set<()=>void>();private initializing:Promise<void>|null=null;private refreshing:Promise<void>|null=null;private edited=new Set<string>();private history:any[]=[];
 private get cacheKey(){return 'primecare.screen-text.v1.'+encodeURIComponent(this.gateway.replace(/\/+$/,''));}
 constructor(readonly gateway:string){
  try{const encoded=localStorage.getItem(this.cacheKey);if(!encoded||encoded.length>4000000)return;const data=JSON.parse(encoded);if(data.format!==1||!Array.isArray(data.catalogs)||data.catalogs.length>500)return;for(const catalog of data.catalogs)if(validTextCatalog(catalog))this.catalogs.set(catalog.screen,catalog);if(Array.isArray(data.edited))for(const screen of data.edited)if(typeof screen==='string'&&this.catalogs.has(screen))this.edited.add(screen);if(Array.isArray(data.history))this.history=data.history.slice(-50).filter(validHistory);}catch{/* Unavailable or corrupt local storage falls back to bundled text. */}
 }
 private persist(required=false){try{let data=JSON.stringify({format:1,catalogs:[...this.catalogs.values()],edited:[...this.edited],history:this.history});while(data.length>4000000&&this.history.length){this.history.shift();data=JSON.stringify({format:1,catalogs:[...this.catalogs.values()],edited:[...this.edited],history:this.history});}if(data.length>4000000)throw Error('Local storage limit exceeded');localStorage.setItem(this.cacheKey,data);}catch{if(required)throw Error('Local storage unavailable');}}
 private url(path=''){return this.gateway.replace(/\/+$/,'')+'/v1/governance/screen-text'+path;}
 async request(path='',method='GET',body?:unknown):Promise<any>{
  const headers:Record<string,string>={};const token=sessionStorage.getItem('primecare_session');if(token)headers.authorization='Bearer '+token;
  if(body)headers['content-type']='application/json';
  const response=await fetch(this.url(path),{method,headers,cache:'no-store',...(body?{body:JSON.stringify(body)}:{})});
  const data=await response.json();if(!response.ok)throw Object.assign(new Error(data.error??'Text request failed'),{status:response.status});
  if(/^\/[a-z][a-z0-9_]{0,79}$/.test(path)&&['GET','PUT'].includes(method)){
   if(!validTextCatalog(data)||data.screen!==path.slice(1))throw Error('Invalid text catalog');this.catalogs.set(data.screen,data);this.edited.delete(data.screen);this.persist();
  }
  return data;
 }
 initialize():Promise<void>{return this.initializing??=this.catalogs.size?Promise.resolve():this.refresh();}
 refresh():Promise<void>{if(this.refreshing)return this.refreshing;return this.refreshing=this.download().finally(()=>{this.refreshing=null;});}
 private async download():Promise<void>{
  const manifest=await this.request();if(!Array.isArray(manifest.screens)||manifest.screens.length>500)throw Error('Invalid text manifest');let changed=false;
  try{for(const row of manifest.screens){if(typeof row.id!=='string'||!/^[a-z][a-z0-9_]{0,79}$/.test(row.id)||!Number.isSafeInteger(row.version)||row.version<0)throw Error('Invalid text manifest');if(this.catalogs.get(row.id)?.version===row.version&&!this.edited.has(row.id))continue;
   await this.request('/'+row.id);changed=true;}}
  finally{if(changed)this.listeners.forEach(listener=>listener());}
 }
 availableScreens(){return [...this.catalogs.keys()].sort();}
 catalog(screen:string):Catalog{const catalog=this.catalogs.get(screen);if(!catalog)throw Error('Missing local catalog');return structuredClone(catalog);}
 seed(defaults:Record<string,Catalog['locales']>){for(const [screen,locales] of Object.entries(defaults)){const catalog={screen,version:0,locales};if(!this.catalogs.has(screen)&&validTextCatalog(catalog))this.catalogs.set(screen,structuredClone(catalog));}this.persist();}
 localHistory(screen:string){return structuredClone(this.history.filter(h=>h.screen===screen).slice().reverse());}
 saveLocal(screen:string,version:number,locales:Catalog['locales']):Catalog{
  const current=this.catalog(screen);let disk:Catalog|undefined;try{const data=JSON.parse(localStorage.getItem(this.cacheKey)??'{}');if(data.format===1&&Array.isArray(data.catalogs)&&data.catalogs.length<=500){disk=data.catalogs.find((c:unknown)=>validTextCatalog(c)&&c.screen===screen);for(const c of data.catalogs)if(validTextCatalog(c))this.catalogs.set(c.screen,c);if(Array.isArray(data.history))this.history=data.history.slice(-50).filter(validHistory);if(Array.isArray(data.edited))this.edited=new Set(data.edited.filter((s:unknown)=>typeof s==='string'&&this.catalogs.has(s)));}}catch{}if(disk&&(disk.version!==current.version||JSON.stringify(disk.locales)!==JSON.stringify(current.locales))){this.catalogs.set(screen,disk);throw Object.assign(Error('Local text changed'),{status:409});}if(current.version!==version)throw Object.assign(Error('Local text changed'),{status:409});
  const next=Math.max(version,...this.history.filter(h=>h.screen===screen).map(h=>h.version))+1;
  const catalog={screen,version:next,locales:structuredClone(locales)};if(!validTextCatalog(catalog)||JSON.stringify(Object.keys(locales.en).sort())!==JSON.stringify(Object.keys(current.locales.en).sort()))throw Error('Invalid local text');if(Object.keys(locales.en).some(key=>parameters(locales.en[key])!==parameters(current.locales.en[key])))throw Error('Text parameters differ');
  const oldHistory=[...this.history],wasEdited=this.edited.has(screen);this.history.push({screen,version:next,actor_id:'device',created_at:new Date().toISOString(),previous_locales:structuredClone(current.locales),locales:catalog.locales});this.history=this.history.slice(-50);
  this.catalogs.set(screen,catalog);this.edited.add(screen);try{this.persist(true);}catch(error){this.catalogs.set(screen,current);this.history=oldHistory;if(!wasEdited)this.edited.delete(screen);throw error;}this.listeners.forEach(listener=>listener());return structuredClone(catalog);
 }
 text(screen:string,language:string,key:string,fallback:string){const value=this.catalogs.get(screen)?.locales[language]?.[key];return typeof value==='string'?value:fallback;}
 async save(screen:string,version:number,locales:Catalog['locales']):Promise<Catalog>{const catalog=await this.request('/'+screen,'PUT',{version,locales});this.listeners.forEach(listener=>listener());return catalog;}
 subscribe(listener:()=>void){this.listeners.add(listener);void this.initialize().catch(()=>{});return ()=>{this.listeners.delete(listener);};}
}
const stores=new Map<string,LiveScreenText>();
export function liveScreenText(gateway:string){let store=stores.get(gateway);if(!store){store=new LiveScreenText(gateway);stores.set(gateway,store);}return store;}
