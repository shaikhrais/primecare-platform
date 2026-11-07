import {test} from 'node:test';
import assert from 'node:assert/strict';
import {browser, deferred, settle, token, nestedControllers} from './fixtures/platform-admin.mjs';

test('initial existing appearance hash renders appearance, preserving query context',async()=>{
  const f=browser({hash:'#appearance',locale:'fr'});await f.render();assert.equal(f.root.view,'appearance');assert.equal(location.hash,'#appearance');assert.equal(new URL(location.href).searchParams.get('context'),'keep');assert.deepEqual(f.pushes,[]);
});
test('sidebar click updates the hash exactly once',async()=>{
  const f=browser();await f.render();await f.click('appearance');assert.equal(f.root.view,'appearance');assert.equal(location.hash,'#appearance');assert.equal(f.pushes.length,1);await f.click('appearance');assert.equal(f.pushes.length,1);
});
test('navigation cannot switch a pending parent mutation or refresh',async()=>{
  const f=browser();await f.render();const wait=deferred();f.respond=()=>wait.promise;f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();await f.click('appearance');assert.equal(f.root.view,'tenants');wait.resolve(Response.json(f.data));await settle();assert.equal(f.root.view,'tenants');assert.deepEqual(f.pushes,[]);
});

for(const id of ['tenants','tenant-selection','launch','onboarding','documents','support','reports','territories','operations','bundle','text','training','appearance'])test('initial/sidebar/Back/Forward agree for existing '+id,async()=>{
  const f=browser({hash:'#'+id});await f.render();assert.equal(f.root.view,id==='tenant-selection'?'organizations':id);assert.ok(f.anchor(id));
  await f.click('appearance');const pushes=f.pushes.length;
  f.setUrl('/platform/administration?locale=en&context=keep&enable-semantics=true#'+id);f.dispatch('popstate');f.dispatch('hashchange');await settle();
  assert.equal(f.root.view,id==='tenant-selection'?'organizations':id);assert.equal(f.pushes.length,pushes);
  f.setUrl('/platform/administration?locale=en&context=keep&enable-semantics=true#appearance');f.dispatch('popstate');f.dispatch('hashchange');await settle();assert.equal(f.root.view,'appearance');
});
for(const [id,capabilities,role] of [
  ['bundle',{canViewBundle:false}],['launch',{canViewBundle:false}],['documents',{canViewBundle:false}],['support',{canViewBundle:false}],
  ['reports',{canViewReports:false}],['territories',{canViewTerritories:false}],['operations',{canViewOperations:false}],
  ['training',{canViewTraining:false,extended:false}],['text',{extended:false},'central_admin'],['onboarding',{canCreateTenant:false}],['vapi',{},'platform_admin'],['calls',{},'platform_admin']
])test('hidden destination cannot be opened through hash: '+id,async()=>{
  const f=browser({hash:'#'+id,capabilities,role});await f.render();assert.ok(['tenants','organizations'].includes(f.root.view));assert.equal(location.hash,'#'+id);assert.ok(!f.root.anchors.some(a=>a.dataset.section===id));assert.deepEqual(f.loads,[]);assert.ok(!f.mounts.includes(id));
  await f.click('appearance');f.setUrl('/platform/administration?enable-semantics=true#'+id);f.dispatch('hashchange');await settle();assert.ok(['tenants','organizations'].includes(f.root.view));assert.equal(location.hash,'#'+id);
});
for(const hash of ['#unknown','#organizations','#account','#%61ppearance','#APPEARANCE','#appearance/','#appearance?tenant=other'])test('unknown hash is preserved without protected loads: '+hash,async()=>{
  const f=browser({hash});await f.render();assert.equal(f.root.view,'tenants');assert.equal(location.hash,hash);assert.deepEqual(f.loads,[]);assert.deepEqual(f.mounts,[]);assert.equal(f.requests.length,1);assert.deepEqual(f.pushes,[]);assert.deepEqual(f.historyReplacements,[]);
});
for(const id of ['accounts','masters','audit'])test(id+' requires tenant selection, retaining tenant-admin initial behavior',async()=>{
  let f=browser({hash:'#'+id});await f.render();assert.equal(f.root.view,'organizations');assert.equal(f.requests.length,1);assert.equal(location.hash,'#'+id);
  const select=f.root.querySelector('[data-cy=platform-topbar-tenant]');select.onchange({currentTarget:{value:'tenant-a'}});await settle();assert.equal(f.root.view,id);assert.ok(f.requests.at(-1).url.endsWith('/tenants/tenant-a/'+id));
  f=browser({hash:'#'+id,role:'tenant_admin'});await f.render();assert.equal(f.root.view,id);assert.ok(f.requests.at(-1).url.endsWith('/tenants/tenant-a/'+id));
});
test('role-specific Vapi/calls availability is identical for initial hash and sidebar',async()=>{
  let f=browser({hash:'#vapi',role:'code_admin'});await f.render();assert.equal(f.root.view,'vapi');assert.ok(f.anchor('vapi'));assert.ok(f.mounts.includes('vapi'));
  f=browser({hash:'#calls',canCall:true});await f.render();assert.equal(f.root.view,'calls');assert.ok(f.anchor('calls'));
});
test('selected tenant changes, palette and dashboard use the same guarded history route',async()=>{
  const f=browser();await f.render();const dashboard=f.dashboard;f.root.entries.find(e=>e.title==='Tenant A').open();await settle();assert.equal(f.root.view,'accounts');assert.equal(location.hash,'#accounts');assert.ok(f.requests.at(-1).url.endsWith('/tenant-a/accounts'));
  dashboard.onNavigate('masters','tenant-b');await settle();assert.equal(location.hash,'#masters');assert.ok(f.requests.at(-1).url.endsWith('/tenant-b/masters'));
  const wait=deferred(),count=f.requests.length,retained=f.root.entries.find(e=>e.title==='Tenant A').open;
  f.respond=()=>wait.promise;f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();retained();dashboard.onNavigate('audit','tenant-a');f.root.querySelector('[data-cy=platform-topbar-tenant]').onchange({currentTarget:{value:'tenant-a'}});await settle();assert.equal(f.requests.length,count+1);assert.equal(location.hash,'#masters');
  f.respond=async()=>Response.json({records:[]});wait.resolve(Response.json(f.data));await settle();assert.ok(f.requests.at(-1).url.endsWith('/tenant-b/masters'));
});
test('busy Back/Forward keeps traversal and reconciles latest URL after work',async()=>{
  const f=browser({hash:'#appearance'});await f.render();const url=location.href,wait=deferred();f.respond=()=>wait.promise;f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();
  f.setUrl('/platform/administration?locale=es&enable-semantics=true#bundle');f.dispatch('popstate');f.dispatch('hashchange');await settle();assert.notEqual(location.href,url);assert.equal(f.root.view,'appearance');assert.equal(f.historyReplacements.length,0);assert.equal(f.pushes.length,0);
  wait.resolve(Response.json(f.data));await settle();assert.equal(f.root.view,'bundle');assert.equal(f.loads.length,1);assert.equal(location.hash,'#bundle');
});
test('deferred read owns view until completion; rejected callbacks never switch its tenant',async()=>{
  const f=browser();await f.render();const wait=deferred();f.respond=async url=>url.endsWith('/accounts')?wait.promise:Response.json({events:[]});
  f.dashboard.onNavigate('accounts','tenant-a');await settle();assert.equal(location.hash,'#accounts');
  f.dashboard.onNavigate('audit','tenant-b');await f.click('appearance');assert.equal(location.hash,'#accounts');assert.ok(f.requests.at(-1).url.endsWith('/tenant-a/accounts'));
  wait.resolve(Response.json({users:[]}));await settle();assert.equal(f.root.view,'accounts');await f.click('audit');assert.ok(f.requests.at(-1).url.endsWith('/tenant-a/audit'));
});
for(const id of ['bundle','operations','territories'])test('nested '+id+' busy ownership blocks view/tenant changes and preserves history',async()=>{
  const f=browser({hash:'#'+id});await f.render();const controller=f.controllers[id],view=f.root.view,url=location.href,renders=f.root.renderCount,requests=f.requests.length;
  const deferredMutation=deferred(),mutation=controller.run(()=>deferredMutation.promise);assert.equal(controller.navigationPending,true);await f.click('appearance');f.root.entries.find(e=>e.title==='Tenant B').open();f.root.querySelector('[data-cy=platform-topbar-tenant]').onchange({currentTarget:{value:'tenant-b'}});for(const fn of f.live)fn();await settle();
  assert.equal(f.root.view,view);assert.equal(location.href,url);assert.equal(f.root.renderCount,renders);assert.equal(f.requests.length,requests);
  f.setUrl('/platform/administration?enable-semantics=true#appearance');f.dispatch('popstate');assert.notEqual(location.href,url);assert.equal(f.historyReplacements.length,0);assert.equal(f.root.view,view);
  deferredMutation.resolve();await mutation;assert.equal(controller.navigationPending,false);await new Promise(resolve=>setTimeout(resolve,65));await settle();assert.equal(f.root.view,'appearance');assert.equal(f.pushes.length,0);
});
test('metadata capability downgrade cannot reload hidden view',async()=>{
  const f=browser({hash:'#bundle'});await f.render();assert.equal(f.loads.length,1);f.data.canViewBundle=false;f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();assert.equal(f.root.view,'tenants');assert.equal(location.hash,'#bundle');assert.equal(f.loads.length,1);assert.ok(!f.root.anchors.some(a=>a.dataset.section==='bundle'));
});
test('same-root remount retires old callbacks/listeners and late metadata responses',async()=>{
  const f=browser({hash:'#appearance'}),wait=deferred();f.respond=()=>wait.promise;const old=f.render();await settle();f.respond=async()=>Response.json(f.data);await f.render();const renders=f.root.renderCount;wait.resolve(Response.json({...f.data,canCreateTenant:false}));await old;assert.equal(f.root.renderCount,renders);assert.equal(f.events.get('hashchange').size,1);assert.equal(f.events.get('popstate').size,1);assert.equal(f.live.size,1);
  const retained=f.anchor('bundle');await f.render();await f.click(retained);assert.equal(f.root.view,'appearance');assert.equal(f.pushes.length,0);
});
test('no-session early return can be remounted without dangling owner',async()=>{
  const f=browser();f.storage.removeItem('primecare_session');await f.render();assert.equal(f.requests.length,0);f.storage.setItem('primecare_session',token);await assert.doesNotReject(f.render());assert.equal(f.root.view,'tenants');
});
for(const replacement of [null,'other-session'])test('session change blocks retained callbacks and late 401/403 responses: '+replacement,async()=>{
  for(const status of [200,401,403]){
    const f=browser({hash:'#appearance'});await f.render();const retained=f.anchor('bundle'),wait=deferred();f.respond=()=>wait.promise;f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();
    if(replacement===null)f.storage.removeItem('primecare_session');else f.storage.setItem('primecare_session',replacement);
    await f.click(retained);wait.resolve(Response.json(status===200?f.data:{error:'denied'},{status}));await settle();assert.equal(f.root.innerHTML,'');assert.equal(f.storage.getItem('primecare_session'),replacement);assert.equal(f.pushes.length,0);assert.equal(f.assigned.length,0);assert.equal(f.reloads(),1);assert.equal(f.events.get('hashchange').size,0);
  }
});
test('detached root and unrelated path relinquish history callbacks',async()=>{
  for(const mode of ['detached','path','pagehide']){
    const f=browser({hash:'#appearance'});await f.render();const retained=f.anchor('bundle'),renders=f.root.renderCount;
    if(mode==='detached')f.root.isConnected=false;else if(mode==='path')f.setUrl('/tenant-dashboard?enable-semantics=true');else for(const fn of f.events.get('pagehide'))fn({persisted:false});
    await f.click(retained);f.dispatch('hashchange');assert.equal(f.root.renderCount,renders);assert.equal(f.pushes.length,0);assert.equal(f.events.get('hashchange').size,0);assert.equal(f.live.size,0);
  }
});
test('embedded account keeps /success history and locale; fresh dispatcher semantics are unchanged',async()=>{
  const f=browser({hash:'#appearance',locale:'fr'});await f.render();const original=location.href;await f.click('account');assert.equal(f.root.view,'account');assert.equal(location.pathname,'/success');assert.equal(location.hash,'');assert.match(f.root.innerHTML,/account fixture/);assert.equal(f.assigned.length,0);assert.equal(new URL(location.href).searchParams.get('context'),'keep');assert.equal(new URL(location.href).searchParams.get('locale'),'fr');
  f.setUrl(original);f.dispatch('popstate');await settle();assert.equal(f.root.view,'appearance');await f.click('account');await f.click('bundle');assert.equal(location.pathname,'/platform/administration');assert.equal(location.hash,'#bundle');assert.equal(f.root.view,'bundle');
});
test('modified or secondary clicks keep native link behavior',async()=>{
  for(const event of [{ctrlKey:true},{metaKey:true},{shiftKey:true},{altKey:true},{button:1},{defaultPrevented:true}]){
    const f=browser();await f.render();assert.equal(await f.click('appearance',event),0);assert.equal(f.pushes.length,0);assert.equal(f.root.view,'tenants');
  }
});
test('401 and 403 still stop rendering and protected load failures stay errors',async()=>{
  for(const status of [401,403]){const f=browser({hash:'#bundle'});f.respond=async()=>Response.json({error:'denied'},{status});await f.render();assert.equal(f.root.renderCount,0);assert.deepEqual(f.loads,[]);assert.equal(f.events.get('hashchange').size,0);if(status===401)assert.equal(f.storage.getItem('primecare_session'),null);else assert.match(f.root.innerHTML,/denied/);}
  const f=browser({hash:'#bundle'});f.loadController=async()=>{throw Error('fixture service unavailable');};await f.render();assert.equal(f.root.renderCount,0);assert.match(f.root.innerHTML,/fixture service unavailable/);assert.equal(location.hash,'#bundle');
});

