import {createBrowser,Element as RecoveryElement} from './fixtures/tenant-review-dom.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile} from 'node:fs/promises';
const {outputFiles}=await build({stdin:{contents:`export * from './packages/primecare_ui/web/layout-customizer';export {ScreenManager,installScreenManager} from './packages/primecare_ui/web/screen-manager';export {resolveManagedRoute} from './websites/typescript/src/managed-routes';export * from './websites/typescript/src/screen-text-binding';export * from './websites/typescript/src/screen-text';export * from './websites/typescript/src/auth-recovery';export * from './websites/typescript/src/growth/enquiry';`,resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm'});
const api=await import('data:text/javascript;base64,'+Buffer.from(outputFiles[0].text).toString('base64'));
const auth=JSON.parse(await readFile('packages/primecare_ui/lib/src/localization/screens/auth.json','utf8')).locales;
const growth=JSON.parse(await readFile('packages/shared/src/growth/registry.json','utf8')).locales;
const decode=value=>value.replace(/&quot;/g,'"').replace(/&#39;/g,"'").replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
// Minimal deterministic DOM fixture, not a browser/layout/HTML-parser emulation.
class Element {
 dataset={};attributes=new Map();styles=new Map();children=[];value='';checked=false;disabled=false;isConnected=true;dir='';lang='';textContent='';
 style={getPropertyValue:key=>this.styles.get(key)??'',setProperty:(key,value)=>this.styles.set(key,value),removeProperty:key=>this.styles.delete(key)};
 constructor(doc){this.ownerDocument=doc;}
 setAttribute(key,value){this.attributes.set(key,value);}getAttribute(key){return this.attributes.get(key)??null;}removeAttribute(key){this.attributes.delete(key);}
 addEventListener(){}removeEventListener(){}focus(){this.ownerDocument.activeElement=this;}remove(){this.isConnected=false;}contains(node){return node===this||this.children.includes(node);}
 querySelector(selector){if(selector==='.app-shell')return this.shell??null;if(selector==='[data-cy=appearance-open]')return this.existingOpener??null;return this.lookup?.get(selector)??null;}
 querySelectorAll(selector){if(selector==='[data-screen-catalog][data-screen-text]')return this.leaves??[];return [];}
 get childNodes(){return this.children;}
 get firstElementChild(){return this.children[0]??null;}
 get innerHTML(){return this.html??'';}
 set innerHTML(html){this.html=html;this.children=[new Element(this.ownerDocument)];this.leaves=[];this.lookup=new Map();const fields=new Map();
  for(const match of html.matchAll(/<(\w+)\b([^>]*)>/g)){
   const [,,attrs]=match,tag=match[1];if(!/data-cy=|data-screen-catalog=/.test(attrs))continue;
   const node=new Element(this.ownerDocument);for(const attr of attrs.matchAll(/([\w-]+)="([^"]*)"/g))node.attributes.set(attr[1],decode(attr[2]));
   const cy=node.attributes.get('data-cy');if(cy)this.lookup.set('[data-cy='+cy+']',node);
   const name=node.attributes.get('name');if(name){fields.set(name,node);this.lookup.set('[name='+name+']',node);}
   node.value=node.attributes.get('value')??'';node.checked=/\schecked(?:\s|$)/.test(attrs);
   if(node.attributes.has('data-screen-catalog')){node.dataset.screenCatalog=node.attributes.get('data-screen-catalog');node.dataset.screenText=node.attributes.get('data-screen-text');node.textContent=decode(html.slice(match.index+match[0].length).split('<')[0]);this.leaves.push(node);}
   if(tag==='form')this.form=node;
  }
  if(this.form){this.form.fields=fields;this.form.elements={namedItem:name=>fields.get(name)??null};this.form.reset=()=>fields.forEach(node=>node.value='');this.form.lookup=this.lookup;}
 }
}
let id=0;
function fixture(locale='en'){
 const storage=new Map(),reads=[];const doc={};doc.documentElement=new Element(doc);doc.documentElement.lang=locale;doc.body=new Element(doc);doc.createElement=()=>new Element(doc);
 const observers=[],events=new Map();class Observer{constructor(callback){this.callback=callback;observers.push(this);}observe(){}disconnect(){this.disconnected=true;}}
 doc.defaultView={MutationObserver:Observer,addEventListener:(name,fn)=>{const listeners=events.get(name)??new Set();listeners.add(fn);events.set(name,listeners);},removeEventListener:(name,fn)=>events.get(name)?.delete(fn)};
 const root=new Element(doc),gateway='https://fixture-'+(++id)+'.invalid';const store=api.liveScreenText(gateway);
 globalThis.getComputedStyle=node=>({getPropertyValue:key=>node.style.getPropertyValue(key)});globalThis.document=doc;globalThis.window=doc.defaultView;globalThis.MutationObserver=Observer;globalThis.HTMLElement=Element;globalThis.HTMLInputElement=Element;
 globalThis.localStorage={getItem:key=>{reads.push(key);return storage.get(key)??null;},setItem:(key,value)=>storage.set(key,value)};globalThis.sessionStorage={getItem:()=>null};
 globalThis.FormData=class{constructor(form){this.form=form;}get(key){return this.form.fields.get(key)?.value??null;}*entries(){for(const [key,node]of this.form.fields)yield [key,node.value];}};
 globalThis.location={pathname:'/enquire/fixture',search:''};globalThis.fetch=async()=>Response.json({screens:[]});
 const manager=new api.ScreenManager(Object.fromEntries(['layout','theme','language','responsive'].map(name=>[name,()=>{}])));api.installScreenManager(root,manager);manager.registerScope('entry',[api.resolveManagedRoute(location.pathname,'')]);
 return {root,doc,gateway,store,storage,reads,observers,events};
}
const tick=()=>new Promise(resolve=>setImmediate(resolve));

test('one default layout owner applies real theme/profile values to raw surfaces without reading personal storage',()=>{
 const {root,doc,reads,storage}=fixture();doc.documentElement.style.setProperty('--color-primary','#123456');
 const first=api.mountPresentationLayout(root,{'--color-primary':'#006b68'});assert.equal(reads.length,0);assert.equal(storage.size,0);
 assert.equal(root.dataset.pcRawLayout,'true');assert.equal(root.dataset.layoutVersion,'1');assert.equal(doc.documentElement.style.getPropertyValue('--color-primary'),'#006b68');
 first.change({...first.current,theme:'dark',density:'compact',contentWidth:80});assert.equal(root.style.getPropertyValue('--layout-content-width'),'80%');assert.equal(root.dataset.density,'compact');assert.equal(doc.documentElement.style.colorScheme,'dark');
 assert.equal(api.mountPresentationLayout(root),first);assert.throws(()=>first.save(),/not persisted/);
 root.shell=new Element(doc);api.mountPresentationLayout(root);assert.equal(root.dataset.pcRawLayout,undefined);assert.equal(root.style.getPropertyValue('--layout-content-width'),'');assert.equal(root.shell.dataset.layoutVersion,'1');
 api.clearLayoutCustomizer(root);assert.equal(root.shell.dataset.layoutVersion,undefined);assert.equal(doc.documentElement.style.getPropertyValue('--color-primary'),'#123456');
});
test('verified account customizer replaces default ownership and is not reset by later boundary draws',()=>{
 const {root,doc,reads}=fixture();doc.documentElement.style.setProperty('--color-primary','#123456');root.shell=new Element(doc);root.existingOpener=new Element(doc);
 const defaultManager=api.mountPresentationLayout(root);const profile={...defaultManager.current,accent:'#123456'};
 // Existing-opener fixture avoids testing Theme Center UI; its separate test suite owns that UI.
 api.mountLayoutCustomizer(root,'tenant-A:user-A','en');const account=api.mountPresentationLayout(root,{'--color-primary':'#ffffff'});
 assert.notEqual(account,defaultManager);assert.ok(reads.includes('primecare-layout:v1:tenant-A%3Auser-A'));account.change(profile);account.save();
 assert.equal(api.mountPresentationLayout(root,{'--color-primary':'#ffffff'}),account);assert.equal(doc.documentElement.style.getPropertyValue('--color-primary'),'#123456');
 api.clearLayoutCustomizer(root);assert.notEqual(api.mountPresentationLayout(root),account);
});
test('label-only live text preserves fields, handlers and busy state; rebinding tears down prior subscriptions',()=>{
 const {root,gateway,store,doc,observers}=fixture('fr');const defaults={en:{title:'Title'},fr:{title:'Titre'},es:{title:'Título'}};store.seed({fixture:defaults});
 root.innerHTML='<main><form data-cy="form"><input data-cy="email" name="email" value="typed@example.invalid"><span data-screen-catalog="fixture" data-screen-text="title">Title</span></form></main>';
 const binding=api.createScreenTextBinding(root,gateway,{fixture:defaults},()=>api.screenLocale(root));binding.bind();const form=root.form,input=root.querySelector('[data-cy=email]');const submit=()=>{};form.onsubmit=submit;input.disabled=true;
 const edits=structuredClone(defaults);edits.fr.title='<img src=x onerror=alert(1)>';store.saveLocal('fixture',0,edits);
 assert.equal(root.leaves[0].textContent,edits.fr.title);assert.equal(input.value,'typed@example.invalid');assert.equal(root.form,form);assert.equal(form.onsubmit,submit);assert.equal(input.disabled,true);assert.equal(doc.documentElement.lang,'fr');
 const old=root.leaves[0];root.innerHTML='<main><span data-screen-catalog="fixture" data-screen-text="title">new</span></main>';observers.at(-1).callback();assert.equal(observers.at(-1).disconnected,true);
 edits.fr.title='New';store.saveLocal('fixture',1,edits);assert.equal(old.textContent,'<img src=x onerror=alert(1)>');assert.equal(root.leaves[0].textContent,'new');
 const second=api.createScreenTextBinding(root,gateway,{fixture:defaults},()=> 'es');second.bind();assert.equal(root.leaves[0].textContent,'Título');second.dispose();
});
test('binding normalizes locale, escapes initial markup, and drops subscriptions on non-BFCache pagehide',()=>{
 const f=fixture('es-MX');assert.equal(api.screenLocale(f.root),'es');f.doc.documentElement.lang='de';assert.equal(api.screenLocale(f.root),'en');
 const defaults={en:{title:'<script>'},fr:{title:'F'},es:{title:'S'}};f.store.seed({fixture:defaults});const binding=api.createScreenTextBinding(f.root,f.gateway,{fixture:defaults},()=> 'en');
 assert.match(binding.markup('fixture','title'),/&lt;script&gt;/);f.root.innerHTML='<main><span data-screen-catalog="fixture" data-screen-text="title"></span></main>';binding.bind();
 for(const fn of [...f.events.get('pagehide')])fn({persisted:true});assert.equal(f.events.get('pagehide').size,1);for(const fn of [...f.events.get('pagehide')])fn({persisted:false});assert.equal(f.events.get('pagehide').size,0);
});
test('actual recovery renderer keeps an in-flight request and credentials intact through live label updates',async()=>{
 const b=createBrowser('https://fixture.invalid/reset-password?locale=fr&enable-semantics=true'),{root,doc}=b;doc.documentElement.lang='fr';doc.defaultView.MutationObserver=globalThis.MutationObserver;
 RecoveryElement.prototype.reset=function(){for(const field of this.querySelectorAll('input'))field.value='';};
 Object.defineProperty(RecoveryElement.prototype,'elements',{configurable:true,get(){return {namedItem:name=>this.querySelector('[name='+name+']')};}});
 globalThis.getComputedStyle=()=>({getPropertyValue:()=>''});
 const gateway='https://recovery-binding-fixture.invalid',store=api.liveScreenText(gateway);store.seed({auth});let sent=0,release;globalThis.fetch=async()=>{sent++;return new Promise(resolve=>release=resolve);};
 const manager=new api.ScreenManager(Object.fromEntries(['layout','theme','language','responsive'].map(name=>[name,()=>{}])));api.installScreenManager(root,manager);const entry=api.resolveManagedRoute(location.pathname,'au');manager.registerScope('entry',[entry]);
 let dispose;await manager.present(entry.id,entry.route,()=>{dispose=api.renderAuthRecovery(root,gateway,'Fixture','reset','fr');});const form=b.cy('recovery-form'),button=b.cy('recovery-submit');
 const values={email:'person@example.invalid',code:'ABCDEF123456',newPassword:'Synthetic-Password-2026',confirmation:'Synthetic-Password-2026'};for(const [key,value]of Object.entries(values))form.querySelector('[name='+key+']').value=value;
 form.onsubmit({preventDefault(){}});form.onsubmit({preventDefault(){}});assert.equal(sent,1);assert.equal(button.disabled,true);
 const edits=structuredClone(auth);edits.fr.email='Adresse en direct';store.saveLocal('auth',0,edits);assert.equal(b.cy('recovery-form'),form);assert.equal(form.querySelector('[name=newPassword]').value,values.newPassword);assert.equal(button.disabled,true);assert.equal(root.querySelector('[data-screen-text=email]').textContent,'Adresse en direct');assert.equal(doc.documentElement.lang,'fr');
 release(Response.json({status:'password_reset',reauthenticationRequired:true}));await tick();assert.equal(form.querySelector('[name=newPassword]').value,'');assert.equal(button.disabled,false);dispose();
});
test('actual enquiry renderer keeps locale/drafts/consent and rejects live safety and consent overrides',async()=>{
 const {root,gateway,store,doc}=fixture('es');store.seed({growth_enquiry:growth});globalThis.fetch=async()=>Response.json({name:'Fixture',pipeline:'client',routingMode:'territory',consentVersion:1,sharingConsentVersion:1});
 await api.renderEnquiry(root,gateway);assert.equal(doc.documentElement.lang,'es');const form=root.form;form.fields.get('name').value='Draft Person';form.fields.get('email').value='draft@example.invalid';form.fields.get('consent').checked=true;form.fields.get('sharingConsent').checked=true;
 const edits=structuredClone(growth);edits.es.enquiry_submit='Enviar ahora';for(const locale of ['en','fr','es'])for(const key of ['enquiry_consent','enquiry_share','enquiry_note'])edits[locale][key]='UNAPPROVED '+key;store.saveLocal('growth_enquiry',0,edits);
 assert.equal(root.form,form);assert.equal(form.fields.get('name').value,'Draft Person');assert.equal(form.fields.get('consent').checked,true);assert.equal(root.leaves.find(n=>n.dataset.screenText==='enquiry_submit').textContent,'Enviar ahora');for(const key of ['enquiry_consent','enquiry_share','enquiry_note']){assert.equal(root.leaves.some(n=>n.dataset.screenText===key),false);assert.ok(decode(root.innerHTML).includes(growth.es[key]),key);}assert.doesNotMatch(root.innerHTML,/UNAPPROVED/);
 for(const locale of ['fr','en']){const language=root.querySelector('[data-cy=enquiry-language]');language.onchange({target:{value:locale}});assert.equal(doc.documentElement.lang,locale);assert.equal(root.form.fields.get('name').value,'Draft Person');assert.equal(root.form.fields.get('consent').checked,true);assert.equal(root.form.fields.get('sharingConsent').checked,true);for(const key of ['enquiry_consent','enquiry_share','enquiry_note'])assert.ok(decode(root.innerHTML).includes(growth[locale][key]),key);assert.doesNotMatch(root.innerHTML,/UNAPPROVED/);}
});

test('actual enquiry renderer ignores persisted safety/consent overrides on initial render in every supported locale',async()=>{
 for(const locale of ['en','fr','es']){
  const {root,gateway,storage}=fixture(locale),cachedGateway=gateway+'/cached';const edits=structuredClone(growth);
  for(const language of ['en','fr','es']){for(const key of ['enquiry_consent','enquiry_share','enquiry_note'])edits[language][key]='UNAPPROVED CACHE '+key;edits[language].enquiry_submit='Cached submit '+language;}
  storage.set('primecare.screen-text.v1.'+encodeURIComponent(cachedGateway),JSON.stringify({format:1,catalogs:[{screen:'growth_enquiry',version:1,locales:edits}],edited:['growth_enquiry'],history:[]}));
  const cached=api.liveScreenText(cachedGateway);assert.equal(cached.text('growth_enquiry',locale,'enquiry_note','fallback'),'UNAPPROVED CACHE enquiry_note');
  globalThis.fetch=async()=>Response.json({name:'Fixture',pipeline:'client',routingMode:'territory',consentVersion:1,sharingConsentVersion:1});await api.renderEnquiry(root,cachedGateway);
  assert.equal(root.leaves.find(n=>n.dataset.screenText==='enquiry_submit').textContent,'Cached submit '+locale);
  for(const key of ['enquiry_consent','enquiry_share','enquiry_note']){assert.equal(root.leaves.some(n=>n.dataset.screenText===key),false);assert.ok(decode(root.innerHTML).includes(growth[locale][key]),locale+': '+key);}
  assert.doesNotMatch(root.innerHTML,/UNAPPROVED CACHE/);
 }
});
