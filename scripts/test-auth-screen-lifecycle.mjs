import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp,writeFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {createBrowser,Element} from './fixtures/tenant-review-dom.mjs';
const directory=await mkdtemp(join(tmpdir(),'auth-lifecycle-'));
after(()=>rm(directory,{recursive:true,force:true}));
const bundle=await build({stdin:{contents:`export {renderAuth} from './websites/typescript/src/auth-screen';export {requestMfa} from './websites/typescript/src/auth-mfa';export {ScreenManager,installScreenManager} from './packages/primecare_ui/web/screen-manager';export {resolveManagedRoute} from './websites/typescript/src/managed-routes';`,resolveDir:process.cwd()},bundle:true,write:false,format:'esm',platform:'node'});
await writeFile(join(directory,'sources.mjs'),bundle.outputFiles[0].text);
const code=await import(pathToFileURL(join(directory,'sources.mjs')));
// Extend only the existing minimal DOM's browser APIs, not production auth behavior.
Element.prototype.reset=function(){for(const field of this.querySelectorAll('input'))field.value='';};
Element.prototype.reportValidity=()=>true;
Object.defineProperty(Element.prototype,'classList',{get(){return {toggle(){},add(){},remove(){}};}});
let sequence=0;
async function fixture({mfa=false,delay='',failMe=false,failure='',path='/login',locale='en',roles='maintenance'}={}){
 const b=createBrowser(`https://fixture.invalid${path}?locale=${locale}&enable-semantics=true`);b.doc.documentElement.lang=locale;b.sessionStorage.removeItem('primecare_session');
 globalThis.getComputedStyle=()=>({getPropertyValue:()=>''});
 let release;const pending=new Promise(resolve=>release=resolve),calls=[];const token='b'.repeat(43);
 globalThis.fetch=async(url,init={})=>{const endpoint=new URL(url).pathname;calls.push({endpoint,init});if(endpoint.includes('screen-text'))return Response.json({screens:[]});if(endpoint.endsWith('/'+delay))await pending;
  if(failure&&endpoint.endsWith('/'+delay)){if(failure==='network')throw Error('Synthetic network failure');if(failure==='parse')return new Response('{', {status:200});return Response.json({error:'fixture rejection'},{status:401});}
  if(endpoint.endsWith('/login'))return Response.json(mfa?{status:'mfa_required',challenge:'a'.repeat(43),purpose:'enroll',setupKey:'A'.repeat(32)}:{token});
  if(endpoint.endsWith('/mfa'))return Response.json({status:'authenticated',token});
  if(endpoint.endsWith('/me'))return failMe?Response.json({error:'fixture rejection'},{status:401}):Response.json({userId:'fixture-user',roles,status:'authenticated'});
  if(endpoint.endsWith('/logout'))return Response.json({status:'signed_out'});throw Error('Unexpected fixture endpoint');};
 const services=Object.fromEntries(['layout','theme','language','responsive'].map(name=>[name,()=>{}]));const manager=new code.ScreenManager(services);code.installScreenManager(b.root,manager);const entry=code.resolveManagedRoute(path,path==='/login'?'co':'au');manager.registerScope('entry',[entry]);
 let dispose;const gateway='https://fixture-'+(++sequence)+'.invalid';await manager.present(entry.id,entry.route,()=>{dispose=code.renderAuth(b.root,gateway,'Fixture',locale);});
 const form=b.cy('login-form');form.querySelector('[name=email]').value='fixture@example.invalid';form.querySelector('[name=password]').value='Synthetic-only-password';
 const submit=()=>form.dispatchEvent({type:'submit'}),count=suffix=>calls.filter(c=>c.endpoint.endsWith('/'+suffix)).length;
 const mutate=change=>{if(change==='replacement')b.root.innerHTML='<main data-cy="replacement">Replacement</main>';if(change==='detach')b.root.remove();if(change==='query')b.go(path+'?locale=es&enable-semantics=true');if(change==='route')b.go('/forgot-password?enable-semantics=true');if(change==='new-session')b.sessionStorage.setItem('primecare_session','newer-fixture-session');if(change==='same-token')b.sessionStorage.setItem('primecare_session',token);if(change==='reentry')code.renderAuth(b.root,gateway,'Replacement');if(change==='dispose')dispose();if(change==='pagehide')b.event('pagehide',{persisted:false});if(change==='bfcache')b.event('pagehide',{persisted:true});if(change==='registration')manager.registerScope('entry',[]);if(change==='connection')services.theme=()=>{throw Error('Fixture lost theme');};};
 return {...b,submit,count,mutate,release,token,calls,dispose,manager};
}
const retired=['replacement','detach','query','route','new-session','same-token','reentry','dispose','pagehide','registration','connection'];
for(const change of retired)test('retained login rejects '+change,async()=>{const f=await fixture();f.mutate(change);await f.settle();f.submit();await f.settle();assert.equal(f.count('login'),0);assert.equal(f.assigned.length,0);});
for(const delay of ['login','me'])for(const change of retired)test('pending '+delay+' retires on '+change,async()=>{const f=await fixture({delay});f.submit();await f.settle();f.mutate(change);f.release();await f.settle();assert.equal(f.assigned.length,0);assert.equal(f.count('logout'),change==='same-token'?0:1);if(change==='new-session')assert.equal(f.sessionStorage.getItem('primecare_session'),'newer-fixture-session');else if(change==='same-token')assert.equal(f.sessionStorage.getItem('primecare_session'),f.token);else assert.equal(f.sessionStorage.getItem('primecare_session'),null);if(change==='replacement')assert.ok(f.cy('replacement'));});
for(const change of retired.filter(c=>c!=='connection'))for(const delayed of [false,true])test('MFA '+(delayed?'pending':'retained')+' rejects '+change,async()=>{const f=await fixture({mfa:true,delay:delayed?'mfa':''});f.submit();await f.settle();const form=f.cy('mfa-form'),input=f.cy('mfa-code');assert.ok(form);input.value='123456';if(delayed){form.dispatchEvent({type:'submit'});await f.settle();assert.equal(f.count('mfa'),1);}f.mutate(change);await f.settle();if(!delayed)form.dispatchEvent({type:'submit'});f.release();await f.settle();assert.equal(f.assigned.length,0);assert.equal(f.count('mfa'),delayed?1:0);assert.equal(f.count('logout'),delayed&&change!=='same-token'?1:0);assert.equal(input.value,'');assert.equal(form.querySelector('[data-cy=mfa-seed]')===null,true);});
for(const change of ['replacement','new-session','registration'])test('late challenge cannot mount after '+change,async()=>{const f=await fixture({mfa:true,delay:'login'});f.submit();f.mutate(change);f.release();await f.settle();assert.equal(f.cy('mfa-form')===null,true);assert.equal(f.count('mfa'),0);assert.equal(f.assigned.length,0);});
for(const change of ['new-session','same-token'])test('failed confirmation preserves '+change,async()=>{const f=await fixture({delay:'me',failMe:true});f.submit();await f.settle();f.mutate(change);f.release();await f.settle();assert.equal(f.count('logout'),change==='same-token'?0:1);assert.equal(f.sessionStorage.getItem('primecare_session'),change==='same-token'?f.token:'newer-fixture-session');assert.equal(f.assigned.length,0);});
for(const mfa of [false,true])for(const changed of [false,true])test('BFCache '+mfa+' resumes only unchanged owner '+changed,async()=>{const f=await fixture({mfa,delay:mfa?'mfa':'me'});f.submit();await f.settle();if(mfa){f.cy('mfa-code').value='123456';f.cy('mfa-form').dispatchEvent({type:'submit'});await f.settle();assert.equal(f.count('mfa'),1);}f.mutate('bfcache');f.release();await f.settle();assert.equal(f.assigned.length,0);assert.equal(f.count('logout'),0);if(changed)f.mutate('new-session');f.event('pageshow',{persisted:true});await f.settle();assert.equal(f.assigned.length,changed?0:1);assert.equal(f.count('logout'),changed?1:0);});
for(const locale of ['en','fr','es'])test('valid fallback portal login preserves '+locale,async()=>{const f=await fixture({path:'/auth-portal',locale,roles:'tenant_admin'});f.submit();await f.settle();assert.equal(f.assigned[0],'/tenant-dashboard?'+(locale==='en'?'':'locale='+locale+'&')+'enable-semantics=true');assert.equal(f.count('logout'),0);});
test('MFA cancel allows a clean retry; direct API stays compatible',async()=>{const f=await fixture({mfa:true});f.submit();await f.settle();f.cy('mfa-cancel').click();await f.settle();assert.equal(f.cy('mfa-form')===null,true);f.submit();await f.settle();f.cy('mfa-code').value='123456';f.cy('mfa-form').dispatchEvent({type:'submit'});await f.settle();assert.equal(f.assigned.length,1);const parent=f.doc.createElement('div');f.root.append(parent);const result=code.requestMfa(parent,{challenge:'a'.repeat(43),purpose:'verify'},'en',async()=> 'synthetic-result');parent.querySelector('form').dispatchEvent({type:'submit'});assert.equal(await result,'synthetic-result');});
test('MFA retirement between verification resolution and delivery revokes its token once',async()=>{const f=await fixture(),parent=f.doc.createElement('div');f.root.append(parent);const controller=new AbortController();let discarded=0;const result=code.requestMfa(parent,{challenge:'a'.repeat(43),purpose:'verify'},'en',async()=>{queueMicrotask(()=>controller.abort());return 'synthetic-only';},controller.signal,async()=>{discarded++;});const rejected=assert.rejects(result,/cancelled/);parent.querySelector('form').dispatchEvent({type:'submit'});await rejected;await f.settle();assert.equal(discarded,1);});
test('failed storage write and failed navigation revoke an uncommitted session',async()=>{for(const failure of ['storage','navigation']){const f=await fixture();if(failure==='storage')f.sessionStorage.setItem=()=>{throw Error('Unavailable fixture storage');};else f.location.assign=()=>{throw Error('Unavailable fixture navigation');};f.submit();await f.settle();assert.equal(f.count('logout'),1);assert.equal(f.sessionStorage.getItem('primecare_session'),null);}});
test('unreadable storage after confirmation fails closed without revoking an unknown stored owner',async()=>{const f=await fixture({delay:'me'});f.submit();await f.settle();f.sessionStorage.getItem=()=>{throw Error('Unavailable fixture storage');};f.release();await f.settle();assert.equal(f.assigned.length,0);assert.equal(f.count('logout'),0);});
for(const delay of ['login','mfa'])test('BFCache pauses identity confirmation after '+delay,async()=>{const f=await fixture({mfa:delay==='mfa',delay});f.submit();await f.settle();if(delay==='mfa'){f.cy('mfa-code').value='123456';f.cy('mfa-form').dispatchEvent({type:'submit'});await f.settle();}f.mutate('bfcache');f.release();await f.settle();assert.equal(f.count('me'),0);assert.equal(f.assigned.length,0);f.event('pageshow',{persisted:true});await f.settle();assert.equal(f.count('me'),1);assert.equal(f.assigned.length,1);});
test('retired delayed login revokes issued token before requesting identity',async()=>{const f=await fixture({delay:'login'});f.submit();await f.settle();f.mutate('replacement');f.release();await f.settle();assert.equal(f.count('me'),0);assert.equal(f.count('logout'),1);assert.ok(f.cy('replacement'));});
for(const delayed of [false,true])test('nested login form retirement rejects '+(delayed?'pending':'retained')+' login',async()=>{const f=await fixture({delay:delayed?'me':''}),form=f.cy('login-form'),password=f.cy('login-password');if(delayed){f.submit();await f.settle();}form.remove();if(!delayed)f.submit();f.release();await f.settle();assert.equal(f.count('login'),delayed?1:0);assert.equal(f.count('logout'),delayed?1:0);assert.equal(f.assigned.length,0);assert.equal(password.value,'');});
for(const delayed of [false,true])test('nested MFA form retirement rejects '+(delayed?'pending':'retained')+' verification',async()=>{const f=await fixture({mfa:true,delay:delayed?'mfa':''});f.submit();await f.settle();const form=f.cy('mfa-form'),input=f.cy('mfa-code'),seed=f.cy('mfa-seed');input.value='123456';if(delayed){form.dispatchEvent({type:'submit'});await f.settle();}form.remove();if(!delayed)form.dispatchEvent({type:'submit'});await f.settle();f.release();await f.settle();assert.equal(f.count('mfa'),delayed?1:0);assert.equal(f.count('logout'),delayed?1:0);assert.equal(f.assigned.length,0);assert.equal(input.value,'');assert.equal(seed.textContent,'');assert.equal(f.cy('login-form').hidden,false);});
test('standalone MFA detects detached parent before verification',async()=>{const f=await fixture(),parent=f.doc.createElement('div');let verified=0;const result=code.requestMfa(parent,{challenge:'a'.repeat(43),purpose:'verify'},'en',async()=>{verified++;return 'synthetic';});const rejected=assert.rejects(result,/cancelled/);parent.querySelector('form')?.dispatchEvent({type:'submit'});await rejected;assert.equal(verified,0);assert.equal(parent.children.length,0);});
for(const delayed of [false,true])test('standalone MFA settles removed form and discards late token '+delayed,async()=>{const f=await fixture(),parent=f.doc.createElement('div');f.root.append(parent);let verified=0,discarded=0,release;const pending=new Promise(resolve=>release=resolve);const result=code.requestMfa(parent,{challenge:'a'.repeat(43),purpose:'enroll',setupKey:'A'.repeat(32)},'en',async()=>{verified++;if(delayed)await pending;return 'synthetic';},undefined,async()=>{discarded++;});let outcome='pending';void result.then(()=>{outcome='resolved';},()=>{outcome='rejected';});const form=parent.querySelector('form'),input=parent.querySelector('[data-cy=mfa-code]'),seed=parent.querySelector('[data-cy=mfa-seed]');input.value='123456';if(delayed){form.dispatchEvent({type:'submit'});await f.settle();}form.remove();if(!delayed)form.dispatchEvent({type:'submit'});await f.settle();release();await f.settle();assert.equal(outcome,'rejected');assert.equal(verified,delayed?1:0);assert.equal(discarded,delayed?1:0);assert.equal(input.value,'');assert.equal(seed.textContent,'');});

