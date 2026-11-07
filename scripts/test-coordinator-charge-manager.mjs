import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {resolve} from 'node:path';
import {createBrowser} from './fixtures/tenant-review-dom.mjs';

// Actual coordinator renderer, view/catalog, session transport and ScreenManager.
// Only the peripheral shell is stubbed. This is not browser acceptance evidence.
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL||process.env.DB_URL)throw Error('Database credentials forbidden in coordinator manager fixtures');
const source=resolve(process.argv[2]??process.cwd());
const built=await build({stdin:{contents:`export * from './websites/typescript/src/coordinator-charge/index';export * from './packages/primecare_ui/web/screen-manager';export * from './websites/typescript/src/managed-routes';`,resolveDir:source},bundle:true,write:false,platform:'node',format:'esm',plugins:[{name:'coordinator-shell-fixture',setup(b){
 b.onResolve({filter:/^\.\.\/shell$/},a=>a.importer.endsWith('/coordinator-charge/index.ts')?{path:a.path,namespace:'fixture'}:null);
 b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:`export const renderShell=(root,o)=>{root.renderCount=(root.renderCount??0)+1;root.innerHTML='<div data-cy="app-shell">'+o.navigation+o.controls+'<main>'+o.content+'</main></div>';};export const bindShell=()=>{};`,loader:'js'}));
}}]});
const m=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const makeData=(overrides={})=>({identity:{userId:'user-A',role:'tenant_admin'},organization:'Fixture tenant',tenant:'tenant-A',canManage:true,truncated:false,users:[{id:'user-A',name:'Fixture user',email:'fixture@example.invalid'}],tenants:[{id:'tenant-A',name:'Fixture tenant'},{id:'tenant-B',name:'Other fixture'}],assignments:[{id:'charge-A',user_id:'user-A',name:'Fixture user',email:'fixture@example.invalid',state:'active',version:3,starts_at:'2026-11-01T04:00:00Z',reason:'Fixture assignment'}],events:[],...overrides});
function fixture({manager=true,path='/coordinator-charge?tenant=tenant-A&enable-semantics=true',session='token-A',data=makeData()}={}){
 const b=createBrowser('https://fixture.invalid'+path),calls=[];b.root.renderCount=0;if(session)b.sessionStorage.setItem('primecare_session',session);else b.sessionStorage.removeItem('primecare_session');
 const f={...b,calls,data,respond:async()=>Response.json(f.data),services:{layout(){},theme(){},language(){},responsive(){}}};
 f.manager=new m.ScreenManager(f.services);if(manager)m.installScreenManager(b.root,f.manager);f.manager.registerScope('entry',[m.resolveManagedRoute('/coordinator-charge','')]);
 globalThis.fetch=async(url,options)=>{calls.push({url,options});return f.respond(url,options);};f.render=()=>m.renderCoordinatorCharge(b.root,'https://gateway.invalid');f.error=()=>b.cy('error-state')?.textContent??'';f.dialog=()=>b.doc.body.querySelector('dialog');f.fire=async(node,event='click')=>{assert.ok(node,'Missing control');node.dispatchEvent({type:event});await b.settle();};return f;
}
function deferred(){let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return{promise,resolve,reject};}

test('missing coordinator registration rejects before the actual authorized read',async()=>{const f=fixture();f.manager.registerScope('entry',[]);await f.render();assert.match(f.error(),/Missing registration/);assert.equal(f.calls.length,0);});
test('retained coordinator assignment cannot dispatch after its root is replaced',async()=>{const f=fixture();await f.render();const form=f.cy('charge-form');f.root.innerHTML='<section data-cy="replacement">Replacement owner</section>';await f.fire(form,'submit');assert.equal(f.calls.length,1);assert.ok(f.cy('replacement'));});
test('late coordinator read cannot replace a newer root',async()=>{const f=fixture(),d=deferred();f.respond=()=>d.promise;const pending=f.render();f.root.innerHTML='<section data-cy="replacement">Replacement owner</section>';d.resolve(Response.json(f.data));await pending;assert.ok(f.cy('replacement'));assert.equal(f.root.renderCount,0);});
test('closed coordinator revoke dialog cannot submit its retained handler',async()=>{const f=fixture();await f.render();await f.fire(f.cy('charge-revoke'));const dialog=f.dialog(),form=dialog.querySelector('form');await f.fire(dialog.querySelector('[data-cy=charge-cancel]'));await f.fire(form,'submit');assert.equal(f.calls.length,1);assert.equal(Boolean(f.dialog()),false);});

