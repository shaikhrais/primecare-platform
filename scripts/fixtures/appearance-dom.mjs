import {createBrowser,Element} from './care-dom-base.mjs';
import {build} from 'esbuild';
import {resolve} from 'node:path';
import {webcrypto,createHash} from 'node:crypto';
export const source=resolve(process.env.APPEARANCE_SOURCE??process.cwd());
const built=await build({stdin:{contents:"export * from './websites/typescript/src/look-review';export * from './packages/primecare_ui/web/screen-manager';export * from './websites/typescript/src/managed-routes';",resolveDir:source},bundle:true,write:false,platform:'node',format:'esm'});
export const api=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text+'\n//# sourceURL=appearance-fixture-actual.mjs').toString('base64'));
function simple(e,s){const tag=s.match(/^[\w-]+/)?.[0];if(tag&&e.tagName!==tag.toUpperCase())return false;for(const[,name]of s.matchAll(/\.([\w-]+)/g))if(!(e.getAttribute('class')??'').split(/\s+/).includes(name))return false;for(const[,key,op,value]of s.matchAll(/\[([^=\^\]\s]+)(?:(\^?=)["']?([^"'\]]*)["']?)?\]/g)){const v=e.getAttribute(key);if(v===null||value!==undefined&&(op==='^='?!v.startsWith(value):v!==value))return false;}return !!(tag||s.startsWith('.')||s.startsWith('['));}
function matches(e,s){const parts=s.trim().split(/\s+/);if(!simple(e,parts.pop()))return false;let p=e.parentElement;while(parts.length){let part=parts.pop();if(part==='>'){part=parts.pop();if(!p||!simple(p,part))return false;p=p.parentElement;continue;}while(p&&!simple(p,part))p=p.parentElement;if(!p)return false;p=p.parentElement;}return true;}
Element.prototype.querySelectorAll=function(s){const found=[];for(const child of this.children){if(s.split(',').some(x=>matches(child,x)))found.push(child);found.push(...child.querySelectorAll(s));}return found;};
Element.prototype.closest=function(s){for(let p=this;p;p=p.parentElement)if(matches(p,s))return p;return null;};
Element.prototype.after=function(e){const p=this.parentElement;if(!p)return;e.remove();e.parentElement=p;p.children.splice(p.children.indexOf(this)+1,0,e);this.ownerDocument.changed(p);};
Element.prototype.insertAdjacentHTML=function(where,html){const holder=this.ownerDocument.createElement('div');holder.innerHTML=html;const nodes=[...holder.children];if(where==='afterbegin')this.prepend(...nodes);else this.append(...nodes);};
Element.prototype.scrollIntoView=function(){this.scrolled=true;};
Object.defineProperties(Element.prototype,{
 className:{get(){return this.getAttribute('class')??'';},set(v){this.setAttribute('class',v);}},
 classList:{get(){const e=this;return{contains:k=>e.className.split(/\s+/).includes(k),add(...ks){e.className=[...new Set([...e.className.split(/\s+/),...ks])].join(' ');},remove(k){e.className=e.className.split(/\s+/).filter(v=>v!==k).join(' ');},toggle(k,v){const set=new Set(e.className.split(/\s+/));if(v??!set.has(k))set.add(k);else set.delete(k);e.className=[...set].join(' ');}};}},
 attributes:{get(){return [...this.attrs].map(([name,value])=>({name,value}));}},
 content:{get(){return this;}},
});

