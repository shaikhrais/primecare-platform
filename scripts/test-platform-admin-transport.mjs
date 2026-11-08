import {test} from 'node:test';
import assert from 'node:assert/strict';
import {browser, deferred, settle, token} from './fixtures/platform-admin.mjs';

const replace=f=>f.storage.setItem('primecare_session','replacement-session');

test('a stale fetch response is rejected before its body is read',async()=>{
 const f=browser(),pending=deferred();let reads=0;
 f.respond=()=>pending.promise;const work=f.render();await settle();replace(f);
 pending.resolve({ok:true,status:200,json:async()=>{reads++;return f.data;}});await work;
 assert.equal(reads,0);assert.equal(f.root.renderCount,0);assert.equal(f.probes,0);
});
test('metadata settling before an account switch cannot start a capability probe',async()=>{
 const f=browser();f.respond=async()=>({status:200,get ok(){queueMicrotask(()=>replace(f));return true;},json:async()=>f.data});
 await f.render();assert.equal(f.probes,0);assert.equal(f.root.renderCount,0);assert.equal(f.storage.getItem('primecare_session'),'replacement-session');
});

const pendingKeys=f=>[...f.values.keys()].filter(k=>k.startsWith('primecare-platform-request:'));
async function until(predicate){for(let i=0;i<200&&!predicate();i++)await new Promise(resolve=>setTimeout(resolve,1));assert.ok(predicate(),'Fixture operation did not start');}
const submit=form=>form.onsubmit({preventDefault(){},currentTarget:form});
async function formFixture(kind='tenant'){
 const f=browser(kind==='tenant'?{}:{hash:'#'+(kind==='account'?'accounts':kind==='master'?'masters':'onboarding'),role:kind==='partner'?'platform_admin':'tenant_admin'});
 const ordinary=f.respond;
 f.respond=async(url,options)=>url.endsWith('/onboarding')?Response.json({partners:[{id:'partner-a',version:4}]}):ordinary(url,options);
 await f.render();const form=f.root.querySelector('[data-cy='+(kind==='partner'?'fixture-partner-partner-a':'platform-'+kind+'-form')+']');assert.ok(form);
 form.values=kind==='tenant'?[['name','Fixture'],['slug','fixture']]:kind==='account'?[['email','fixture@example.invalid'],['role','admin'],['password','synthetic-only']]:kind==='master'?[['type','fixture'],['code','fixture'],['label','Fixture']]:[['name','Fixture']];
 return {f,form};
}
for(const kind of ['tenant','account','master','partner'])for(const mode of ['replacement','remount'])test(`${kind} success receipt rejects ${mode} before draft reset, navigation or follow-on reads`,async()=>{
 const {f,form}=await formFixture(kind),ordinary=f.respond;let remount,keyAtSettlement;
 f.respond=async(url,options)=>options.method==='POST'?{status:200,json:async()=>({tenant:f.data.tenants[0]}),get ok(){keyAtSettlement=pendingKeys(f)[0];queueMicrotask(()=>{if(mode==='replacement')replace(f);else{f.storage.setItem(keyAtSettlement,'new-owner-pending-key');remount=f.render();}});return true;}}:ordinary(url,options);
 const before=f.requests.length;submit(form);await until(()=>!!keyAtSettlement);await settle();if(remount)await remount;
 assert.equal(form.resetCount??0,0);assert.equal(f.pushes.length,0);assert.equal(f.storage.getItem(keyAtSettlement),mode==='remount'?'new-owner-pending-key':f.requests[before].options.headers['Idempotency-Key']);
 assert.equal(f.requests.filter(r=>r.options.method==='POST').length,1);
 if(mode==='replacement'){assert.equal(f.requests.length,before+1);assert.equal(f.root.innerHTML.length,0);}else assert.ok(f.root.innerHTML);
});

