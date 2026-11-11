import {test,afterEach} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile, mkdtemp} from 'node:fs/promises';
import {createRequire} from 'node:module';
import {tmpdir} from 'node:os';
import {join} from 'node:path';

// Synthetic transport/DOM fixtures only. No database connection or live authority read.
if (process.env.PRODUCTION_DATABASE_URL || process.env.GOVERNANCE_DATABASE_URL || process.env.DB_URL) {
  throw Error('Production/database credentials forbidden in workspace route fixtures');
}
const registry = JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json', 'utf8'));
const importCode = async options => {
  const output = await build({...options, bundle: true, write: false, platform: 'node', format: 'esm'});
  return import('data:text/javascript;base64,' + Buffer.from(output.outputFiles[0].text).toString('base64'));
};
const backendPath = join(await mkdtemp(join(tmpdir(), 'workspace-route-backend-')), 'workspace.cjs');
await build({entryPoints: ['cloudflare/workers/src/workspace.ts'], bundle: true, platform: 'node', format: 'cjs', outfile: backendPath,
  plugins: [{name: 'isolated-workspace-database', setup(builder) {
    builder.onResolve({filter: /^pg$/}, () => ({path: 'pg', namespace: 'fixture'}));
    builder.onLoad({filter: /.*/, namespace: 'fixture'}, () => ({contents: `export class Client {
      async connect() {} async end() {} async query(sql, values) {return globalThis.__workspaceRouteQuery(sql, values);}
    }`, loader: 'js'}));
  }}]});
const {workspace} = createRequire(import.meta.url)(backendPath);
const token = 'a'.repeat(43);
async function serverData(role = 'ceo') {
  globalThis.__workspaceRouteQuery = async (sql, values) => {
    if (sql.includes('WHERE s.token_hash=$1')) return {rows: [{id: 'fixture-user', roles: role, tenant_id: 'fixture-tenant'}]};
    if (sql.includes('SELECT roles AS role')) {assert.deepEqual(values, ['fixture-tenant']); return {rows: [{role, count: 1}]};}
    if (sql.includes('COUNT(*)::int AS count FROM auth_sessions')) return {rows: [{count: 1}]};
    if (sql.includes('FROM auth_account_audit') || sql.includes('FROM pg_attribute') || sql.startsWith('BEGIN') || sql === 'ROLLBACK') return {rows: []};
    assert.fail('Unexpected fixture SQL: ' + sql);
  };
  const response = await workspace(new Request('https://fixture.invalid/workspace', {headers: {authorization: 'Bearer ' + token}}),
    {SERVICE_NAME: 'governance', DB_URL: 'synthetic-pg-adapter-only'}, '/workspace', {});
  assert.equal(response.status, 200);
  return response.json();
}
const fixtures = {
  './account-mutations-panel': `export const mutationActorForScreen=()=>false; export const accountCreationMarkup=()=>''; export const bindAccountCreation=()=>()=>{};`,
  './tenant-accounts-panel': `export const tenantAccountsScreen='fixture-disabled'; export const tenantAccountsMarkup=()=>''; export const bindTenantAccounts=()=>()=>{};`,
  './admin-training': `export const openAdminTraining=()=>{}; export const trainingText=()=>'';`,
  './media-look': `export class DashboardMediaLook {roleLabel(v){return v;} sectionIcon(){return '';} heading(v){return v;}}`,
  './screen-text': `export const liveScreenText=()=>({text:(_screen,_locale,_key,fallback)=>fallback,subscribe:callback=>{globalThis.__workspaceRouteLive.push(callback);return ()=>{};}});`,
  './account': `export const accountMarkup=()=>''; export const bindAccount=()=>()=>{};`,
  './auth-client': `export const signOut=async()=>{};`,
  './shell': `export const renderShell=(root,options)=>root.renderShell(options); export const bindShell=(root,_title,_locale,_scope,entries)=>{root.entries=entries();};`,
  './reports': `export const reportPanel=()=>document.createElement('section');`,
};
const client = await importCode({stdin: {contents: `export * from './websites/typescript/src/workspace';
  export * from './packages/primecare_ui/web/screen-manager'; export * from './websites/typescript/src/managed-routes';`, resolveDir: process.cwd()},
  plugins: [{name: 'workspace-peripheral-fixtures', setup(builder) {
    const callFixtures={
      './external-calls':'export const mountExternalDialer=()=>{};',
      './infrastructure/webrtc/batched-peer':'export class BatchedIcePeerConnection {}',
      './internal-call-client':`export class InternalCallRequestError extends Error {}
        export class InternalCallClient {async directory(){globalThis.__callLifecycle.directory++;return globalThis.__callLifecycle.directoryResponse();}
        async command(){return {items:[]};}}`,
      './shell':`export const renderShell=(root,options)=>{root.innerHTML=options.content;globalThis.__callLifecycle.renders++;};export const bindShell=()=>{};`,
    };
    builder.onResolve({filter: /^\.\//}, args => {
      if(args.importer.endsWith('/workspace.ts')&&fixtures[args.path])return {path:args.path,namespace:'fixture'};
      if(args.importer.endsWith('/internal-calls.ts')&&callFixtures[args.path])return {path:args.path,namespace:'calls-fixture'};
      return null;
    });
    builder.onResolve({filter: /call-events\.mjs$/}, args=>args.importer.endsWith('/internal-calls.ts')?{path:'call-events',namespace:'calls-events-fixture'}:null);
    builder.onLoad({filter: /[\/]internal-calls\.ts$/}, async args=>({contents:'await globalThis.__callsImportGate;\n'+await readFile(args.path,'utf8')+'\nglobalThis.__renderInternalCalls=renderInternalCalls;',loader:'ts'}));
    builder.onLoad({filter: /.*/, namespace:'calls-events-fixture'},()=>({contents:`export class BrowserCallEvents {
      connected=false;start(){globalThis.__callLifecycle.starts++;}close(){globalThis.__callLifecycle.closes++;}
    }`,loader:'js'}));
    builder.onLoad({filter: /.*/, namespace: 'fixture'}, args => ({contents: fixtures[args.path], loader: 'js'}));
    builder.onLoad({filter: /.*/, namespace: 'calls-fixture'}, args => ({contents: callFixtures[args.path], loader: 'js'}));
  }}]});

