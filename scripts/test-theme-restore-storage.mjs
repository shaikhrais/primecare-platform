import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const result=await build({entryPoints:['packages/primecare_ui/web/theme-restore-storage.ts','packages/primecare_ui/web/theme-library.ts','packages/domain/src/theme_center.ts'],bundle:true,platform:'node',format:'esm',outdir:'out',write:false});
const load=async name=>import('data:text/javascript;base64,'+Buffer.from(result.outputFiles.find(f=>f.path.endsWith('/'+name+'.js')).text).toString('base64'));
const {storeRestoreCopy,restoreCopyKeys,themeLibraryAbsent}=await load('theme-restore-storage');
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
