import {test} from 'node:test';
import assert from 'node:assert/strict';
import {fixture,c,catalog,configuration,deferred,invalidate} from './fixtures/maintenance-dom.mjs';
async function ready(options){const f=fixture(options);await f.render();assert.ok(f.cy(c.settings),'actual maintenance form rendered');assert.ok(f.cy('theme-center'),'actual shared Theme Center bound');assert.equal(f.calls.length,2);return f;}
const ack={message:'Settings saved. Send a test email to check delivery.'};
test('actual maintenance, transport and shared shell preserve localized current behavior',async()=>{
 for(const locale of ['en','fr','es']){const f=await ready({locale});assert.match(f.root.textContent,new RegExp(catalog.locales[locale].title));assert.ok(f.cy(c.createAccount));await f.fire(f.cy(c.refresh));assert.equal(f.calls.length,4);assert.ok(f.connections.length>=8);f.event('pagehide',{persisted:false});}
});
test('missing manager and missing session issue no private reads',async()=>{
 const f=fixture({manager:false});await f.render();assert.equal(f.calls.length,0);assert.ok(f.cy('error-state'));
 const g=fixture();g.sessionStorage.removeItem('primecare_session');await g.render();assert.equal(g.calls.length,0);assert.equal(g.assigned.length,1);assert.match(g.assigned[0],/^\/login\?returnUrl=/);
});
test('all missing, throwing and asynchronous presentation connections are contained',async()=>{
 for(const name of ['layout','theme','language','responsive'])for(const failure of ['missing','throws','async']){const f=fixture();f.services[name]=failure==='missing'?undefined:failure==='async'?async()=>{}:()=>{throw Error('private connection detail');};await f.render();assert.equal(f.calls.length,0);assert.ok(f.cy('error-state'));assert.equal(f.root.textContent.includes('private connection detail'),false);}
});
test('synchronous connection root or session replacement is not adopted before read',async()=>{
 for(const kind of ['root','session']){const f=fixture();f.services.theme=()=>invalidate(f,kind);await f.render();assert.equal(f.calls.length,0);if(kind==='root')assert.ok(f.cy('replacement'));else assert.equal(f.root.childNodes.length,0);}
});
test('actual refresh and retry re-enter manager after registration revocation',async()=>{
 for(const retry of [false,true]){const f=fixture();if(retry)f.respond=async()=>{throw new TypeError('offline');};await f.render();const refresh=f.cy(c.refresh),count=f.calls.length;invalidate(f,'manager');await f.fire(refresh);assert.equal(f.calls.length,count);assert.ok(f.cy('error-state'));assert.equal(Boolean(f.cy(c.settings)),false);}
});
test('failed current read retry recovers by identity and configuration GET only',async()=>{
 const f=fixture(),respond=f.respond;f.respond=async()=>{throw new TypeError('offline');};await f.render();assert.ok(f.cy(c.refresh));f.respond=respond;await f.fire(f.cy(c.refresh));assert.ok(f.cy(c.settings));assert.equal(f.writes().length,0);
});
for(const kind of ['root','main','query','route','session','removed','manager','connection','pagehide'])test('retained forms, refresh, email, logout and shell actions are inert after '+kind,async()=>{
 const f=await ready();const callbacks=[[c.settings,'submit'],[c.createAccount,'submit'],[c.refresh,'click'],[c.testEmail,'click'],[c.signout,'click']].map(([id,event])=>f.retained(f.cy(id),event));
 const opener=f.cy('appearance-open').onclick,theme=f.cy('theme-center-new').onclick,prior=f.calls.length;let payloadReads=0;globalThis.FormData=class{constructor(){payloadReads++;throw Error('retired payload was read');}};
 invalidate(f,kind);for(const fn of callbacks)fn();opener();theme();await f.settle();assert.equal(f.calls.length,prior);assert.equal(payloadReads,0);assert.deepEqual(f.assigned,[]);assert.equal(f.localStorage.values.size,0);if(kind==='root'||kind==='main')assert.ok(f.cy('replacement'));
});
test('pending real refresh does not overwrite replacement root on success or failure',async()=>{
 for(const failure of [false,true]){const f=await ready(),d=deferred();f.respond=async url=>url.endsWith('/me')?Response.json({userId:'fixture-user',roles:f.role}):d.promise;await f.fire(f.cy(c.refresh));invalidate(f,'root');if(failure)d.reject(Error('old failed'));else d.resolve(Response.json(configuration('obsolete@example.invalid')));await f.settle();assert.ok(f.cy('replacement'));assert.equal(f.calls.length,4);}
});
test('latest actual renderer wins over an older pending identity or configuration response',async()=>{
 for(const stage of ['identity','configuration']){const f=fixture(),d=deferred(),respond=f.respond;let held=false;f.respond=(url,o)=>!held&&(stage==='identity'||!url.endsWith('/me'))?(held=true,d.promise):respond(url,o);const older=f.render();await f.settle();f.data=configuration('latest@example.invalid');await f.render();d.resolve(Response.json(stage==='identity'?{userId:'fixture-user',roles:f.role}:configuration('obsolete@example.invalid')));await older;assert.equal(f.cy(c.sender).value,'latest@example.invalid');}
});
test('session switch during body decode preserves replacement token and new root',async()=>{
 for(const status of [200,401]){const f=await ready(),d=deferred();f.respond=async()=>({ok:status===200,status,json:()=>d.promise});await f.fire(f.cy(c.refresh));invalidate(f,'root');invalidate(f,'session');d.resolve(status===200?{userId:'old',roles:f.role}:{error:'Invalid session'});await f.settle();assert.equal(f.sessionStorage.getItem('primecare_session'),'token-B');assert.ok(f.cy('replacement'));assert.deepEqual(f.assigned,[]);}
});
test('storage read failures at entry and retained callbacks fail closed',async()=>{
 for(const initial of [false,true]){const f=initial?fixture():await ready(),refresh=initial?null:f.retained(f.cy(c.refresh)),count=f.calls.length;f.sessionStorage.getItem=()=>{throw Error('storage private');};if(initial)await f.render();else refresh();await f.settle();assert.equal(f.calls.length,count);assert.ok(f.cy('error-state'));assert.equal(f.root.textContent.includes('storage private'),false);}
});
test('save, test-email and account creation keep existing endpoints, body and acknowledgement contracts',async()=>{
 for(const action of ['save','email','create']){const f=await ready();if(action==='save')await f.fire(f.fill(c.settings,{sender:'new@example.invalid'}),'submit');if(action==='email')await f.fire(f.cy(c.testEmail));if(action==='create')await f.fire(f.fill(c.createAccount,{email:'new@example.invalid',password:'fixture-password'}),'submit');assert.equal(f.writes().length,1);const request=f.writes()[0],body=JSON.parse(request.options.body);assert.equal(request.options.method,'POST');assert.equal(request.options.cache,'no-store');assert.ok(request.options.headers['idempotency-key']);assert.equal(request.url,'https://gateway.invalid'+catalog.endpoints[action==='save'?'configuration':action==='email'?'testEmail':'createAccount']);if(action==='save'){assert.equal(body.revision,7);assert.equal(body.sender,'new@example.invalid');assert.deepEqual(body.templates,Object.fromEntries(Object.keys(f.data.templates).map(id=>[id,{subject:'Subject',title:'Title',body:'Body'}])));}if(action==='create')assert.deepEqual(body,{email:'new@example.invalid',password:'fixture-password',role:catalog.creationRole});assert.equal(f.calls.length,5);assert.ok(f.cy(c.status).value);}
});
test('readiness and account creation grants remain effective',async()=>{
 const f=fixture({role:'maintenance'});f.data.settingsReady=false;await f.render();assert.equal(Boolean(f.cy(c.createAccount)),false);assert.equal(f.cy(c.save).disabled,true);await f.fire(f.cy(c.settings),'submit');assert.equal(f.writes().length,0);await f.fire(f.cy(c.testEmail));assert.equal(f.writes().length,1);assert.equal(f.cy(c.save).disabled,true);
});
test('concurrent save, email, account, logout and refresh dispatch only the first operation',async()=>{
 const f=await ready(),d=deferred();f.respond=()=>d.promise;const form=f.cy(c.settings);await f.fire(form,'submit');await f.fire(form,'submit');await f.fire(f.cy(c.testEmail));await f.fire(f.cy(c.createAccount),'submit');await f.fire(f.cy(c.signout));await f.fire(f.cy(c.refresh));assert.equal(f.writes().length,1);assert.equal(f.calls.length,3);d.reject(Error('failed'));await f.settle();assert.equal(f.cy(c.save).disabled,false);
});
test('mutation completion cannot redraw, clear passwords, navigate or enable a replacement owner',async()=>{
 for(const failure of [false,true]){const f=await ready(),d=deferred();f.respond=()=>d.promise;await f.fire(f.cy(c.settings),'submit');invalidate(f,'root');f.root.innerHTML='<main data-cy="replacement"><input type="password" value="new password"><button disabled>New busy action</button></main>';if(failure)d.reject(Error('late failure'));else d.resolve(Response.json(ack));await f.settle();assert.ok(f.cy('replacement'));assert.equal(f.root.querySelector('input').value,'new password');assert.equal(f.root.querySelector('button').disabled,true);assert.equal(f.calls.length,3);assert.deepEqual(f.assigned,[]);}
});
test('retained previous-generation submit after successful mutation refresh reads no payload',async()=>{
 const f=await ready(),old=f.retained(f.cy(c.settings),'submit');await f.fire(f.cy(c.settings),'submit');let reads=0;globalThis.FormData=class{constructor(){reads++;}};old();await f.settle();assert.equal(reads,0);assert.equal(f.writes().length,1);
});
test('malformed mutation acknowledgement and post-acceptance read failure never claim a successful refresh',async()=>{
 for(const malformed of [false,true]){const f=await ready();f.respond=async(_u,o)=>o.method==='GET'?Response.json({error:'unavailable'},{status:503}):Response.json(malformed?{message:'unexpected'}:ack);await f.fire(f.cy(c.settings),'submit');assert.equal(f.writes().length,1);if(malformed)assert.equal(f.cy(c.status).value,catalog.locales.en.failed);else{assert.equal(Boolean(f.cy(c.status)),false);assert.ok(f.cy(c.refresh));assert.equal(f.root.textContent.includes(catalog.locales.en.server_25),false);}}
});
test('confirmed logout clears original session and navigates once; failures retain current session',async()=>{
 for(const valid of [false,true]){const f=await ready();f.respond=async()=>Response.json(valid?{status:'signed_out'}:{});await f.fire(f.cy(c.signout));assert.equal(f.writes().length,1);assert.equal(f.sessionStorage.getItem('primecare_session'),valid?null:'token-A');assert.equal(f.assigned.length,valid?1:0);if(!valid)assert.equal(f.cy(c.status).value,catalog.locales.en.failed);}
});
test('late logout cannot clear new session or navigate replacement root',async()=>{
 const f=await ready(),d=deferred();f.respond=()=>d.promise;await f.fire(f.cy(c.signout));invalidate(f,'root');invalidate(f,'session');d.resolve(Response.json({status:'signed_out'}));await f.settle();assert.ok(f.cy('replacement'));assert.equal(f.sessionStorage.getItem('primecare_session'),'token-B');assert.deepEqual(f.assigned,[]);
});
test('logout storage removal and navigation failures remain contained',async()=>{
 for(const stage of ['remove','navigate']){const f=await ready();if(stage==='remove')f.sessionStorage.removeItem=()=>{throw Error('blocked');};else f.location.assign=()=>{throw Error('blocked');};await f.fire(f.cy(c.signout));assert.equal(f.writes().length,1);assert.ok(stage==='remove'?f.cy(c.status):f.cy('error-state'));}
});
test('persisted pagehide suspends pending read until successful manager revalidation',async()=>{
 const f=fixture(),d=deferred(),respond=f.respond;f.respond=(u,o)=>u.endsWith('/me')?d.promise:respond(u,o);const pending=f.render();f.event('pagehide',{persisted:true});d.resolve(Response.json({userId:'fixture-user',roles:f.role}));await f.settle();assert.equal(f.calls.length,1);assert.equal(Boolean(f.cy(c.settings)),false);f.event('pageshow',{persisted:true});await pending;assert.ok(f.cy(c.settings));assert.equal(f.calls.length,2);
});
test('BFCache restore rejects changed manager, session and URL without extra reads',async()=>{
 for(const kind of ['manager','session','query']){const f=await ready(),refresh=f.retained(f.cy(c.refresh)),count=f.calls.length;f.event('pagehide',{persisted:true});refresh();invalidate(f,kind);f.event('pageshow',{persisted:true});refresh();await f.settle();assert.equal(f.calls.length,count);assert.equal(Boolean(f.cy(c.settings)),false);}
});
test('accepted mutation while suspended resumes by GET and never repeats the POST',async()=>{
 const f=await ready(),d=deferred(),respond=f.respond;f.respond=()=>d.promise;await f.fire(f.cy(c.settings),'submit');f.event('pagehide',{persisted:true});d.resolve(Response.json(ack));await f.settle();assert.equal(f.calls.length,3);f.respond=respond;f.event('pageshow',{persisted:true});await f.settle();assert.equal(f.writes().length,1);assert.equal(f.calls.length,5);assert.ok(f.cy(c.settings));
});
test('actual appearance and Theme Center writes are suspended and retire with the renderer',async()=>{
 const f=await ready();f.cy('appearance-open').onclick();const theme=f.cy('appearance-theme');theme.value='dark';await f.fire(theme,'change');assert.equal(f.root.querySelector('[data-cy=app-shell]').dataset.themeCenterActive,'true');const save=f.cy('appearance-save').onclick,create=f.cy('theme-center-new').onclick;f.event('pagehide',{persisted:true});save();create();await f.settle();assert.equal(f.localStorage.values.size,0);f.event('pageshow',{persisted:true});save();await f.settle();assert.equal(f.localStorage.values.size,1);const count=f.localStorage.values.size;await f.render();save();create();await f.settle();assert.equal(f.localStorage.values.size,count);
});
test('nonpersisted teardown and repeat render release listeners and actual shell observers',async()=>{
 const f=await ready();await f.render();await f.render();for(const key of ['popstate','hashchange','storage','pageshow'])assert.equal(f.events.listeners.get(key)?.size??0,1);f.event('pagehide',{persisted:false});assert.equal(f.observers.size,0);for(const key of ['popstate','hashchange','storage','pageshow','pagehide'])assert.equal(f.events.listeners.get(key)?.size??0,0);assert.equal(Boolean(f.cy('appearance-dialog')),false);
});
test('obsolete same-token 401 cannot delete a newer renderer session',async()=>{
 for(const stage of ['initial','mutation']){const f=fixture(),d=deferred(),respond=f.respond;let pending;if(stage==='initial'){f.respond=()=>d.promise;pending=f.render();await f.settle();}else{await f.render();f.respond=()=>d.promise;await f.fire(f.cy(c.settings),'submit');}f.respond=respond;await f.render();d.resolve(Response.json({error:'Invalid session'},{status:401}));if(pending)await pending;await f.settle();assert.equal(f.sessionStorage.getItem('primecare_session'),'token-A');assert.ok(f.cy(c.settings));assert.deepEqual(f.assigned,[]);}
});
test('current 401 presents localized sign-in recovery at entry, mutation and restored refresh',async()=>{
 for(const stage of ['initial','mutation','restored']){
  const f=stage==='initial'?fixture({locale:'fr'}):await ready({locale:'fr'}),d=deferred();
  f.respond=stage==='restored'?()=>d.promise:async()=>Response.json({error:'Invalid session'},{status:401});
  if(stage==='initial')await f.render();
  if(stage==='mutation')await f.fire(f.cy(c.settings),'submit');
  if(stage==='restored'){await f.fire(f.cy(c.refresh));f.event('pagehide',{persisted:true});d.resolve(Response.json({error:'Invalid session'},{status:401}));await f.settle();assert.deepEqual(f.assigned,[]);f.event('pageshow',{persisted:true});await f.settle();}
  assert.equal(f.sessionStorage.getItem('primecare_session'),null);assert.equal(Boolean(f.cy(c.settings)),false);assert.ok(f.root.textContent.includes(catalog.locales.fr.unavailable));assert.ok(f.root.textContent.includes(catalog.locales.fr.signin));assert.ok(f.root.querySelector('a'));
  const count=f.calls.length;await f.fire(f.cy(c.refresh));assert.equal(f.calls.length,count);assert.equal(f.assigned.length,1);
 }
});
test('same-token retired logout keeps replacement browser session while its server request is already dispatched',async()=>{
 const f=await ready(),d=deferred(),respond=f.respond;f.respond=()=>d.promise;await f.fire(f.cy(c.signout));f.respond=respond;await f.render();d.resolve(Response.json({status:'signed_out'}));await f.settle();assert.equal(f.sessionStorage.getItem('primecare_session'),'token-A');assert.ok(f.cy(c.settings));assert.deepEqual(f.assigned,[]);assert.equal(f.writes().length,1);
});
test('current logout accepted during persisted suspension navigates on restored ownership',async()=>{
 const f=await ready(),d=deferred();f.respond=()=>d.promise;await f.fire(f.cy(c.signout));f.event('pagehide',{persisted:true});d.resolve(Response.json({status:'signed_out'}));await f.settle();assert.deepEqual(f.assigned,[]);assert.equal(f.sessionStorage.getItem('primecare_session'),null);f.event('pageshow',{persisted:true});await f.settle();assert.equal(f.assigned.length,1);assert.equal(f.writes().length,1);
});
test('retained native link callbacks prevent stale navigation while current links remain normal',async()=>{
 const f=await ready(),link=f.root.querySelector('a'),callbacks=[...link.listeners.get('click')??[]];let prevented=false;const event={preventDefault(){prevented=true;}};for(const callback of callbacks)callback(event);assert.equal(prevented,false);invalidate(f,'query');for(const callback of callbacks)callback(event);assert.equal(prevented,true);assert.equal(f.calls.length,2);
});