// Minimal DOM adapter: captures the actual workspace HTML, bound anchor handlers,
// and command-palette entries. This is not browser/Cypress or layout acceptance.
class Element {
  attrs = new Map(); dataset = {}; children = []; controls = new Map(); anchors = []; entries = []; listeners = new Map();
  innerHTML = ''; renderCount = 0; focusCount = 0; open = false; isConnected = true; style = {getPropertyValue: () => '', setProperty() {}, removeProperty() {}};
  constructor(doc) {this.ownerDocument = doc;}
  setAttribute(key, value) {this.attrs.set(key, value);}
  getAttribute(key) {return this.attrs.get(key) ?? null;}
  removeAttribute(key) {this.attrs.delete(key);}
  replaceChildren(...children) {this.children = children; this.innerHTML = ''; this.anchors = []; this.controls.clear();}
  insertBefore() {} insertAdjacentHTML() {} setSelectionRange() {} append(...children){this.children.push(...children);} pause(){} play(){return Promise.resolve();} removeEventListener(name,callback){if(this.listeners.get(name)===callback)this.listeners.delete(name);}
  focus() {this.focusCount++;}
  addEventListener(name, callback) {this.listeners.set(name, callback);}
  querySelectorAll(selector) {return selector === 'a[data-route]' ? this.anchors.filter(anchor => anchor.dataset.route !== undefined) : [];}
  querySelector(selector) {
    if (selector === 'main') return this;
    const cy = selector.match(/\[data-cy=["']?([^\]"']+)["']?\]/)?.[1];
    const key = cy ?? selector;
    if (!this.controls.has(key)) this.controls.set(key, new Element(this.ownerDocument));
    return this.controls.get(key);
  }
  renderShell(options) {
    this.renderCount++;
    this.innerHTML = options.mainAttributes + options.navigation + options.controls + options.content;
    this.anchors = [];
    for (const match of this.innerHTML.matchAll(/<a\b([^>]*)>/g)) {
      const anchor = new Element(this.ownerDocument);
      for (const attribute of match[1].matchAll(/([\w-]+)="([^"]*)"/g)) {
        const value = attribute[2].replaceAll('&amp;', '&').replaceAll('&quot;', '"');
        anchor.setAttribute(attribute[1], value);
        if (attribute[1] === 'data-route') anchor.dataset.route = value;
        if (attribute[1] === 'href') anchor.href = new URL(value, this.ownerDocument.baseURI).href;
      }
      if (anchor.getAttribute('data-cy')) this.controls.set(anchor.getAttribute('data-cy'), anchor);
      this.anchors.push(anchor);
    }
  }
}
async function browser({role = 'ceo', path, locale = 'en', data} = {}) {
  data ??= await serverData(role);
  path ??= data.landing;
  const values = new Map([['primecare_session', token]]);
  const storage = {getItem: key => values.get(key) ?? null, setItem: (key, value) => values.set(key, value), removeItem: key => values.delete(key)};
  const doc = {baseURI: 'https://fixture.invalid' + path + '?enable-semantics=true'};
  doc.documentElement = new Element(doc); doc.documentElement.lang = locale; doc.createElement = () => new Element(doc);
  const root = new Element(doc), assigned = [], replaced = [], pushes = [], historyReplacements = [], requests = [];
  let reloads = 0;
  const setUrl = target => {
    const url = new URL(target, doc.baseURI);
    Object.assign(globalThis.location, {pathname: url.pathname, search: url.search, href: url.href});
  };
  const events = new Map();
  const view = {
    addEventListener: (name, callback) => {if (!events.has(name)) events.set(name, new Set()); events.get(name).add(callback);},
    removeEventListener: (name, callback) => events.get(name)?.delete(callback),
  };
  view.dispatchEvent=event=>{for(const callback of [...events.get(event.type)??[]])callback(event);view['on'+event.type]?.(event);};
  Object.assign(globalThis, {document: doc, window: view, sessionStorage: storage, localStorage: storage,
    location: {assign: url => assigned.push(url), replace: url => replaced.push(url), reload: () => reloads++},
    history: {pushState: (_a, _b, url) => {pushes.push(url); setUrl(url);}, replaceState: (_a, _b, url) => {historyReplacements.push(url); setUrl(url);}},
    __workspaceRouteLive: [], fetch: async (url, options) => {requests.push({url, options}); return globalThis.__workspaceRead(data);},
  });
  globalThis.__workspaceRead=async data=>Response.json(data);
  globalThis.__callLifecycle={starts:0,closes:0,directory:0,renders:0,directoryResponse:async()=>({userId:'fixture-user',self:null,items:[]})};
  setUrl(path + '?enable-semantics=true');
  const services = Object.fromEntries(['layout', 'theme', 'language', 'responsive'].map(key => [key, () => {}]));
  const manager = new client.ScreenManager(services); client.installScreenManager(root, manager);
  // Match main.ts's document entry; popstate below models both property and listener delivery.
  manager.registerScope('entry',[client.resolveManagedRoute(location.pathname,'')]);
  const palette = route => {const entry = root.entries.find(entry => entry.detail.endsWith(' · ' + route)); assert.ok(entry, 'Missing palette entry: ' + route); return entry.open;};
  const anchor = code => {const link = root.querySelector('[data-cy="sidebar-item-' + code + '"]'); assert.equal(typeof link.onclick, 'function', 'Missing sidebar binding: ' + code); return link;};
  const click = link => {let prevented = 0; link.onclick({preventDefault: () => prevented++}); assert.equal(prevented, 1);};
  const render = () => client.renderWorkspace(root, 'https://gateway.invalid');
  return {root, data, manager, services, storage, assigned, replaced, pushes, historyReplacements, requests, setUrl, palette, anchor, click, render, events,
    dispatch: (name, event) => {for (const callback of [...events.get(name) ?? []]) callback(event);}, reloads: () => reloads};
}
const pathOf = url => new URL(url, 'https://fixture.invalid').pathname;
const assertUrl = (url, path, locale = 'en') => {
  const value = new URL(url, 'https://fixture.invalid');
  assert.equal(value.pathname, path);
  assert.equal(value.searchParams.get('enable-semantics'), 'true');
  assert.ok(value.search.endsWith('enable-semantics=true'));
  assert.equal(value.searchParams.get('locale'), locale === 'en' ? null : locale);
};




