import {test} from 'node:test';
import assert from 'node:assert/strict';
import {browser, deferred, settle, installPortalPresentation} from './fixtures/platform-admin.mjs';

const names=['layout','theme','language','responsive'];
const entries=f=>f.entries.filter(e=>e.name==='layout').map(e=>e.screen.route);
const error=f=>f.root.children.find(e=>e.getAttribute('data-cy')==='error-state')?.textContent??'';

test('administrator checks its installed presentation before initial data access and rendering',async()=>{
 const f=browser();f.respond=async()=>{assert.ok(entries(f).length);assert.ok(entries(f).every(route=>route==='/platform/administration'));return Response.json(f.data);};
 await f.render();assert.equal(f.root.view,'tenants');assert.ok(entries(f).length>=2);assert.deepEqual(f.entries.slice(-4).map(e=>e.name),names);
});
test('embedded account and return tabs enter their existing dispatcher registrations',async()=>{
 const f=browser();await f.render();f.entries.length=0;await f.click('account');
 assert.equal(f.root.view,'account');assert.equal(location.pathname,'/success');assert.ok(entries(f).includes('/success'));
 assert.equal(f.entries.at(-1).screen.adapter,'workspace');await f.click('appearance');assert.equal(f.root.view,'appearance');assert.equal(entries(f).at(-1),'/platform/administration');
});
for(const missing of names)test('lost '+missing+' connection clears old account content before refresh work',async()=>{
 const f=browser();await f.render();await f.click('account');const requests=f.requests.length;delete f.connections[missing];
 f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();
 assert.match(error(f),new RegExp('Missing '+missing));assert.equal(f.requests.length,requests);assert.equal(f.root.innerHTML,'');assert.equal(f.live.size,0);
});

test('missing production installation fails closed without creating a manager or reading data',async()=>{
 const f=browser({installManager:false});f.root.innerHTML='previous protected content';
 await assert.rejects(f.render(),/Missing manager/);assert.match(error(f),/Missing manager/);assert.equal(f.requests.length,0);assert.equal(f.live.size,0);
});
for(const missing of names)test('initial '+missing+' validation precedes subscriptions and protected reads',async()=>{
 const f=browser({hash:'#bundle'});delete f.connections[missing];await f.render();
 assert.match(error(f),new RegExp('Missing '+missing));assert.equal(f.requests.length,0);assert.equal(f.probes,0);assert.equal(f.live.size,0);assert.equal(f.loads.length,0);
});
for(const name of names)for(const mode of ['throw','promise'])test(name+' '+mode+' failure on account navigation retires old callbacks',async()=>{
 const f=browser();await f.render();const old=f.anchor('appearance'),before=f.requests.length;
 f.connections[name]=mode==='throw'?()=>{throw Error('private connection detail');}:async()=>{throw Error('private connection detail');};
 await f.click('account');assert.match(error(f),mode==='throw'?/Presentation connection failed/:new RegExp('Asynchronous '+name));
 assert.equal(f.root.innerHTML,'');assert.equal(f.requests.length,before);assert.equal(f.live.size,0);assert.equal(f.events.get('popstate').size,0);
 const state=error(f);await f.click(old);f.dispatch('popstate');assert.equal(error(f),state);assert.equal(f.requests.length,before);
});

