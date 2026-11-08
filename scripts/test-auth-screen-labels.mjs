import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {createBrowser,Element} from './fixtures/tenant-review-dom.mjs';

const {outputFiles}=await build({stdin:{contents:`
 export {renderAuth} from './websites/typescript/src/auth-screen';
 export {liveScreenText} from './websites/typescript/src/screen-text';
 export {ScreenManager,installScreenManager} from './packages/primecare_ui/web/screen-manager';
 export {resolveManagedRoute} from './websites/typescript/src/managed-routes';
`,resolveDir:process.cwd()},bundle:true,write:false,format:'esm',platform:'node'});
const code=await import('data:text/javascript;base64,'+Buffer.from(outputFiles[0].text).toString('base64'));
const auth=JSON.parse(await readFile('packages/primecare_ui/lib/src/localization/screens/auth.json','utf8')).locales;
Element.prototype.reset=function(){for(const field of this.querySelectorAll('input'))field.value='';};
Object.defineProperty(Element.prototype,'classList',{get(){return {toggle(){},add(){},remove(){}};}});

// Contract checks on the real renderer's markup in the existing minimal DOM.
// This does not implement accessible-name computation or replace browser/AX testing.
function assertNativeLabel(control,text,key){
 assert.equal(control.getAttribute('aria-label'),null,'native naming must not be overridden');
 assert.equal(control.getAttribute('aria-labelledby'),null,'no separate naming source');
 const container=key==='login'?control:control.closest('label');
 assert.ok(container,'input has a wrapping native label');
 if(key!=='login'){
  assert.deepEqual(container.querySelectorAll('input'),[control],'one labelable control per label');
  assert.equal(container.getAttribute('for'),null,'implicit label is not redirected');
 }
 assert.equal(container.querySelector('[data-auth-text="'+key+'"]').textContent,text);
 assert.equal(container.textContent,text,'the native name source contains only the localized text');
 for(const icon of container.querySelectorAll('svg')){
  assert.equal(icon.getAttribute('aria-hidden'),'true');
  assert.equal(icon.getAttribute('focusable'),'false');
 }
}
const keys={email:'login-email',password:'login-password',login:'login-submit'};
const edits=()=>{
 const locales=structuredClone(auth);
 // Deliberately synthetic text, including markup-like characters, never catalog translations.
 for(const [locale,values] of Object.entries(locales))for(const key of Object.keys(keys))values[key]='<fixture-'+locale+'-'+key+'> & '+values[key];
 return locales;
};
let sequence=0;
async function fixture({locale='en',cached=false,delayLogin=false}={}){
 const b=createBrowser('https://fixture.invalid/login?locale='+locale+'&enable-semantics=true');
 b.doc.documentElement.lang=locale;b.sessionStorage.removeItem('primecare_session');
 globalThis.getComputedStyle=()=>({getPropertyValue:()=>''});
 const gateway='https://login-labels-'+(++sequence)+'.invalid',calls=[];
 let release,download=null;const pending=new Promise(resolve=>release=resolve);
 globalThis.fetch=async(url,init={})=>{
  assert.equal(new URL(url).origin,gateway,'only the isolated fixture gateway is allowed');
  const endpoint=new URL(url).pathname;calls.push({endpoint,init});
  if(endpoint==='/v1/governance/screen-text')return Response.json({screens:download?[{id:'auth',version:download.version}]:[]});
  if(endpoint==='/v1/governance/screen-text/auth'){assert.ok(download);return Response.json(download);}
  if(endpoint==='/v1/auth/login'){if(delayLogin)await pending;return Response.json({token:'b'.repeat(43)});}
  if(endpoint==='/v1/auth/me')return Response.json({userId:'fixture-user',roles:'tenant_admin',status:'authenticated'});
  if(endpoint==='/v1/auth/logout')return Response.json({status:'signed_out'});
  assert.fail('Unexpected fixture endpoint');
 };
 if(cached)b.localStorage.setItem('primecare.screen-text.v1.'+encodeURIComponent(gateway),JSON.stringify({format:1,catalogs:[{screen:'auth',version:1,locales:edits()}]}));
 const store=code.liveScreenText(gateway);
 const services=Object.fromEntries(['layout','theme','language','responsive'].map(name=>[name,()=>{}]));
 const manager=new code.ScreenManager(services);code.installScreenManager(b.root,manager);
 const entry=code.resolveManagedRoute('/login','au');manager.registerScope('entry',[entry]);
 let dispose;await manager.present(entry.id,entry.route,()=>{dispose=code.renderAuth(b.root,gateway,'Fixture',locale);});
 await b.settle();
 const form=b.cy('login-form'),email=b.cy('login-email'),password=b.cy('login-password'),button=b.cy('login-submit');
 email.value='fixture@example.invalid';password.value='Synthetic-only-password';password.focus();
 return {...b,form,email,password,button,store,manager,dispose,release,calls,
  submit:()=>form.dispatchEvent({type:'submit'}),
  count:suffix=>calls.filter(c=>c.endpoint.endsWith('/'+suffix)).length,
  download:async locales=>{download={screen:'auth',version:2,locales};await store.refresh();},
 };
}

