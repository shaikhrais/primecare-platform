import test from 'node:test';
import assert from 'node:assert/strict';
import {webcrypto} from 'node:crypto';
import {runInNewContext} from 'node:vm';
import {build} from 'esbuild';
const built=await build({entryPoints:['websites/typescript/src/theme-library.ts'],bundle:true,platform:'node',format:'cjs',write:false});
function environment(){
 const records=new Map();let unavailable=false;
 const module={exports:{}};
 runInNewContext(built.outputFiles[0].text,{module,exports:module.exports,structuredClone,TextEncoder,Uint8Array,crypto:{getRandomValues:bytes=>webcrypto.getRandomValues(bytes)},localStorage:{getItem:key=>records.get(key)??null,setItem:(key,value)=>{if(unavailable)throw Error('Storage unavailable');records.set(key,value);}}});
 return {Library:module.exports.PersonalThemeLibrary,fail:()=>{unavailable=true;}};
}
const theme={version:1,name:'Original theme',preset:'default',fontFamily:'system',fontScale:1,radius:16,colors:{}};
test('Secure fallback IDs support save/reload, rename, duplication, deletion and account isolation',()=>{
 const {Library}=environment(),first=new Library('account-a');
 const id=first.save(theme);assert.match(id,/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/);
 first.rename(id,'Renamed');const duplicate=first.duplicate(id,'Copy');assert.notEqual(id,duplicate);
 const restored=new Library('account-a');assert.equal(restored.items.length,2);assert.equal(restored.active.radius,16);
 assert.equal(new Library('account-b').items.length,0);
 restored.remove(id);assert.equal(restored.items.length,1);restored.resetActive();assert.equal(restored.active,null);
});
test('Failed writes and invalid settings do not change the saved library',()=>{
 const {Library,fail}=environment(),store=new Library('account');store.save(theme);fail();
 assert.throws(()=>store.save({...theme,name:'Unsaved'}));assert.equal(store.items.length,1);
 assert.throws(()=>store.import(JSON.stringify({...theme,role:'administrator'})));
 assert.equal(new Library('account').active.name,'Original theme');
});
