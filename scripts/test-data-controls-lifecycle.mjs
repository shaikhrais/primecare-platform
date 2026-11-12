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
