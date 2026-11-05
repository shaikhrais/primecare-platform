import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const result=await build({entryPoints:['packages/primecare_ui/web/theme-restore-storage.ts','packages/primecare_ui/web/theme-library.ts','packages/domain/src/theme_center.ts'],bundle:true,platform:'node',format:'esm',outdir:'out',write:false});
const load=async name=>import('data:text/javascript;base64,'+Buffer.from(result.outputFiles.find(f=>f.path.endsWith('/'+name+'.js')).text).toString('base64'));
const {storeRestoreCopy,restoreCopyKeys,themeLibraryAbsent,withThemeLibraryLock}=await load('theme-restore-storage');
const {PersonalThemeLibrary}=await load('theme-library');
const {defaultPersonalTheme}=await load('theme_center');
class MemoryStorage {
 data=new Map();get length(){return this.data.size;}key(i){return [...this.data.keys()][i]??null;}
 getItem(k){return this.data.get(k)??null;}setItem(k,v){this.data.set(k,String(v));}removeItem(k){this.data.delete(k);}
}
const key='primecare-themes:v1:actor-a',other='primecare-themes:v1:actor-b';
const ids=['00000000-0000-4000-8000-000000000001','00000000-0000-4000-8000-000000000002'];
const theme={...defaultPersonalTheme,name:'Account theme'},document=JSON.stringify({version:1,active:theme,items:[{id:ids[0],theme}]});
test('restore uses a scoped copy and never overwrites an existing local library',()=>{
 const storage=new MemoryStorage();globalThis.localStorage=storage;
 const copy=storeRestoreCopy(storage,key,document,ids[0]);assert.equal(storage.getItem(key),null);assert.equal(storage.getItem(copy),document);
 assert.equal(new PersonalThemeLibrary(key).active.name,'Account theme');assert.equal(themeLibraryAbsent(storage,other),true);
 const editor=new PersonalThemeLibrary(key);const local=JSON.stringify({version:1,active:{...theme,name:'Other tab'},items:[]});storage.setItem(key,local);
 assert.throws(()=>editor.save({...theme,name:'New'}),/another_tab/);assert.equal(storage.getItem(key),local);assert.equal(storage.getItem(copy),document);
 assert.equal(new PersonalThemeLibrary(key).active.name,'Other tab');
});
test('multiple simultaneous restore copies are retained and require explicit recovery',()=>{
 const storage=new MemoryStorage();globalThis.localStorage=storage;
 const copy=storeRestoreCopy(storage,key,document,ids[0]);const second=copy.slice(0,-36)+ids[1];storage.setItem(second,document);
 assert.equal(restoreCopyKeys(storage,key).length,2);const library=new PersonalThemeLibrary(key);assert.equal(library.recoveryRequired,true);
 assert.throws(()=>library.save(theme),/recovery/);assert.equal(storage.getItem(copy),document);assert.equal(storage.getItem(second),document);
 assert.throws(()=>storeRestoreCopy(storage,key,document,'bad'));library.discardUnreadable();assert.equal(restoreCopyKeys(storage,key).length,0);
});

test('a stale editor cannot replace a theme saved by another tab',()=>{
 const storage=new MemoryStorage();globalThis.localStorage=storage;storage.setItem(key,document);
 const first=new PersonalThemeLibrary(key),second=new PersonalThemeLibrary(key);
 first.rename(ids[0],'Newer');const newer=storage.getItem(key);
 assert.throws(()=>second.rename(ids[0],'Stale'),/another_tab/);assert.equal(storage.getItem(key),newer);
 assert.equal(new PersonalThemeLibrary(key).items[0].theme.name,'Newer');
});
test('recovery refuses to erase a library that changed after it became unreadable',()=>{
 const storage=new MemoryStorage();globalThis.localStorage=storage;storage.setItem(key,'broken');
 const editor=new PersonalThemeLibrary(key);storage.setItem(key,document);
 assert.throws(()=>editor.discardUnreadable(),/another_tab/);assert.equal(storage.getItem(key),document);
});

test('cooperating writers serialize and a stale writer is rejected',async(t)=>{
 const storage=new MemoryStorage();globalThis.localStorage=storage;storage.setItem(key,document);
 const prior=Object.getOwnPropertyDescriptor(globalThis,'navigator');let tail=Promise.resolve(),calls=[];
 Object.defineProperty(globalThis,'navigator',{configurable:true,value:{locks:{request(name,options,work){calls.push({name,options});const task=tail.then(work);tail=task.catch(()=>{});return task;}}}});
 t.after(()=>{if(prior)Object.defineProperty(globalThis,'navigator',prior);else delete globalThis.navigator;});
 const first=new PersonalThemeLibrary(key),second=new PersonalThemeLibrary(key);
 const result=await Promise.allSettled([first.withWriteLock(()=>first.rename(ids[0],'First')),second.withWriteLock(()=>second.rename(ids[0],'Second'))]);
 assert.equal(result[0].status,'fulfilled');assert.equal(result[1].status,'rejected');
 assert.equal(new PersonalThemeLibrary(key).items[0].theme.name,'First');
 assert.deepEqual(calls,[{name:'primecare-theme-library:'+key,options:{mode:'exclusive'}},{name:'primecare-theme-library:'+key,options:{mode:'exclusive'}}]);
});

test('competing restore copies use the same account lock',async(t)=>{
 const storage=new MemoryStorage();globalThis.localStorage=storage;const prior=Object.getOwnPropertyDescriptor(globalThis,'navigator');let tail=Promise.resolve();
 Object.defineProperty(globalThis,'navigator',{configurable:true,value:{locks:{request(name,options,work){const task=tail.then(work);tail=task.catch(()=>{});return task;}}}});
 t.after(()=>{if(prior)Object.defineProperty(globalThis,'navigator',prior);else delete globalThis.navigator;});
 const result=await Promise.allSettled([withThemeLibraryLock(key,()=>storeRestoreCopy(storage,key,document,ids[0])),withThemeLibraryLock(key,()=>storeRestoreCopy(storage,key,document,ids[1]))]);
 assert.equal(result[0].status,'fulfilled');assert.equal(result[1].status,'rejected');assert.equal(restoreCopyKeys(storage,key).length,1);
});
test('missing browser locking primitives fail closed',async(t)=>{
 const priorNav=Object.getOwnPropertyDescriptor(globalThis,'navigator'),priorIdb=Object.getOwnPropertyDescriptor(globalThis,'indexedDB');
 Object.defineProperty(globalThis,'navigator',{configurable:true,value:{}});Object.defineProperty(globalThis,'indexedDB',{configurable:true,value:undefined});
 t.after(()=>{if(priorNav)Object.defineProperty(globalThis,'navigator',priorNav);else delete globalThis.navigator;if(priorIdb)Object.defineProperty(globalThis,'indexedDB',priorIdb);else delete globalThis.indexedDB;});
 let executed=false;await assert.rejects(withThemeLibraryLock(key,()=>{executed=true;}),/theme_lock_unavailable/);assert.equal(executed,false);
});
