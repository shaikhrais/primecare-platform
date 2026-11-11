import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

// Actual presentation, layout, theme, language and shell owners. DOM/CSS/history
// event delivery is synthetic: these checks are not real-browser acceptance.
if (Object.keys(process.env).some(key => /(?:DATABASE_URL|DB_URL|CLOUDFLARE|CF_API|PGPASSWORD)/i.test(key))) {
  throw Error('Database/Cloudflare credentials forbidden in document-scroll fixtures');
}
const built = await build({stdin:{contents:`
  export {installPortalPresentation} from './websites/typescript/src/screen-presentation';
  export {liveScreenText} from './websites/typescript/src/screen-text';
  export {ShellEnvironment} from './packages/primecare_ui/web/shell-environment';
`,resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm'});
const {installPortalPresentation, liveScreenText, ShellEnvironment} = await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));

class Element {
  attrs = new Map(); dataset = {}; children = []; isConnected = true; parentElement = null;
  lang = ''; scrollTop = 91; scrollLeft = 17; scrolls = []; innerHTML = '';
  classList = {add(){},remove(){},toggle(){}};
  constructor(doc) {
    this.ownerDocument = doc;
    const values = new Map();
    this.style = {scrollbarColor:'',getPropertyValue:k=>values.get(k)??'',setProperty:(k,v)=>values.set(k,v),removeProperty:k=>values.delete(k)};
  }
  get dir(){return this.getAttribute('dir')??'';} set dir(value){this.setAttribute('dir',value);}
  getAttribute(k){return this.attrs.get(k)??null;} setAttribute(k,v){this.attrs.set(k,v);} removeAttribute(k){this.attrs.delete(k);}
  contains(el){return el===this||this.children.some(child=>child.contains(el));}
  append(...children){for(const child of children){this.children.push(child);child.parentElement=this;}}
  replaceChildren(...children){this.children=[];this.append(...children);this.innerHTML='';}
  querySelector(){return null;} querySelectorAll(){return [];} addEventListener(){}
  scrollTo(options){this.scrolls.push({...options});this.scrollTop=options.top;this.scrollLeft=options.left;}
}
let sequence = 0;
function fixture(path='/one?enable-semantics=true', {embedded=false}={}) {
  const events = new Map(), values = new Map(), document = {}, scrolls = [];
  const storage = {getItem:k=>values.get(k)??null,setItem:(k,v)=>values.set(k,v),removeItem:k=>values.delete(k)};
  let location = new URL(path,'https://portal.invalid'), responsive = true, viewport = {top:620,left:36};
  document.documentElement = new Element(document);document.body = new Element(document);document.documentElement.append(document.body);
  document.createElement = ()=>new Element(document);document.scrollingElement = document.documentElement;
  const root = new Element(document);root.setAttribute('id','app');document.body.append(root);
  let canonical = root;
  if(embedded){const host = new Element(document);document.body.append(host);host.append(root);}
  document.querySelector = selector=>selector==='#app'?canonical:null;
  const history = {state:{fixture:'unchanged'},pushState(state,_title,url){this.state=state;location=new URL(url,location);},replaceState(state,_title,url){this.state=state;location=new URL(url,location);}};
  Object.defineProperty(history,'scrollRestoration',{get:()=> 'auto',set(){assert.fail('Native restoration must not be changed');}});
  const view = {
    get location(){return location;},history,
    scrollTo(options){scrolls.push({...options});viewport={top:options.top,left:options.left};},
    addEventListener(name,fn){if(!events.has(name))events.set(name,new Set());events.get(name).add(fn);},
    removeEventListener(name,fn){events.get(name)?.delete(fn);},
    getComputedStyle:()=>({getPropertyValue:key=>key==='--primecare-responsive-styles'?(responsive?'1':''):document.documentElement.style.getPropertyValue(key)}),
  };
  document.defaultView = view;document.baseURI = location.href;
  Object.assign(globalThis,{document,window:view,location,history,localStorage:storage,sessionStorage:storage,getComputedStyle:view.getComputedStyle});
  const gateway='https://gateway.invalid/document-scroll-'+(++sequence),theme={'--color-primary':'#006b68'};
  const install=element=>installPortalPresentation(element,theme,gateway);
  const manager=install(root);
  const enter=(route=location.pathname,{id='governed:'+route,kind='governed',owner=manager}={})=>{
    const screen={id,route,kind,adapter:'workspace'};owner.registerScope('fixture',[screen]);return owner.enter(id,route);
  };
  const setUrl=url=>{location=new URL(url,location);globalThis.location=location;};
  const dispatch=(name,data={})=>{for(const fn of [...events.get(name)??[]])fn(data);};
  const position=(top=620,left=36)=>{viewport={top,left};};
  return {root,document,view,history,events,scrolls,enter,setUrl,dispatch,position,install,manager,theme,
    get viewport(){return viewport;},setResponsive:value=>responsive=value,language:liveScreenText(gateway),
    canonical:element=>{canonical=element;},element:()=>new Element(document)};
}
const reset = {top:0,left:0,behavior:'instant'};

test('production bridge resets the document viewport once for an accepted changed path',()=>{
  const f=fixture();f.enter();assert.deepEqual(f.viewport,{top:620,left:36});assert.deepEqual(f.scrolls,[]);
  f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[reset]);assert.deepEqual(f.viewport,{top:0,left:0});
  f.position(340,12);f.enter();assert.deepEqual(f.viewport,{top:340,left:12});assert.equal(f.scrolls.length,1);
});
for(const path of ['/one?enable-semantics=true','/one?locale=fr&enable-semantics=true#details'])test('initial dispatcher and governed identities preserve '+path,()=>{
  const f=fixture(path);f.enter('/one',{id:'typescript:workspace:/one',kind:'workspace-host'});f.enter('/one');
  assert.deepEqual(f.scrolls,[]);assert.deepEqual(f.viewport,{top:620,left:36});assert.equal(f.root.dataset.layoutVersion,'1');
});
for(const start of ['/','/dashboard'])test('initial '+start+' canonical landing resolution preserves restored position',()=>{
  const f=fixture(start);f.enter(start,{id:'typescript:workspace:'+start,kind:'workspace-host'});
  f.history.replaceState(f.history.state,'','/one?enable-semantics=true');f.enter('/one');assert.deepEqual(f.scrolls,[]);
  f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[reset]);
});
test('same-path changed identity, language, query and fragment redraws preserve position',()=>{
  const f=fixture();f.enter();
  for(const [url,id] of [['/one?locale=fr&enable-semantics=true','locale'],['/one?enable-semantics=true#details','fragment'],['/one?view=calls&enable-semantics=true','calls'],['/one?enable-semantics=true','ordinary']]){
    f.setUrl(url);f.enter('/one',{id});assert.deepEqual(f.scrolls,[]);
  }
});
for(const event of ['popstate','hashchange'])test(event+' protects delayed accepted navigation without taking native restoration ownership',async()=>{
  const f=fixture();f.enter();const push=f.history.pushState,replace=f.history.replaceState,state=f.history.state;
  f.setUrl('/two?enable-semantics=true');f.dispatch(event);f.enter('/one');await new Promise(resolve=>setImmediate(resolve));f.enter('/two');
  f.position(850,22);f.enter('/two');assert.deepEqual(f.scrolls,[]);assert.deepEqual(f.viewport,{top:850,left:22});
  assert.equal(f.history.pushState,push);assert.equal(f.history.replaceState,replace);assert.equal(f.history.state,state);assert.equal(f.history.scrollRestoration,'auto');
  f.setUrl('/three?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[reset]);
});
test('Back and Forward remain protected through duplicate events and later redraws',async()=>{
  const f=fixture();f.enter();f.setUrl('/two?enable-semantics=true');f.enter();
  for(const url of ['/one?enable-semantics=true','/two?enable-semantics=true','/one?enable-semantics=true']){
    f.setUrl(url);f.position();f.dispatch('popstate');f.dispatch('hashchange');await Promise.resolve();f.enter();f.enter();assert.deepEqual(f.viewport,{top:620,left:36});
  }
  assert.equal(f.scrolls.length,1);
});
test('protection is released for a later accepted URL, including returning to the original URL',()=>{
  const f=fixture();f.enter();f.setUrl('/two?enable-semantics=true');f.enter();f.setUrl('/one?enable-semantics=true');f.enter();
  assert.deepEqual(f.scrolls,[reset,reset]);
  f.setUrl('/two?enable-semantics=true');f.dispatch('popstate');f.enter();f.setUrl('/three?enable-semantics=true');f.enter();f.setUrl('/two?enable-semantics=true');f.enter();
  assert.deepEqual(f.scrolls,[reset,reset,reset,reset]);
});
test('a history URL never makes an old mounted route consume or reset the new route',()=>{
  const f=fixture();f.enter();f.setUrl('/two?enable-semantics=true');f.dispatch('popstate');
  for(let i=0;i<3;i++)f.enter('/one');assert.deepEqual(f.scrolls,[]);f.enter('/two');assert.deepEqual(f.scrolls,[]);
  f.setUrl('/three?enable-semantics=true');f.enter('/two');assert.deepEqual(f.scrolls,[]);f.enter('/three');assert.deepEqual(f.scrolls,[reset]);
});
test('cross-path fragment navigation is preserved and later ordinary navigation resets',()=>{
  const f=fixture();f.enter();f.setUrl('/two?enable-semantics=true#details');f.enter();assert.deepEqual(f.scrolls,[]);
  f.setUrl('/three?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[reset]);
});
test('a cancelled route that never enters presentation causes no document scroll',()=>{
  const f=fixture();f.enter();f.setUrl('/two?enable-semantics=true');f.setUrl('/one?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[]);
});
for(const fail of ['responsive','theme','language'])test(fail+' validation must succeed before resetting the document',()=>{
  const f=fixture();f.enter();f.setUrl('/two?enable-semantics=true');
  const oldText=f.language.text,style=f.document.documentElement.style,oldProperty=style.getPropertyValue;
  if(fail==='responsive')f.setResponsive(false);
  if(fail==='theme')style.getPropertyValue=key=>key==='--color-primary'?'':oldProperty(key);
  if(fail==='language')f.language.text=undefined;
  assert.throws(()=>f.enter(),/Screen Manager/);assert.deepEqual(f.scrolls,[]);assert.deepEqual(f.viewport,{top:620,left:36});
  f.setResponsive(true);style.getPropertyValue=oldProperty;f.language.text=oldText;f.enter();assert.deepEqual(f.scrolls,[reset]);
});
test('unregistered routes fail before document effects',()=>{
  const f=fixture();f.enter();f.setUrl('/two?enable-semantics=true');assert.throws(()=>f.manager.enter('missing','/two'),/Missing registration/);assert.deepEqual(f.scrolls,[]);
});
test('nested panels and unrelated siblings keep their scroll positions',()=>{
  const f=fixture(),nested=f.element(),sibling=f.element();f.root.append(nested);f.document.body.append(sibling);f.enter();f.setUrl('/two?enable-semantics=true');f.enter();
  assert.deepEqual(f.scrolls,[reset]);for(const element of [nested,sibling]){assert.equal(element.scrollTop,91);assert.equal(element.scrollLeft,17);assert.deepEqual(element.scrolls,[]);}
});
test('an embedded #app cannot claim the document viewport',()=>{
  const f=fixture('/one?enable-semantics=true',{embedded:true});f.enter();f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[]);
});
test('a noncanonical sibling installation cannot claim the portal viewport',()=>{
  const f=fixture(),sibling=f.element();f.document.body.append(sibling);sibling.setAttribute('id','app');const other=f.install(sibling);
  f.enter();f.enter('/one',{owner:other});f.setUrl('/two?enable-semantics=true');f.enter('/two',{owner:other});assert.deepEqual(f.scrolls,[]);f.enter();assert.deepEqual(f.scrolls,[reset]);
});
for(const change of ['detached','reparented','adopted'])test(change+' portal root cannot reset its original document',()=>{
  const f=fixture();f.enter();
  if(change==='detached')f.root.isConnected=false;
  if(change==='reparented'){const parent=f.element();f.document.body.append(parent);parent.append(f.root);}
  if(change==='adopted')f.root.ownerDocument={...f.document,body:f.element()};
  f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[]);
});
test('replacement canonical root retires the old document owner',()=>{
  const f=fixture();f.enter();const old=f.root,replacement=f.element();old.isConnected=false;replacement.setAttribute('id','app');f.document.body.append(replacement);f.canonical(replacement);const newer=f.install(replacement);
  assert.equal(f.events.get('popstate').size,1);assert.equal(f.events.get('pageshow').size,1);
  f.enter('/one',{owner:newer});f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[]);f.enter('/two',{owner:newer});assert.deepEqual(f.scrolls,[reset]);
});
test('BFCache suspension and deferred restored entry preserve position, then ordinary navigation works',async()=>{
  const f=fixture();f.enter();f.dispatch('pagehide',{persisted:true});f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[]);
  f.dispatch('pageshow',{persisted:true});await new Promise(resolve=>setImmediate(resolve));f.enter();assert.deepEqual(f.scrolls,[]);
  f.setUrl('/three?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[reset]);
});
test('non-BFCache exit removes document listeners and prevents subsequent owner effects',()=>{
  const f=fixture();f.enter();f.dispatch('pagehide',{persisted:false});
  for(const name of ['popstate','hashchange','pageshow'])assert.equal(f.events.get(name)?.size??0,0,name);
  f.setUrl('/two?enable-semantics=true');assert.throws(()=>f.enter(),/invalid_shell_route/);f.dispatch('popstate');f.dispatch('pageshow',{persisted:true});assert.deepEqual(f.scrolls,[]);
});
test('the owner document window, not the ambient window, receives the reset',()=>{
  const f=fixture();f.enter();globalThis.window={scrollTo(){assert.fail('Foreign window scrolled');}};f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[reset]);
});
test('reusable ShellEnvironment retains contained-root validation and original identity behavior',async()=>{
  const f=fixture(),root=f.element(),nested=f.element(),sibling=f.element();root.append(nested);f.document.body.append(root,sibling);root.dir='rtl';root.style.scrollbarColor='red blue';
  const env=new ShellEnvironment(root,'ltr');assert.throws(()=>env.routeChanged('one',[f.document.documentElement]),/invalid_shell_route/);assert.throws(()=>env.routeChanged('one',[sibling]),/invalid_shell_route/);
  env.routeChanged('one',[root,nested]);assert.deepEqual(nested.scrolls,[]);env.routeChanged('two',[root,nested]);assert.deepEqual(nested.scrolls,[reset]);env.routeChanged('two',[root,nested]);assert.equal(nested.scrolls.length,1);assert.deepEqual(f.scrolls,[]);
  await env.dispose();assert.equal(root.dir,'rtl');assert.equal(root.style.scrollbarColor,'red blue');assert.throws(()=>env.routeChanged('three'),/invalid_shell_route/);
});

for(const owner of ['portal','other'])test(owner+' fullscreen preserves the document beneath it',()=>{
  const f=fixture();f.enter();f.document.fullscreenElement=owner==='portal'?f.root:f.element();f.setUrl('/two?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[]);
  f.document.fullscreenElement=null;f.enter();assert.deepEqual(f.scrolls,[]);f.setUrl('/three?enable-semantics=true');f.enter();assert.deepEqual(f.scrolls,[reset]);
});
test('a rejected document scroll is retried at the same accepted route',()=>{
  const f=fixture();f.enter();const scroll=f.view.scrollTo;f.view.scrollTo=()=>{throw Error('scroll unavailable');};f.setUrl('/two?enable-semantics=true');
  assert.throws(()=>f.enter(),/scroll unavailable/);assert.deepEqual(f.scrolls,[]);f.view.scrollTo=scroll;f.enter();assert.deepEqual(f.scrolls,[reset]);
});
