import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({entryPoints:['packages/primecare_ui/web/data-controls.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {PrimeDataControls}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const settle=()=>new Promise(resolve=>setImmediate(resolve));
function fixture(t){
 const {document,Event}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const previous=Object.getOwnPropertyDescriptor(globalThis,'Event');Object.defineProperty(globalThis,'Event',{value:Event,writable:true,configurable:true});
 t.after(()=>{if(previous)Object.defineProperty(globalThis,'Event',previous);else delete globalThis.Event;});
 const root=document.getElementById('root'),kit=new PrimeDataControls(root,'data-state-regression');t.after(()=>kit.dispose());
 return {root,kit,Event};
}
test('actual table retains first/last page disabled state after each completed action',async t=>{
 const {root,kit,Event}=fixture(t);
 const table=kit.table([{key:'name',label:'Name',width:100,visible:true,pinned:false}],Array.from({length:3},(_,i)=>({id:'r'+i,values:{name:'Row '+i}})),{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100,pageSize:2});root.append(table.element);
 const previous=root.querySelector('[data-cy=data-controls-previous]'),next=root.querySelector('[data-cy=data-controls-next]');
 assert.equal(previous.disabled,true);assert.equal(next.disabled,false);
 next.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,1);assert.equal(next.disabled,true);assert.equal(previous.disabled,false);
 next.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,1,'disabled end-page control cannot advance');
 previous.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,0);assert.equal(previous.disabled,true);assert.equal(next.disabled,false);
 previous.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,0,'disabled start-page control cannot retreat');
});
test('actual form retry clears stale alert role and retains error/loading/success states',async t=>{
 const {root,kit,Event}=fixture(t);let calls=0,finish;
 const form=kit.form([],async()=>{if(++calls===1)throw Error('denied');await new Promise(resolve=>finish=resolve);});root.append(form);
 const button=root.querySelector('[data-cy=data-controls-submit]');button.dispatchEvent(new Event('click'));await settle();
 const status=root.querySelector('[data-cy=data-controls-submit-status]');assert.equal(status.getAttribute('role'),'alert');assert.equal(status.textContent,kit.text('error'));
 button.dispatchEvent(new Event('click'));assert.equal(status.textContent,kit.text('loading'));assert.equal(status.getAttribute('role'),'status');assert.equal(button.disabled,true);assert.equal(button.getAttribute('aria-busy'),'true');
 button.dispatchEvent(new Event('click'));assert.equal(calls,2,'retry is serialized');finish();await settle();
 assert.equal(status.textContent,kit.text('success'));assert.equal(status.getAttribute('role'),'status');assert.equal(button.disabled,false);assert.equal(button.getAttribute('aria-busy'),null);
});

test('autocomplete rejects detached old-result clicks and preserves current pointer selection',async t=>{
 const {root,kit,Event}=fixture(t),selected=[];
 const box=kit.autocomplete(async query=>[{value:query,label:query+' label'}],value=>selected.push(value));root.append(box);
 const input=root.querySelector('[role=combobox]');input.value='first';input.dispatchEvent(new Event('input'));await settle();
 const old=root.querySelector('[role=option]');input.value='second';input.dispatchEvent(new Event('input'));await settle();
 old.dispatchEvent(new Event('pointerdown',{cancelable:true}));assert.deepEqual(selected,[]);assert.equal(input.value,'second');
 root.querySelector('[role=option]').dispatchEvent(new Event('pointerdown',{cancelable:true}));assert.deepEqual(selected,['second']);assert.equal(input.value,'second label');
});
test('autocomplete hidden options cannot select after Escape or blur',async t=>{
 const {root,kit,Event}=fixture(t),selected=[];root.append(kit.autocomplete(async()=>[{value:'a',label:'A'}],value=>selected.push(value)));
 const input=root.querySelector('[role=combobox]');
 for(const mode of ['Escape','blur']){input.dispatchEvent(new Event('input'));await settle();const option=root.querySelector('[role=option]');
  if(mode==='blur')input.dispatchEvent(new Event('blur'));else{const key=new Event('keydown');key.key=mode;input.dispatchEvent(key);}
  option.dispatchEvent(new Event('pointerdown'));assert.deepEqual(selected,[]);
 }
});