test('Back and Forward between account and admin use exact canonical route entries without rewriting history',async()=>{
 const f=browser({locale:'fr'});await f.render();await f.click('account');await f.click('appearance');const history=[...f.historyStack];
 for(const [delta,view,path] of [[-1,'account','/success'],[-1,'tenants','/platform/administration'],[1,'account','/success'],[1,'appearance','/platform/administration']]){
  f.entries.length=0;f.go(delta);await settle();assert.equal(f.root.view,view);assert.ok(entries(f).length);assert.equal(entries(f).at(-1),path);assert.equal(location.pathname,path);
 }
 assert.deepEqual(f.historyStack,history);assert.equal(f.historyReplacements.length,0);
});
for(const trigger of ['live','language','history','same-click','refresh'])test('same-route '+trigger+' rechecks without repairing a missing entry registration',async()=>{
 const f=browser();await f.render();await f.click('account');const old=f.anchor('account');f.manager.registerScope('entry',[]);
 if(trigger==='live')for(const fn of [...f.live])fn();
 if(trigger==='language')f.root.querySelector('[data-cy=platform-language]').onchange({currentTarget:{value:'fr'}});
 if(trigger==='history')f.dispatch('hashchange');
 if(trigger==='same-click')await f.click(old);
 if(trigger==='refresh')f.root.querySelector('[data-cy=platform-refresh]').onclick();
 await settle();assert.match(error(f),/Missing registration/);assert.equal(f.root.innerHTML,'');assert.equal(f.live.size,0);
});
test('entry transitions preserve unrelated and workspace-owned registrations through remount and disposal',async()=>{
 const f=browser(),account={id:'typescript:account',route:'/success',kind:'feature',adapter:'workspace-account'},governed={id:'governed:fixture',route:'/existing-fixture',kind:'governed',adapter:'workspace'};
 f.manager.registerScope('workspace',[account,governed]);f.manager.registerScope('unrelated',[{id:'unrelated',route:'/other-fixture',kind:'feature',adapter:'fixture'}]);
 for(let i=0;i<3;i++){
  await f.render();await f.click('account');assert.equal(f.manager.enter('typescript:workspace:/success','/success').adapter,'workspace');
  assert.deepEqual(f.manager.enter(account.id,account.route),account);assert.deepEqual(f.manager.enter(governed.id,governed.route),governed);
  await f.click('appearance');assert.equal(f.manager.enter('typescript:platform:/platform/administration','/platform/administration').adapter,'platform');
 }
 for(const fn of [...f.events.get('pagehide')])fn({persisted:false});assert.equal(f.events.get('popstate').size,0);
 assert.deepEqual(f.manager.enter(account.id,account.route),account);assert.equal(f.manager.enter('unrelated','/other-fixture').adapter,'fixture');
 // Entry is static presentation metadata, retained just as main.ts retains it.
 assert.equal(f.manager.enter('typescript:platform:/platform/administration','/platform/administration').adapter,'platform');
});
test('late old owner cannot replace a remounted entry or clear replacement content',async()=>{
 const f=browser(),pending=deferred(),ordinary=f.respond;f.respond=()=>pending.promise;const old=f.render();await settle();
 f.respond=ordinary;await f.render();await f.click('account');const before=f.root.innerHTML,route=entries(f).at(-1),count=f.entries.length;
 pending.resolve(Response.json(f.data));await old;assert.equal(f.root.innerHTML,before);assert.equal(entries(f).at(-1),route);assert.equal(f.entries.length,count);assert.equal(f.events.get('popstate').size,1);
});
for(const mode of ['replacement','removed','storage','detached','path'])test('stale '+mode+' owner cannot enter presentation after pending reads settle',async()=>{
 const f=browser(),pending=deferred();f.respond=()=>pending.promise;const work=f.render();await settle();const count=f.entries.length;
 if(mode==='replacement')f.storage.setItem('primecare_session','replacement');
 if(mode==='removed')f.storage.removeItem('primecare_session');
 if(mode==='storage')f.storage.getItem=()=>{throw Error('storage unavailable');};
 if(mode==='detached')f.root.isConnected=false;
 if(mode==='path')f.setUrl('/other');
 pending.resolve(Response.json(f.data));await work;assert.equal(f.entries.length,count);assert.equal(f.probes,0);assert.equal(f.root.renderCount,0);
});
for(const phase of ['fetch','body','probe'])for(const rejects of [false,true])test('connection loss during '+phase+' '+(rejects?'rejection':'success')+' stops downstream reads with configuration error',async()=>{
 const f=browser({hash:'#accounts',role:'tenant_admin'}),pending=deferred(),ready=deferred();let bodyReads=0;
 if(phase==='fetch')f.respond=()=>{ready.resolve();return pending.promise;};
 if(phase==='body')f.respond=async()=>({ok:true,status:200,json:()=>{bodyReads++;ready.resolve();return pending.promise;}});
 if(phase==='probe')f.probe=()=>{ready.resolve();return pending.promise;};
 const work=f.render();await ready.promise;delete f.connections.responsive;
 if(rejects)pending.reject(Error('generic network failure'));
 else pending.resolve(phase==='fetch'?{ok:true,status:200,json:async()=>{bodyReads++;return f.data;}}:phase==='body'?f.data:true);
 await work;assert.match(error(f),/Missing responsive/);assert.equal(f.root.renderCount,0);assert.equal(f.requests.length,1);assert.equal(f.probes,phase==='probe'?1:0);if(phase==='fetch')assert.equal(bodyReads,0);assert.equal(f.live.size,0);
});
for(const origin of ['admin','account'])test('busy '+origin+' refresh retains owned presentation while traversing, then reconciles',async()=>{
 const f=browser();await f.render();await f.click('account');if(origin==='admin')await f.click('appearance');
 const pending=deferred();f.respond=()=>pending.promise;f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();f.entries.length=0;
 f.go(-1);assert.equal(f.root.view,origin==='admin'?'appearance':'account');assert.equal(f.entries.length,0);
 pending.resolve(Response.json(f.data));await settle();const paths=entries(f),owned=origin==='admin'?'/platform/administration':'/success',next=origin==='admin'?'/success':'/platform/administration';
 assert.ok(paths.includes(owned));assert.equal(paths.at(-1),next);const transition=paths.indexOf(next);assert.ok(paths.slice(0,transition).every(p=>p===owned));assert.ok(paths.slice(transition).every(p=>p===next));
});
for(const kind of ['bundle','operations','territories'])test('busy '+kind+' mutation defers account entry until idle',async()=>{
 const f=browser();await f.render();await f.click('account');await f.click(kind);const pending=deferred(),mutation=f.controllers[kind].run(()=>pending.promise),before=[...f.historyStack];f.entries.length=0;
 f.go(-1);await settle();assert.equal(f.root.view,kind);assert.deepEqual(entries(f),[]);pending.resolve();await mutation;await new Promise(resolve=>setTimeout(resolve,65));await settle();assert.equal(f.root.view,'account');assert.equal(entries(f).at(-1),'/success');assert.deepEqual(f.historyStack,before);
});
test('connection loss after a dispatched mutation preserves its uncertain retry identity and draft',async()=>{
 const f=browser();await f.render();const pending=deferred(),ready=deferred(),ordinary=f.respond;
 f.respond=(url,options)=>options.method==='POST'?(ready.resolve(),pending.promise):ordinary(url,options);
 const form=f.root.querySelector('[data-cy=platform-tenant-form]');form.values=[['name','Fixture'],['slug','fixture']];form.onsubmit({preventDefault(){},currentTarget:form});await ready.promise;
 const keys=[...f.values.keys()].filter(k=>k.startsWith('primecare-platform-request:'));assert.equal(keys.length,1);const identity=f.values.get(keys[0]);delete f.connections.theme;pending.resolve(Response.json({tenant:f.data.tenants[0]}));await settle();
 assert.match(error(f),/Missing theme/);assert.equal(f.values.get(keys[0]),identity);assert.equal(form.resetCount??0,0);assert.equal(f.requests.length,2);assert.equal(f.pushes.length,0);
});

