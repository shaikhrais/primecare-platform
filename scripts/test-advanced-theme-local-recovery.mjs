import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {runInNewContext} from 'node:vm';
const built=await build({entryPoints:['packages/primecare_ui/web/theme-library.ts'],bundle:true,platform:'node',format:'cjs',write:false});
const key='primecare-themes:v1:actor',copy='primecare-theme-restored:v1:actor:00000000-0000-4000-8000-000000000001';
function fixture(){const data=new Map([[key,'corrupt'],[copy,'corrupt copy'],['other-account','untouched']]),removed=[];let readDenied=false,keysDenied=false;
 const storage={get length(){return data.size;},key:i=>{if(keysDenied)throw Error('enumeration denied');return [...data.keys()][i]??null;},getItem:k=>{if(readDenied)throw Error('read denied');return data.get(k)??null;},setItem:(k,v)=>data.set(k,v),removeItem:k=>{removed.push(k);data.delete(k);}};
 const module={exports:{}};runInNewContext(built.outputFiles[0].text,{module,exports:module.exports,structuredClone,TextEncoder,Uint8Array,localStorage:storage});
 return {Library:module.exports.PersonalThemeLibrary,data,removed,set readDenied(v){readDenied=v;},set keysDenied(v){keysDenied=v;}};
}
for(const failure of ['read','enumeration'])test(`failed initial ${failure} cannot authorize deleting newly readable data`,()=>{
 const f=fixture();if(failure==='read')f.readDenied=true;else f.keysDenied=true;
 const library=new f.Library(key);assert.equal(library.recoveryRequired,true);f.readDenied=false;f.keysDenied=false;
 const before=[...f.data];assert.throws(()=>library.discardUnreadable(),/theme_changed_in_another_tab/);assert.deepEqual([...f.data],before);assert.deepEqual(f.removed,[]);
 // Reloading establishes an exact observation for the existing explicit recovery action.
 const reloaded=new f.Library(key);reloaded.discardUnreadable();assert.equal(f.data.has(key),false);assert.equal(f.data.get('other-account'),'untouched');
});
for(const change of ['update','delete','add'])test(`local recovery retains restore copies after external ${change}`,()=>{
 const f=fixture(),library=new f.Library(key);assert.equal(library.recoveryRequired,true);
 if(change==='update')f.data.set(copy,'newer copy');if(change==='delete')f.data.delete(copy);if(change==='add')f.data.set(copy+'-another','another copy');
 const before=[...f.data];assert.throws(()=>library.discardUnreadable(),/theme_changed_in_another_tab/);assert.deepEqual([...f.data],before);assert.deepEqual(f.removed,[]);assert.equal(library.recoveryRequired,true);
});
test('unchanged explicitly discarded local recovery removes only observed account records',()=>{
 const f=fixture(),library=new f.Library(key);library.discardUnreadable();assert.deepEqual(f.removed,[key,copy]);assert.equal(f.data.get('other-account'),'untouched');assert.equal(library.recoveryRequired,false);assert.equal(library.active,null);assert.equal(library.items.length,0);
});
test('external primary-library change blocks recovery before any copy deletion',()=>{
 const f=fixture(),library=new f.Library(key);f.data.set(key,'new library');const before=[...f.data];assert.throws(()=>library.discardUnreadable(),/theme_changed_in_another_tab/);assert.deepEqual([...f.data],before);assert.deepEqual(f.removed,[]);
});
const validRecord=JSON.stringify({version:1,active:null,items:[]});
for(const change of ['update','delete','add'])test(`restored library save retains a restore source after external ${change}`,()=>{
 const f=fixture();f.data.delete(key);f.data.set(copy,validRecord);const library=new f.Library(key);assert.equal(library.recoveryRequired,false);
 if(change==='update')f.data.set(copy,JSON.stringify({version:1,active:{version:1,name:'Newer theme',preset:'default',fontFamily:'system',fontScale:1,radius:12,colors:{}},items:[]}));
 if(change==='delete')f.data.delete(copy);if(change==='add')f.data.set(copy+'-another',validRecord);
 const before=[...f.data];assert.throws(()=>library.resetActive(),/theme_changed_in_another_tab/);assert.deepEqual([...f.data],before);assert.deepEqual(f.removed,[]);
});
test('initially empty library cannot shadow a newly restored account copy',()=>{
 const f=fixture();f.data.delete(key);f.data.delete(copy);const library=new f.Library(key);f.data.set(copy,validRecord);const before=[...f.data];assert.throws(()=>library.resetActive(),/theme_changed_in_another_tab/);assert.deepEqual([...f.data],before);
});
test('unchanged restored library may promote into primary storage and continue saving',()=>{
 const f=fixture();f.data.delete(key);f.data.set(copy,validRecord);const library=new f.Library(key);library.resetActive();assert.equal(f.data.get(key),validRecord);assert.equal(f.data.get(copy),validRecord);
 library.resetActive();assert.equal(f.data.get(key),validRecord);assert.equal(f.data.get('other-account'),'untouched');
});