for(const phase of ['digest','fetch','body'])for(const reject of [false,true])test(`${phase} ${reject?'rejection':'fulfillment'} after replacement cannot consume a mutation`,async t=>{
 const {f,form}=await formFixture(),pending=deferred(),ready=deferred(),ordinary=f.respond;let reads=0,accessedFailure=0;
 if(phase==='digest')t.mock.method(crypto.subtle,'digest',()=>{ready.resolve();return pending.promise;});
 f.respond=async(url,options)=>{
  if(options.method!=='POST')return ordinary(url,options);
  if(phase==='fetch'){ready.resolve();return pending.promise;}
  return {status:200,ok:true,json:()=>{reads++;ready.resolve();return pending.promise;}};
 };
 const before=f.requests.length;submit(form);await ready.promise;const key=pendingKeys(f)[0],identity=key&&f.storage.getItem(key);replace(f);
 if(reject){const failure={get message(){accessedFailure++;return 'old transport failure';}};pending.reject(failure);}else pending.resolve(phase==='digest'?new Uint8Array(32).buffer:phase==='fetch'?{status:200,ok:true,json:async()=>{reads++;return {tenant:f.data.tenants[0]};}}:{tenant:f.data.tenants[0]});
 await settle();assert.equal(form.resetCount??0,0);assert.equal(f.root.innerHTML.length,0);assert.equal(f.pushes.length,0);assert.equal(accessedFailure,0);assert.equal(f.storage.getItem('primecare_session'),'replacement-session');assert.equal(f.requests.length,before+(phase==='digest'?0:1));if(phase==='fetch')assert.equal(reads,0);if(key)assert.equal(f.storage.getItem(key),identity);
});

for(const status of [200,401,403])for(const mode of ['replacement','logout','remount','detached','path','storage'])test(`late ${status} fetch is isolated after ${mode}`,async()=>{
 const f=browser(),pending=deferred(),ordinary=f.respond;let reads=0;
 f.respond=()=>pending.promise;const work=f.render();await settle();let retained='';
 if(mode==='replacement')replace(f);if(mode==='logout')f.storage.removeItem('primecare_session');
 if(mode==='remount'){f.respond=ordinary;await f.render();retained=f.root.innerHTML;}
 if(mode==='detached')f.root.isConnected=false;if(mode==='path')f.setUrl('/different');
 if(mode==='storage')f.storage.getItem=()=>{throw Error('storage unavailable');};
 const renders=f.root.renderCount;pending.resolve({status,ok:status===200,json:async()=>{reads++;return status===200?f.data:{error:'denied'};}});await work;
 assert.equal(reads,0);assert.equal(f.root.renderCount,renders);assert.deepEqual(f.assigned,[]);if(mode==='remount')assert.ok(f.root.innerHTML===retained,'New owner markup must remain unchanged');if(mode==='replacement')assert.equal(f.storage.getItem('primecare_session'),'replacement-session');
});

for(const reject of [false,true])test(`stale capability probe ${reject?'rejection':'fulfillment'} cannot start tenant reads`,async()=>{
 const f=browser({hash:'#accounts',role:'tenant_admin'}),pending=deferred(),ready=deferred();f.probe=()=>{ready.resolve();return pending.promise;};
 const work=f.render();await ready.promise;replace(f);if(reject)pending.reject(Error('old probe failed'));else pending.resolve(true);await work;
 assert.equal(f.requests.length,1);assert.equal(f.root.renderCount,0);assert.equal(f.root.innerHTML.length,0);assert.deepEqual(f.loads,[]);
});
test('capability probe helper microtask is guarded before tenant/cache consumption',async()=>{
 const f=browser({hash:'#accounts',role:'tenant_admin'});f.probe=()=>Promise.resolve(true).then(value=>{queueMicrotask(()=>queueMicrotask(()=>replace(f)));return value;});await f.render();assert.equal(f.requests.length,1);assert.equal(f.root.renderCount,0);
});