// The real workspace handler supplies existing registry grants, and the real
// workspace + InternalCallsPanel own lifecycle/cleanup. DOM, call transport,
// push events, and media devices are synthetic. No browser/production claim.
let active;
const settle=async()=>{for(let i=0;i<5;i++)await new Promise(resolve=>setImmediate(resolve));};
function deferred(){let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return {promise,resolve,reject};}
async function calls(){
 const data=await serverData('customer_support'),page=data.screens.find(page=>page.code==='communication');
 assert.equal(page.route,'/staff/communication');assert.ok(page.grants.some(g=>g.role==='customer_support'&&g.view===1));
 const f=await browser({data,path:page.route});f.page=page;f.setUrl(page.route+'?view=calls&enable-semantics=true');active=f;return f;
}
afterEach(()=>{active?.dispatch('pagehide',{persisted:false});active=undefined;});
const callsActive=()=>globalThis.__callLifecycle.starts-globalThis.__callLifecycle.closes;
const leave=f=>f.dispatch('pagehide',{persisted:true});
const resume=f=>f.dispatch('pageshow',{persisted:true});

test('query changed during the actual lazy module import never mounts obsolete calls',async()=>{
 const gate=deferred();globalThis.__callsImportGate=gate.promise;const f=await calls();const pending=f.render();await settle();
 assert.equal(globalThis.__callLifecycle.renders,0);
 f.setUrl(f.page.route+'?enable-semantics=true');gate.resolve();await pending;await settle();
 assert.equal(globalThis.__callLifecycle.renders,0);assert.match(f.root.innerHTML,/screen-communication/);
});
test('actual calls close on persisted leave and a fresh grant read creates a new owner on each return',async()=>{
 const f=await calls();await f.render();assert.equal(callsActive(),1);
 for(let i=0;i<3;i++){
  leave(f);assert.equal(callsActive(),0);assert.throws(()=>f.manager.enter('governed:'+f.page.code,f.page.route),/Missing registration/);
  resume(f);await settle();assert.equal(f.requests.length,i+2);assert.equal(callsActive(),1);
  assert.equal(f.events.get('pageshow').size,1);assert.equal(f.events.get('pagehide').size,2);
 }
 assert.equal(globalThis.__callLifecycle.renders,4);
});
test('duplicate persisted pageshow shares the pending authorization refresh',async()=>{
 const f=await calls();await f.render();leave(f);const wait=deferred();globalThis.__workspaceRead=()=>wait.promise;
 resume(f);resume(f);resume(f);assert.equal(f.requests.length,2);assert.equal(callsActive(),0);
 wait.resolve(Response.json(f.data));await settle();assert.equal(callsActive(),1);assert.equal(f.events.get('pageshow').size,1);
});
for(const replacement of ['replacement-account',null,'unreadable'])test('restoration retires stale calls for '+replacement,async()=>{
 const f=await calls();await f.render();leave(f);
 if(replacement==='unreadable')f.storage.getItem=()=>{throw new DOMException('Blocked','SecurityError');};
 else if(replacement===null)f.storage.removeItem('primecare_session');else f.storage.setItem('primecare_session',replacement);
 resume(f);await settle();assert.equal(callsActive(),0);assert.equal(f.requests.length,1);assert.equal(f.root.innerHTML,'');
 assert.throws(()=>f.manager.enter('governed:'+f.page.code,f.page.route),/Missing registration/);
 if(replacement==='unreadable')assert.match(f.root.children[0].textContent,/Session storage/);else assert.equal(f.reloads(),1);
 assert.equal(f.events.get('pageshow').size,0);
});
for(const mode of ['revoked','forbidden','unauthorized','unavailable'])test('restoration cannot retain calls after '+mode,async()=>{
 const f=await calls();await f.render();leave(f);
 globalThis.__workspaceRead=async()=>mode==='revoked'?Response.json({...f.data,screens:f.data.screens.filter(p=>p.code!==f.page.code)}):Response.json({error:mode},{status:mode==='forbidden'?403:mode==='unauthorized'?401:503});
 resume(f);await settle();assert.equal(callsActive(),0);assert.equal(globalThis.__callLifecycle.renders,1);
 assert.throws(()=>f.manager.enter('governed:'+f.page.code,f.page.route),/Missing registration/);
 assert.doesNotMatch(f.root.innerHTML,/internal-call-panel/);
});
for(const change of ['query','path'])test('restoration follows the current '+change+' rather than reviving the previous calls panel',async()=>{
 const f=await calls();await f.render();leave(f);
 const target=change==='query'?f.page.route:f.data.screens.find(p=>p.route!==f.page.route).route;
 f.setUrl(target+'?enable-semantics=true');resume(f);await settle();
 assert.equal(callsActive(),0);assert.equal(globalThis.__callLifecycle.renders,1);assert.doesNotMatch(f.root.innerHTML,/internal-call-panel/);
 assert.equal(f.requests.length,2);
});
test('same-document traversal retires calls and can return through a fresh grant read',async()=>{
 const f=await calls();await f.render();
 f.setUrl(f.page.route+'?enable-semantics=true');f.dispatch('popstate',{});await settle();
 assert.equal(callsActive(),0);assert.match(f.root.innerHTML,/screen-communication/);
 f.setUrl(f.page.route+'?view=calls&enable-semantics=true');f.dispatch('popstate',{});await settle();
 assert.equal(callsActive(),1);assert.equal(f.requests.length,3);assert.equal(globalThis.__callLifecycle.renders,2);
});
test('persisted leave during pending workspace load blocks its old response and permits one fresh restore',async()=>{
 const f=await calls(),wait=deferred();globalThis.__workspaceRead=()=>wait.promise;const old=f.render();await settle();leave(f);
 globalThis.__workspaceRead=async()=>Response.json(f.data);resume(f);await settle();assert.equal(callsActive(),1);
 const renders=globalThis.__callLifecycle.renders;wait.resolve(Response.json(f.data));await old;assert.equal(globalThis.__callLifecycle.renders,renders);
});
for(const fail of [false,true])test('pending panel start is closed before remount; old '+(fail?'rejection':'fulfillment')+' cannot repaint its replacement',async()=>{
 const f=await calls(),wait=deferred();globalThis.__callLifecycle.directoryResponse=()=>wait.promise;
 const old=f.render();await settle();assert.equal(globalThis.__callLifecycle.renders,1);assert.equal(globalThis.__callLifecycle.starts,0);
 globalThis.__callLifecycle.directoryResponse=async()=>({userId:'fixture-user',self:null,items:[]});await f.render();
 const status=f.root.querySelector('[data-cy=internal-call-status]');status.textContent='replacement status';
 if(fail)wait.reject(Error('old failure'));else wait.resolve({userId:'fixture-user',self:null,items:[]});await old;await settle();
 assert.equal(status.textContent,'replacement status');
 assert.equal(globalThis.__callLifecycle.starts,1);assert.equal(globalThis.__callLifecycle.closes,1);
 assert.equal(f.events.get('pagehide').size,2);
});
test('pending panel start cannot repaint after calls query changes',async()=>{
 const f=await calls(),wait=deferred();globalThis.__callLifecycle.directoryResponse=()=>wait.promise;
 const old=f.render();await settle();f.setUrl(f.page.route+'?enable-semantics=true');f.dispatch('popstate',{});await settle();
 const html=f.root.innerHTML;wait.reject(Error('old start failed'));await old;assert.equal(f.root.innerHTML,html);assert.match(html,/screen-communication/);
 assert.equal(globalThis.__callLifecycle.starts,0);assert.equal(globalThis.__callLifecycle.closes,1);
});
test('nonpersisted departure removes lifecycle bindings and never reopens closed call owner',async()=>{
 const f=await calls();await f.render();f.dispatch('pagehide',{persisted:false});
 resume(f);await settle();assert.equal(callsActive(),0);assert.equal(f.requests.length,1);assert.equal(f.events.get('pageshow').size,0);assert.equal(f.events.get('pagehide').size,0);
 assert.throws(()=>f.manager.enter('governed:'+f.page.code,f.page.route),/Missing registration/);
});
test('obsolete owner events and detached roots cannot refresh or retire the current route',async()=>{
 const f=await calls();await f.render();const old=[...f.events.get('pageshow')][0];await f.render();
 const before=f.requests.length;old({persisted:true});await settle();assert.equal(f.requests.length,before);
 f.root.isConnected=false;resume(f);await settle();assert.equal(f.requests.length,before);
});
test('generic workspace keeps persisted restoration and server-filtered presentation registration',async()=>{
 const f=await calls();f.setUrl(f.page.route+'?enable-semantics=true');await f.render();leave(f);resume(f);await settle();
 assert.match(f.root.innerHTML,/screen-communication/);assert.equal(f.requests.length,2);assert.equal(globalThis.__callLifecycle.renders,0);
 assert.equal(f.manager.enter('governed:'+f.page.code,f.page.route).route,f.page.route);
});