test('native traversal during deferred parent mutation preserves exact history entries and newest intent',async()=>{
  const f=browser();await f.render();await f.click('appearance');await f.click('tenants');const before=[...f.historyStack],wait=deferred();
  const ordinary=f.respond;f.respond=async(url,options)=>options.method==='POST'?wait.promise:ordinary(url,options);
  const form=f.root.querySelector('[data-cy=platform-tenant-form]');form.values=[['name','Fixture tenant'],['slug','fixture-tenant']];form.onsubmit({preventDefault(){},currentTarget:form});for(let i=0;i<30&&!f.requests.some(r=>r.options.method==='POST');i++)await new Promise(resolve=>setTimeout(resolve,5));assert.equal(f.requests.filter(r=>r.options.method==='POST').length,1,f.root.innerHTML);
  f.go(-1);f.go(-1);f.go(1);assert.equal(f.historyIndex(),1);assert.equal(location.hash,'#appearance');assert.equal(f.root.view,'tenants');
  await f.click('bundle');form.onsubmit({preventDefault(){},currentTarget:form});for(let i=0;i<30&&!f.requests.some(r=>r.options.method==='POST');i++)await new Promise(resolve=>setTimeout(resolve,5));assert.equal(f.requests.filter(r=>r.options.method==='POST').length,1,f.root.innerHTML);
  wait.resolve(Response.json({tenant:f.data.tenants[0]}));await settle();assert.equal(f.root.view,'appearance');assert.deepEqual(f.historyStack,before);assert.equal(f.historyReplacements.length,0);
  f.go(1);await settle();assert.equal(f.root.view,'tenants');f.go(-1);await settle();assert.equal(f.root.view,'appearance');
});
test('nested deferred mutation preserves Back entries and coalesces popstate/hashchange',async()=>{
  const f=browser();await f.render();await f.click('appearance');await f.click('bundle');const before=[...f.historyStack],count=f.loads.length,wait=deferred(),mutation=f.controllers.bundle.run(()=>wait.promise);
  f.go(-1);f.go(-1);f.go(1);assert.deepEqual(f.historyStack,before);assert.equal(f.root.view,'bundle');assert.equal(location.hash,'#appearance');assert.equal(f.loads.length,count);
  wait.resolve();await mutation;await new Promise(resolve=>setTimeout(resolve,65));await settle();assert.equal(f.root.view,'appearance');assert.deepEqual(f.historyStack,before);
  f.go(1);await settle();assert.equal(f.root.view,'bundle');assert.equal(f.loads.length,count+1);assert.deepEqual(f.historyStack,before);assert.equal(f.historyReplacements.length,0);
});
test('embedded account native admin links target the admin dispatcher even for new tabs',async()=>{
  const f=browser({locale:'es',canCall:true});await f.render();await f.click('account');assert.equal(location.pathname,'/success');
  for(const id of ['bundle','training','appearance','calls']){
    const a=f.anchor(id),target=new URL(a.getAttribute('href'),location.href);assert.equal(target.pathname,'/platform/administration');assert.equal(target.hash,'#'+id);assert.equal(target.searchParams.get('locale'),'es');assert.equal(target.searchParams.get('context'),'keep');assert.ok(target.search.endsWith('enable-semantics=true'));assert.equal(await f.click(a,{ctrlKey:true}),0);
  }
  assert.equal(f.root.view,'account');assert.equal(f.pushes.length,1);
});
test('locale changes are preserved in accepted and native URLs without dropping unrelated context',async()=>{
  const f=browser({locale:'fr'});await f.render();f.root.querySelector('[data-cy=platform-language]').onchange({currentTarget:{value:'en'}});await f.click('appearance');assert.equal(new URL(location.href).searchParams.get('locale'),'en');assert.equal(new URL(location.href).searchParams.get('context'),'keep');
  await f.click('account');assert.equal(new URL(location.href).searchParams.get('locale'),'en');
});
test('persisted restoration reloads for fresh capabilities and retires old callbacks',async()=>{
  const f=browser({hash:'#bundle'});await f.render();const retained=f.anchor('appearance');f.data.canViewBundle=false;f.dispatch('pagehide');assert.equal(f.reloads(),0);f.dispatch('pageshow');assert.equal(f.reloads(),1);assert.equal(f.root.innerHTML,'');assert.equal(f.events.get('hashchange').size,0);assert.equal(f.live.size,0);await f.click(retained);assert.equal(f.pushes.length,0);assert.equal(f.reloads(),1);
});
test('late response body or transport rejection cannot repaint a replacement owner/session',async()=>{
  for(const rejection of [false,true]){
    const f=browser(),wait=deferred();f.respond=async()=>({ok:true,status:200,json:()=>wait.promise});const old=f.render();await settle();f.storage.setItem('primecare_session','replacement');if(rejection)wait.reject(Error('old failure'));else wait.resolve(f.data);await old;assert.equal(f.root.innerHTML,'');assert.equal(f.root.renderCount,0);assert.equal(f.storage.getItem('primecare_session'),'replacement');assert.equal(f.reloads(),1);
  }
});
test('nested busy signals are read-only reflections of their actual pending operations',async()=>{
  for(const [name,Controller] of Object.entries(nestedControllers)){
    const controller=new Controller('https://fixture.invalid',token,()=>{});assert.equal(controller.navigationPending,false);
    assert.throws(()=>{controller.navigationPending=true;},TypeError);const wait=deferred(),work=controller.run(()=>wait.promise);assert.equal(controller.navigationPending,true,name);wait.reject(Error('synthetic mutation conflict'));await work;assert.equal(controller.navigationPending,false,name);
  }
});
test('new explicit navigation after nested completion supersedes older queued traversal',async()=>{
  const f=browser({hash:'#bundle'});await f.render();const wait=deferred(),work=f.controllers.bundle.run(()=>wait.promise);f.setUrl('/platform/administration?enable-semantics=true#training');f.dispatch('popstate');wait.resolve();await work;
  await f.click('appearance');assert.equal(f.root.view,'appearance');assert.equal(location.hash,'#appearance');await new Promise(resolve=>setTimeout(resolve,65));await settle();assert.equal(f.root.view,'appearance');assert.equal(location.hash,'#appearance');assert.equal(f.pushes.length,1);
});
test('embedded account navigation retains common focus completion behavior',async()=>{
  const f=browser();await f.render();const focus=f.root.focusCount;await f.click('account');assert.equal(f.root.focusCount,focus+1);assert.equal(f.root.view,'account');
});