for(const kind of ['accounts','masters','audit','onboarding'])test(`stale ${kind} result cannot consume its payload`,async()=>{
 const f=browser({hash:'#'+kind,role:kind==='onboarding'?'platform_admin':'tenant_admin'}),ordinary=f.respond;let accesses=0;
 const key={accounts:'users',masters:'records',audit:'events',onboarding:'partners'}[kind];
 f.respond=async(url,options)=>url.endsWith('/'+kind)?{status:200,get ok(){queueMicrotask(()=>replace(f));return true;},json:async()=>({get [key](){accesses++;return [];}})}:ordinary(url,options);
 await f.render();assert.equal(accesses,0);assert.equal(f.root.renderCount,0);assert.deepEqual(f.loads,[]);
});
test('stale demo audit cannot consume its cache or start the selected destination',async()=>{
 const f=browser({hash:'#bundle',role:'code_admin'}),ordinary=f.respond;let accesses=0;
 f.data.tenants[0].slug='demo-primecare-maple-home-care';
 f.respond=async(url,options)=>url.endsWith('/audit')?{status:200,get ok(){queueMicrotask(()=>replace(f));return true;},json:async()=>({get events(){accesses++;return [];}})}:ordinary(url,options);
 await f.render();assert.equal(accesses,0);assert.deepEqual(f.loads,[]);assert.equal(f.root.renderCount,0);
});
test('stale extra-tenant read cannot insert its payload into the tenant cache',async()=>{
 const f=browser(),ordinary=f.respond;await f.render();let accesses=0;
 f.respond=async(url,options)=>url.endsWith('/tenants/tenant-extra')?{status:200,get ok(){queueMicrotask(()=>replace(f));return true;},json:async()=>({get tenant(){accesses++;return {id:'tenant-extra',slug:'extra',name:'Extra'};}})}:ordinary(url,options);
 f.dashboard.onNavigate('accounts','tenant-extra');await settle();assert.equal(accesses,0);assert.ok(!f.requests.some(r=>r.url.endsWith('/tenant-extra/accounts')));assert.equal(f.root.innerHTML.length,0);
});

for(const kind of ['user','master'])test(`stale ${kind} update cannot record saved rows or issue a list reload`,async()=>{
 const view=kind==='user'?'accounts':'masters',f=browser({hash:'#'+view,role:'tenant_admin'}),ordinary=f.respond;
 const record=kind==='user'?{id:'row-a',email:'fixture@example.invalid',roles:'admin',status:'active',canModify:true}:{id:'row-a',type:'fixture',code:'fixture',label:'Fixture',status:'active',version:3};
 f.respond=async(url,options)=>url.endsWith('/'+view)?{ok:true,status:200,json:async()=>({[kind==='user'?'users':'records']:[record]})}:ordinary(url,options);
 await f.render();const row=f.root.querySelectorAll('[data-'+kind+']')[0];assert.ok(row);let accesses=0;
 Object.defineProperty(kind==='user'?row.dataset:record,kind==='user'?'user':'id',{get(){accesses++;return 'row-a';},configurable:true});
 let beforeSettlement;
 f.respond=async()=>({status:200,json:async()=>({ok:true}),get ok(){beforeSettlement=accesses;queueMicrotask(()=>replace(f));return true;}});
 const before=f.requests.length;for(const fn of row.querySelector('button').listeners.get('click'))fn();await until(()=>beforeSettlement!==undefined);await settle();
 assert.equal(accesses,beforeSettlement);assert.equal(f.requests.length,before+1);assert.equal(f.root.innerHTML.length,0);assert.equal(pendingKeys(f).length,1);
});

