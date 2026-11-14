import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {parseHTML} from 'linkedom';
const built=await build({stdin:{contents:"export * from './packages/primecare_ui/web/shell-utilities';export * from './packages/shared/src/preference-sync/client';",resolveDir:process.cwd()},bundle:true,platform:'node',format:'esm',write:false});
const api=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const scope={tenantId:'t',userId:'u',role:'psw',dataset:'live'},item={id:'record1',title:'Notice',detail:'Owned content',read:false,status:'delivered'};
const flush=()=>new Promise(resolve=>setImmediate(resolve));
async function fixture(load=async()=>[item]){
 const {document}=parseHTML('<html><head></head><body><div id="shell"><div id="slot"></div></div></body></html>');
 const storage=new Map();let mutations=0;
 const pref=new api.PreferenceSyncClient({scope,kind:'shortcuts',resource:'navigation',policy:{panelIds:[],screenIds:[]}},async()=>{throw Error('No preference request expected');},{read:async k=>storage.get(k)??null,write:async(k,v)=>{storage.set(k,v);},remove:async k=>storage.delete(k)});
 const c=new api.ShellUtilitiesController(scope,{notifications:{load,markRead:async(id,read)=>{mutations++;return {...item,id,read};}}},pref,[],()=>{});
 const view=new api.ShellUtilitiesView(document.getElementById('slot'),document.getElementById('shell'),c,'en','ltr');
 document.querySelector('dialog').close=()=>{};
 await c.load('notifications');
 return {c,view,document,button:()=>document.querySelector('[data-cy="shell-utilities-mark-read-record1"]'),mutations:()=>mutations};
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

test('switching to idle favourites clears a resource load busy announcement',async()=>{
 let hold=false,release;
 const f=await fixture(async()=>hold?new Promise(resolve=>release=resolve):[item]);
 try{
  hold=true;const pending=f.c.load('notifications');
  assert.equal(f.document.querySelector('[role="tabpanel"]').getAttribute('aria-busy'),'true');
  f.document.querySelector('[data-cy="shell-utilities-favourites"]').click();await flush();
  assert.equal(f.document.querySelector('[role="tabpanel"]').getAttribute('aria-busy'),'false');
  release([item]);await pending;
 }finally{release?.([item]);await f.view.dispose();}
});

for(const stage of ['unsubscribe','dialog','controller'])for(const failure of [Error('cleanup failed'),null,undefined])test('utility view completes cleanup after '+stage+' throws '+String(failure),async()=>{const f=await fixture(),slot=f.document.getElementById('slot'),shell=f.document.getElementById('shell'),old=f.button();let disposed=0;const dispose=f.c.dispose.bind(f.c);f.c.dispose=async()=>{disposed++;await dispose();if(stage==='controller')throw failure;};if(stage==='unsubscribe'){const off=f.view.off;f.view.off=()=>{off();throw failure;};}if(stage==='dialog')f.document.querySelector('dialog').close=()=>{throw failure;};let caught=false;try{await f.view.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.equal(disposed,1);assert.equal(slot.childNodes.length,0);assert.equal(shell.hasAttribute('data-pc-shell-environment'),false);assert.equal(shell.hasAttribute('dir'),false);assert.deepEqual(f.c.current.notifications.items,[]);old.click();await flush();assert.equal(f.mutations(),0);await f.view.dispose();assert.equal(disposed,1);const environment=new api.ShellEnvironment(shell,'rtl');await environment.dispose();});

test('utility view preserves first undefined failure while later cleanup also fails',async()=>{const f=await fixture(),off=f.view.off,dispose=f.c.dispose.bind(f.c);f.view.off=()=>{off();throw undefined;};f.document.querySelector('dialog').close=()=>{throw Error('later dialog error');};f.c.dispose=async()=>{await dispose();throw Error('later controller error');};let caught=false;try{await f.view.dispose();}catch(error){caught=true;assert.equal(error,undefined);}assert.equal(caught,true);assert.equal(f.document.getElementById('slot').childNodes.length,0);assert.equal(f.document.getElementById('shell').hasAttribute('data-pc-shell-environment'),false);assert.deepEqual(f.c.current.notifications.items,[]);});