for(const locale of ['en','fr','es'])for(const [key,id] of Object.entries(keys))test(locale+' '+key+' uses native localized naming',async t=>{
 const f=await fixture({locale});t.after(f.dispose);
 assertNativeLabel(f.cy(id),auth[locale][key],key);
});
for(const locale of ['en','fr','es'])test(locale+' cached labels preserve input/button semantics and decorative icons',async t=>{
 const f=await fixture({locale,cached:true});t.after(f.dispose);
 const expected=edits()[locale];
 for(const [key,id] of Object.entries(keys))assertNativeLabel(f.cy(id),expected[key],key);
 assert.equal(f.form.getAttribute('aria-label'),auth[locale].login_body);
 for(const [control,name,type,autocomplete] of [[f.email,'email','email','username'],[f.password,'password','password','current-password']]){
  assert.equal(control.getAttribute('name'),name);assert.equal(control.getAttribute('type'),type);
  assert.equal(control.getAttribute('autocomplete'),autocomplete);assert.equal(control.hasAttribute('required'),true);
 }
 assert.equal(f.button.getAttribute('type'),'submit');
 for(const id of ['media-login-mail','media-login-key','media-login-arrow']){
  assert.equal(f.cy(id).getAttribute('aria-hidden'),'true');assert.equal(f.cy(id).getAttribute('focusable'),'false');
 }
 assert.equal(f.count('screen-text'),0,'valid cached catalog requires no fetch');
});
for(const locale of ['en','fr','es'])for(const mode of ['local','download'])test(locale+' '+mode+' text refresh keeps pending credentials, focus and submit ownership',async t=>{
 const f=await fixture({locale,delayLogin:true});t.after(()=>{f.dispose();f.release();});
 f.store.seed({auth});f.submit();await f.settle();assert.equal(f.count('login'),1);
 const update=edits();
 if(mode==='local')f.store.saveLocal('auth',0,update);else await f.download(update);
 await f.settle();
 assert.equal(f.cy('login-form'),f.form);assert.equal(f.cy('login-email'),f.email);assert.equal(f.cy('login-password'),f.password);assert.equal(f.cy('login-submit'),f.button);
 assert.equal(f.email.value,'fixture@example.invalid');assert.equal(f.password.value,'Synthetic-only-password');assert.equal(f.doc.activeElement,f.password);
 for(const [key,id] of Object.entries(keys))assertNativeLabel(f.cy(id),update[locale][key],key);
 assert.equal(f.root.querySelector('fixture-'+locale+'-email'),null,'text refresh cannot create markup');
 assert.equal(f.cy('api-status').value,auth[locale].loading);
 f.submit();await f.settle();assert.equal(f.count('login'),1,'a live update cannot unlock duplicate submission');
 assert.deepEqual(JSON.parse(f.calls.find(c=>c.endpoint.endsWith('/login')).init.body),{email:'fixture@example.invalid',password:'Synthetic-only-password'});
 f.release();await f.settle();
 assert.equal(f.count('me'),1);assert.equal(f.count('logout'),0);assert.equal(f.assigned.length,1);
 assert.equal(f.assigned[0],'/tenant-dashboard?'+(locale==='en'?'':'locale='+locale+'&')+'enable-semantics=true');
});
for(const change of ['dispose','pagehide','replacement','new-session','registration','bfcache'])test('live login label notifications respect '+change,async t=>{
 const f=await fixture({locale:'fr'});t.after(f.dispose);f.store.seed({auth});
 const label=f.email.closest('label').querySelector('[data-auth-text=email]');
 if(change==='dispose')f.dispose();
 if(change==='pagehide')f.event('pagehide',{persisted:false});
 if(change==='replacement')f.root.innerHTML='<main data-cy="replacement">Replacement</main>';
 if(change==='new-session')f.sessionStorage.setItem('primecare_session','newer-fixture-session');
 if(change==='registration')f.manager.registerScope('entry',[]);
 if(change==='bfcache')f.event('pagehide',{persisted:true});
 const update=edits();f.store.saveLocal('auth',0,update);await f.settle();
 assert.equal(label.textContent,auth.fr.email,'retired or suspended labels are not changed');
 if(change==='bfcache'){
  assert.equal(f.password.value,'Synthetic-only-password');f.submit();await f.settle();assert.equal(f.count('login'),0);
  f.event('pageshow',{persisted:true});f.store.saveLocal('auth',1,auth);
  assertNativeLabel(f.email,auth.fr.email,'email');
 }else assert.equal(f.password.value,'');
 if(change==='replacement')assert.ok(f.cy('replacement'));
 if(change==='new-session')assert.equal(f.sessionStorage.getItem('primecare_session'),'newer-fixture-session');
});
test('unsupported locale retains the existing English fallback naming',async t=>{
 const f=await fixture({locale:'de'});t.after(f.dispose);
 for(const [key,id] of Object.entries(keys))assertNativeLabel(f.cy(id),auth.en[key],key);
});
