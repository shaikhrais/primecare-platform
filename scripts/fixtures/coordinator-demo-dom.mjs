import {createBrowser,Element} from './care-dom-base.mjs';
import {build} from 'esbuild';
import {resolve} from 'node:path';
import {existsSync} from 'node:fs';
import {mkdtemp,writeFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {pathToFileURL} from 'node:url';
import {seedState} from '../../packages/shared/src/psw-workspace/schedule-core.mjs';
import {changeWorkspace,projectState} from '../../packages/shared/src/psw-workspace/actions.mjs';


if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL||process.env.DB_URL)throw Error('Database credentials forbidden in care fixtures');
const source=resolve(process.argv[2]??process.cwd());
const managedExports=existsSync(resolve(source,'websites/typescript/src/care/ownership.ts'))?"export * from './websites/typescript/src/care/ownership';export * from './websites/typescript/src/care/live-client';":'';
const built=await build({stdin:{contents:managedExports+"export * from './websites/typescript/src/psw-workspace/index';export * from './websites/typescript/src/care/dashboard';export * from './packages/primecare_ui/web/screen-manager';export * from './websites/typescript/src/managed-routes';",resolveDir:source},bundle:true,write:false,platform:'node',format:'esm'});
const directory=await mkdtemp(resolve(tmpdir(),'primecare-demo-test-'));
let module;try{const path=resolve(directory,'actual.mjs');await writeFile(path,built.outputFiles[0].text);module=await import(pathToFileURL(path));}finally{await rm(directory,{recursive:true,force:true});}
export const m=module;
// Extend existing deterministic DOM model for normal class/id/child selectors and forms.
function atom(e,s){s=s.trim();if(!s)return false;const tag=s.match(/^[\w-]+/)?.[0];if(tag&&e.tagName!==tag.toUpperCase())return false;for(const [,v]of s.matchAll(/#([\w-]+)/g))if(e.id!==v)return false;for(const [,v]of s.matchAll(/\.([\w-]+)/g))if(!(e.getAttribute('class')??'').split(/\s+/).includes(v))return false;for(const [,k,v]of s.matchAll(/\[([^=\]\s]+)(?:=["']?([^"'\]]*)["']?)?\]/g))if(!e.hasAttribute(k)||(v!==undefined&&e.getAttribute(k)!==v))return false;return !!(tag||s.startsWith('.')||s.startsWith('#')||s.startsWith('['));}
function matches(e,s){const parts=s.trim().replace(/\s*>\s*/g,' > ').split(/\s+/);if(!atom(e,parts.pop()))return false;let p=e.parentElement;while(parts.length){const token=parts.pop();if(token==='>'){if(!p||!atom(p,parts.pop()))return false;p=p.parentElement;}else{while(p&&!atom(p,token))p=p.parentElement;if(!p)return false;p=p.parentElement;}}return true;}
Element.prototype.querySelectorAll=function(s){let out=[];for(const c of this.children){if(s.split(',').some(x=>matches(c,x)))out.push(c);out.push(...c.querySelectorAll(s));}return out;};
Element.prototype.closest=function(s){for(let p=this;p;p=p.parentElement)if(matches(p,s))return p;return null;};
Object.defineProperties(Element.prototype,{classList:{get(){const node=this;const values=()=>new Set((node.getAttribute('class')??'').split(/\s+/).filter(Boolean));return{contains:k=>values().has(k),toggle(k,force){const v=values(),on=force??!v.has(k);on?v.add(k):v.delete(k);node.setAttribute('class',[...v].join(' '));return on;},add(...ks){const v=values();ks.forEach(k=>v.add(k));node.setAttribute('class',[...v].join(' '));},remove(...ks){const v=values();ks.forEach(k=>v.delete(k));node.setAttribute('class',[...v].join(' '));}};}},childElementCount:{get(){return this.children.length;}},elements:{get(){const es=this.querySelectorAll('input,select,textarea,button');es.namedItem=n=>es.find(e=>e.getAttribute('name')===n)??null;return es;}},options:{get(){return this.querySelectorAll('option');}},name:{get(){return this.getAttribute('name');},set(value){this.setAttribute('name',value);}},type:{get(){return this.getAttribute('type');},set(value){this.setAttribute('type',value);}}});
Element.prototype.scrollIntoView=function(){};
Object.defineProperties(Element.prototype,{
 attributes:{get(){return [...this.attrs].map(([name,value])=>({name,value}));}},
 content:{get(){return this;}},
 checked:{get(){return this._checked??this.hasAttribute('checked');},set(value){this._checked=value;}},
 selected:{get(){return this.hasAttribute('selected');},set(value){value?this.setAttribute('selected',''):this.removeAttribute('selected');}},
 selectedOptions:{get(){return this.options.filter(o=>o.selected);}},
 multiple:{get(){return this.hasAttribute('multiple');}}
});
Element.prototype.after=function(e){const p=this.parentElement;if(!p)return;e.parentElement=p;p.children.splice(p.children.indexOf(this)+1,0,e);this.ownerDocument.changed();};

// The existing reducer models only the authorized saved demo service, never
// production access or database concurrency. Browser layout/BFCache are modeled.
const timers=new Set(),realSetTimeout=globalThis.setTimeout,realClearTimeout=globalThis.clearTimeout;
export function fixture({route='/psw',query='?dataset=demo&tenant=fixture-tenant&enable-semantics=true',manager=true,canManage=true}={}){
 const b=createBrowser('https://fixture.invalid'+route+query),calls=[];
 globalThis.window.scrollTo=()=>{};globalThis.getComputedStyle=()=>({getPropertyValue:()=>''});globalThis.Node=Element;
 const f={...b,calls,services:{layout(){},theme(){},language(){},responsive(){}},printed:0,downloads:[],revoked:[],timers};
 globalThis.setTimeout=(fn,delay,...args)=>{const timer=realSetTimeout(()=>{timers.delete(timer);fn(...args);},delay);timer.unref();timers.add(timer);return timer;};
 globalThis.clearTimeout=timer=>{timers.delete(timer);return realClearTimeout(timer);};
 f.identity={userId:'fixture-worker',role:canManage?'scheduler':'rn',tenantId:'fixture-tenant',organization:'Fixture tenant'};
 f.actor={id:f.identity.userId,roles:f.identity.role};
 f.demo={dataset:'demo',database:'PostgreSQL',synthetic:true,version:7,canManage,identity:f.identity,scopes:[],liveCareAvailable:true,state:projectState(seedState(),f.actor)};
 f.info={identity:f.identity,canManage,scopes:[],liveCareAvailable:true};
 f.manager=new m.ScreenManager(f.services);if(manager)m.installScreenManager(f.root,f.manager);f.entry=m.resolveManagedRoute(route,'');f.manager.registerScope('entry',[f.entry]);
 f.render=()=>m.renderPSW(f.root,'https://gateway.invalid');
 f.respond=async(url,o)=>{if(o.method==='POST'){const body=JSON.parse(o.body);try{if(body.version!==f.demo.version)return Response.json({error:'conflict'},{status:409});f.demo.state=projectState(changeWorkspace(f.demo.state,f.actor,body.action,body.value,'2026-11-07T10:00:00Z').data,f.actor);f.demo.version++;}catch(error){return Response.json({error:error.message},{status:error.message==='forbidden'?403:400});}return Response.json(f.demo);}return Response.json(url.includes('dataset=info')?f.info:f.demo);};
 globalThis.fetch=(url,options)=>{calls.push({url,options});return f.respond(url,options);};
 f.fire=async(node,type='click',extra={})=>{if(!node)throw Error('Missing fixture control');node.dispatchEvent({type,...extra});await f.settle();};
 f.find=s=>f.root.querySelector(s);f.dialog=()=>f.doc.querySelector('dialog');f.form=()=>f.dialog()?.querySelector('form');f.writes=()=>calls.filter(c=>c.options.method!=='GET');
 f.nav=page=>f.fire(f.find('[data-nav="'+page+'"]'));f.action=action=>f.fire(f.find('[data-action="'+action+'"]'));
 f.fill=(values,form=f.form())=>{if(!form)throw Error('Missing form');for(const[k,v]of Object.entries(values)){const e=form.elements.namedItem(k);if(!e)throw Error('Missing '+k);if(typeof v==='boolean')e.checked=v;else e.value=String(v);}return form;};
 window.print=()=>f.printed++;URL.createObjectURL=blob=>{f.downloads.push(blob);return 'blob:fixture-'+f.downloads.length;};URL.revokeObjectURL=url=>f.revoked.push(url);
 return f;
}
Element.prototype.toggleAttribute=function(k,force){const on=force??!this.hasAttribute(k);on?this.setAttribute(k,''):this.removeAttribute(k);return on;};
Element.prototype.setSelectionRange=function(a,b){this.selectionStart=a;this.selectionEnd=b;};
export function deferred(){let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return{promise,resolve,reject};}
export function invalidate(f,kind){if(kind==='charge')f.sessionStorage.setItem('primecare_care_charge','changed');if(kind==='root')f.root.innerHTML='<main data-cy="replacement">Replacement owner</main>';if(kind==='query')f.go('/psw?dataset=live&tenant=other&enable-semantics=true');if(kind==='route')f.go('/account?enable-semantics=true');if(kind==='session')f.sessionStorage.setItem('primecare_session','token-B');if(kind==='removed')f.root.remove();if(kind==='manager')f.manager.registerScope('entry',[]);if(kind==='presentation')f.services.theme=undefined;if(kind==='pagehide')f.event('pagehide',{persisted:false});}