// A persisted show can be followed by another hide before its queued waiter runs.
for(const delay of ['login','me','mfa'])for(const cycles of [0,1,3])for(const ending of ['resume','pagehide','new-session','same-token'])test(`repeated BFCache ${delay} cycles=${cycles} ending=${ending}`,async()=>{
 const f=await fixture({mfa:delay==='mfa',delay});f.submit();await f.settle();
 if(delay==='mfa'){f.cy('mfa-code').value='123456';f.cy('mfa-form').dispatchEvent({type:'submit'});await f.settle();}
 assert.equal(f.count(delay),1);
 const status=f.cy('api-status').value,mfaStatus=f.cy('mfa-status')?.textContent;
 const assertPaused=()=>{
  assert.equal(f.sessionStorage.getItem('primecare_session'),null,'no suspended session commit');
  assert.equal(f.assigned.length,0,'no suspended navigation');
  assert.equal(f.count('logout'),0,'a suspended owner retains its provisional token');
  assert.equal(f.count('me'),delay==='me'?1:0,'no suspended identity request');
  assert.equal(f.cy('api-status').value,status,'no suspended login status update');
  if(delay==='mfa'){assert.equal(f.cy('mfa-status').textContent,mfaStatus,'no suspended MFA status update');assert.equal(f.cy('mfa-submit').disabled,true);}
 };
 f.mutate('bfcache');f.release();await f.settle();assertPaused();
 for(let cycle=0;cycle<cycles;cycle++){f.event('pageshow',{persisted:true});f.mutate('bfcache');await f.settle();assertPaused();}
 if(ending!=='resume')f.mutate(ending);
 f.event('pageshow',{persisted:true});await f.settle();
 assert.equal(f.assigned.length,ending==='resume'?1:0);
 assert.equal(f.count('me'),delay==='me'||ending==='resume'?1:0);
 assert.equal(f.count('logout'),['pagehide','new-session'].includes(ending)?1:0);
 assert.equal(f.sessionStorage.getItem('primecare_session'),ending==='new-session'?'newer-fixture-session':ending==='pagehide'?null:f.token);
 for(const call of f.calls.filter(call=>call.endpoint.endsWith('/logout')))assert.equal(new Headers(call.init.headers).get('authorization'),'Bearer '+f.token,'cleanup revokes only this attempt token');
 // Repeated retirement/resume events must never duplicate cleanup or navigation.
 f.mutate('pagehide');f.event('pageshow',{persisted:true});await f.settle();
 assert.equal(f.count('logout'),['pagehide','new-session'].includes(ending)?1:0);
 assert.equal(f.assigned.length,ending==='resume'?1:0);
});