for(const mode of ['pending-workspace','pending-start'])test('nonpersisted leave during '+mode+' never installs a late owner',async()=>{
 const f=await calls(),wait=deferred();
 if(mode==='pending-workspace')globalThis.__workspaceRead=()=>wait.promise;else globalThis.__callLifecycle.directoryResponse=()=>wait.promise;
 const work=f.render();await settle();f.dispatch('pagehide',{persisted:false});const renders=globalThis.__callLifecycle.renders;
 wait.resolve(mode==='pending-workspace'?Response.json(f.data):{userId:'fixture-user',self:null,items:[]});await work;await settle();
 assert.equal(globalThis.__callLifecycle.renders,renders);assert.equal(globalThis.__callLifecycle.starts,0);assert.equal(f.events.get('pageshow').size,0);
});
for(const failure of [false,true])test('persisted leave during panel start isolates old '+(failure?'rejection':'fulfillment')+' from restored owner',async()=>{
 const f=await calls(),wait=deferred();globalThis.__callLifecycle.directoryResponse=()=>wait.promise;const work=f.render();await settle();
 leave(f);globalThis.__callLifecycle.directoryResponse=async()=>({userId:'fixture-user',self:null,items:[]});resume(f);await settle();
 const status=f.root.querySelector('[data-cy=internal-call-status]');status.textContent='restored status';
 if(failure)wait.reject(Error('previous start failed'));else wait.resolve({userId:'fixture-user',self:null,items:[]});await work;
 assert.equal(status.textContent,'restored status');assert.equal(globalThis.__callLifecycle.starts,1);assert.equal(globalThis.__callLifecycle.closes,1);
 assert.equal(f.events.get('pageshow').size,1);
});
test('session change while grant refresh is pending cannot claim a call owner',async()=>{
 const f=await calls();await f.render();leave(f);const wait=deferred();globalThis.__workspaceRead=()=>wait.promise;resume(f);
 f.storage.setItem('primecare_session','replacement');wait.resolve(Response.json(f.data));await settle();
 assert.equal(globalThis.__callLifecycle.renders,1);assert.equal(callsActive(),0);assert.equal(f.root.innerHTML,'');assert.equal(f.reloads(),1);
});
test('closed startup between refresh completion and start continuation cannot restart push events',async()=>{
 // Close via the fulfilled inbox operation's next microtask. The production
 // start() must verify ownership again before opening its push channel.
 const f=await calls();const original=f.root.querySelector.bind(f.root);let armed=false;
 f.root.querySelector=selector=>{const el=original(selector);if(selector==='[data-cy=internal-call-history]'&&!armed){armed=true;queueMicrotask(()=>f.dispatch('pagehide',{persisted:false}));}return el;};
 await f.render();assert.equal(globalThis.__callLifecycle.starts,0);assert.equal(globalThis.__callLifecycle.closes,1);
});

