import {createBrowser,Element} from './care-dom-base.mjs';
import {build} from 'esbuild';
import {resolve} from 'node:path';
import {readFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
import {webcrypto} from 'node:crypto';
// Actual renderer, transport, ScreenManager, shared shell, appearance and Theme Center.
// Small DOM additions model APIs these modules use, not layout or native BFCache.
export const source=resolve(process.env.MAINTENANCE_SOURCE??process.cwd());
export const catalog=JSON.parse(await readFile(source+'/packages/shared/src/maintenance.json','utf8'));
export const c=catalog.controls;
const built=await build({stdin:{contents:"export * from './websites/typescript/src/maintenance';export * from './packages/primecare_ui/web/screen-manager';export * from './websites/typescript/src/managed-routes';",resolveDir:source},bundle:true,write:false,platform:'node',format:'esm'});
export const api=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text+'\n//# sourceURL=maintenance-fixture-actual.mjs').toString('base64'));
console.log('MAINTENANCE_FIXTURE',JSON.stringify({source,bundleBytes:built.outputFiles[0].contents.length,shell:'actual'}));
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
export function configuration(sender='current@example.invalid'){
 const ids=Object.keys(c).filter(k=>k.startsWith('template_')&&k.endsWith('_subject')).map(k=>k.slice(9,-8));
 return {sender,settingsReady:true,emailReady:true,revision:7,templates:Object.fromEntries(ids.map(id=>[id,{subject:'Subject',title:'Title',body:'Body',required:[]} ])),pending:[],externalConfiguration:[],audit:[]};
}
export const deferred=()=>{let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return{promise,resolve,reject};};
export function fixture({manager=true,locale='en',role='ceo'}={}){
 const f=createBrowser('https://fixture.invalid/maintenance/configuration?locale='+locale+'&enable-semantics=true');f.doc.documentElement.lang=locale;
 const computed=()=>({getPropertyValue:()=>''}),media=()=>({matches:false,addEventListener(){},removeEventListener(){}});
 Object.assign(globalThis,{Node:Element,HTMLButtonElement:Element,HTMLFormElement:Element,HTMLSelectElement:Element,getComputedStyle:computed,matchMedia:media});
 Object.defineProperty(globalThis,'crypto',{configurable:true,value:webcrypto});Object.defineProperty(globalThis,'navigator',{configurable:true,value:{}});f.events.matchMedia=media;f.events.getComputedStyle=computed;
 f.calls=[];f.data=configuration();f.role=role;f.connections=[];f.services=Object.fromEntries(['layout','theme','language','responsive'].map(k=>[k,()=>f.connections.push(k)]));
 f.manager=new api.ScreenManager(f.services);if(manager)api.installScreenManager(f.root,f.manager);f.entry=api.resolveManagedRoute('/maintenance/configuration','');f.manager.registerScope('entry',[f.entry]);
 f.respond=async(url,o)=>{
  if(url.endsWith('/me'))return Response.json({userId:'fixture-user',roles:f.role,status:'authenticated'});
  if(o.method==='GET')return Response.json(f.data);
  if(url.endsWith('/logout'))return Response.json({status:'signed_out'});
  if(url.endsWith('/register'))return Response.json({userId:'created-user'});
  return Response.json({message:url.endsWith('/test-email')?'Provider accepted the test. Check your inbox/spam to confirm delivery.':'Settings saved. Send a test email to check delivery.'});
 };
 globalThis.fetch=(url,options)=>{assert.ok(url.startsWith('https://gateway.invalid/'));assert.equal(options.headers.authorization,'Bearer token-A');f.calls.push({url,options});return f.respond(url,options);};
 f.render=()=>api.renderMaintenance(f.root,'https://gateway.invalid');f.writes=()=>f.calls.filter(x=>x.options.method!=='GET');
 f.fire=async(node,type='click')=>{assert.ok(node,'fixture control exists');node.dispatchEvent({type});await f.settle();};
 f.fill=(id,values)=>{const form=f.cy(id);for(const[k,v]of Object.entries(values)){const field=form.querySelector('[name="'+k+'"]');assert.ok(field,k);field.value=v;}return form;};
 f.retained=(node,type='click')=>{const callbacks=[...node.listeners.get(type)??[]];return()=>{for(const callback of callbacks)callback({currentTarget:node,preventDefault(){}});};};
 return f;
}
export function invalidate(f,kind){
 if(kind==='root')f.root.innerHTML='<main data-cy="replacement">Replacement</main>';
 if(kind==='main')f.root.querySelector('main').innerHTML='<p data-cy="replacement">Replacement main</p>';
 if(kind==='route')f.go('/success?enable-semantics=true');
 if(kind==='query')f.go('/maintenance/configuration?locale=fr&enable-semantics=true');
 if(kind==='session')f.sessionStorage.setItem('primecare_session','token-B');
 if(kind==='removed')f.root.remove();
 if(kind==='manager')f.manager.registerScope('entry',[]);
 if(kind==='connection')f.services.theme=()=>{throw Error('private connection detail');};
 if(kind==='pagehide')f.event('pagehide',{persisted:false});
}
