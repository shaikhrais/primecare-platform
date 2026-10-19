import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
const {outputFiles}=await build({entryPoints:['websites/typescript/src/screen-text.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {LiveScreenText}=await import('data:text/javascript;base64,'+Buffer.from(outputFiles[0].text).toString('base64'));

test('downloaded JSON survives restart offline; refresh is explicit and scoped to gateway',async()=>{
 const saved=new Map();globalThis.localStorage={getItem:key=>saved.get(key)??null,setItem:(key,value)=>saved.set(key,value)};
 globalThis.sessionStorage={getItem:()=>null};
 let requests=0,version=0,offline=false;
 globalThis.fetch=async url=>{requests++;if(offline)throw Error('offline');return {ok:true,json:async()=>String(url).endsWith('/screen-text')?{screens:[{id:'fixture',version}]}:{screen:'fixture',version,locales:{en:{title:'English '+version},fr:{title:'Français '+version},es:{title:'Español '+version}}}};};
 const first=new LiveScreenText('https://one');await first.initialize();assert.equal(requests,2);assert.equal(first.text('fixture','fr','title','Fallback'),'Français 0');
 const encoded=[...saved.values()][0];assert.deepEqual(Object.keys(JSON.parse(encoded)).sort(),['catalogs','edited','format','history']);assert.ok(!encoded.includes('authorization'));
 requests=0;offline=true;const restarted=new LiveScreenText('https://one');const stop=restarted.subscribe(()=>{});await restarted.initialize();assert.equal(requests,0);assert.equal(restarted.text('fixture','es','title','Fallback'),'Español 0');stop();
 const edited={en:{title:'Local'},fr:{title:'Locale'},es:{title:'Local'}};restarted.saveLocal('fixture',0,edited);assert.equal(requests,0);const localRestart=new LiveScreenText('https://one');await localRestart.initialize();assert.equal(requests,0);assert.equal(localRestart.text('fixture','fr','title','Fallback'),'Locale');assert.equal(localRestart.localHistory('fixture').length,1);
 await assert.rejects(restarted.refresh());assert.equal(restarted.text('fixture','en','title','Fallback'),'Local');
 offline=false;version=1;await restarted.refresh();assert.equal(restarted.text('fixture','en','title','Fallback'),'English 1');
 const other=new LiveScreenText('https://other');assert.equal(other.text('fixture','en','title','Fallback'),'Fallback');
 const cached=new LiveScreenText('https://one');assert.equal(cached.text('fixture','fr','title','Fallback'),'Français 1');const competing=new LiveScreenText('https://one');cached.saveLocal('fixture',1,edited);assert.throws(()=>competing.saveLocal('fixture',1,edited),error=>error.status===409);assert.equal(cached.localHistory('fixture').length,2);
});

test('corrupt or unavailable local storage does not break fallback/download',async()=>{
 globalThis.sessionStorage={getItem:()=>null};globalThis.localStorage={getItem:()=>'{invalid',setItem:()=>{throw Error('full');}};
 globalThis.fetch=async url=>({ok:true,json:async()=>String(url).endsWith('/screen-text')?{screens:[{id:'fixture',version:0}]}:{screen:'fixture',version:0,locales:{en:{title:'Downloaded'},fr:{title:'Téléchargé'},es:{title:'Descargado'}}}});
 const store=new LiveScreenText('https://one');assert.equal(store.text('fixture','en','title','Fallback'),'Fallback');await store.initialize();assert.equal(store.text('fixture','en','title','Fallback'),'Downloaded');assert.throws(()=>store.saveLocal('fixture',0,{en:{title:'Edit'},fr:{title:'Édité'},es:{title:'Editado'}}),/Local storage/);assert.equal(store.text('fixture','en','title','Fallback'),'Downloaded');assert.equal(store.localHistory('fixture').length,0);
});