for(const change of ['filter','replace'])test('table retires old sort controls after '+change+' while current controls still work',async t=>{
 const {root,kit,Event}=fixture(t),rows=[{id:'a',values:{name:'Alpha'}},{id:'b',values:{name:'Beta'}}];
 const table=kit.table([{key:'name',label:'Name',width:100,visible:true,pinned:false}],rows,{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100});root.append(table.element);
 const old=root.querySelector('[data-cy=data-controls-sort-name]');
 if(change==='replace')table.replace(rows);else{const filter=root.querySelector('[data-cy=data-controls-filter]');filter.value='Alpha';filter.dispatchEvent(new Event('input'));}
 const prior={key:table.model.sortKey,descending:table.model.descending};old.dispatchEvent(new Event('click'));
 assert.deepEqual({key:table.model.sortKey,descending:table.model.descending},prior,'detached header must not change current sorting');
 root.querySelector('[data-cy=data-controls-sort-name]').dispatchEvent(new Event('click'));assert.equal(table.model.sortKey,'name');
});

function editorSelection(input,Event,start,end){input.selectionStart=start;input.selectionEnd=end;input.dispatchEvent(new Event('select'));}
function formatStates(root){return ['bold','italic','list'].map(key=>root.querySelector('[data-cy="data-controls-'+key+'"]').getAttribute('aria-pressed'));}
test('editor exposes the current block format and updates all toggles on block navigation',t=>{
 const {root,kit,Event}=fixture(t);const editor=kit.editor({version:1,blocks:[{text:'first',bold:true,italic:false,kind:'bullet'},{text:'second',bold:false,italic:true,kind:'paragraph'}]});root.append(editor.element);
 assert.deepEqual(formatStates(root),['true','false','true']);root.querySelector('[data-cy=data-controls-editor-block-1]').dispatchEvent(new Event('click'));
 assert.deepEqual(formatStates(root),['false','true','false']);assert.equal(root.querySelector('[data-cy=data-controls-editor]').value,'second');
 assert.deepEqual(editor.document().blocks.map(b=>({bold:b.bold,italic:b.italic,kind:b.kind})),[{bold:true,italic:false,kind:'bullet'},{bold:false,italic:true,kind:'paragraph'}]);
});
test('editor reports selected range mixed/all/none states and reflects applied formatting',async t=>{
 const {root,kit,Event}=fixture(t);const editor=kit.editor({version:2,blocks:[{text:'Hello world',bold:false,italic:false,kind:'paragraph',marks:[{start:0,end:5,bold:true,italic:false}]}]},undefined,undefined,{inlineRanges:true});root.append(editor.element);
 const input=root.querySelector('[data-cy=data-controls-editor]');input.focus=()=>{};input.setSelectionRange=(start,end)=>{input.selectionStart=start;input.selectionEnd=end;};
 editorSelection(input,Event,0,5);assert.deepEqual(formatStates(root),['true','false','false']);
 editorSelection(input,Event,0,8);assert.deepEqual(formatStates(root),['mixed','false','false']);
 editorSelection(input,Event,6,11);assert.deepEqual(formatStates(root),['false','false','false']);
 editorSelection(input,Event,2,2);assert.deepEqual(formatStates(root),['false','false','false'],'collapsed selection reflects existing whole-block toggle semantics');
 editorSelection(input,Event,0,8);root.querySelector('[data-cy=data-controls-italic]').dispatchEvent(new Event('click'));await settle();assert.deepEqual(formatStates(root),['mixed','true','false']);
 assert.equal(input.selectionStart,0);assert.equal(input.selectionEnd,8);assert.equal(editor.document().blocks[0].text,'Hello world');
 root.querySelector('[data-cy=data-controls-list]').dispatchEvent(new Event('click'));await settle();assert.deepEqual(formatStates(root),['mixed','true','true']);
 input.selectionStart=0;input.selectionEnd=0;input.dispatchEvent(new Event('input'));assert.deepEqual(formatStates(root),['false','false','true']);assert.equal(editor.document().blocks[0].text,'Hello world');
});
