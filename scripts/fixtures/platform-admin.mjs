import assert from 'node:assert/strict';
import {build} from 'esbuild';

// Actual admin module, synthetic HTTP/DOM peripherals only. This is not browser acceptance.
if (Object.keys(process.env).some(key => /(?:DATABASE_URL|DB_URL|CLOUDFLARE|CF_API|PGPASSWORD)/i.test(key))) {
  throw Error('Database/Cloudflare credentials forbidden in admin fixtures');
}
// Exercise the real nested run()/busy lifecycle while isolating its transport and
// DOM panels. No mutation endpoint or confirmation payload is changed by this batch.
const nestedFixtures={
 './client': `export class BundleClient {assertSession(){}} export const fileContent=async()=>''; export class OperationsClient {assertSession(){}} export class TerritoryClient {assertSession(){}}`,
 './panel': `export const bundlePanel=()=>''; export const operationsPanel=()=>''; export const territoryPanel=()=>'';`,
 './history-controller': `export class BundleHistoryController {reset(){} markup(){return '';} bind(){}}`,
 './attention-panel': `export const attentionPanel=()=>'';`,
 './labels': `export const observeTerritoryLabels=()=>()=>{};`,
};
const nestedBuild=await build({stdin:{contents:`export {BundleController} from './websites/typescript/src/platform-bundle/controller'; export {OperationsController} from './websites/typescript/src/tenant-operations/controller'; export {TerritoryController} from './websites/typescript/src/territories/controller';`,resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm',plugins:[{name:'nested-transport-panels',setup(builder){
 builder.onResolve({filter:/^\.\//},args=>/\/(platform-bundle|tenant-operations|territories)\/controller\.ts$/.test(args.importer)&&nestedFixtures[args.path]?{path:args.path,namespace:'nested-fixture'}:null);
 builder.onLoad({filter:/.*/,namespace:'nested-fixture'},args=>({contents:nestedFixtures[args.path],loader:'js'}));
}}]});
const nestedControllers=await import('data:text/javascript;base64,'+Buffer.from(nestedBuild.outputFiles[0].text).toString('base64'));
const fixtures = {
  './admin-sidebar-menu': 'export const mountAdminSidebarMenu=()=>{};',
  './admin-topbar': 'export const matchApprovedAdminTopbar=()=>{};',
  './shell-icons': 'export const shellIcon=()=>"";',
  './admin-demo-calls': 'export const mountDemoCallHistory=()=>{};',
  './code-admin-layout': 'export const codeAdminNavigation=v=>v; export const codeAdminDescription=()=>""; export const codeAdminPage=o=>`<div data-cy="code-admin-page-body">${o.content}</div>`;',
  './admin-dashboard': 'export const mountAdminDashboard=async(root,_gateway,_token,_locale,options)=>{globalThis.__adminFixture.dashboard=options;};',
  './vapi-admin': 'export const mountVapiAdmin=()=>globalThis.__adminFixture.mounts.push("vapi");',
  './external-calls': 'export const canUseExternalCalls=async()=>{globalThis.__adminFixture.probes++;return globalThis.__adminFixture.probe();}; export const mountExternalDialer=(_g,_t,open)=>{if(open)globalThis.__adminFixture.mounts.push("dialer");};',
  './platform-bundle/controller': controller('BundleController', 'bundle', 'openTab(tab){this.tab=tab;} openWorkflow(item){this.tab=item.destination;}'),
  './tenant-operations/controller': controller('OperationsController', 'operations'),
  './territories/controller': controller('TerritoryController', 'territories', 'dispose(){}'),
  './platform-bundle/panel': 'export const bundleText=(_locale,key)=>key;',
  './tenant-operations/panel': 'export const operationsText=(_locale,key)=>key;',
  './territories/panel': 'export const territoryText=(_locale,key)=>key;',
  './auth-client': 'export const signOut=async()=>globalThis.__adminFixture.signOut();',
  './admin-row-draft': 'export class AdminRowDraft {capture(){} restore(){}}',
  './form-draft': 'export class FormDraft {capture(){} restore(){}}',
  './media-look': 'export class DashboardMediaLook {navigationIcon(){return "";}}',
  './platform-onboarding': 'export const onboardingPanel=partners=>partners.map(p=>`<form data-partner="${p.id}" data-cy="fixture-partner-${p.id}"></form>`).join("");',
  './admin-training': 'export const trainingPanel=()=>document.createElement("section"); export const trainingText=(_gateway,_locale,key)=>key;',
  './screen-text-editor': 'export const screenTextEditor=async()=>globalThis.__adminFixture.mounts.push("text");',
  './screen-text': 'export const liveScreenText=()=>({text:(_s,_l,_k,fallback)=>fallback,subscribe:callback=>{globalThis.__adminFixture.live.add(callback);return ()=>globalThis.__adminFixture.live.delete(callback);}});',
  './account': 'export const accountMarkup=()=>"account fixture"; export const bindAccount=()=>{};',
  './shell': 'export const renderShell=(root,options)=>root.renderShell(options); export const bindShell=(root,_t,_l,_s,entries)=>{root.entries=entries();};',
  './reports': 'export const reportPanel=()=>{globalThis.__adminFixture.mounts.push("reports");return document.createElement("section");};',
  './workspace': `export const escapeHtml=value=>String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));`,
};
function controller(name, kind, extra='') {
  return `export class ${name} extends globalThis.__adminControllerTypes.${name} {
    constructor(...args){super(...args);this.callback=args[2];globalThis.__adminFixture.controllers[${JSON.stringify(kind)}]=this;}
    async load(...args){globalThis.__adminFixture.loads.push([${JSON.stringify(kind)},...args]);await globalThis.__adminFixture.loadController(${JSON.stringify(kind)});}
    mount(){globalThis.__adminFixture.mounts.push(${JSON.stringify(kind)});} ${extra}
  }`;
}
const built = await build({stdin: {contents: `export * from './websites/typescript/src/platform-admin'; export * from './packages/primecare_ui/web/screen-manager'; export * from './websites/typescript/src/managed-routes'; export * from './websites/typescript/src/screen-presentation';`, resolveDir: process.cwd()}, bundle: true, write: false, platform: 'node', format: 'esm',
  plugins: [{name: 'admin-peripherals', setup(builder) {
    builder.onResolve({filter: /^\.\//}, args => args.importer.endsWith('/platform-admin.ts') && fixtures[args.path] ? {path: args.path, namespace: 'fixture'} : null);
    builder.onLoad({filter: /.*/, namespace: 'fixture'}, args => ({contents: fixtures[args.path], loader: 'js'}));
  }}]});
globalThis.__adminControllerTypes=nestedControllers;
const {renderPlatformAdmin, ScreenManager, installScreenManager, resolveManagedRoute, installPortalPresentation} = await import('data:text/javascript;base64,' + Buffer.from(built.outputFiles[0].text).toString('base64'));
class Element {
  attrs = new Map(); dataset = {}; controls = new Map(); anchors = []; entries = []; listeners = new Map(); children = []; value='';
  innerHTML=''; isConnected=true; disabled=false; focusCount=0; renderCount=0; textContent='';
  classList={remove(){},toggle(){}};
  constructor(doc){this.ownerDocument=doc;}
  setAttribute(k,v){this.attrs.set(k,v);} getAttribute(k){return this.attrs.get(k)??null;} removeAttribute(k){this.attrs.delete(k);} hasAttribute(k){return this.attrs.has(k);}
  addEventListener(k,fn){if(!this.listeners.has(k))this.listeners.set(k,new Set());this.listeners.get(k).add(fn);}
  removeEventListener(k,fn){this.listeners.get(k)?.delete(fn);}
  contains(el){return el===this||[...this.controls.values()].includes(el);}
  append(...children){this.children.push(...children);} replaceChildren(...children){this.innerHTML='';this.children=children;this.anchors=[];this.controls.clear();}
  remove(){this.isConnected=false;} insertAdjacentHTML(_where,html){this.parse(html);} focus(){this.focusCount++;} reset(){this.resetCount=(this.resetCount??0)+1;} scrollTo(){}
  querySelectorAll(selector){
    if(['[data-user]','[data-master]','[data-partner]'].includes(selector))return [...this.controls.values()].filter(e=>e.hasAttribute(selector.slice(1,-1)));
    if(selector==='[data-section]')return this.anchors.filter(a=>a.dataset.section);
    if(selector==='[data-cy=platform-tenant-select],[data-cy=platform-topbar-tenant]')return ['platform-tenant-select','platform-topbar-tenant'].map(id=>this.controls.get(id)).filter(Boolean);
    if(selector==='input,button,select')return [...this.controls.values()].filter(e=>['input','button','select'].includes(e.tagName));
    if(selector==='form[data-cy]')return [...this.controls.values()].filter(e=>e.tagName==='form');
    return [];
  }
  querySelector(selector){
    const cy=selector.match(/\[data-cy=["']?([^\]"']+)["']?\]/)?.[1];
    if(cy)return this.controls.get(cy)??null;
    if(['button','[data-role]','[data-status]','[data-label]'].includes(selector))return [...this.controls.values()].find(e=>selector==='button'?e.tagName==='button':e.hasAttribute(selector.slice(1,-1)))??null;
    if(['aside','main h1','.app-shell','.code-admin-page-header','h1'].includes(selector))return this;
    return null;
  }
  parse(html){
    for(const match of html.matchAll(/<(a|button|select|input|section|div|output|form)\b([^>]*)>/g)){
      const el=new Element(this.ownerDocument);el.tagName=match[1];
      for(const a of match[2].matchAll(/([\w-]+)=(?:"([^"]*)"|'([^']*)'|([^\s>]+))/g)){
        const value=(a[2]??a[3]??a[4]).replaceAll('&amp;','&').replaceAll('&quot;','"'); el.setAttribute(a[1],value);
        if(a[1]==='data-cy')el.dataset.cy=value;
        if(a[1].startsWith('data-'))el.dataset[a[1].slice(5)]=value;
        if(a[1]==='href')el.href=new URL(value,this.ownerDocument.baseURI).href;
      }
      for(const attr of ['data-role','data-status','data-label'])if(match[2].includes(attr))el.setAttribute(attr,'');
      if(el.dataset.cy)this.controls.set(el.dataset.cy,el);
      if(el.tagName==='a')this.anchors.push(el);
    }
    for(const match of html.matchAll(/<tr\b([^>]*data-(user|master)="([^"]+)"[^>]*)>([\s\S]*?)<\/tr>/g)){const row=new Element(this.ownerDocument);row.dataset[match[2]]=match[3];row.setAttribute('data-'+match[2],match[3]);row.parse(match[4]);this.controls.set('fixture-row-'+match[2]+'-'+match[3],row);}
  }
  renderShell(options){this.renderCount++;this.controls.clear();this.anchors=[];this.innerHTML=options.mainAttributes+options.navigation+options.controls+options.content;this.parse(options.navigation+options.controls+options.content);this.view=options.mainAttributes.match(/data-admin-view="([^"]+)"/)?.[1];}
}
const token='fixture-admin-token';
function deferred(){let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return {promise,resolve,reject};}
const settle=async()=>{for(let i=0;i<6;i++)await new Promise(resolve=>setImmediate(resolve));};
function browser({hash='',role='platform_admin',locale='en',capabilities={},path='/platform/administration',canCall=false,installManager=true}={}){
  const data={role,scope:role==='tenant_admin'?'tenant':'global',canCreateTenant:role!=='tenant_admin',canViewReports:true,canViewTerritories:true,canViewOperations:true,canViewBundle:true,extended:role==='platform_admin',canViewTraining:true,growthDashboard:false,identity:{userId:'fixture-admin'},tenants:[{id:'tenant-a',name:'Tenant A',slug:'tenant-a'},{id:'tenant-b',name:'Tenant B',slug:'tenant-b'}],assignableRoles:['admin'],masterTypes:['fixture'],...capabilities};
  const values=new Map([['primecare_session',token]]), storage={getItem:k=>values.get(k)??null,setItem:(k,v)=>values.set(k,v),removeItem:k=>values.delete(k)};
  const doc={baseURI:'https://fixture.invalid'+path+'?locale='+locale+'&context=keep&enable-semantics=true'+hash};doc.documentElement=new Element(doc);doc.documentElement.lang=locale;doc.createElement=()=>new Element(doc);
  const root=new Element(doc),events=new Map(),assigned=[],replaced=[],pushes=[],historyReplacements=[],requests=[],loads=[],mounts=[],live=new Set(),controllers={};let reloads=0,historyIndex=0;const historyStack=[doc.baseURI];
  const setUrl=target=>{const url=new URL(target,doc.baseURI);Object.assign(globalThis.location,{href:url.href,pathname:url.pathname,search:url.search,hash:url.hash});};
  const view={scrollTo(){},addEventListener:(name,fn)=>{if(!events.has(name))events.set(name,new Set());events.get(name).add(fn);},removeEventListener:(name,fn)=>events.get(name)?.delete(fn)};
  const fixture={root,data,storage,events,assigned,replaced,pushes,historyReplacements,requests,loads,mounts,live,controllers,canCall,values,probes:0,probe:async()=>canCall,signOut:async()=>{},setUrl,loadController:async()=>{},reloads:()=>reloads,
    respond:async url=>url.endsWith('/v1/governance/platform')?Response.json(data):Response.json({users:[],records:[],events:[],partners:[]}),
    dispatch:name=>{for(const fn of [...events.get(name)??[]])fn({persisted:true});},
    historyStack,historyIndex:()=>historyIndex,go:delta=>{const next=historyIndex+delta;if(next<0||next>=historyStack.length)return;historyIndex=next;setUrl(historyStack[historyIndex]);fixture.dispatch('popstate');fixture.dispatch('hashchange');},
    render:()=>renderPlatformAdmin(root,'https://gateway.invalid'),
    anchor:id=>{const el=root.anchors.find(a=>a.dataset.section===id);assert.ok(el,'Missing anchor '+id);return el;},
    click:async(id,event={})=>{const el=typeof id==='string'?fixture.anchor(id):id;let prevented=0;el.onclick?.({preventDefault:()=>prevented++,...event});await settle();return prevented;},
  };
  Object.assign(globalThis,{document:doc,window:view,sessionStorage:storage,localStorage:storage,__adminFixture:fixture,
    location:{assign:url=>assigned.push(url),replace:url=>replaced.push(url),reload:()=>reloads++},history:{state:{other:'preserved'},pushState:(_s,_t,url)=>{pushes.push(url);setUrl(url);historyStack.splice(historyIndex+1);historyStack.push(location.href);historyIndex++;},replaceState:(_s,_t,url)=>{historyReplacements.push(url);setUrl(url);historyStack[historyIndex]=location.href;}},
    FormData:class extends Map {constructor(form){super(form?.values??[]);}},
    fetch:async(url,options)=>{requests.push({url,options});return fixture.respond(url,options);},
  });
  setUrl(doc.baseURI);
  // Match main.ts: the real manager and canonical dispatcher registration share
  // the same bundled module instance as the actual administrator renderer.
  const entries=[],connections=Object.fromEntries(['layout','theme','language','responsive'].map(name=>[name,screen=>entries.push({name,screen})]));
  const manager=new ScreenManager(connections);manager.registerScope('entry',[resolveManagedRoute(path,'')]);
  if(installManager)installScreenManager(root,manager);
  Object.assign(fixture,{manager,connections,entries});
  return fixture;
}

export {browser, deferred, settle, token, nestedControllers, installPortalPresentation};
