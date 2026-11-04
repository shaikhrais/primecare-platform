import {restoreCopyKeys} from './theme-restore-storage';
import {prepareStoredThemeMigration} from './advanced-theme-migration';
import {validatePersonalTheme,validateThemeLibrary,type PersonalTheme,type ThemeLibrary,type SavedTheme} from '../../domain/src/theme_center';
/** Secure UUID generation also supports previews where randomUUID is unavailable. */
function themeId():string {
 if(typeof crypto.randomUUID==='function')return crypto.randomUUID();
 const bytes=crypto.getRandomValues(new Uint8Array(16));
 bytes[6]=(bytes[6]&15)|64;bytes[8]=(bytes[8]&63)|128;
 const hex=Array.from(bytes,b=>b.toString(16).padStart(2,'0')).join('');
 return [hex.slice(0,8),hex.slice(8,12),hex.slice(12,16),hex.slice(16,20),hex.slice(20)].join('-');
}
/** One atomic local library record per authenticated account/role. */
export class PersonalThemeLibrary {
 private library:ThemeLibrary={version:1,active:null,items:[]};
 private unreadable=false;
 private restored=false;
 private baseline:string|null|undefined=undefined;
 constructor(private readonly key:string){try{
  const local=localStorage.getItem(key);this.baseline=local;const copies=restoreCopyKeys(localStorage,key);
  if(local===null&&copies.length>1)throw Error('Multiple restore copies require recovery');
  const raw=local??(copies.length===1?localStorage.getItem(copies[0]):null);
  this.restored=local===null&&raw!==null;
  if(raw!==null){if(new TextEncoder().encode(raw).length>65536)throw Error();this.library=validateThemeLibrary(JSON.parse(raw));}
 }catch{this.unreadable=true;}}

 prepareMigration() { return prepareStoredThemeMigration(localStorage, this.key); }
 get recoveryRequired():boolean{return this.unreadable;}
 /** Explicit scoped recovery only: never replace a record that could not be read. */
 discardUnreadable():void {if(!this.unreadable)throw Error('theme_recovery_not_required');if(this.baseline!==undefined&&localStorage.getItem(this.key)!==this.baseline)throw Error('theme_changed_in_another_tab');localStorage.removeItem(this.key);this.baseline=null;for(const key of restoreCopyKeys(localStorage,this.key))localStorage.removeItem(key);this.restored=false;this.library={version:1,active:null,items:[]};this.unreadable=false;}
 /** Serialize UI writes across cooperating tabs where Web Locks is available. */
 async withWriteLock(work:()=>void):Promise<void> {
  const locks=globalThis.navigator?.locks;
  if(!locks){work();return;}
  await locks.request('primecare-theme-library:'+this.key,{mode:'exclusive'},()=>{work();});
 }
 get active():PersonalTheme|null{return this.library.active?structuredClone(this.library.active):null;}get items():SavedTheme[]{return structuredClone(this.library.items);}
 private commit(next:ThemeLibrary):void {if(this.unreadable)throw Error('theme_recovery_required');const validated=validateThemeLibrary(next);if(localStorage.getItem(this.key)!==this.baseline)throw Error('theme_changed_in_another_tab');const serialized=JSON.stringify(validated);localStorage.setItem(this.key,serialized);this.baseline=serialized;this.restored=false;this.library=validated;}
 save(value:unknown,id?:string):string {const theme=validatePersonalTheme(value);const next=structuredClone(this.library);if(id&&!next.items.some(i=>i.id===id))throw Error('Theme no longer exists');if(next.items.some(i=>i.id!==id&&i.theme.name.toLowerCase()===theme.name.toLowerCase()))throw Error('Choose a unique theme name');const key=id??themeId();const index=next.items.findIndex(i=>i.id===key);if(index>=0)next.items[index]={id:key,theme};else next.items.push({id:key,theme});next.active=theme;this.commit(next);return key;}
 activate(id:string):PersonalTheme {const item=this.library.items.find(i=>i.id===id);if(!item)throw Error('Theme no longer exists');this.commit({...structuredClone(this.library),active:item.theme});return structuredClone(item.theme);}
 rename(id:string,name:string):void {const item=this.library.items.find(i=>i.id===id);if(!item)throw Error('Theme no longer exists');const next=structuredClone(this.library);const renamed=validatePersonalTheme({...item.theme,name});next.items=next.items.map(i=>i.id===id?{id,theme:renamed}:i);if(next.active?.name===item.theme.name)next.active=renamed;this.commit(next);}
 duplicate(id:string,name:string):string {const item=this.library.items.find(i=>i.id===id);if(!item)throw Error('Theme no longer exists');return this.save({...item.theme,name});}
 remove(id:string):void {if(!this.library.items.some(i=>i.id===id))throw Error('Theme no longer exists');const item=this.library.items.find(i=>i.id===id)!;this.commit({...structuredClone(this.library),active:this.library.active,items:this.library.items.filter(i=>i.id!==id)});}
 resetActive():void {this.commit({...structuredClone(this.library),active:null});}
 export(value:unknown):string {return JSON.stringify(validatePersonalTheme(value),null,2);}
 import(json:string):PersonalTheme {if(new TextEncoder().encode(json).length>16384)throw Error('Theme file is too large');return validatePersonalTheme(JSON.parse(json));}
}
