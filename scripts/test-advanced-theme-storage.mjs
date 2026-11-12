import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const bundle=await build({entryPoints:['packages/primecare_ui/web/advanced-theme-migration.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {prepareStoredThemeMigration}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
test('migration preserves the exact source and rejects conflicting or failed backups',()=>{
 const source=JSON.stringify({version:1,active:null,items:[]});
 const data=new Map([['primecare-themes:v1:actor',source],['other:themes','untouched']]);
 const storage={getItem:key=>data.get(key)??null,setItem:(key,value)=>data.set(key,value)};
 assert.equal(prepareStoredThemeMigration(storage,'primecare-themes:v1:actor').candidate.version,2);
 assert.equal(data.get('primecare-theme-migration-backup:v1:actor'),source);
 assert.equal(data.get('other:themes'),'untouched');
 data.set('primecare-theme-migration-backup:v1:actor','existing');
 assert.throws(()=>prepareStoredThemeMigration(storage,'primecare-themes:v1:actor'),/differs/);
 assert.equal(data.get('primecare-theme-migration-backup:v1:actor'),'existing');
 data.delete('primecare-theme-migration-backup:v1:actor');
 assert.throws(()=>prepareStoredThemeMigration({...storage,setItem(){throw Error('storage denied');}},'primecare-themes:v1:actor'),/denied/);
 assert.equal(data.get('primecare-themes:v1:actor'),source);
 assert.throws(()=>prepareStoredThemeMigration(storage,'unscoped'),/scope/);
});

test('the Theme Center library prepares an actor-scoped backup', async t => {
 const bundle = await build({entryPoints:['packages/primecare_ui/web/theme-library.ts'],bundle:true,platform:'node',format:'esm',write:false});
 const {PersonalThemeLibrary}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
 const data=new Map();
 const previous=Object.getOwnPropertyDescriptor(globalThis,'localStorage');
 Object.defineProperty(globalThis,'localStorage',{configurable:true,value:{
  getItem:key=>data.get(key)??null,setItem:(key,value)=>data.set(key,value),removeItem:key=>data.delete(key),
 }});
 t.after(()=>{if(previous)Object.defineProperty(globalThis,'localStorage',previous);else delete globalThis.localStorage;});
 const source='primecare-themes:v1:tenant-user-role';
 const backup='primecare-theme-migration-backup:v1:tenant-user-role';
 const library=new PersonalThemeLibrary(source);
 library.resetActive();
 const original=data.get(source);
 const prepared=library.prepareMigration();
 assert.equal(data.get(source),original);
 assert.equal(data.get(backup),original);
 assert.equal(prepared.candidate.version,2);
 assert.equal(prepared.requiresReview,true);
});

const advanced=await build({entryPoints:['packages/primecare_ui/web/advanced-theme.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {AdvancedThemeLibrary,defaultAdvancedTheme}=await import('data:text/javascript;base64,'+Buffer.from(advanced.outputFiles[0].text).toString('base64'));
const advancedId='00000000-0000-4000-8000-000000000001';
for(const action of ['save','apply','rename','remove'])for(const change of ['update','delete'])test(`advanced ${action} preserves an external ${change}`,()=>{
 const data=new Map(),port={getItem:k=>data.get(k)??null,setItem:(k,v)=>data.set(k,v)};
 const theme=defaultAdvancedTheme(),a=new AdvancedThemeLibrary('actor',port,()=>advancedId);a.save(theme);
 const b=new AdvancedThemeLibrary('actor',port,()=>advancedId);
 if(change==='update')a.apply({...theme,name:'Newer active'});else data.delete(a.key);
 const stored=data.get(a.key),before=b.current;
 const mutate={save:()=>b.save({...theme,name:'Stale save'},advancedId),apply:()=>b.apply(theme),rename:()=>b.rename(advancedId,'Stale rename'),remove:()=>b.remove(advancedId)};
 assert.throws(mutate[action],/theme_changed_in_another_tab/);assert.equal(data.get(a.key),stored);assert.deepEqual(b.current,before);
});
test('advanced empty storage is invalid and is never overwritten',()=>{
 const key='primecare.advanced-theme.v2:actor',data=new Map([[key,'']]);let writes=0;
 assert.throws(()=>new AdvancedThemeLibrary('actor',{getItem:k=>data.get(k)??null,setItem(){writes++;}}));assert.equal(writes,0);assert.equal(data.get(key),'');
});
test('advanced failed storage keeps baseline and in-memory state retryable',()=>{
 const data=new Map();let denied=false;
 const port={getItem:k=>data.get(k)??null,setItem:(k,v)=>{if(denied)throw Error('denied');data.set(k,v);}};
 const a=new AdvancedThemeLibrary('actor',port,()=>advancedId),theme=defaultAdvancedTheme();a.save(theme);const before=a.current,stored=data.get(a.key);
 denied=true;assert.throws(()=>a.apply(theme),/denied/);assert.deepEqual(a.current,before);assert.equal(data.get(a.key),stored);
 denied=false;a.apply(theme);assert.deepEqual(a.current.active,theme);a.rename(advancedId,'Renamed');assert.equal(a.current.items[0].theme.name,'Renamed');
});
test('advanced initially empty editor preserves a library created by another editor',()=>{
 const data=new Map(),port={getItem:k=>data.get(k)??null,setItem:(k,v)=>data.set(k,v)},theme=defaultAdvancedTheme();
 const a=new AdvancedThemeLibrary('actor',port,()=>advancedId),b=new AdvancedThemeLibrary('actor',port,()=>advancedId);
 a.save(theme);const stored=data.get(a.key);assert.throws(()=>b.apply(theme),/theme_changed_in_another_tab/);assert.equal(data.get(a.key),stored);assert.deepEqual(b.current,{version:2,active:null,items:[]});
});
test('advanced preflight storage failure retains state and permits explicit retry',()=>{
 const data=new Map();let denied=false;const port={getItem:k=>{if(denied)throw Error('read denied');return data.get(k)??null;},setItem:(k,v)=>data.set(k,v)};
 const a=new AdvancedThemeLibrary('actor',port,()=>advancedId),theme=defaultAdvancedTheme();a.save(theme);const before=a.current,stored=data.get(a.key);
 denied=true;assert.throws(()=>a.apply(theme),/read denied/);assert.deepEqual(a.current,before);assert.equal(data.get(a.key),stored);denied=false;a.apply(theme);assert.deepEqual(a.current.active,theme);
});
