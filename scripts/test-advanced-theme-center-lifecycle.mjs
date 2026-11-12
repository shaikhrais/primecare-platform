import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {parseHTML} from 'linkedom';
const bundle=await build({entryPoints:['packages/primecare_ui/web/theme-center.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {mountThemeCenter}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const initial={version:1,name:'At save click',preset:'default',fontFamily:'system',fontScale:1,radius:12,colors:{}};
const tick=()=>new Promise(r=>setImmediate(r));
function fixture(t){
 const {document,window}=parseHTML('<html><head></head><body><dialog><h2></h2><form></form></dialog></body></html>');
 // Supply the standard writable select value property missing from this source-test DOM.
 Object.defineProperty(window.HTMLSelectElement.prototype,'value',{configurable:true,get(){return this.getAttribute('data-test-value')??this.querySelector('option[selected]')?.value??this.querySelector('option')?.value??'';},set(v){this.setAttribute('data-test-value',v);}});
 const previous=Object.getOwnPropertyDescriptor(globalThis,'document');Object.defineProperty(globalThis,'document',{configurable:true,value:document});t.after(()=>{if(previous)Object.defineProperty(globalThis,'document',previous);else delete globalThis.document;});
 const dialog=document.querySelector('dialog');let current=true,release,generation=0;const calls=[],locked=new Promise(r=>release=r);
 const manager={personalTheme:structuredClone(initial),setPersonalTheme(v){this.personalTheme=v;generation++;calls.push(['preview',v]);}};
 const library={items:[],active:null,recoveryRequired:false,withWriteLock:async work=>{await locked;work();},save(v){calls.push(['save',v]);this.active=v;return 'id';},import(text){return JSON.parse(text);}};
 mountThemeCenter(dialog,manager,library,'en',()=>current,()=>generation);
 return {dialog,manager,calls,release,set current(v){current=v;},el:id=>dialog.querySelector(`[data-cy=${id}]`)};
}
test('pending import cannot replace draft while a save waits for its lock',async t=>{
 const f=fixture(t),file=f.el('theme-center-import');let finish;
 Object.defineProperty(file,'files',{value:[{size:100,text:()=>new Promise(r=>finish=r)}]});const importing=file.onchange();
 f.el('theme-center-new').onclick();finish(JSON.stringify({...initial,name:'Late imported draft'}));await importing;
 assert.equal(f.el('theme-center-name').value,initial.name);f.release();await tick();await tick();
 assert.equal(f.calls.find(c=>c[0]==='save')[1].name,initial.name);
});
test('busy save ignores quick palettes and draft preview callbacks',async t=>{
 const f=fixture(t);f.el('theme-center-new').onclick();const before=f.manager.personalTheme;
 f.el('theme-quick-blue').onclick();f.el('theme-center-scale').value='1.5';f.el('theme-center-scale').onchange();
 assert.equal(f.el('theme-center-name').value,initial.name);assert.deepEqual(f.manager.personalTheme,before);f.release();await tick();await tick();
});
test('late lock completion cannot re-enable controls in a stale host',async t=>{
 const f=fixture(t),save=f.el('theme-center-new');save.onclick();assert.equal(save.disabled,true);f.current=false;f.release();await tick();await tick();assert.equal(save.disabled,true);assert.equal(f.calls.length,0);
});

test('successful locked save restores controls after its own presentation revision',async t=>{
 const f=fixture(t),save=f.el('theme-center-new');save.onclick();f.release();await tick();await tick();assert.equal(save.disabled,false);assert.equal(f.calls.filter(c=>c[0]==='save').length,1);assert.equal(f.el('theme-center-status').value,'Saved on this browser.');
});
