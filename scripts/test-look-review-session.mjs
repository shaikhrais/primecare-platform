import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile} from 'node:fs/promises';
import {resolve} from 'node:path';
import {webcrypto} from 'node:crypto';

// Actual renderer and transport; isolated presentation dependencies, no browser or live service.
// LOOK_REVIEW_SOURCE permits an unchanged pre-fix negative-control run.
const source=await readFile(process.env.LOOK_REVIEW_SOURCE??'websites/typescript/src/look-review.ts','utf8');
const stubs={
 './shell':`const shells=new WeakMap();export function renderShell(root,o){const previous=shells.get(root),main=root.querySelector('[data-cy=shell-main]');if(!previous||!main||previous.role!==o.role||previous.home!==o.home)root.innerHTML='<div data-cy="app-shell"><header data-cy="shell-controls">'+o.controls+'</header><main data-cy="shell-main">'+o.content+'</main></div>';else{if(previous.controls!==o.controls)root.querySelector('[data-cy=shell-controls]').innerHTML=o.controls;main.innerHTML=o.content}shells.set(root,o)} export function bindShell(){}`,
 './media-look':`export class DashboardMediaLook {navigationIcon(){return ''} heading(){return ''} reviewProcess(){return ''} reviewState(){return ''} score(){return ''} emptyReview(){return ''}}`,
 './form-draft':`export class FormDraft {capture(){globalThis.draftCaptures++} restore(){} clear(){globalThis.draftClears++}}`,
 './workspace':`export const escapeHtml=v=>String(v??'').replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('"','&quot;');`,
};
const built=await build({stdin:{contents:source+"\nexport {ScreenManager,installScreenManager} from '../../../packages/primecare_ui/web/screen-manager';export {resolveManagedRoute} from './managed-routes';",resolveDir:resolve('websites/typescript/src'),loader:'ts'},bundle:true,write:false,platform:'node',format:'esm',plugins:[{name:'presentation-fixture',setup(b){b.onResolve({filter:/^\.\//},a=>stubs[a.path]?{path:a.path,namespace:'fixture'}:undefined);b.onLoad({filter:/.*/,namespace:'fixture'},a=>({contents:stubs[a.path],loader:'js'}));}}]});
const {renderLookReview,LookReviewClient,ScreenManager,installScreenManager,resolveManagedRoute}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const deferred=()=>{let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b});return {promise,resolve,reject}};
const tick=async()=>{for(let i=0;i<8;i++)await new Promise(r=>setImmediate(r))};
let decode=()=>Promise.resolve(),srcAssignments=0,observers=new Set();
// MutationObserver delivery is asynchronous, like the DOM checkpoint after a synchronous draw.
function notifyMutation(target){for(const observer of observers){if(!observer.active||observer.target!==target.ownerDocument&&observer.target!==target)continue;observer.records.push({type:'childList',target});if(observer.queued)continue;observer.queued=true;queueMicrotask(()=>{observer.queued=false;const records=observer.records.splice(0);if(observer.active&&records.length)observer.callback(records,observer)})}}
class FixtureMutationObserver {constructor(callback){this.callback=callback;this.active=false;this.records=[];this.queued=false}observe(target){this.target=target;this.active=true;observers.add(this)}disconnect(){this.active=false;this.records=[];observers.delete(this)}takeRecords(){return this.records.splice(0)}}
class Element {
 constructor(tag='div',attrs={},parent=null){this.ownerDocument=parent?.ownerDocument;this.tag=tag;this.attrs=attrs;this.parent=parent;this.children=[];this.parts=[];this.dataset={};for(const [k,v] of Object.entries(attrs))if(k.startsWith('data-'))this.dataset[k.slice(5).replace(/-([a-z])/g,(_,c)=>c.toUpperCase())]=v;this.value=attrs.value??'';this.checked='checked'in attrs;this.disabled='disabled'in attrs;this.hidden='hidden'in attrs;this.connected=true;this.listeners={};this.html='';}
 get isConnected(){return this.connected&&(this.parent?.isConnected??true)}
 set isConnected(v){this.connected=v;notifyMutation(this)}
 set innerHTML(html){notifyMutation(this);for(const c of this.children)c.connected=false;this.children=[];this.parts=[];const stack=[this];for(const m of html.matchAll(/<\/?([\w-]+)\b([^>]*)>|([^<]+)/g)){if(m[3]!==undefined){stack.at(-1).parts.push(m[3]);continue}const tag=m[1];if(m[0].startsWith('</')){if(stack.at(-1).tag===tag)stack.pop();continue}const attrs={};for(const a of m[2].matchAll(/([\w-]+)(?:="([^"]*)"|='([^']*)'|=([^\s>]+))?/g))attrs[a[1]]=a[2]??a[3]??a[4]??'';const node=new Element(tag,attrs,stack.at(-1));stack.at(-1).children.push(node);stack.at(-1).parts.push(node);if(!['input','img','br','hr','meta','link'].includes(tag))stack.push(node)}}
 get innerHTML(){return this.parts.map(part=>typeof part==='string'?part:part.outerHTML).join('')}
 get outerHTML(){return '<'+this.tag+Object.entries(this.attrs).map(([k,v])=>' '+k+'="'+v+'"').join('')+'>'+this.innerHTML+(['input','img','br','hr','meta','link'].includes(this.tag)?'':'</'+this.tag+'>')}
 contains(node){return node===this||this.children.some(child=>child.contains(node))}
 get childNodes(){return this.children}
 get firstElementChild(){return this.children[0]??null}
 querySelectorAll(selector){const match=n=>{if(selector==='button'||selector==='main')return n.tag===selector;const a=selector.match(/^\[([^=\]]+)(?:=["']?([^\]"']+)["']?)?\]$/);return a&&a[1]in n.attrs&&(a[2]===undefined||n.attrs[a[1]]===a[2])};const result=[];const visit=n=>{for(const c of n.children){if(match(c))result.push(c);visit(c)}};visit(this);return result}
 querySelector(s){return this.querySelectorAll(s)[0]??null}
 addEventListener(type,fn){this.listeners[type]=fn}
 click(){return this.onclick?.({currentTarget:this})??this.listeners.click?.({currentTarget:this})}
 focus(){} removeAttribute(key){delete this.attrs[key]} replaceChildren(){this.innerHTML=''}
 set src(v){srcAssignments++;this.attrs.src=v} get src(){return this.attrs.src}
 decode(){return decode(this)}
}
const bytes=new Uint8Array([137,80,78,71]);
const digest=Buffer.from(await webcrypto.subtle.digest('SHA-256',bytes)).toString('hex');
const payload=(label='PRIVATE OLD ACCOUNT')=>({identity:{role:'reviewer',userId:'old-user'},providerReady:true,canSubmit:true,screens:[{code:'screen',name:label,route:'/screen'}],rows:[{id:'r1',version:1,image_digest:digest,screen:'screen',platform:'web',width:320,height:800,locale:'en',build:'build',theme:'theme',layout:'layout',state:'pending',policyCurrent:true,coverage:{approved:0,required:1},canRunAI:true,humanActions:['approved']}]});
function fixture(){
 observers=new Set();globalThis.MutationObserver=FixtureMutationObserver;const root=new Element(),storage=new Map([['primecare_session','old-token']]),calls=[],created=[],revoked=[],navigations=[];srcAssignments=0;globalThis.draftCaptures=globalThis.draftClears=0;decode=()=>Promise.resolve();
 globalThis.sessionStorage={getItem:k=>storage.get(k)??null,setItem:(k,v)=>storage.set(k,v),removeItem:k=>storage.delete(k)};
 globalThis.document={documentElement:{lang:'en'},createElement:tag=>new Element(tag),defaultView:Object.assign(new EventTarget(),{MutationObserver:FixtureMutationObserver})};root.ownerDocument=globalThis.document;
 globalThis.location={pathname:'/appearance-review',search:'?enable-semantics=true',assign:v=>navigations.push(v),reload:()=>navigations.push('reload')};
 const manager=new ScreenManager(Object.fromEntries(['layout','theme','language','responsive'].map(key=>[key,()=>{}])));manager.registerScope('fixture',[resolveManagedRoute('/appearance-review','')]);installScreenManager(root,manager);
 globalThis.FormData=class{constructor(form){this.form=form}*[Symbol.iterator](){for(const e of this.form.querySelectorAll('[name]'))yield [e.attrs.name,e.attrs.name==='image'?{size:bytes.length,arrayBuffer:async()=>bytes.buffer}:e.value]}};
 Object.defineProperty(globalThis,'crypto',{configurable:true,value:{randomUUID:()=> 'fixture-request',subtle:{digest:async()=>Buffer.from(digest,'hex')}}});
 URL.createObjectURL=()=>{const url='blob:fixture-'+created.length;created.push(url);return url};URL.revokeObjectURL=url=>revoked.push(url);
 let responder=async url=>url.endsWith('/image')?new Response(bytes,{headers:{'content-type':'image/png'}}):Response.json(payload());
 globalThis.fetch=(url,options)=>{calls.push({url,options});return responder(url,options)};
 return {root,storage,calls,created,revoked,navigations,setRespond:fn=>responder=fn,el:id=>root.querySelector(`[data-cy=${id}]`),switch:()=>storage.set('primecare_session','new-token'),render:()=>renderLookReview(root,'https://image-fixture.invalid')};
}
async function ready(){const f=fixture();await f.render();await tick();assert.match(f.root.innerHTML,/PRIVATE OLD ACCOUNT/);assert.equal(f.el('look-proof-r1').hidden,false);return f}
function cleared(f){assert.equal(f.root.innerHTML,'','old account content cleared');assert.ok(f.created.every(u=>f.revoked.includes(u)),'all allocated URLs revoked')}
const submit=form=>form.onsubmit({preventDefault(){}});
for(const stage of ['fetch','json'])for(const outcome of ['resolve','reject'])test(`refresh ${stage} ${outcome} after account switch clears old account`,async()=>{
 const f=await ready(),wait=deferred();f.setRespond(()=>stage==='fetch'?wait.promise:Promise.resolve({ok:true,json:()=>wait.promise}));f.el('look-refresh').click();await tick();f.switch();if(outcome==='reject')wait.reject(Error('old failure'));else wait.resolve(stage==='fetch'?Response.json(payload()):payload());await tick();cleared(f);
});
for(const action of ['ai','human','upload'])for(const stage of ['fetch','json'])for(const outcome of ['resolve','reject'])test(`${action} ${stage} ${outcome} after account switch never redraws private state`,async()=>{
 const f=await ready(),wait=deferred();f.setRespond(()=>stage==='fetch'?wait.promise:Promise.resolve({ok:true,json:()=>wait.promise}));if(action==='ai')f.el('look-ai-r1').click();else submit(f.el(action==='upload'?'look-form':'look-human-form-r1'));await tick();const count=f.calls.length;f.switch();if(outcome==='reject')wait.reject(Error('old mutation failed'));else wait.resolve(stage==='fetch'?Response.json({ok:true}):{ok:true});await tick();cleared(f);assert.equal(f.calls.length,count,'no stale follow-up refresh');
});
test('retained language, upload, AI, human, refresh and image retry controls are inert after invalidation',async()=>{
 const f=await ready();const language=f.el('look-language'),upload=f.el('look-form'),human=f.el('look-human-form-r1'),ai=f.el('look-ai-r1'),refresh=f.el('look-refresh'),retry=f.el('look-image-retry-r1');const count=f.calls.length;f.switch();language.value='fr';language.onchange({currentTarget:language});await tick();cleared(f);f.storage.set('primecare_session','old-token');language.onchange({currentTarget:language});submit(upload);submit(human);ai.click();refresh.click();retry.click();await tick();cleared(f);assert.equal(f.calls.length,count);
});
for(const stage of ['fetch','blob','digest','decode'])test(`image ${stage} completion invalidates stale owner without URL leaks`,async()=>{
 const f=fixture(),wait=deferred();if(stage==='digest')crypto.subtle.digest=()=>wait.promise;if(stage==='decode')decode=()=>wait.promise;
 f.setRespond(async url=>!url.endsWith('/image')?Response.json(payload()):stage==='fetch'?wait.promise:stage==='blob'?{ok:true,headers:new Headers({'content-type':'image/png'}),blob:()=>wait.promise}:new Response(bytes,{headers:{'content-type':'image/png'}}));await f.render();await tick();f.switch();wait.resolve(stage==='fetch'?new Response(bytes,{headers:{'content-type':'image/png'}}):stage==='blob'?new Blob([bytes]):stage==='digest'?Buffer.from(digest,'hex'):undefined);await tick();cleared(f);assert.equal(f.created.length,stage==='decode'?1:0);assert.equal(srcAssignments,stage==='decode'?1:0);
});
test('new renderer owns shared root even when old initial request completes later',async()=>{
 const f=fixture(),wait=deferred();let count=0;f.setRespond(async url=>url.endsWith('/image')?new Response(bytes,{headers:{'content-type':'image/png'}}):++count===1?wait.promise:Response.json(payload('NEW OWNER')));const old=f.render();await tick();await f.render();await tick();wait.resolve(Response.json(payload('OLD OWNER')));await old;await tick();assert.match(f.root.innerHTML,/NEW OWNER/);assert.doesNotMatch(f.root.innerHTML,/OLD OWNER/);assert.equal(f.navigations.length,0);
});
for(const outcome of ['resolve','reject'])test(`same-session older refresh ${outcome} cannot replace newer result`,async()=>{
 const f=await ready(),wait=deferred();let count=0;f.setRespond(async url=>url.endsWith('/image')?new Response(bytes,{headers:{'content-type':'image/png'}}):++count===1?wait.promise:Response.json(payload('LATEST RESULT')));const refresh=f.el('look-refresh');refresh.click();await tick();refresh.click();await tick();if(outcome==='reject')wait.reject(Error('old failure'));else wait.resolve(Response.json(payload('OUTDATED RESULT')));await tick();assert.match(f.root.innerHTML,/LATEST RESULT/);assert.doesNotMatch(f.root.innerHTML,/OUTDATED RESULT/);
});
test('detached mutation completion clears its own content without navigating current route',async()=>{
 const f=await ready(),wait=deferred();f.setRespond(()=>wait.promise);f.el('look-ai-r1').click();await tick();f.root.isConnected=false;f.switch();wait.reject(Error('old failure'));await tick();cleared(f);assert.equal(f.navigations.length,0);
});
test('client rejects stale JSON and preserves new account token on old 401',async()=>{
 const f=fixture(),wait=deferred();f.setRespond(async()=>({ok:false,status:401,json:()=>wait.promise}));const result=new LookReviewClient('https://image-fixture.invalid','old-token').request();const rejected=assert.rejects(result);await tick();f.switch();wait.resolve({error:'unauthorized'});await rejected;assert.equal(f.storage.get('primecare_session'),'new-token');assert.equal(f.navigations.length,0);
});
test('current-session renderer still displays image evidence and submits approved action',async()=>{
 const f=await ready();assert.equal(f.el('look-inspected-r1').disabled,false);f.el('look-ai-r1').click();await tick();assert.ok(f.calls.some(c=>c.url.endsWith('/ai')&&c.options.method==='POST'));assert.match(f.root.innerHTML,/PRIVATE OLD ACCOUNT/);assert.equal(f.navigations.length,0);
});

for(const outcome of ['resolve','reject'])test(`superseded mutation ${outcome} cannot redraw or reload newer renderer`,async()=>{
 const f=await ready(),wait=deferred();f.setRespond(async(url,options)=>options.method==='POST'?wait.promise:url.endsWith('/image')?new Response(bytes,{headers:{'content-type':'image/png'}}):Response.json(payload('NEW OWNER')));f.el('look-ai-r1').click();await tick();await f.render();await tick();if(outcome==='reject')wait.reject(Error('old failure'));else wait.resolve(Response.json({ok:true}));await tick();assert.match(f.root.innerHTML,/NEW OWNER/);assert.equal(f.navigations.length,0);assert.equal(f.calls.filter(c=>c.options.method==='GET').length,2);
});
test('different route replacing root content is not erased by old completion',async()=>{
 const f=await ready(),wait=deferred();f.setRespond(()=>wait.promise);f.el('look-ai-r1').click();await tick();f.root.innerHTML='<main data-cy="new-route">NEW ROUTE</main>';f.switch();wait.reject(Error('old failure'));await tick();assert.match(f.root.innerHTML,/NEW ROUTE/);assert.equal(f.navigations.length,0);assert.ok(f.created.every(u=>f.revoked.includes(u)));
});
test('blocked session storage invalidates old retained controls without throwing',async()=>{
 const f=await ready(),language=f.el('look-language'),count=f.calls.length;globalThis.sessionStorage.getItem=()=>{throw Error('storage blocked')};assert.doesNotThrow(()=>language.onchange({currentTarget:language}));await tick();cleared(f);assert.equal(f.calls.length,count);
});
test('current-session failed mutation remains retryable and does not clear owning renderer',async()=>{
 const f=await ready();let attempts=0;f.setRespond(async(url,options)=>options.method==='POST'?(++attempts===1?Promise.reject(Error('network')):Response.json({ok:true})):url.endsWith('/image')?new Response(bytes,{headers:{'content-type':'image/png'}}):Response.json(payload()));f.el('look-ai-r1').click();await tick();assert.match(f.root.innerHTML,/PRIVATE OLD ACCOUNT/);f.el('look-ai-r1').click();await tick();assert.equal(attempts,2);assert.equal(f.navigations.length,0);
});
for(const stage of ['fetch','blob','digest','decode'])test(`image ${stage} rejection after account switch clears instead of retaining stale view`,async()=>{
 const f=fixture(),wait=deferred();if(stage==='digest')crypto.subtle.digest=()=>wait.promise;if(stage==='decode')decode=()=>wait.promise;
 f.setRespond(async url=>!url.endsWith('/image')?Response.json(payload()):stage==='fetch'?wait.promise:stage==='blob'?{ok:true,headers:new Headers({'content-type':'image/png'}),blob:()=>wait.promise}:new Response(bytes,{headers:{'content-type':'image/png'}}));await f.render();await tick();f.switch();wait.reject(Error('stale image failure'));await tick();cleared(f);assert.equal(f.created.length,stage==='decode'?1:0);
});
test('superseded pending image decode cannot reveal old image and releases its URL',async()=>{
 const f=fixture(),wait=deferred();let decodes=0;decode=()=>++decodes===1?wait.promise:Promise.resolve();await f.render();await tick();const oldImage=f.el('look-proof-r1'),oldURL=oldImage.src;await f.render();await tick();wait.resolve();await tick();assert.equal(oldImage.hidden,true);assert.equal(f.el('look-proof-r1').hidden,false);assert.ok(f.revoked.includes(oldURL));assert.equal(f.created.filter(u=>!f.revoked.includes(u)).length,1);assert.equal(f.navigations.length,0);
});

for(const action of ['refresh','mutation'])test(`current-session ${action} 401 navigates to login once without reload`,async()=>{
 const f=await ready();f.setRespond(async()=>Response.json({error:'unauthorized'},{status:401}));f.el(action==='refresh'?'look-refresh':'look-ai-r1').click();await tick();assert.deepEqual(f.navigations,['/login?enable-semantics=true']);assert.equal(f.storage.has('primecare_session'),false);cleared(f);
});
for(const transition of ['refresh','error'])for(const control of ['language','upload','ai','human','refresh','image-retry'])test(`retained ${control} from earlier draw is inert after same-session ${transition}`,async()=>{
 const f=await ready(),old=f.el({'language':'look-language','upload':'look-form','ai':'look-ai-r1','human':'look-human-form-r1','refresh':'look-refresh','image-retry':'look-image-retry-r1'}[control]),handler=control==='language'?old.onchange:control==='upload'||control==='human'?old.onsubmit:old.onclick??old.listeners.click;
 if(transition==='error')f.setRespond(async()=>{throw Error('refresh failed')});f.el('look-refresh').click();await tick();const content=f.root.innerHTML,count=f.calls.length,captures=globalThis.draftCaptures;
 old.value='fr';handler({currentTarget:old,preventDefault(){}});await tick();assert.equal(f.calls.length,count,'no request from detached control');assert.equal(f.root.innerHTML,content,'no redraw from detached control');assert.equal(globalThis.draftCaptures,captures,'no private draft capture');
});
for(const transition of ['replacement','removal'])test(`idle loaded evidence releases URLs on external root ${transition}`,async()=>{
 const f=await ready(),count=f.calls.length;assert.equal(f.created.length,1);if(transition==='replacement')f.root.innerHTML='<main data-cy="new-route">NEW ROUTE</main>';else f.root.isConnected=false;await tick();assert.ok(f.created.every(u=>f.revoked.includes(u)));assert.equal(f.navigations.length,0);assert.equal(f.calls.length,count);assert.equal(observers.size,0,'disposed observer disconnects');if(transition==='replacement')assert.match(f.root.innerHTML,/NEW ROUTE/);else assert.equal(f.root.innerHTML,'');
});
for(const outcome of ['resolve','reject'])test(`older pending refresh ${outcome} cannot redraw during active mutation`,async()=>{
 const f=await ready(),refresh=deferred(),mutation=deferred();f.setRespond(async(url,options)=>options.method==='POST'?mutation.promise:refresh.promise);f.el('look-refresh').click();await tick();f.el('look-ai-r1').click();await tick();const content=f.root.innerHTML,count=f.calls.length;if(outcome==='resolve')refresh.resolve(Response.json(payload('STALE REFRESH')));else refresh.reject(Error('stale refresh failure'));await tick();assert.equal(f.root.innerHTML,content);assert.equal(f.calls.length,count);assert.equal(f.el('look-ai-r1').disabled,true);f.setRespond(async url=>url.endsWith('/image')?new Response(bytes,{headers:{'content-type':'image/png'}}):Response.json(payload('MUTATION RESULT')));mutation.resolve(Response.json({ok:true}));await tick();assert.match(f.root.innerHTML,/MUTATION RESULT/);
});

test('idle image evidence is disposed when another route replaces only stable shell main',async()=>{
 const f=await ready(),shell=f.root.firstElementChild,oldPanel=f.el('look-review'),count=f.calls.length;f.el('shell-main').innerHTML='<section data-cy="new-route">NEW ROUTE</section>';assert.equal(f.root.firstElementChild,shell);assert.equal(f.root.contains(oldPanel),false);await tick();assert.match(f.root.innerHTML,/NEW ROUTE/);assert.ok(f.created.every(u=>f.revoked.includes(u)));assert.equal(observers.size,0);assert.equal(f.calls.length,count);assert.equal(f.navigations.length,0);
});
for(const outcome of ['resolve','reject'])test(`pending refresh ${outcome} cannot replace a newer route within the same shell`,async()=>{
 const f=await ready(),wait=deferred(),shell=f.root.firstElementChild;f.setRespond(()=>wait.promise);f.el('look-refresh').click();await tick();f.el('shell-main').innerHTML='<section data-cy="new-route">NEW ROUTE</section>';assert.equal(f.root.firstElementChild,shell);if(outcome==='resolve')wait.resolve(Response.json(payload('OLD LOOK CONTENT')));else wait.reject(Error('old refresh failure'));await tick();assert.equal(f.root.firstElementChild,shell);assert.match(f.root.innerHTML,/NEW ROUTE/);assert.doesNotMatch(f.root.innerHTML,/OLD LOOK CONTENT/);assert.ok(f.created.every(u=>f.revoked.includes(u)));assert.equal(f.navigations.length,0);
});