// Browser-owned form/file and image APIs used by real FormDraft and media evidence.
Object.defineProperties(Element.prototype,{
 name:{get(){return this.getAttribute('name')??'';}},type:{get(){return this.getAttribute('type')??'';},set(v){this.setAttribute('type',v);}},
 elements:{get(){const fields=this.querySelectorAll('input,select,textarea');fields.namedItem=name=>fields.find(f=>f.name===name);return fields;}},
 options:{get(){return this.querySelectorAll('option');}},
 src:{get(){return this.getAttribute('src');},set(v){this.setAttribute('src',v);}},
});
Element.prototype.replaceWith=function(node){this.before(node);this.remove();};
export const bytes=new Uint8Array([137,80,78,71]);
export const digest=Buffer.from(await webcrypto.subtle.digest('SHA-256',bytes)).toString('hex');
export const payload=(name='Current private screen')=>({identity:{role:'reviewer',userId:'fixture-user'},providerReady:true,canSubmit:true,screens:[{code:'screen',name,route:'/screen'}],rows:[{id:'r1',version:1,image_digest:digest,screen:'screen',platform:'web',width:320,height:800,locale:'en',build:'build',theme:'theme',layout:'layout',state:'pending',policyCurrent:true,coverage:{approved:0,required:1},canRunAI:true,humanActions:['approved']}]});
export const deferred=()=>{let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return{promise,resolve,reject};};
let active;
export function cleanup(){active?.event('pagehide',{persisted:false});active=undefined;}
export function fixture({manager=true,locale='en'}={}){
 cleanup();const f=createBrowser('https://fixture.invalid/appearance-review?locale='+locale+'&enable-semantics=true');f.doc.documentElement.lang=locale;active=f;
 const computed=()=>({getPropertyValue:()=>''}),media=()=>({matches:false,addEventListener(){},removeEventListener(){}});
 Object.assign(globalThis,{Node:Element,HTMLButtonElement:Element,HTMLFormElement:Element,HTMLSelectElement:Element,HTMLTextAreaElement:Element,getComputedStyle:computed,matchMedia:media});
 for(const [name,tag] of Object.entries({HTMLInputElement:'INPUT',HTMLSelectElement:'SELECT',HTMLTextAreaElement:'TEXTAREA'}))globalThis[name]=class{static [Symbol.hasInstance](node){return node?.tagName===tag;}};
 Object.defineProperty(globalThis,'crypto',{configurable:true,value:{randomUUID:()=>webcrypto.randomUUID(),subtle:{digest:async(_,bytes)=>createHash('sha256').update(new Uint8Array(bytes)).digest()}}});Object.defineProperty(globalThis,'navigator',{configurable:true,value:{}});f.events.matchMedia=media;f.events.getComputedStyle=computed;
 f.calls=[];f.data=payload();f.created=[];f.revoked=[];f.decode=async()=>{};Element.prototype.decode=function(){return f.decode(this);};
 URL.createObjectURL=()=>{const url='blob:appearance-'+f.created.length;f.created.push(url);return url;};URL.revokeObjectURL=url=>f.revoked.push(url);
 f.file={size:bytes.length,arrayBuffer:async()=>bytes.buffer};
 globalThis.FormData=class{constructor(form){this.rows=form.elements.map(e=>[e.name,e.type==='file'?f.file:e.value]);}*[Symbol.iterator](){yield* this.rows;}};
 f.connections=[];f.services=Object.fromEntries(['layout','theme','language','responsive'].map(k=>[k,()=>f.connections.push(k)]));
 f.manager=new api.ScreenManager(f.services);if(manager)api.installScreenManager(f.root,f.manager);f.entry=api.resolveManagedRoute('/appearance-review','');f.manager.registerScope('entry',[f.entry]);
 f.respond=async(url,o)=>url.endsWith('/image')?new Response(bytes,{headers:{'content-type':'image/png'}}):Response.json(o.method==='POST'?{ok:true}:f.data);
 globalThis.fetch=(url,options)=>{f.calls.push({url,options});return f.respond(url,options);};
 f.render=()=>api.renderLookReview(f.root,'https://gateway.invalid');f.writes=()=>f.calls.filter(x=>x.options.method==='POST');
 f.fire=async(node,type='click')=>{if(!node)throw Error('Missing fixture control');node.dispatchEvent({type});await f.settle();};
 f.retained=(node,type='click')=>{const callbacks=[...node.listeners.get(type)??[],...(node['on'+type]?[node['on'+type]]:[])];return()=>{for(const callback of callbacks)callback({currentTarget:node,preventDefault(){}});};};
 return f;
}
export function invalidate(f,kind){
 if(kind==='root')f.root.innerHTML='<main data-cy="replacement">Replacement</main>';
 if(kind==='main')f.root.querySelector('main').innerHTML='<p data-cy="replacement">Replacement main</p>';
 if(kind==='route')f.go('/success?enable-semantics=true');
 if(kind==='query')f.go('/appearance-review?locale=fr&enable-semantics=true');
 if(kind==='session')f.sessionStorage.setItem('primecare_session','token-B');
 if(kind==='removed')f.root.remove();
 if(kind==='manager')f.manager.registerScope('entry',[]);
 if(kind==='connection')f.services.theme=()=>{throw Error('private connection detail');};
 if(kind==='pagehide')f.event('pagehide',{persisted:false});
}
