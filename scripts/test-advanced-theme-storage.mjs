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