// Real production bridge and layout/theme owners; only DOM/CSS services are synthetic.
function bridgeFixture(){
 const f=browser({installManager:false}),doc=f.root.ownerDocument;
 const style=()=>{const values=new Map();return {scrollbarColor:'',getPropertyValue:k=>values.get(k)??'',setProperty:(k,v)=>values.set(k,v),removeProperty:k=>values.delete(k)};};
 f.root.style=style();doc.documentElement.style=style();doc.body=doc.createElement('body');doc.body.style=style();
 f.root.classList.add=()=>{};doc.documentElement.classList.add=()=>{};let responsive=true;
 doc.defaultView=window;window.getComputedStyle=()=>({getPropertyValue:k=>k==='--primecare-responsive-styles'?(responsive?'1':''):doc.documentElement.style.getPropertyValue(k)});globalThis.getComputedStyle=window.getComputedStyle;
 f.manager=installPortalPresentation(f.root,{'--color-primary':'#006b68'},'https://gateway.invalid');f.setResponsive=value=>responsive=value;return f;
}
test('production bridge supplies existing layout, language, theme and responsive connections across account entry',async()=>{
 const f=bridgeFixture();await f.render();await f.click('account');assert.equal(f.root.view,'account');assert.equal(f.root.dataset.layoutVersion,'1');assert.ok(document.documentElement.style.getPropertyValue('--color-primary'));assert.equal(f.root.dir,'ltr');
 f.root.querySelector('[data-cy=platform-language]').onchange({currentTarget:{value:'es'}});assert.equal(document.documentElement.lang,'es');await f.click('appearance');assert.equal(f.root.view,'appearance');
});
test('production responsive stylesheet loss on account redraw is a configuration failure, never stale content',async()=>{
 const f=bridgeFixture();await f.render();await f.click('account');f.setResponsive(false);for(const fn of [...f.live])fn();
 assert.match(error(f),/Presentation connection failed/);assert.equal(f.root.innerHTML,'');assert.equal(f.live.size,0);
});

for(const kind of ['bundle','operations','territories'])test('initial '+kind+' failure cannot replace a lost connection with a service error',async()=>{
 const f=browser({hash:'#'+kind}),pending=deferred(),ready=deferred();f.loadController=()=>{ready.resolve();return pending.promise;};
 const work=f.render();await ready.promise;delete f.connections.theme;pending.reject(Error('ordinary service unavailable'));await work;
 assert.match(error(f),/Missing theme/);assert.equal(f.root.innerHTML,'');assert.equal(f.live.size,0);
});