for(const phase of ['fetch','body'])test(`current ${phase} failure preserves the original error and exact retry key`,async()=>{
 const {f,form}=await formFixture('account'),ordinary=f.respond;let attempt=0;
 f.respond=async(url,options)=>{if(options.method!=='POST')return ordinary(url,options);attempt++;if(attempt===1){if(phase==='fetch')throw Error('current transport failed');return {status:200,ok:true,json:async()=>{throw Error('current transport failed');}};}return Response.json({ok:true});};
 submit(form);await until(()=>f.root.innerHTML.includes('current transport failed'));const retry=f.root.querySelector('[data-cy=platform-account-form]');retry.values=form.values;submit(retry);await until(()=>attempt===2);await settle();assert.equal(retry.resetCount,1);assert.equal(pendingKeys(f).length,0);
 const successful=f.root.querySelector('[data-cy=platform-account-form]');successful.values=form.values;submit(successful);await until(()=>attempt===3);await settle();const keys=f.requests.filter(r=>r.options.method==='POST').map(r=>r.options.headers['Idempotency-Key']);assert.equal(keys[0],keys[1]);assert.notEqual(keys[1],keys[2]);
});
for(const status of [400,401,403,409,422,500,503])test(`current ${status} retains legacy errors, terminal state and retry policy`,async()=>{
 const {f,form}=await formFixture('account');f.respond=async()=>Response.json({error:'fixture rejection'},{status});submit(form);await until(()=>f.requests.some(r=>r.options.method==='POST'));await settle();
 assert.equal(form.resetCount??0,0);assert.equal(pendingKeys(f).length,status<500?0:1);
 if(status===401){assert.equal(f.storage.getItem('primecare_session'),null);assert.deepEqual(f.assigned,['/login']);assert.equal(f.root.innerHTML.length,0);}
 else{assert.ok(f.root.innerHTML.includes('fixture rejection'));assert.equal(f.storage.getItem('primecare_session'),token);if(status===403)assert.equal(f.events.get('hashchange').size,0);}
});
test('ordinary mutation preserves endpoint, bearer, body, tenant and password-excluded fingerprint',async()=>{
 const {f,form}=await formFixture('account');f.respond=async()=>Response.json({error:'retry'},{status:503});submit(form);await until(()=>f.root.innerHTML.includes('retry'));const retry=f.root.querySelector('[data-cy=platform-account-form]');retry.values=form.values.map(([key,value])=>[key,key==='password'?'synthetic-replacement':value]);submit(retry);await until(()=>f.requests.filter(r=>r.options.method==='POST').length===2);await settle();
 const calls=f.requests.filter(r=>r.options.method==='POST');assert.equal(calls[0].url,'https://gateway.invalid/v1/governance/platform/tenants/tenant-a/accounts');assert.equal(calls[0].options.headers.authorization,'Bearer '+token);assert.equal(calls[0].options.cache,'no-store');assert.equal(calls[0].options.headers['content-type'],'application/json');assert.ok(JSON.parse(calls[0].options.body).password);assert.notEqual(JSON.parse(calls[0].options.body).password,JSON.parse(calls[1].options.body).password);assert.equal(calls[0].options.headers['Idempotency-Key'],calls[1].options.headers['Idempotency-Key']);assert.ok(!pendingKeys(f)[0].includes('password'));
});
test('a changed pending record is not removed by an accepted old request',async()=>{
 const {f,form}=await formFixture('account'),ordinary=f.respond;let key;
 f.respond=async(url,options)=>options.method==='POST'?{status:200,json:async()=>({ok:true}),get ok(){key=pendingKeys(f)[0];f.storage.setItem(key,'replacement-request-key');return true;}}:ordinary(url,options);
 submit(form);await until(()=>!!key);await settle();assert.equal(form.resetCount,1);assert.equal(f.storage.getItem(key),'replacement-request-key');
});

for(const mode of ['replacement','remount'])for(const reject of [false,true])test(`logout ${reject?'rejection':'success'} cannot clear or navigate a ${mode}`,async()=>{
 const f=browser(),pending=deferred();await f.render();f.signOut=()=>pending.promise;f.root.querySelector('[data-cy=platform-logout]').onclick();await settle();let retained='';
 if(mode==='replacement')replace(f);else{await f.render();retained=f.root.innerHTML;}
 if(reject)pending.reject(Error('old signout failed'));else pending.resolve();await settle();assert.deepEqual(f.assigned,[]);assert.equal(f.storage.getItem('primecare_session'),mode==='replacement'?'replacement-session':token);if(mode==='remount'){assert.ok(f.root.innerHTML===retained,'New owner markup must remain unchanged');assert.equal(f.reloads(),0);}
});
test('current logout retains successful session removal and navigation',async()=>{
 const f=browser();await f.render();f.root.querySelector('[data-cy=platform-logout]').onclick();await settle();assert.equal(f.storage.getItem('primecare_session'),null);assert.deepEqual(f.assigned,['/login?enable-semantics=true']);assert.equal(f.root.innerHTML.length,0);
});
for(const mode of ['missing','unreadable'])test(`remount with ${mode} storage clears the old root before exit`,async()=>{
 const f=browser();await f.render();assert.ok(f.root.innerHTML);const before=f.requests.length;
 if(mode==='missing'){f.storage.removeItem('primecare_session');await f.render();assert.deepEqual(f.assigned,['/login']);}else{f.storage.getItem=()=>{throw Error('storage unavailable');};await assert.rejects(f.render(),/storage unavailable/);}
 assert.equal(f.root.innerHTML.length,0);assert.equal(f.requests.length,before);assert.equal(f.live.size,0);assert.equal(f.events.get('hashchange').size,0);
});