// Error delivery observes the same lifetime as success, but failed identity cleanup is prompt.
for(const delay of ['login','me','mfa'])for(const failure of ['http','network','parse'])for(const cycles of [-1,0,3])for(const ending of ['resume','pagehide','query','new-session','same-token','registration','replacement','reentry'])test(`delayed error ${delay}/${failure} cycles=${cycles} ending=${ending}`,async()=>{
 const f=await fixture({mfa:delay==='mfa',delay,failure});f.submit();await f.settle();
 if(delay==='mfa'){f.cy('mfa-code').value='123456';f.cy('mfa-form').dispatchEvent({type:'submit'});await f.settle();}
 const loginStatus=f.cy('api-status'),mfaStatus=f.cy('mfa-status'),button=f.cy('mfa-submit');
 const loading=loginStatus.value,mfaLoading=mfaStatus?.textContent;
 // Adopted tokens must not be revoked even when confirmation fails during suspension.
 if(ending==='same-token')f.mutate(ending);
 if(cycles>=0)f.mutate('bfcache');
 if(cycles<0&&ending!=='resume'&&ending!=='same-token')f.mutate(ending);
 f.release();await f.settle();
 const assertPaused=()=>{
  assert.equal(loginStatus.value,loading,'no suspended login error');
  if(delay==='mfa'){assert.equal(mfaStatus.textContent,mfaLoading,'no suspended MFA error');assert.equal(button.disabled,true,'no suspended retry');}
  assert.equal(f.count('logout'),delay==='me'&&ending!=='same-token'?1:0,'failed identity promptly cleans only its token');
  assert.equal(f.assigned.length,0);
 };
 if(cycles>=0){assertPaused();for(let i=0;i<cycles;i++){f.event('pageshow',{persisted:true});f.mutate('bfcache');await f.settle();if(ending!=='same-token')assertPaused();}
  if(ending!=='resume'&&ending!=='same-token')f.mutate(ending);
  f.event('pageshow',{persisted:true});await f.settle();
 }
 assert.equal(f.assigned.length,0);
 assert.equal(f.count('logout'),delay==='me'&&ending!=='same-token'?1:0);
 assert.equal(f.count('me'),delay==='me'?1:0,'errors cannot proceed to identity');
 assert.equal(f.sessionStorage.getItem('primecare_session'),ending==='same-token'?f.token:ending==='new-session'?'newer-fixture-session':null);
 if(ending==='resume'){
  if(delay==='mfa'){assert.notEqual(mfaStatus.textContent,mfaLoading);assert.equal(button.disabled,false);assert.equal(f.cy('mfa-code').value,'');f.cy('mfa-code').value='654321';f.cy('mfa-form').dispatchEvent({type:'submit'});await f.settle();assert.equal(f.count('mfa'),2,'MFA can retry');}
  else{assert.notEqual(loginStatus.value,loading);f.submit();await f.settle();assert.equal(f.count('login'),2,'login can retry');}
 }else{
  assert.equal(loginStatus.value,loading,'retired login error does not mutate its old output');
  if(ending==='replacement')assert.ok(f.cy('replacement'));
  if(ending==='reentry')assert.equal(f.cy('api-status').value,'');
 }
 for(const call of f.calls.filter(call=>call.endpoint.endsWith('/logout')))assert.equal(new Headers(call.init.headers).get('authorization'),'Bearer '+f.token);
 const cleanup=f.count('logout');f.dispose();f.event('pageshow',{persisted:true});await f.settle();assert.equal(f.count('logout'),cleanup,'retirement does not duplicate cleanup');
});
