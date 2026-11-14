import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const metadata=JSON.parse(await readFile('packages/primecare_ui/catalogs/work-modules.registration.json','utf8'));
const built=await build({entryPoints:['packages/primecare_ui/web/work-modules.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {PrimeWorkModule,WorkModuleSession,WorkFailure}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
for(const missing of ['filter','create'])for(const marker of [null,'host-marker'])for(const existingStyle of [false,true])test(`failed shared construction releases ownership: ${missing}/${marker}/${existingStyle}`,async()=>{
 const {document}=parseHTML('<html><head></head><body><main><button>Host-owned content</button></main></body></html>'),root=document.querySelector('main'),original=root.firstChild;
 if(marker!==null)root.setAttribute('data-pc-work-modules',marker);
 if(existingStyle){const style=document.createElement('style');style.setAttribute('data-pc-work-style','');style.textContent='/* pre-existing shared style */';document.head.append(style);}
 const headBefore=document.head.innerHTML;
 const scope={tenantId:'lifecycle-tenant',userId:'lifecycle-actor',role:'tenant_admin',dataset:'live'},session=new WorkModuleSession(scope,'calendar');
 let active=0;const subscribe=session.subscribe.bind(session);session.subscribe=(fn)=>{active++;const stop=subscribe(fn);return()=>{active--;stop();};};
 const bad=structuredClone(metadata);bad.controls=bad.controls.filter(c=>c.key!==missing);
 const options={locale:'en',year:2026,month:11,firstWeekday:1};
 assert.throws(()=>new PrimeWorkModule(root,session,{...options,metadata:bad}),e=>e instanceof WorkFailure&&e.code==='invalid');
 assert.equal(active,0);assert.equal(root.firstChild,original);assert.equal(root.childNodes.length,1);assert.equal(root.getAttribute('data-pc-work-modules'),marker);assert.equal(document.head.innerHTML,headBefore);assert.notEqual(session.status,'disposed');
 let clicks=0;original.addEventListener('click',()=>clicks++);original.click();assert.equal(clicks,1);
 const valid=new PrimeWorkModule(root,session,options);assert.equal(active,1);assert.match(root.textContent,/calendar/i);valid.dispose();assert.equal(active,0);assert.notEqual(session.status,'disposed');session.dispose();
});
test('a rejected duplicate constructor cannot release the existing owner',()=>{
 const {document}=parseHTML('<html><head></head><body><main></main></body></html>'),root=document.querySelector('main');
 const session=new WorkModuleSession({tenantId:'tenant-owner',userId:'actor-owner',role:'tenant_admin',dataset:'live'},'calendar');
 const options={locale:'en',year:2026,month:11,firstWeekday:0},owner=new PrimeWorkModule(root,session,options),original=root.firstChild;
 assert.throws(()=>new PrimeWorkModule(root,session,options),e=>e instanceof WorkFailure&&e.code==='invalid');assert.equal(root.firstChild,original);assert.equal(root.hasAttribute('data-pc-work-modules'),true);
 owner.render();assert.match(root.textContent,/calendar/i);owner.dispose();assert.notEqual(session.status,'disposed');session.dispose();
});

const settle=()=>new Promise(resolve=>setImmediate(resolve));
async function focusFixture(t,module='tasks'){
 const {document,Event,HTMLInputElement,HTMLElement}=parseHTML('<html><head></head><body><main></main><input id="new-owner"></body></html>');
 let focused=null;Object.defineProperty(document,'activeElement',{get:()=>focused,configurable:true});
 const focus=HTMLElement.prototype.focus;HTMLElement.prototype.focus=function(){focused=this;};t.after(()=>HTMLElement.prototype.focus=focus);
 const previous=Object.getOwnPropertyDescriptor(globalThis,'HTMLInputElement');Object.defineProperty(globalThis,'HTMLInputElement',{value:HTMLInputElement,configurable:true});t.after(()=>{if(previous)Object.defineProperty(globalThis,'HTMLInputElement',previous);else delete globalThis.HTMLInputElement;});
 const root=document.querySelector('main'),scope={tenantId:'focus-tenant',userId:'focus-actor',role:'tenant_admin',dataset:'live'};
 let item={id:'focus-item',version:1,title:'Focus task',body:'Instructions',date:'2026-11-05',lane:'open',meta:'',actions:module==='contacts'?[]:[{id:'edit',label:'Edit',fields:['title'],target:''}]},readFailure=false,hold;
 const snapshot=()=>({scope,module,items:[item],lanes:[{id:'open',label:'Open'}],offset:0,total:1,partial:false});
 const port={read:async()=>snapshot(),mutate:async command=>{if(hold)await hold;item={...item,...command.fields,version:item.version+1};return{itemId:item.id,action:command.action,version:item.version,expected:command.fields};},readItem:async()=>{if(readFailure){readFailure=false;throw Error('Readback unavailable');}return snapshot();}};
 const session=new WorkModuleSession(scope,module,port,()=> '11111111-1111-4111-8111-111111111111');await session.load();
 const view=new PrimeWorkModule(root,session,{locale:'en',year:2026,month:11,firstWeekday:1});await settle();
 t.after(()=>{view.dispose();session.dispose();});
 const click=selector=>root.querySelector(selector).dispatchEvent(new Event('click'));
 const open=()=>click('[data-cy^=work-modules-open-]');
 const assertOpen=()=>assert.equal(document.activeElement===root.querySelector('[data-cy^=work-modules-open-]'),true);
 return {root,document,session,view,click,open,assertOpen,failRead:()=>readFailure=true,hold:promise=>hold=promise,refresh:patch=>{item={...item,...patch};return session.load();},input:value=>{const input=root.querySelector('[data-cy=work-modules-title]');input.value=value;input.dispatchEvent(new Event('input'));}};
}
for(const module of ['calendar','contacts','tasks','notes','board'])test('shared web '+module+' Close restores originating Open focus',async t=>{
 const f=await focusFixture(t,module);f.open();assert.equal(f.document.activeElement,f.root.querySelector('[data-work-detail]'));
 f.click('[data-cy=work-modules-close]');await settle();f.assertOpen();
});
test('verified Save restores originating Open focus',async t=>{
 const f=await focusFixture(t);f.open();f.click('[data-cy=work-modules-save]');await settle();assert.equal(f.session.status,'success');f.assertOpen();
});
test('successful independent-read recovery restores originating Open focus',async t=>{
 const f=await focusFixture(t);f.open();f.failRead();f.click('[data-cy=work-modules-save]');await settle();assert.equal(f.session.current.pending,true);
 f.click('[data-cy=work-modules-save-pending]');await settle();assert.equal(f.session.status,'success');f.assertOpen();
});
test('late verified Save cannot steal focus from replacement owner',async t=>{
 const f=await focusFixture(t);let finish;f.hold(new Promise(resolve=>finish=resolve));f.open();f.click('[data-cy=work-modules-save]');f.view.dispose();
 const newOwner=f.document.getElementById('new-owner');newOwner.focus();finish();await settle();assert.equal(f.document.activeElement,newOwner);assert.equal(f.root.childNodes.length,0);
});


test('clean editor reload adopts the refreshed title and version before saving',async t=>{
 const f=await focusFixture(t);f.open();await f.refresh({title:'Refreshed task',version:2});
 assert.equal(f.root.querySelector('[data-cy=work-modules-title]').value,'Refreshed task');
 f.click('[data-cy=work-modules-save]');await settle();assert.equal(f.session.status,'success');assert.equal(f.session.current.snapshot.items[0].version,3);f.assertOpen();
});
test('dirty editor preserves its draft and original version across an external refresh',async t=>{
 const f=await focusFixture(t);f.open();f.input('Retained local draft');await f.refresh({title:'Server update',version:2});
 assert.equal(f.root.querySelector('[data-cy=work-modules-title]').value,'Retained local draft');assert.equal(f.view.hasUnsavedChanges,true);
 f.click('[data-cy=work-modules-save]');await settle();assert.equal(f.session.current.snapshot.items[0].title,'Server update');assert.equal(f.root.querySelector('[data-cy=work-modules-title]').value,'Retained local draft');
});
test('clean editor reload drops actions revoked by the authorized snapshot',async t=>{
 const f=await focusFixture(t);f.open();await f.refresh({version:2,actions:[]});
 assert.equal(f.root.querySelector('[data-cy=work-modules-save]')===null,true);assert.equal(f.root.querySelector('[data-cy=work-modules-action]')===null,true);assert.ok(f.root.querySelector('[data-work-detail]'));
});
test('pending recovery retains its original draft across repeated view renders',async t=>{
 const f=await focusFixture(t);f.open();f.input('Pending draft');f.failRead();f.click('[data-cy=work-modules-save]');await settle();
 assert.equal(f.session.current.pending,true);f.view.render();f.view.render();assert.equal(f.root.querySelector('[data-cy=work-modules-title]').value,'Pending draft');
 f.click('[data-cy=work-modules-save-pending]');await settle();assert.equal(f.session.status,'success');assert.equal(f.session.current.snapshot.items[0].title,'Pending draft');f.assertOpen();
});

for(const failure of [Error('unsubscribe'),null,undefined])test('work renderer clears private draft and releases owner after cleanup throws '+String(failure),async t=>{const f=await focusFixture(t);f.open();f.input('Private unsaved draft');const off=f.view.unsubscribe;f.view.unsubscribe=()=>{off();throw failure;};let caught=false;try{f.view.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.equal(f.root.childNodes.length,0);assert.equal(f.root.hasAttribute('data-pc-work-modules'),false);assert.equal(f.view.selected,null);assert.deepEqual(f.view.draft,{});assert.notEqual(f.session.status,'disposed');const next=new PrimeWorkModule(f.root,f.session,{locale:'en',year:2026,month:11,firstWeekday:1});f.root.textContent='Replacement owner';f.view.dispose();assert.equal(f.root.textContent,'Replacement owner');next.dispose();});

for(const failure of [Error('cleanup'),null,undefined])test('failed work constructor restores host despite unsubscribe failure '+String(failure),()=>{const {document}=parseHTML('<html><head></head><body><main><span>Caller content</span></main></body></html>'),root=document.querySelector('main'),child=root.firstChild,session=new WorkModuleSession({tenantId:'t',userId:'u',role:'tenant_admin',dataset:'live'},'tasks');const subscribe=session.subscribe.bind(session);session.subscribe=fn=>{const off=subscribe(fn);return()=>{off();throw failure;};};const bad=structuredClone(metadata);bad.controls=bad.controls.filter(c=>c.key!=='filter');assert.throws(()=>new PrimeWorkModule(root,session,{locale:'en',year:2026,month:11,firstWeekday:1,metadata:bad}),error=>error?.code==='invalid');assert.equal(root.firstChild,child);assert.equal(root.hasAttribute('data-pc-work-modules'),false);assert.notEqual(session.status,'disposed');session.subscribe=subscribe;const next=new PrimeWorkModule(root,session,{locale:'en',year:2026,month:11,firstWeekday:1});next.dispose();session.dispose();});
