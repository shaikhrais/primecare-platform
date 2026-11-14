import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';

const built=await build({stdin:{contents:`export {AdvancedThemeEditor} from './packages/primecare_ui/web/advanced-theme-editor';export * from './packages/primecare_ui/web/advanced-theme';`,resolveDir:process.cwd()},bundle:true,platform:'node',format:'esm',write:false});
const api=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const deferred=()=>{let resolve;const promise=new Promise(done=>resolve=done);return {promise,resolve};};
const settle=async()=>{for(let i=0;i<6;i++)await Promise.resolve();};
function fixture(){
 const {document,window,Event}=parseHTML('<html><head></head><body><main id="editor"></main></body></html>');
 const prior=globalThis.HTMLSelectElement;globalThis.HTMLSelectElement=window.HTMLSelectElement;
 // Linkedom lacks these browser DOM properties; supply only their standard behavior.
 const descriptor=Object.getOwnPropertyDescriptor(window.HTMLSelectElement.prototype,'value');
 if(!descriptor?.set)Object.defineProperty(window.HTMLSelectElement.prototype,'value',{configurable:true,get:descriptor.get,set(value){for(const option of this.options)option.selected=option.value===value;}});
 const style=document.createElement('span').style;
 if(!style.getPropertyPriority)Object.getPrototypeOf(style).getPropertyPriority=()=>'';
 const records=new Map(),scope='theme-import-fixture';let id=0,applies=0;
 const library=new api.AdvancedThemeLibrary(scope,{getItem:key=>records.get(key)??null,setItem:(key,value)=>records.set(key,value)},()=>`00000000-0000-4000-8000-${String(++id).padStart(12,'0')}`);
 const labels=Object.fromEntries(['saved','preview','configuration','apply','save','update','rename','duplicate','remove','reset','copy','import','export','success','error','empty'].map(k=>[k,k]));
 const root=document.getElementById('editor'),schema=[{id:'fixture-name',label:'Theme name',path:'name',when:null}];
 const options={scope,schema,allowedIds:['fixture-name'],labels,optionLabels:Object.fromEntries(['primary','secondary','success','warning','error','info'].map(k=>[k,k])),regionLabels:Object.fromEntries(api.themeRegions.map(k=>[k,k])),library,onApply:()=>applies++,onLegacy:()=>{},copyText:async()=>{},download:()=>{}};const editor=new api.AdvancedThemeEditor(root,options);
 const file=root.querySelector('[data-theme-import]');
 return {root,Event,editor,library,records,options,applies:()=>applies,
  draft:()=>JSON.parse(root.querySelector('[data-theme-configuration]').textContent),
  import:promise=>{Object.defineProperty(file,'files',{configurable:true,value:[{size:100,text:()=>promise}]});file.dispatchEvent(new Event('change'));},
  theme:name=>JSON.stringify(api.patchTheme(api.defaultAdvancedTheme(),'name',name)),
  dispose(){editor.dispose();library.dispose();if(prior===undefined)delete globalThis.HTMLSelectElement;else globalThis.HTMLSelectElement=prior;}};
}
test('newest theme import wins when older file reads finish last',async()=>{
 const f=fixture(),old=deferred(),latest=deferred();
 try{f.import(old.promise);f.import(latest.promise);latest.resolve(f.theme('Latest selected theme'));await settle();assert.equal(f.draft().name,'Latest selected theme');old.resolve(f.theme('Old selected theme'));await settle();assert.equal(f.draft().name,'Latest selected theme');assert.equal(f.applies(),0);assert.equal(f.records.size,0);}finally{f.dispose();}
});
test('a later manual draft edit survives a pending file read',async()=>{
 const f=fixture(),read=deferred();
 try{f.import(read.promise);const name=f.root.querySelector('[data-theme-field="fixture-name"]');name.value='Newer manual choice';name.dispatchEvent(new f.Event('change'));read.resolve(f.theme('Earlier file choice'));await settle();assert.equal(f.draft().name,'Newer manual choice');assert.equal(f.records.size,0);}finally{f.dispose();}
});
test('disposed editor cannot apply a late import to its replacement',async()=>{
 const f=fixture(),read=deferred();f.import(read.promise);f.editor.dispose();const replacement=f.root.ownerDocument.createElement('p');replacement.textContent='Replacement owner';f.root.append(replacement);read.resolve(f.theme('Retired file'));await settle();assert.equal(f.root.textContent,'Replacement owner');assert.equal(f.applies(),0);f.dispose();
});

test('reset cancels an older import instead of silently replacing the reset draft',async()=>{
 const f=fixture(),read=deferred();
 try{f.import(read.promise);f.root.querySelector('[data-theme-action="reset"]').click();await settle();const reset=f.draft();read.resolve(f.theme('Obsolete file'));await settle();assert.deepEqual(f.draft(),reset);assert.equal(f.library.current.active,null);assert.equal(f.applies(),1);}finally{f.dispose();}
});

test('caller options cannot redirect saves to a different actor library',async()=>{
 const f=fixture(),otherRecords=new Map(),other=new api.AdvancedThemeLibrary('other-actor',{getItem:k=>otherRecords.get(k)??null,setItem:(k,v)=>otherRecords.set(k,v)},()=> '00000000-0000-4000-8000-000000000099');
 try{f.options.library=other;f.root.querySelector('[data-theme-action="save"]').click();await settle();assert.equal(f.library.current.items.length,1);assert.equal(other.current.items.length,0);assert.equal(otherRecords.size,0);}finally{f.dispose();other.dispose();}
});
test('caller callback replacement cannot take ownership of editor apply',async()=>{
 const f=fixture();let redirected=0;
 try{f.options.onApply=()=>redirected++;f.root.querySelector('[data-theme-action="apply"]').click();await settle();assert.equal(f.applies(),1);assert.equal(redirected,0);}finally{f.dispose();}
});
test('caller label-map mutations cannot replace captured status and palette labels',async()=>{
 const f=fixture();try{f.options.labels.success='Changed status';f.options.optionLabels.primary='Changed palette';f.root.querySelector('[data-theme-action="save"]').click();await settle();assert.equal(f.root.querySelector('[role="status"]').value,'success');assert.equal(f.root.querySelector('[data-theme-preview="main"] [data-theme-shade]').textContent,'primary');}finally{f.dispose();}
});

for(const failure of [Error('preview cleanup'),null,undefined])test('theme editor retires imports and clears private preview after '+String(failure),async()=>{const f=fixture(),pending=deferred();f.import(pending.promise);const dispose=f.editor.preview.dispose.bind(f.editor.preview);f.editor.preview.dispose=()=>{dispose();throw failure;};let caught=false;try{f.editor.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.equal(f.root.childNodes.length,0);assert.equal(f.root.hasAttribute('data-advanced-theme-editor'),false);pending.resolve(f.theme('Late private theme'));await settle();assert.equal(f.root.childNodes.length,0);f.dispose();});
