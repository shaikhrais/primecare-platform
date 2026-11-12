import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const bundle=await build({entryPoints:['packages/primecare_ui/web/navigation.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {mountNavigation}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
function fixture(){
 const {document,window}=parseHTML('<html><body><div id="navigation"></div></body></html>');
 globalThis.document=document;globalThis.window=window;globalThis.Node=window.Node;
 window.matchMedia=()=>({matches:false});
 const host=document.getElementById('navigation'),opened=[];
 const entries=()=>[{title:'Authorized record',detail:'Existing result',open:()=>opened.push('old')}];
 const mount=(scope='tenant:actor:role',locale='en',source=entries)=>mountNavigation(host,'Existing title',locale,scope,source);
 const search=(query='record')=>{const input=host.querySelector('input');input.value=query;input.dispatchEvent(new window.Event('input'));return host.querySelector('[data-cy=universal-search-result]');};
 mount();return {host,opened,mount,search};
}
for(const transition of ['query','scope','locale','activation'])test(`retired search result cannot navigate after ${transition}`,()=>{
 const f=fixture(),old=f.search();assert.ok(old);
 if(transition==='query')f.search('missing');
 if(transition==='scope')f.mount('tenant:replacement:role','en',()=>[]);
 if(transition==='locale')f.mount('tenant:actor:role','fr',()=>[]);
 if(transition==='activation')old.click();
 old.click();
 assert.deepEqual(f.opened,transition==='activation'?['old']:[]);
});
test('retired search inputs cannot read old actor entries after locale replacement',()=>{
 const f=fixture(),oldInput=f.host.querySelector('input');let reads=0;
 f.mount('actor','en',()=>{reads++;return [];});
 f.mount('replacement','fr',()=>[]);oldInput.value='record';oldInput.dispatchEvent(new window.Event('input'));
 assert.equal(reads,0);
});
test('current search results remain usable after same-locale scope refresh',()=>{
 const f=fixture();f.search();f.mount('tenant:replacement:role','en',()=>[{title:'Current record',detail:'Replacement',open:()=>f.opened.push('new')}]);
 const current=f.search();assert.ok(current);current.click();assert.deepEqual(f.opened,['new']);
 assert.equal(f.host.querySelector('input').value,'');assert.equal(f.host.querySelector('[data-cy=universal-search-results]').hidden,true);
});
test('retired result cannot clear the current query or open the replacement actor entry',()=>{
 const f=fixture(),old=f.search();f.mount('replacement','en',()=>[{title:'Current record',detail:'Authorized replacement',open:()=>f.opened.push('new')}]);
 const current=f.search();old.click();assert.equal(f.host.querySelector('input').value,'record');assert.deepEqual(f.opened,[]);
 current.click();assert.deepEqual(f.opened,['new']);
});
test('detached search host cannot dispatch navigation or read entries',()=>{
 const f=fixture(),old=f.search(),input=f.host.querySelector('input');f.host.remove();old.click();input.dispatchEvent(new window.Event('input'));assert.deepEqual(f.opened,[]);
});
test('same-locale mount rebuilds a host whose old subtree was replaced',()=>{
 const f=fixture(),old=f.search();f.host.replaceChildren();f.mount();assert.ok(f.host.querySelector('input'));old.click();assert.deepEqual(f.opened,[]);f.search().click();assert.deepEqual(f.opened,['old']);
});
test('retired focusout timer cannot hide replacement query results',async()=>{
 const f=fixture();f.search();f.host.querySelector('.global-search').dispatchEvent(new window.Event('focusout'));
 f.mount('replacement','en',()=>[{title:'Current record',detail:'Current',open:()=>f.opened.push('new')}]);
 const current=f.search();await new Promise(resolve=>setTimeout(resolve,0));
 assert.equal(f.host.querySelector('[data-cy=universal-search-results]').hidden,false);current.click();assert.deepEqual(f.opened,['new']);
});