for(const kind of ['user','master'])test(`accepted ${kind} update retains PATCH payload, tenant, version and refresh`,async()=>{
 const view=kind==='user'?'accounts':'masters',f=browser({hash:'#'+view,role:'tenant_admin'}),ordinary=f.respond;
 const record=kind==='user'?{id:'row-a',email:'fixture@example.invalid',roles:'admin',status:'active',canModify:true}:{id:'row-a',type:'fixture',code:'fixture',label:'Fixture',status:'active',version:7};
 f.respond=async(url,options)=>options.method==='PATCH'?Response.json({ok:true}):url.endsWith('/'+view)?Response.json({[kind==='user'?'users':'records']:[record]}):ordinary(url,options);
 await f.render();const row=f.root.querySelectorAll('[data-'+kind+']')[0];row.querySelector('[data-status]').value='inactive';row.querySelector(kind==='user'?'[data-role]':'[data-label]').value=kind==='user'?'admin':'Updated fixture';
 const before=f.requests.length;for(const fn of row.querySelector('button').listeners.get('click'))fn();await until(()=>f.requests.length===before+2);await settle();const mutation=f.requests[before];
 assert.equal(mutation.options.method,'PATCH');assert.equal(mutation.url,'https://gateway.invalid/v1/governance/platform/tenants/tenant-a/'+view+'/row-a');assert.deepEqual(JSON.parse(mutation.options.body),kind==='user'?{role:'admin',status:'inactive'}:{label:'Updated fixture',status:'inactive',version:7});assert.equal(pendingKeys(f).length,0);
});
test('accepted partner activation retains its version and refreshes existing metadata',async()=>{
 const {f,form}=await formFixture('partner'),ordinary=f.respond;f.respond=async(url,options)=>options.method==='POST'?Response.json({ok:true}):ordinary(url,options);submit(form);await until(()=>form.resetCount===1);await settle();const mutation=f.requests.find(r=>r.options.method==='POST');assert.ok(mutation.url.endsWith('/onboarding/partner-a/activate'));assert.equal(JSON.parse(mutation.options.body).version,4);assert.equal(pendingKeys(f).length,0);assert.equal(f.requests.filter(r=>r.url.endsWith('/v1/governance/platform')).length,2);
});
test('current digest rejection remains visible without sending or allocating a retry key',async t=>{
 const {f,form}=await formFixture();t.mock.method(crypto.subtle,'digest',async()=>{throw Error('digest unavailable');});const before=f.requests.length;submit(form);await settle();assert.ok(f.root.innerHTML.includes('digest unavailable'));assert.equal(f.requests.length,before);assert.equal(pendingKeys(f).length,0);assert.equal(form.resetCount??0,0);
});