function assignment(f){
 f.cy('charge-user').value='user-A';f.cy('charge-start').value='2026-11-10';f.cy('charge-end').value='2026-12-01';f.cy('charge-reason').value='Cover coordinator absence';
 return f.cy('charge-form');
}
async function revoke(f){await f.fire(f.cy('charge-revoke'));const dialog=f.dialog();dialog.querySelector('[data-cy=charge-revoke-reason]').value='Coordinator coverage ended';return dialog;}
const writes=f=>f.calls.filter(c=>c.options.method==='POST');
const body=c=>JSON.parse(c.options.body);
const marker={token:'token-A',id:'charge-A'};

test('missing manager rejects without reading or rendering private content',async()=>{
 const f=fixture({manager:false});await assert.rejects(f.render(),/Missing manager/);assert.match(f.error(),/Missing manager/);assert.equal(f.calls.length,0);
});
for(const connection of ['layout','theme','language','responsive']){
 test('missing '+connection+' connection fails before coordinator read',async()=>{
  const f=fixture();f.services[connection]=undefined;await f.render();assert.match(f.error(),new RegExp('Missing '+connection));assert.equal(f.calls.length,0);
 });
 test('throwing '+connection+' connection fails before coordinator read',async()=>{
  const f=fixture();f.services[connection]=()=>{throw Error('private detail');};await f.render();assert.equal(f.error(),'Screen Manager: Presentation connection failed');assert.equal(f.calls.length,0);
 });
}
test('async connection cannot authorize a read',async()=>{
 const f=fixture();f.services.language=async()=>{};await f.render();assert.match(f.error(),/Asynchronous language/);assert.equal(f.calls.length,0);
});
test('manager accepts compatible registration metadata without a stricter identity contract',async()=>{
 const f=fixture();f.manager.registerScope('entry',[{...m.resolveManagedRoute('/coordinator-charge',''),adapter:'existing-compatible-adapter',kind:'governed'}]);await f.render();assert.ok(f.cy('charge-form'));assert.equal(f.calls.length,1);
});
test('manager connections finish before the authorized GET',async()=>{
 const f=fixture(),seen=[];for(const name of Object.keys(f.services))f.services[name]=()=>seen.push(name);f.respond=async()=>{assert.deepEqual(seen.slice(-4),['layout','theme','language','responsive']);return Response.json(f.data);};await f.render();assert.equal(f.calls[0].url,'https://gateway.invalid/v1/governance/care/additional-charge?tenant=tenant-A');assert.equal(f.calls[0].options.headers.authorization,'Bearer token-A');assert.equal(f.calls[0].options.cache,'no-store');assert.equal(f.calls[0].options.headers['x-requested-with'],undefined);
});
test('missing session clears old content and redirects without reading',async()=>{
 const f=fixture({session:null});f.root.innerHTML='<div>Old private content</div>';await f.render();assert.equal(f.calls.length,0);assert.deepEqual(f.assigned,['/login?enable-semantics=true']);assert.equal(f.root.textContent,'');
});
test('wrong route cannot borrow coordinator registration',async()=>{
 const f=fixture({path:'/success?enable-semantics=true'});await f.render();assert.equal(f.calls.length,0);assert.equal(f.root.textContent,'');
});
for(const invalidation of ['root','detached','query','session','registration','pagehide','rerender']){
 test('retained controls fail closed after '+invalidation,async()=>{
  const f=fixture();await f.render();const form=assignment(f),enter=f.cy('charge-enter'),revoke=f.cy('charge-revoke'),refresh=f.cy('charge-refresh'),tenant=f.cy('charge-tenant'),back=f.cy('charge-return');
  f.sessionStorage.setItem('primecare_care_charge',JSON.stringify(marker));
  if(invalidation==='root')f.root.innerHTML='<main data-cy="replacement">New owner</main>';
  if(invalidation==='detached')f.root.remove();
  if(invalidation==='query')f.go('/coordinator-charge?tenant=tenant-B&enable-semantics=true');
  if(invalidation==='session')f.sessionStorage.setItem('primecare_session','token-B');
  if(invalidation==='registration')f.manager.registerScope('entry',[]);
  if(invalidation==='pagehide')f.event('pagehide',{persisted:false});
  if(invalidation==='rerender')await f.render();
  const count=f.calls.length;
  for(const [control,event]of [[form,'submit'],[enter,'click'],[revoke,'click'],[refresh,'click'],[tenant,'change'],[back,'click']])await f.fire(control,event);
  assert.equal(f.calls.length,count);assert.equal(f.dialog(),null);assert.deepEqual(f.assigned,[]);assert.equal(f.sessionStorage.getItem('primecare_care_charge'),JSON.stringify(marker));
  if(invalidation==='root')assert.ok(f.cy('replacement'));
  if(invalidation==='registration')assert.match(f.error(),/Missing registration/);
 });
}
for(const invalidation of ['root','query','session','registration','pagehide','rerender']){
 for(const result of ['success','401','network','json']){
  test('pending read '+result+' cannot affect '+invalidation+' replacement',async()=>{
   const f=fixture(),d=deferred();f.respond=()=>d.promise;const pending=f.render();
   if(invalidation==='root')f.root.innerHTML='<main data-cy="replacement">New owner</main>';
   if(invalidation==='query')f.go('/coordinator-charge?tenant=tenant-B&enable-semantics=true');
   if(invalidation==='session')f.sessionStorage.setItem('primecare_session','token-B');
   if(invalidation==='registration')f.manager.registerScope('entry',[]);
   if(invalidation==='pagehide')f.event('pagehide',{persisted:false});
   if(invalidation==='rerender'){f.respond=async()=>Response.json(makeData({organization:'Replacement organization'}));await f.render();}
   if(result==='network')d.reject(Error('offline'));else if(result==='json')d.resolve(new Response('invalid',{status:401}));else d.resolve(Response.json(result==='401'?{error:'expired'}:f.data,{status:result==='401'?401:200}));
   await pending;
   assert.deepEqual(f.assigned,[]);assert.equal(f.sessionStorage.getItem('primecare_session'),invalidation==='session'?'token-B':'token-A');
   if(invalidation==='root')assert.ok(f.cy('replacement'));
   if(invalidation==='rerender')assert.match(f.root.textContent,/Replacement organization/);
   if(invalidation==='registration')assert.match(f.error(),/Missing registration/);
  });
 }
}
test('fresh 401 still signs out the current session and clears charge marker',async()=>{
 const f=fixture();f.sessionStorage.setItem('primecare_care_charge',JSON.stringify(marker));f.respond=async()=>Response.json({error:'expired'},{status:401});await f.render();assert.equal(f.sessionStorage.getItem('primecare_session'),null);assert.equal(f.sessionStorage.getItem('primecare_care_charge'),null);assert.deepEqual(f.assigned,['/login?enable-semantics=true']);assert.equal(f.root.textContent,'');
});
test('ordinary read failure exposes safe text and retry uses the original tenant',async()=>{
 const f=fixture();f.respond=async()=>Response.json({error:'<private-error>'},{status:503});await f.render();assert.equal(f.root.querySelector('[role=alert]').textContent,'<private-error>');f.respond=async()=>Response.json(f.data);await f.fire(f.cy('charge-retry'));assert.ok(f.cy('charge-form'));assert.equal(f.calls.length,2);assert.ok(f.calls.every(c=>c.url.endsWith('?tenant=tenant-A')));
});
test('retained error retry cannot fetch after root replacement',async()=>{
 const f=fixture();f.respond=async()=>{throw Error('offline');};await f.render();const retry=f.cy('charge-retry');f.root.innerHTML='<main data-cy="replacement">New owner</main>';await f.fire(retry);assert.equal(f.calls.length,1);assert.ok(f.cy('replacement'));
});
test('assignment preserves endpoint, body, session and idempotency headers',async()=>{
 const f=fixture();await f.render();await f.fire(assignment(f),'submit');assert.equal(writes(f).length,1);assert.deepEqual(body(writes(f)[0]),{action:'assign',userId:'user-A',startsOn:'2026-11-10',endsOn:'2026-12-01',reason:'Cover coordinator absence'});assert.equal(writes(f)[0].options.headers.authorization,'Bearer token-A');assert.match(writes(f)[0].options.headers['idempotency-key'],/^[A-Za-z0-9_-]{16,100}$/);assert.equal(f.calls.length,3);assert.match(f.cy('charge-status').textContent,/saved to PostgreSQL/);
});
test('assignment errors preserve the draft and reuse only the failed payload retry identity',async()=>{
 const f=fixture();await f.render();const form=assignment(f);f.respond=async()=>Response.json({error:'version conflict'},{status:409});await f.fire(form,'submit');assert.equal(f.cy('charge-form'),form);assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');assert.equal(f.cy('charge-assign').disabled,false);assert.match(f.cy('charge-status').textContent,/version conflict/);await f.fire(form,'submit');assert.equal(writes(f)[0].options.headers['idempotency-key'],writes(f)[1].options.headers['idempotency-key']);f.cy('charge-reason').value='Changed coordinator coverage';await f.fire(form,'submit');assert.notEqual(writes(f)[1].options.headers['idempotency-key'],writes(f)[2].options.headers['idempotency-key']);
});
test('repeated assignment and refresh while writing dispatch exactly one mutation',async()=>{
 const f=fixture();await f.render();const form=assignment(f),d=deferred();f.respond=(_u,o)=>o.method==='POST'?d.promise:Promise.resolve(Response.json(f.data));form.dispatchEvent({type:'submit'});await f.fire(form,'submit');await f.fire(f.cy('charge-refresh'));assert.equal(writes(f).length,1);assert.equal(f.calls.length,2);d.resolve(Response.json({ok:true}));await f.settle();assert.equal(f.calls.length,3);
});
test('enter retains server check before session marker and live care navigation',async()=>{
 const f=fixture();await f.render();const d=deferred();f.respond=()=>d.promise;f.cy('charge-enter').click();assert.equal(f.sessionStorage.getItem('primecare_care_charge'),null);assert.deepEqual(f.assigned,[]);assert.deepEqual(body(writes(f)[0]),{action:'enter',id:'charge-A'});d.resolve(Response.json({ok:true}));await f.settle();assert.deepEqual(JSON.parse(f.sessionStorage.getItem('primecare_care_charge')),marker);assert.deepEqual(f.assigned,['/care?dataset=live&enable-semantics=true']);
});
for(const action of ['assign','enter','revoke']){
 for(const invalidation of ['root','query','session','registration','rerender']){
  for(const status of [200,401]){
   test('pending '+action+' '+status+' cannot affect '+invalidation+' replacement',async()=>{
    const f=fixture();await f.render();const d=deferred();f.respond=()=>d.promise;f.sessionStorage.setItem('primecare_care_charge',JSON.stringify(marker));
    if(action==='assign')assignment(f).dispatchEvent({type:'submit'});
    if(action==='enter')f.cy('charge-enter').click();
    if(action==='revoke'){const dialog=await revoke(f);dialog.querySelector('form').dispatchEvent({type:'submit'});}
    assert.equal(writes(f).length,1);
    if(invalidation==='root')f.root.innerHTML='<main data-cy="replacement">New owner</main>';
    if(invalidation==='query')f.go('/coordinator-charge?tenant=tenant-B&enable-semantics=true');
    if(invalidation==='session')f.sessionStorage.setItem('primecare_session','token-B');
    if(invalidation==='registration')f.manager.registerScope('entry',[]);
    if(invalidation==='rerender'){f.respond=async()=>Response.json(makeData({organization:'Replacement organization'}));await f.render();}
    const count=f.calls.length;d.resolve(Response.json(status===401?{error:'expired'}:{ok:true},{status}));await f.settle();
    assert.equal(f.calls.length,count);assert.deepEqual(f.assigned,[]);assert.equal(f.sessionStorage.getItem('primecare_care_charge'),JSON.stringify(marker));assert.equal(f.sessionStorage.getItem('primecare_session'),invalidation==='session'?'token-B':'token-A');
    if(invalidation==='root')assert.ok(f.cy('replacement'));
    if(invalidation==='rerender')assert.match(f.root.textContent,/Replacement organization/);
   });
  }
 }
}
test('revoke preserves ID, numeric version and reason, clears matching marker and refreshes',async()=>{
 const f=fixture();await f.render();f.sessionStorage.setItem('primecare_care_charge',JSON.stringify(marker));const dialog=await revoke(f);await f.fire(dialog.querySelector('form'),'submit');assert.deepEqual(body(writes(f)[0]),{action:'revoke',id:'charge-A',version:3,reason:'Coordinator coverage ended'});assert.equal(f.sessionStorage.getItem('primecare_care_charge'),null);assert.equal(f.dialog(),null);assert.equal(f.calls.length,3);assert.match(f.cy('charge-status').textContent,/Primary role retained/);
});
for(const stored of ['{invalid',JSON.stringify({token:'token-A',id:'other'})]){
 test('revoke completion survives unrelated or malformed optional marker '+stored,async()=>{
  const f=fixture();await f.render();f.sessionStorage.setItem('primecare_care_charge',stored);const dialog=await revoke(f);await f.fire(dialog.querySelector('form'),'submit');assert.equal(f.sessionStorage.getItem('primecare_care_charge'),stored);assert.equal(f.dialog(),null);assert.match(f.cy('charge-status').textContent,/Additional charge ended/);
 });
}
test('revoke error preserves reason and version for an idempotent retry',async()=>{
 const f=fixture();await f.render();const dialog=await revoke(f),form=dialog.querySelector('form');f.respond=async()=>Response.json({error:'version conflict'},{status:409});await f.fire(form,'submit');assert.equal(f.dialog(),dialog);assert.equal(dialog.querySelector('[data-cy=charge-revoke-reason]').value,'Coordinator coverage ended');assert.match(dialog.querySelector('[role=alert]').textContent,/version conflict/);assert.equal(dialog.querySelector('[data-cy=charge-confirm-revoke]').disabled,false);await f.fire(form,'submit');assert.equal(writes(f)[0].options.headers['idempotency-key'],writes(f)[1].options.headers['idempotency-key']);assert.equal(body(writes(f)[1]).version,3);
});
for(const close of ['cancel','escape','close','remove']){
 test('dialog '+close+' invalidates retained confirmation and permits a fresh dialog',async()=>{
  const f=fixture();await f.render();const dialog=await revoke(f),form=dialog.querySelector('form');
  if(close==='cancel')dialog.querySelector('[data-cy=charge-cancel]').click();
  if(close==='escape')dialog.dispatchEvent({type:'cancel'});
  if(close==='close')dialog.close();
  if(close==='remove')dialog.remove();
  await f.fire(form,'submit');assert.equal(writes(f).length,0);assert.equal(f.dialog(),null);await revoke(f);assert.ok(f.dialog());assert.notEqual(f.dialog(),dialog);
 });
}
test('closing pending revoke suppresses refresh, error and marker changes',async()=>{
 const f=fixture();await f.render();const dialog=await revoke(f),d=deferred();f.sessionStorage.setItem('primecare_care_charge',JSON.stringify(marker));f.respond=()=>d.promise;dialog.querySelector('form').dispatchEvent({type:'submit'});dialog.dispatchEvent({type:'cancel'});d.resolve(Response.json({ok:true}));await f.settle();assert.equal(f.calls.length,2);assert.equal(f.dialog(),null);assert.equal(f.sessionStorage.getItem('primecare_care_charge'),JSON.stringify(marker));
});
test('refresh preserves unsaved assignment without an unregistered confirmation prompt',async()=>{
 const f=fixture();await f.render();assignment(f);f.events.confirm=()=>{throw Error('Unexpected confirmation');};await f.fire(f.cy('charge-refresh'));assert.equal(f.calls.length,2);assert.equal(f.cy('charge-user').value,'user-A');assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');assert.equal(f.cy('charge-start').value,'2026-11-10');
});
test('refresh cannot restore a user absent from the new server options',async()=>{
 const f=fixture();await f.render();assignment(f);f.data=makeData({users:[{id:'user-B',name:'Other user',email:'other@example.invalid'}]});await f.fire(f.cy('charge-refresh'));assert.equal(f.cy('charge-user').value,'');assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');
});
test('refresh cannot restore assignment controls when server removes management',async()=>{
 const f=fixture();await f.render();const retained=assignment(f);f.data=makeData({canManage:false,users:[]});await f.fire(f.cy('charge-refresh'));assert.equal(f.cy('charge-form'),null);await f.fire(retained,'submit');assert.equal(writes(f).length,0);
});
test('failed refresh keeps assignment draft and inline error',async()=>{
 const f=fixture();await f.render();const form=assignment(f);f.respond=async()=>{throw Error('network unavailable');};await f.fire(f.cy('charge-refresh'));assert.equal(f.cy('charge-form'),form);assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');assert.match(f.cy('charge-status').textContent,/network unavailable/);
});
test('a read started before assignment editing cannot replace the draft',async()=>{
 const f=fixture();await f.render();const d=deferred();f.respond=()=>d.promise;f.cy('charge-refresh').click();const form=assignment(f);d.resolve(Response.json(f.data));await f.settle();assert.equal(f.cy('charge-form'),form);assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');
});
test('a read started before a dialog cannot remove its reason',async()=>{
 const f=fixture();await f.render();const d=deferred();f.respond=()=>d.promise;f.cy('charge-refresh').click();const dialog=await revoke(f);d.resolve(Response.json(f.data));await f.settle();assert.equal(f.dialog(),dialog);assert.equal(dialog.querySelector('[data-cy=charge-revoke-reason]').value,'Coordinator coverage ended');
});
test('refresh is blocked while a revoke draft is open',async()=>{
 const f=fixture();await f.render();const dialog=await revoke(f);await f.fire(f.cy('charge-refresh'));assert.equal(f.calls.length,1);assert.equal(f.dialog(),dialog);
});
test('successful revoke preserves an unrelated assignment draft across refresh',async()=>{
 const f=fixture();await f.render();assignment(f);const dialog=await revoke(f);await f.fire(dialog.querySelector('form'),'submit');assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');assert.equal(f.cy('charge-start').value,'2026-11-10');assert.match(f.cy('charge-status').textContent,/Additional charge ended/);
});
test('latest refresh wins and a stale read cannot overwrite it',async()=>{
 const f=fixture();await f.render();const first=deferred(),second=deferred();let n=0;f.respond=()=>++n===1?first.promise:second.promise;f.cy('charge-refresh').click();f.cy('charge-refresh').click();second.resolve(Response.json(makeData({organization:'Latest snapshot'})));await f.settle();first.resolve(Response.json(makeData({organization:'Older snapshot'})));await f.settle();assert.match(f.root.textContent,/Latest snapshot/);assert.doesNotMatch(f.root.textContent,/Older snapshot/);
});
test('a pre-mutation read cannot redraw while the assignment is pending',async()=>{
 const f=fixture();await f.render();const read=deferred(),write=deferred();let reads=0;f.respond=(_u,o)=>o.method==='POST'?write.promise:++reads===1?read.promise:Promise.resolve(Response.json(f.data));f.cy('charge-refresh').click();const form=assignment(f);form.dispatchEvent({type:'submit'});read.resolve(Response.json(makeData({organization:'Old read'})));await f.settle();assert.equal(f.cy('charge-form'),form);assert.equal(f.cy('charge-assign').disabled,true);write.resolve(Response.json({ok:true}));await f.settle();assert.match(f.cy('charge-status').textContent,/saved to PostgreSQL/);
});
test('BFCache suspension preserves drafts and suppresses interactions until restoration',async()=>{
 const f=fixture();await f.render();const form=assignment(f),dialog=await revoke(f);f.event('pagehide',{persisted:true});await f.fire(form,'submit');await f.fire(dialog.querySelector('form'),'submit');assert.equal(f.calls.length,1);assert.equal(f.dialog(),dialog);f.event('pageshow',{persisted:true});await f.fire(dialog.querySelector('[data-cy=charge-cancel]'));assert.equal(f.cy('charge-form'),form);await f.fire(form,'submit');assert.equal(writes(f).length,1);
});
test('BFCache holds pending read until a valid restore',async()=>{
 const f=fixture(),d=deferred();f.respond=()=>d.promise;const pending=f.render();f.event('pagehide',{persisted:true});d.resolve(Response.json(f.data));await f.settle();assert.equal(f.root.renderCount,0);f.event('pageshow',{persisted:true});await pending;assert.equal(f.root.renderCount,1);assert.ok(f.cy('charge-form'));
});
test('BFCache holds pending enter then navigates exactly once on restore',async()=>{
 const f=fixture();await f.render();const d=deferred();f.respond=()=>d.promise;f.cy('charge-enter').click();f.event('pagehide',{persisted:true});d.resolve(Response.json({ok:true}));await f.settle();assert.equal(f.sessionStorage.getItem('primecare_care_charge'),null);assert.deepEqual(f.assigned,[]);f.event('pageshow',{persisted:true});await f.settle();assert.deepEqual(f.assigned,['/care?dataset=live&enable-semantics=true']);f.event('pageshow',{persisted:true});await f.settle();assert.equal(f.assigned.length,1);
});
test('BFCache restore with replaced session suppresses an old 401',async()=>{
 const f=fixture(),d=deferred();f.respond=()=>d.promise;const pending=f.render();f.event('pagehide',{persisted:true});d.resolve(Response.json({error:'expired'},{status:401}));await f.settle();f.sessionStorage.setItem('primecare_session','token-B');f.event('pageshow',{persisted:true});await pending;assert.equal(f.sessionStorage.getItem('primecare_session'),'token-B');assert.deepEqual(f.assigned,[]);assert.equal(f.root.textContent,'');
});
test('page destruction releases observers and event handlers and closes dialogs',async()=>{
 const f=fixture();await f.render();await revoke(f);f.event('pagehide',{persisted:false});await f.settle();assert.equal(f.dialog(),null);assert.equal(f.observers.size,0);for(const name of ['popstate','hashchange','pagehide','pageshow'])assert.equal(f.events.listeners.get(name)?.size??0,0);
});
test('tenant navigation keeps existing query contract and retires old controls',async()=>{
 const f=fixture();await f.render();const form=assignment(f),tenant=f.cy('charge-tenant');tenant.value='tenant-B';await f.fire(tenant,'change');assert.deepEqual(f.assigned,['/coordinator-charge?tenant=tenant-B&enable-semantics=true']);f.event('pagehide',{persisted:false});await f.fire(form,'submit');assert.equal(writes(f).length,0);
});
test('return navigation clears charge marker and prevents retained controls',async()=>{
 const f=fixture();await f.render();f.sessionStorage.setItem('primecare_care_charge',JSON.stringify(marker));const enter=f.cy('charge-enter');await f.fire(f.cy('charge-return'));assert.equal(f.sessionStorage.getItem('primecare_care_charge'),null);f.event('pagehide',{persisted:false});await f.fire(enter);assert.equal(writes(f).length,0);
});
test('server-filtered nonmanager response does not invent assign or revoke actions',async()=>{
 const f=fixture({data:makeData({canManage:false,assignments:[],users:[]})});await f.render();assert.equal(f.cy('charge-form'),null);assert.equal(f.cy('charge-revoke'),null);assert.equal(f.cy('charge-enter'),null);assert.equal(f.calls.length,1);
});

