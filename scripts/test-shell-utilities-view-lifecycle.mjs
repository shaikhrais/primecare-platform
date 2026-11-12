import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {parseHTML} from 'linkedom';
const built=await build({stdin:{contents:"export * from './packages/primecare_ui/web/shell-utilities';export * from './packages/shared/src/preference-sync/client';",resolveDir:process.cwd()},bundle:true,platform:'node',format:'esm',write:false});
const api=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const scope={tenantId:'t',userId:'u',role:'psw',dataset:'live'},item={id:'record1',title:'Notice',detail:'Owned content',read:false,status:'delivered'};
const flush=()=>new Promise(resolve=>setImmediate(resolve));
async function fixture(){
 const {document}=parseHTML('<html><head></head><body><div id="shell"><div id="slot"></div></div></body></html>');
 const storage=new Map();let mutations=0;
 const pref=new api.PreferenceSyncClient({scope,kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:[]}},async()=>{throw Error('No preference request expected');},{read:async k=>storage.get(k)??null,write:async(k,v)=>{storage.set(k,v);},remove:async k=>storage.delete(k)});
 const c=new api.ShellUtilitiesController(scope,{notifications:{load:async()=>[item],markRead:async(id,read)=>{mutations++;return {...item,id,read};}}},pref,[],()=>{});
 const view=new api.ShellUtilitiesView(document.getElementById('slot'),document.getElementById('shell'),c,'en','ltr');
 document.querySelector('dialog').close=()=>{};
 await c.load('notifications');
 return {c,view,button:()=>document.querySelector('[data-cy="shell-utilities-mark-read-record1"]'),mutations:()=>mutations};
}
test('retired resource buttons cannot issue read-receipt mutations',async()=>{
 const f=await fixture();try{const old=f.button();await f.c.load('notifications');assert.equal(old.isConnected,false);old.click();await flush();assert.equal(f.mutations(),0);}finally{await f.view.dispose();}
});
test('a click queued before redraw cannot dispatch after its generation retires',async()=>{
 const f=await fixture();try{f.button().click();await f.c.load('events');await flush();assert.equal(f.mutations(),0);}finally{await f.view.dispose();}
});
test('current resource button still dispatches once and renders acknowledged value',async()=>{
 const f=await fixture();try{f.button().click();await flush();assert.equal(f.mutations(),1);assert.equal(f.c.current.notifications.items[0].read,true);}finally{await f.view.dispose();}
});