// This role-specific demo hydration deliberately precedes tenant selection. It
// is distinct from ordinary selected-tenant activity reads. The existing fixture
// runs the actual admin owner/request/consume code, but stubs dashboard rendering
// and HTTP; these checks do not grant permission or replace browser/server tests.
const demoSlug='demo-primecare-maple-home-care';
const demoId='demo/fixture ?';
const demoAudit='https://gateway.invalid/v1/governance/platform/tenants/'+encodeURIComponent(demoId)+'/audit';
const demoVersion='approved-code-admin-demo-v1';
const demoData=id=>({version:demoVersion,tenantIds:{example:'tenant-b'},examples:{tenants:[{id:'example'}],calls:[{id,tenant:'example'}]}});
const demoEvents=kind=>kind==='missing'?[{}, {current_state:{}}]:kind==='wrong'?[{current_state:{demoDataset:{...demoData('wrong'),version:demoVersion+'-next'}}}]:kind==='case'?[{current_state:{demoDataset:{...demoData('case'),version:demoVersion.toUpperCase()}}}]:[
 {},{current_state:{demoDataset:{...demoData('wrong'),version:'other'}}},
 {current_state:{demoDataset:demoData('first')}},{current_state:{demoDataset:demoData('second')}},
];
function demoFixture(options={},kind='valid'){
 const f=browser({role:'code_admin',...options}),ordinary=f.respond;
 f.data.tenants[0]={...f.data.tenants[0],id:demoId,slug:demoSlug};
 f.respond=(url,request)=>url===demoAudit?Promise.resolve(Response.json({events:demoEvents(kind)})):ordinary(url,request);
 return f;
}
async function selectDemoTenant(f){
 const select=f.root.querySelector('[data-cy=platform-topbar-tenant]');assert.ok(select);assert.equal(select.disabled,false);
 const before=f.root.renderCount;select.value='tenant-b';select.onchange({currentTarget:select});
 await until(()=>f.root.renderCount>before);await settle();assert.equal(f.dashboard.selected,'tenant-b');
}
async function refreshDemo(f){
 const before=f.root.renderCount,button=f.root.querySelector('[data-cy=platform-refresh]');assert.ok(button);assert.equal(button.disabled,false);button.onclick();
 await until(()=>f.root.renderCount>before);await settle();
}
function assertDemoReads(f,expected){
 const reads=f.requests.filter(r=>/\/(accounts|masters|audit)$/.test(new URL(r.url).pathname));
 assert.equal(reads.length,expected);
 for(const r of reads){assert.equal(r.url,demoAudit);assert.equal(r.options.method,'GET');assert.equal(r.options.cache,'no-store');assert.equal(r.options.headers.authorization,'Bearer '+token);assert.equal(r.options.body,undefined);assert.equal(r.options.headers['Idempotency-Key'],undefined);}
 assert.deepEqual(pendingKeys(f),[]);
}
for(const locale of ['en','fr','es'])for(const selected of [false,true])for(const kind of ['valid','missing','wrong','case'])for(const synthetic of [false,true])test(`demo hydration ${locale}, ${selected?'selected':'unselected'}, ${kind} marker, ${synthetic?'synthetic':'ordinary'} actor`,async()=>{
 const f=demoFixture({locale},kind);f.data.identity.userId=synthetic?'synthetic-demo-contract':'fixture-admin';
 await f.render();assert.equal(f.dashboard.selected,'');assertDemoReads(f,1);
 if(selected)await selectDemoTenant(f);
 await refreshDemo(f);assertDemoReads(f,2);
 assert.equal(f.dashboard.selected,selected?'tenant-b':'');assert.equal(f.dashboard.demoOnly,kind==='valid'&&!synthetic);
 assert.deepEqual(f.dashboard.demoCalls,kind==='valid'?demoData('first').examples.calls:undefined);
 assert.deepEqual(f.dashboard.demoOrder,kind==='valid'?['tenant-b']:undefined);
 assert.equal(!!f.root.querySelector('[data-cy=platform-nav-calls]'),kind==='valid');
 assert.equal(f.storage.getItem('primecare_session'),token);assert.deepEqual(f.assigned,[]);assert.equal(f.reloads(),0);
});
for(const role of ['code_admin','platform_admin'])for(const slug of [demoSlug,demoSlug.toUpperCase(),demoSlug+'-other'])for(const selected of [false,true])test(`demo lookup uses server role ${role} and exact slug ${slug}, ${selected?'selected':'unselected'}`,async()=>{
 const f=demoFixture({role});f.data.tenants[0].slug=slug;await f.render();if(selected)await selectDemoTenant(f);await refreshDemo(f);
 const match=role==='code_admin'&&slug===demoSlug;assertDemoReads(f,match?2:0);
 assert.equal(f.dashboard.selected,selected?'tenant-b':'');assert.equal(f.dashboard.demoOnly,match);
 assert.deepEqual(f.dashboard.demoCalls,match?demoData('first').examples.calls:undefined);
 assert.equal(!!f.root.querySelector('[data-cy=platform-nav-calls]'),match);
});
test('accepted demo default does not overwrite an explicit overview filter choice on refresh',async()=>{
 const f=demoFixture();await f.render();assert.equal(f.dashboard.demoOnly,true);f.dashboard.onDemoChange(false);assert.equal(f.dashboard.demoOnly,false);
 await refreshDemo(f);assert.equal(f.dashboard.demoOnly,false);assert.deepEqual(f.dashboard.demoCalls,demoData('first').examples.calls);assertDemoReads(f,2);
});
test('Code Admin accounts hash remains unselected while its approved demo is hydrated',async()=>{
 const f=demoFixture({hash:'#accounts'});await f.render();assert.equal(f.root.view,'organizations');assert.equal(f.dashboard.selected,'');assertDemoReads(f,1);
});
for(const view of ['accounts','masters','audit'])test(`tenant administrator ${view} hash retains its server-returned initial tenant without demo hydration`,async()=>{
 const f=browser({role:'tenant_admin',hash:'#'+view});f.data.tenants[0].slug=demoSlug;await f.render();
 assert.equal(f.root.view,view);assert.deepEqual(f.requests.map(r=>new URL(r.url).pathname),['/v1/governance/platform','/v1/governance/platform/tenants/tenant-a/'+view]);
 assert.equal(f.storage.getItem('primecare_session'),token);assert.deepEqual(f.assigned,[]);
});
for(const selected of [false,true])for(const phase of ['fetch','body','consume'])for(const kind of ['valid','wrong'])test(`stale demo ${phase} rejects ${kind} marker with ${selected?'selected':'unselected'} owner`,async()=>{
 const f=demoFixture(),pending=deferred(),ready=deferred();let bodyReads=0,eventReads=0,work;
 if(selected){await f.render();await selectDemoTenant(f);}
 const ordinary=f.respond,priorDashboard=f.dashboard;
 const payload={get events(){eventReads++;return demoEvents(kind);}};
 const response={status:200,get ok(){if(phase==='consume')queueMicrotask(()=>replace(f));return true;},json:()=>{bodyReads++;if(phase==='body'){ready.resolve();return pending.promise;}return Promise.resolve(payload);}};
 f.respond=(url,options)=>{if(url!==demoAudit)return ordinary(url,options);if(phase==='fetch'){ready.resolve();return pending.promise;}return Promise.resolve(response);};
 const before=f.requests.length,renders=f.root.renderCount;
 if(selected)f.root.querySelector('[data-cy=platform-refresh]').onclick();else work=f.render();
 if(phase!=='consume'){await ready.promise;replace(f);pending.resolve(phase==='fetch'?response:payload);}
 if(work)await work;await until(()=>f.root.innerHTML.length===0);await settle();
 assert.equal(eventReads,0);assert.equal(bodyReads,phase==='fetch'?0:1);assert.equal(f.root.renderCount,renders);assert.equal(f.dashboard,priorDashboard);
 assert.deepEqual(f.loads,[]);assert.equal(f.requests.length,before+2);assert.equal(f.storage.getItem('primecare_session'),'replacement-session');assert.deepEqual(f.assigned,[]);assert.deepEqual(pendingKeys(f),[]);
});
for(const selected of [false,true])for(const status of [401,403])test(`current demo ${status} fails closed for ${selected?'selected':'unselected'} owner`,async()=>{
 const f=demoFixture();if(selected){await f.render();await selectDemoTenant(f);}const ordinary=f.respond,priorDashboard=f.dashboard;
 f.respond=(url,options)=>url===demoAudit?Promise.resolve(Response.json({error:'Demo audit denied'},{status})):ordinary(url,options);
 const before=f.requests.length,renders=f.root.renderCount;
 if(selected){f.root.querySelector('[data-cy=platform-refresh]').onclick();await until(()=>status===401?f.assigned.length===1:f.root.innerHTML.includes('Demo audit denied'));await settle();}else await f.render();
 assert.equal(f.requests.length,before+2);assert.equal(f.root.renderCount,renders);assert.equal(f.dashboard,priorDashboard);assert.deepEqual(f.loads,[]);assert.deepEqual(pendingKeys(f),[]);
 assert.equal(f.storage.getItem('primecare_session'),status===401?null:token);assert.deepEqual(f.assigned,status===401?['/login']:[]);
 assert.ok(!f.root.innerHTML.includes('data-cy="platform-nav-calls"'));
});