test('failed enter navigation restores controls and permits retry',async()=>{
 const f=fixture();await f.render();const original=f.location.assign;f.location.assign=()=>{throw Error('Navigation unavailable');};await f.fire(f.cy('charge-enter'));assert.equal(f.cy('charge-enter').disabled,false);assert.match(f.cy('charge-status').textContent,/Navigation unavailable/);f.location.assign=original;await f.fire(f.cy('charge-enter'));assert.deepEqual(f.assigned,['/care?dataset=live&enable-semantics=true']);assert.equal(writes(f).length,2);
});
test('failed tenant navigation leaves current owner recoverable',async()=>{
 const f=fixture();await f.render();f.location.assign=()=>{throw Error('Navigation unavailable');};await f.fire(f.cy('charge-tenant'),'change');assert.match(f.cy('charge-status').textContent,/Navigation unavailable/);await f.fire(f.cy('charge-refresh'));assert.equal(f.calls.length,2);assert.ok(f.cy('charge-form'));
});
test('a later canceled link click does not retire the current document',async()=>{
 const f=fixture();await f.render();const back=f.cy('charge-return');back.addEventListener('click',event=>event.preventDefault());await f.fire(back);await f.fire(f.cy('charge-refresh'));assert.equal(f.calls.length,2);assert.ok(f.cy('charge-form'));
});
test('current 401 storage failure is contained in the route error state',async()=>{
 const f=fixture();f.respond=async()=>Response.json({error:'expired'},{status:401});f.sessionStorage.removeItem=()=>{throw Error('Storage denied');};await f.render();assert.match(f.error(),/Session storage is unavailable/);assert.deepEqual(f.assigned,[]);
});
test('navigation accepted without departure keeps canceled-beforeunload recovery possible',async()=>{
 const f=fixture();await f.render();await f.fire(f.cy('charge-enter'));assert.equal(f.cy('charge-enter').disabled,false);await f.fire(f.cy('charge-refresh'));assert.equal(f.calls.length,3);assert.ok(f.cy('charge-form'));
});

test('malformed initial read remains a recoverable route error',async()=>{
 const f=fixture();f.respond=async()=>Response.json({unexpected:'shape'});await f.render();assert.ok(f.cy('charge-retry'));assert.ok(f.root.querySelector('[role=alert]').textContent);f.respond=async()=>Response.json(f.data);await f.fire(f.cy('charge-retry'));assert.ok(f.cy('charge-form'));assert.equal(f.calls.length,2);
});
test('malformed refresh keeps draft and live retry controls',async()=>{
 const f=fixture();await f.render();const form=assignment(f);f.respond=async()=>Response.json({unexpected:'shape'});await f.fire(f.cy('charge-refresh'));assert.equal(f.cy('charge-form'),form);assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');assert.ok(f.cy('charge-status').textContent);f.respond=async()=>Response.json(f.data);await f.fire(f.cy('charge-refresh'));assert.equal(f.calls.length,3);assert.equal(f.cy('charge-reason').value,'Cover coordinator absence');
});
