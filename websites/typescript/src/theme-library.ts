import {validatePersonalTheme,validateThemeLibrary,type PersonalTheme,type ThemeLibrary,type SavedTheme} from '../../../packages/domain/src/theme_center';
/** One atomic local library record per authenticated account/role. */
export class PersonalThemeLibrary {
 private library:ThemeLibrary={version:1,active:null,items:[]};
 constructor(private readonly key:string){try{const raw=localStorage.getItem(key);if(raw){if(raw.length>65536)throw Error();this.library=validateThemeLibrary(JSON.parse(raw));}}catch{/* Invalid or unavailable storage never applies unvalidated themes. */}}
 get active():PersonalTheme|null{return this.library.active?structuredClone(this.library.active):null;}get items():SavedTheme[]{return structuredClone(this.library.items);}
 private commit(next:ThemeLibrary):void {const validated=validateThemeLibrary(next);localStorage.setItem(this.key,JSON.stringify(validated));this.library=validated;}
 save(value:unknown,id?:string):string {const theme=validatePersonalTheme(value);const next=structuredClone(this.library);if(id&&!next.items.some(i=>i.id===id))throw Error('Theme no longer exists');if(next.items.some(i=>i.id!==id&&i.theme.name.toLowerCase()===theme.name.toLowerCase()))throw Error('Choose a unique theme name');const key=id??crypto.randomUUID();const index=next.items.findIndex(i=>i.id===key);if(index>=0)next.items[index]={id:key,theme};else next.items.push({id:key,theme});next.active=theme;this.commit(next);return key;}
 activate(id:string):PersonalTheme {const item=this.library.items.find(i=>i.id===id);if(!item)throw Error('Theme no longer exists');this.commit({...structuredClone(this.library),active:item.theme});return structuredClone(item.theme);}
 rename(id:string,name:string):void {const item=this.library.items.find(i=>i.id===id);if(!item)throw Error('Theme no longer exists');const next=structuredClone(this.library);const renamed=validatePersonalTheme({...item.theme,name});next.items=next.items.map(i=>i.id===id?{id,theme:renamed}:i);if(next.active?.name===item.theme.name)next.active=renamed;this.commit(next);}
 duplicate(id:string,name:string):string {const item=this.library.items.find(i=>i.id===id);if(!item)throw Error('Theme no longer exists');return this.save({...item.theme,name});}
 remove(id:string):void {if(!this.library.items.some(i=>i.id===id))throw Error('Theme no longer exists');const item=this.library.items.find(i=>i.id===id)!;this.commit({...structuredClone(this.library),active:this.library.active,items:this.library.items.filter(i=>i.id!==id)});}
 resetActive():void {this.commit({...structuredClone(this.library),active:null});}
 export(value:unknown):string {return JSON.stringify(validatePersonalTheme(value),null,2);}
 import(json:string):PersonalTheme {if(new TextEncoder().encode(json).length>16384)throw Error('Theme file is too large');return validatePersonalTheme(JSON.parse(json));}
}