test('three-argument calls renderer still starts and returns its disposable panel',async()=>{
 const f=await calls();const panel=await globalThis.__renderInternalCalls(f.root,'https://gateway.invalid',{userId:f.data.identity.userId,role:f.data.identity.role,home:f.data.landing,navigation:''});
 assert.equal(panel.closed,false);assert.equal(globalThis.__callLifecycle.starts,1);assert.match(f.root.innerHTML,/internal-call-panel/);
 panel.close();panel.close();assert.equal(globalThis.__callLifecycle.closes,1);assert.equal(f.events.get('pagehide').size,0);
});
test('current-panel initial startup failure still renders unavailable with three-argument API',async()=>{
 const f=await calls();globalThis.__callLifecycle.directoryResponse=async()=>{throw Error('current call service unavailable');};
 const panel=await globalThis.__renderInternalCalls(f.root,'https://gateway.invalid',{userId:f.data.identity.userId,role:f.data.identity.role,home:f.data.landing,navigation:''});
 assert.equal(panel.closed,false);assert.equal(globalThis.__callLifecycle.starts,0);
 assert.equal(f.root.querySelector('[data-cy=internal-call-status]').textContent,panel.labels.unavailable);
 panel.close();
});

for(const replacement of ['replacement',null,'unreadable'])test('transport rejection during pending start closes the stale '+replacement+' session owner',async()=>{
 const f=await calls();await f.render();leave(f);const wait=deferred();globalThis.__callLifecycle.directoryResponse=()=>wait.promise;
 resume(f);await settle();const status=f.root.querySelector('[data-cy=internal-call-status]');status.textContent='pending owner';
 if(replacement==='unreadable')f.storage.getItem=()=>{throw new DOMException('Blocked','SecurityError');};else if(replacement===null)f.storage.removeItem('primecare_session');else f.storage.setItem('primecare_session',replacement);
 wait.reject(Error('session client rejected changed actor'));await settle();
 assert.equal(globalThis.__callLifecycle.starts,1);assert.equal(globalThis.__callLifecycle.closes,2);
 assert.equal(status.textContent,'pending owner','Retired owner must not write unavailable over its existing or replacement status');
 assert.equal(f.events.get('pagehide').size,0,'Changed session retires the panel and workspace lifecycle');
 assert.equal(f.root.innerHTML,'');assert.throws(()=>f.manager.enter('governed:'+f.page.code,f.page.route),/Missing registration/);
 if(replacement==='unreadable')assert.match(f.root.children[0].textContent,/Session storage/);else assert.equal(f.reloads(),1);
});

for(const name of ["layout","theme","language","responsive"])for(const rejects of [false,true])test("lost "+name+" during actual calls startup "+(rejects?"rejection":"fulfillment")+" retires presentation without restart",async()=>{
 const f=await calls(),wait=deferred();globalThis.__callLifecycle.directoryResponse=()=>wait.promise;
 const work=f.render();await settle();assert.equal(globalThis.__callLifecycle.starts,0);delete f.services[name];
 if(rejects)wait.reject(Error("synthetic directory failure"));else wait.resolve({userId:"fixture-user",self:null,items:[]});
 await work;await settle();assert.match(f.root.children[0]?.textContent??"",new RegExp("Missing "+name));
 assert.equal(globalThis.__callLifecycle.starts,0);assert.equal(globalThis.__callLifecycle.closes,1);
 assert.equal(f.events.get("pagehide").size,0);assert.equal(f.events.get("pageshow").size,0);assert.equal(f.events.get("popstate").size,0);
 const reads=f.requests.length;f.services[name]=()=>{};resume(f);await settle();assert.equal(f.requests.length,reads);assert.equal(globalThis.__callLifecycle.starts,0);
 assert.throws(()=>f.manager.enter("governed:"+f.page.code,f.page.route),/Missing registration/);
});
