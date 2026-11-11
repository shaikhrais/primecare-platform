import {test} from 'node:test';
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
  './account-mutations-panel': `export const mutationActorForScreen=(code,role)=>code==='ceo_dashboard'&&role==='ceo'; export const accountCreationMarkup=()=>''; export const bindAccountCreation=()=>{globalThis.__creation.starts++;return ()=>globalThis.__creation.stops++;};`,
  './tenant-accounts-panel': `export const tenantAccountsScreen='fixture-disabled'; export const tenantAccountsMarkup=()=>''; export const bindTenantAccounts=()=>()=>{};`,
  './admin-training': `export const openAdminTraining=(...args)=>globalThis.__training.push(args); export const trainingText=()=>'';`,
  './media-look': `export class DashboardMediaLook {roleLabel(v){return v;} sectionIcon(){return '';} heading(v){return v;}}`,
  './screen-text': `export const liveScreenText=()=>({text:(_screen,_locale,_key,fallback)=>fallback,subscribe:callback=>{globalThis.__workspaceRouteLive.add(callback);return ()=>globalThis.__workspaceRouteLive.delete(callback);}});`,
  './account': `export const accountMarkup=()=>''; export const bindAccount=()=>()=>{};`,
  './auth-client': `export const signOut=async(...args)=>{globalThis.__signouts.push(args);await globalThis.__signoutResponse();};`,
  './shell': `export const renderShell=(root,options)=>root.renderShell(options); export const bindShell=(root,_title,_locale,_scope,entries)=>{root.entries=entries();};`,
  './reports': `export const reportPanel=()=>document.createElement('section');`,
  './internal-calls': `export const renderInternalCalls=async(root)=>{root.innerHTML='calls fixture';};`,
};
const client = await importCode({stdin: {contents: `export * from './websites/typescript/src/workspace';
  export * from './packages/primecare_ui/web/screen-manager'; export * from './websites/typescript/src/managed-routes';`, resolveDir: process.cwd()},
  plugins: [{name: 'workspace-peripheral-fixtures', setup(builder) {
    builder.onResolve({filter: /^\.\//}, args => args.importer.endsWith('/workspace.ts') && fixtures[args.path] ? {path: args.path, namespace: 'fixture'} : null);
    builder.onLoad({filter: /.*/, namespace: 'fixture'}, args => ({contents: fixtures[args.path], loader: 'js'}));
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
  insertBefore() {} insertAdjacentHTML() {} setSelectionRange() {}
  focus() {this.focusCount++;} click(){globalThis.__downloads.push({href:this.href,download:this.download});}
  addEventListener(name, callback) {this.listeners.set(name, callback);}
  removeEventListener(name, callback) {if(this.listeners.get(name)===callback)this.listeners.delete(name);}
  querySelectorAll(selector) {return selector === 'a[data-route]' ? this.anchors.filter(anchor => anchor.dataset.route !== undefined) : [];}
  querySelector(selector) {
    if (selector === 'main') return this;
    const cy = selector.match(/\[data-cy=["']?([^\]"']+)["']?\]/)?.[1];
    const key = cy ?? selector;
    if (cy && !this.innerHTML.includes('data-cy='+cy) && !this.innerHTML.includes('data-cy=\"'+cy+'\"')) return null;
    if (!this.controls.has(key)) this.controls.set(key, new Element(this.ownerDocument));
    return this.controls.get(key);
  }
  renderShell(options) {
    this.renderCount++;this.controls.clear();this.children=[];
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
    __creation: {starts:0,stops:0}, __downloads: [], __workspaceRouteLive: new Set(), __training: [], __signouts: [], __signoutResponse: async()=>{}, fetch: async (url, options) => {requests.push({url, options}); return Response.json(data);},
  });
  setUrl(path + '?enable-semantics=true');
  const services = Object.fromEntries(['layout', 'theme', 'language', 'responsive'].map(key => [key, () => {}]));
  const manager = new client.ScreenManager(services); client.installScreenManager(root, manager);
  manager.registerScope('entry',[client.resolveManagedRoute(location.pathname,'')]);
  const palette = route => {const entry = root.entries.find(entry => entry.detail.endsWith(' · ' + route)); assert.ok(entry, 'Missing palette entry: ' + route); return entry.open;};
  const anchor = code => {const link = root.querySelector('[data-cy="sidebar-item-' + code + '"]'); assert.equal(typeof link.onclick, 'function', 'Missing sidebar binding: ' + code); return link;};
  const click = link => {let prevented = 0; link.onclick({preventDefault: () => prevented++}); assert.equal(prevented, 1);};
  const render = () => client.renderWorkspace(root, 'https://gateway.invalid');
  return {root, data, manager, services, storage, assigned, replaced, pushes, historyReplacements, requests, setUrl, palette, anchor, click, render, events,
    dispatch: (name, event={}) => view.dispatchEvent({type:name,...event}), reloads: () => reloads};
}
const pathOf = url => new URL(url, 'https://fixture.invalid').pathname;
const assertUrl = (url, path, locale = 'en') => {
  const value = new URL(url, 'https://fixture.invalid');
  assert.equal(value.pathname, path);
  assert.equal(value.searchParams.get('enable-semantics'), 'true');
  assert.ok(value.search.endsWith('enable-semantics=true'));
  assert.equal(value.searchParams.get('locale'), locale === 'en' ? null : locale);
};

const error=f=>f.root.children.find(e=>e.getAttribute('data-cy')==='error-state')?.textContent??'';
const settle=async()=>{for(let i=0;i<12;i++)await Promise.resolve();await new Promise(setImmediate);};
const control=(f,name)=>f.root.querySelector(`[data-cy="${name}"]`);
const invoke=async(el,event='click')=>{const cb=el['on'+event]??el.listeners.get(event);assert.equal(typeof cb,'function');await cb({currentTarget:el});await settle();};
const lose=f=>{delete f.services.language;f.dispatch('popstate');assert.match(error(f),/Missing language/);};
const checkRetired=f=>{
 assert.equal(__workspaceRouteLive.size,0);assert.equal(f.root.listeners.has('input'),false);
 for(const name of ['pagehide','pageshow','popstate'])assert.equal(f.events.get(name)?.size??0,0,name);
 assert.throws(()=>f.manager.enter('governed:ceo_dashboard',f.data.landing),/Missing registration/);
};
const controls=['workspace-training','workspace-refresh','workspace-logout','workspace-export'];

test('fixture account-creation disposal uses the existing CEO screen, never a new screen grant',async()=>{
 const policy=JSON.parse(await readFile('packages/shared/src/account-mutations.json','utf8'));
 assert.ok(JSON.stringify(policy).includes('ceo_dashboard'));
 const f=await browser();await f.render();assert.equal(__creation.starts,1);lose(f);assert.equal(__creation.stops,1);checkRetired(f);
});
for(const name of ['layout','theme','language','responsive'])for(const mode of ['missing','throw','promise'])test(name+' '+mode+' is terminal before protected workspace reads',async()=>{
 const f=await browser();
 if(mode==='missing')delete f.services[name];
 else f.services[name]=mode==='throw'?()=>{throw Error('private error');}:async()=>{throw Error('private error');};
 await f.render();assert.match(error(f),mode==='missing'?new RegExp('Missing '+name):mode==='throw'?/Presentation connection failed/:new RegExp('Asynchronous '+name));
 assert.equal(f.requests.length,0);assert.equal(f.root.renderCount,0);checkRetired(f);
});
test('missing document entry is rejected without replacing unrelated or workspace registrations',async()=>{
 const f=await browser();f.manager.registerScope('entry',[]);
 f.manager.registerScope('unrelated',[{id:'test-unrelated',route:'/test-unrelated',kind:'feature',adapter:'fixture'}]);
 await f.render();assert.match(error(f),/Missing registration/);assert.equal(f.requests.length,0);checkRetired(f);
 assert.equal(f.manager.enter('test-unrelated','/test-unrelated').adapter,'fixture');
});
for(const name of controls)for(const interruption of ['failure','remount','route','redraw','session','pagehide','detach'])test(name+' retained after '+interruption+' cannot execute',async()=>{
 const f=await browser();await f.render();const old=control(f,name);
 if(interruption==='failure')lose(f);
 if(interruption==='remount')await f.render();
 if(interruption==='route'){f.setUrl('/success?enable-semantics=true');f.dispatch('popstate');}
 if(interruption==='redraw')f.dispatch('popstate');
 if(interruption==='session')f.storage.setItem('primecare_session','replacement-session');
 if(interruption==='pagehide')f.dispatch('pagehide',{persisted:false});
 if(interruption==='detach')f.root.isConnected=false;
 const requests=f.requests.length,html=f.root.innerHTML;
 await invoke(old);
 assert.equal(f.requests.length,requests);assert.equal(__training.length,0);assert.equal(__signouts.length,0);assert.equal(__downloads.length,0);
 if(interruption!=='session')assert.equal(f.root.innerHTML,html);
 if(interruption==='failure')checkRetired(f);
 if(interruption==='session')assert.equal(f.storage.getItem('primecare_session'),'replacement-session');
});
for(const name of controls)test(name+' revalidates presentation before a current control acts',async()=>{
 const f=await browser();await f.render();const old=control(f,name);delete f.services.responsive;const requests=f.requests.length;
 await invoke(old);assert.match(error(f),/Missing responsive/);checkRetired(f);assert.equal(f.requests.length,requests);
 assert.equal(__training.length,0);assert.equal(__signouts.length,0);assert.equal(__downloads.length,0);
});
test('failed owner never revives through retained navigation, live text, history or repaired services',async()=>{
 const f=await browser();await f.render();const old=f.palette('/maintenance/configuration'),generic=f.palette(f.data.screens.find(p=>p.code==='ceo_reports').route),live=[...__workspaceRouteLive];
 lose(f);const message=error(f);f.services.language=()=>{};
 old();generic();for(const callback of live)callback();f.dispatch('popstate');f.dispatch('pageshow',{persisted:true});
 assert.equal(error(f),message);assert.equal(f.root.renderCount,1);assert.deepEqual(f.assigned,[]);assert.deepEqual(f.pushes,[]);assert.equal(f.requests.length,1);checkRetired(f);
});
for(const [name,event] of [['workspace-search','input'],['workspace-pending','change'],['inventory-prev','click'],['inventory-next','click']])test('removed '+name+' cannot redraw or focus replacement content',async()=>{
 const f=await browser();await f.render();const old=control(f,name);f.setUrl('/success?enable-semantics=true');f.dispatch('popstate');const html=f.root.innerHTML,renders=f.root.renderCount;
 old.value='old filter';old.checked=true;await invoke(old,event);assert.equal(f.root.innerHTML,html);assert.equal(f.root.renderCount,renders);assert.equal(old.focusCount,0);
});
for(const interruption of ['failure','remount','route','pagehide','detach','session'])for(const rejects of [false,true])test('pending logout '+(rejects?'rejection':'success')+' after '+interruption+' cannot commit to a new owner',async()=>{
 const f=await browser();await f.render();const button=control(f,'workspace-logout');let resolve,reject;
 __signoutResponse=()=>new Promise((a,b)=>{resolve=a;reject=b;});const work=invoke(button);await settle();assert.equal(__signouts.length,1);
 if(interruption==='failure')lose(f);
 if(interruption==='remount')await f.render();
 if(interruption==='route'){f.setUrl('/success?enable-semantics=true');f.dispatch('popstate');}
 if(interruption==='pagehide')f.dispatch('pagehide',{persisted:false});
 if(interruption==='detach')f.root.isConnected=false;
 if(interruption==='session')f.storage.setItem('primecare_session','replacement-session');
 const state=button.textContent,disabled=button.disabled;
 if(rejects)reject(Error('synthetic response failed'));else resolve();await work;
 assert.equal(f.storage.getItem('primecare_session'),interruption==='session'?'replacement-session':token);
 assert.deepEqual(f.assigned,[]);assert.equal(button.textContent,state);assert.equal(button.disabled,disabled);
});
for(const outcome of ['success','forbidden','network'])test('connection loss during pending grant '+outcome+' remains a configuration failure',async()=>{
 const f=await browser();let resolve,reject;globalThis.fetch=()=>new Promise((a,b)=>{resolve=a;reject=b;});const work=f.render();delete f.services.theme;
 if(outcome==='success')resolve(Response.json(f.data));else if(outcome==='forbidden')resolve(Response.json({error:'Forbidden'},{status:403}));else reject(Error('network failed'));
 await work;assert.match(error(f),/Missing theme/);checkRetired(f);assert.equal(f.root.renderCount,0);
});
test('retirement removes only its listeners and never replaces native or foreign onpopstate',async()=>{
 const f=await browser();let first=0,second=0;const foreign=()=>first++;window.onpopstate=foreign;
 await f.render();assert.equal(window.onpopstate,foreign);const later=()=>second++;window.onpopstate=later;
 lose(f);assert.equal(window.onpopstate,later);f.dispatch('popstate');assert.equal(second,2);assert.equal(first,0);checkRetired(f);
});
test('same-token remount cleans up old available panel disposers and live subscriptions',async()=>{
 const f=await browser();for(let i=0;i<3;i++){await f.render();assert.equal(__workspaceRouteLive.size,1);assert.equal(__creation.starts,i+1);assert.equal(__creation.stops,i);}
 f.dispatch('pagehide',{persisted:false});assert.equal(__creation.stops,3);checkRetired(f);
});
test('original dispatcher entry survives SPA paths and is never silently repaired after loss',async()=>{
 const f=await browser();await f.render();const entry=client.resolveManagedRoute(f.data.landing,'');
 f.click(f.root.querySelector('[data-cy="workspace-account"]'));await f.render();assert.match(f.root.innerHTML,/screen-account/);assert.equal(f.manager.enter(entry.id,entry.route).route,f.data.landing);
 f.manager.registerScope('entry',[]);const count=f.requests.length;await f.render();assert.match(error(f),/Missing registration/);assert.equal(f.requests.length,count);checkRetired(f);
});
test('current training/export/refresh and confirmed logout retain their existing behavior',async()=>{
 const f=await browser();await f.render();await invoke(control(f,'workspace-training'));await invoke(control(f,'workspace-export'));
 assert.equal(__training.length,1);assert.equal(__downloads.length,1);await invoke(control(f,'workspace-refresh'));assert.equal(f.requests.length,2);assert.equal(__workspaceRouteLive.size,1);
 await invoke(control(f,'workspace-logout'));assert.equal(__signouts.length,1);assert.equal(f.storage.getItem('primecare_session'),null);assert.equal(new URL(f.assigned[0],'https://fixture.invalid').pathname,'/login');checkRetired(f);
});

for(const failure of ['missing','throw'])test('unsuccessful first entry '+failure+' cannot seed another route',async()=>{
 const f=await browser();const original=f.services.language;
 if(failure==='missing')f.manager.registerScope('entry',[]);else f.services.language=()=>{throw Error('synthetic first failure');};
 await f.render();assert.equal(f.requests.length,0);f.services.language=original;
 f.setUrl('/success?enable-semantics=true');f.manager.registerScope('entry',[client.resolveManagedRoute('/success','')]);
 await f.render();assert.equal(f.requests.length,1);assert.match(f.root.innerHTML,/screen-account/);
});

// Exercise the actual workspace, portal bridge, reports, account and password client.
// Only synthetic DOM/network and unrelated child panels are substituted.
const {browser:ownedBrowser}=await import('./fixtures/workspace-owned-children.mjs');
const childEl=(root,id)=>root.querySelector(`[data-cy=${id}]`);
const childEvent=target=>({currentTarget:target,preventDefault(){}});
const childInvoke=async(target,name='click')=>{await target['on'+name]?.(childEvent(target));for(const fn of [...target.listeners.get(name)??[]])await fn(childEvent(target));};
const deferred=()=>{let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return {promise,resolve,reject};};
const reportDefinition={id:'registered',title:'Synthetic report',canExport:true,canEmail:true,supportsFilters:true};
const reportResult={title:'Synthetic report result',classification:'internal',generatedAt:'today',scope:'fixture-tenant',columns:[{key:'value',label:'Value'}],rows:[{value:'synthetic row'}]};
const childResponse=async(url,_options,data)=>url.includes('/reports?')?Response.json({reports:[reportDefinition],resources:{accepted:'Accepted'}}):url.includes('/reports/')?Response.json(reportResult):Response.json(data);
const failChild=f=>{f.documentReview.failures.responsive=true;for(const callback of [...__boundary.live])callback();assert.match(error(f),/Screen Manager/);};
async function reportFixture(){const f=await ownedBrowser();__boundary.respond=childResponse;await f.render();await settle();f.panel=f.root.children.find(c=>c.dataset.cy==='shared-reports');assert.ok(f.panel);await childInvoke(childEl(f.panel,'report-generate'));await settle();assert.match(f.panel.innerHTML,/Synthetic report result/);return f;}
async function accountFixture(){const f=await ownedBrowser({path:'/success'});globalThis.FormData=class{get(key){return key==='currentPassword'?'synthetic-current':'synthetic-new-password';}};await f.render();return f;}
async function interruptChild(f,kind){
 if(kind==='failure')failChild(f);
 if(kind==='remount'){__boundary.respond=childResponse;await f.render();await settle();}
 if(kind==='route')f.palette(location.pathname==='/success'?f.data.landing:'/success')();
 if(kind==='leave')f.dispatch('pagehide',{persisted:true});
}
for(const kind of ['failure','remount','leave'])test('actual report pending PDF is locally discarded after '+kind,async()=>{
 const f=await reportFixture(),pending=deferred();__boundary.respond=()=>pending.promise;await childInvoke(childEl(f.panel,'report-pdf'));await settle();await interruptChild(f,kind);
 pending.resolve(new Response('%PDF-1.7'));await settle();assert.equal(__boundary.downloads.length,0);assert.equal(f.reloads(),0);f.dispatch('pagehide',{persisted:false});
});
for(const kind of ['failure','remount','route','leave'])for(const succeeds of [true,false])test('actual password '+(succeeds?'success':'failure')+' is locally discarded after '+kind,async()=>{
 const f=await accountFixture(),form=childEl(f.root,'change-password-form'),output=form.querySelector('output'),button=form.querySelector('button'),pending=deferred();
 __boundary.respond=()=>pending.promise;const work=childInvoke(form,'submit');await settle();await interruptChild(f,kind);const before={session:f.storage.getItem('primecare_session'),redirects:[...f.assigned],value:output.value,disabled:button.disabled};
 if(succeeds)pending.resolve(Response.json({status:'password_changed',reauthenticationRequired:true}));else pending.reject(Error('synthetic failure'));await work;await settle();
 assert.equal(f.storage.getItem('primecare_session'),before.session);assert.deepEqual(f.assigned,before.redirects);assert.equal(output.value,before.value);assert.equal(button.disabled,before.disabled);f.dispatch('pagehide',{persisted:false});
});
test('actual current password change redirects once without a reload from its cleanup',async()=>{
 const f=await accountFixture();__boundary.respond=async()=>Response.json({status:'password_changed',reauthenticationRequired:true});await childInvoke(childEl(f.root,'change-password-form'),'submit');await settle();
 assert.equal(f.storage.getItem('primecare_session'),null);assert.deepEqual(f.assigned,['/login?enable-semantics=true']);assert.equal(f.reloads(),0);f.dispatch('pagehide',{persisted:false});
});
test('cached actual report keeps drafts through shell redraw and resumes after hidden-control rejection',async()=>{
 const f=await reportFixture();const recipient=childEl(f.panel,'report-recipient');recipient.value='synthetic@example.invalid';await childInvoke(recipient,'input');
 for(const callback of [...__boundary.live])callback();await settle();assert.equal(f.root.children.find(c=>c.dataset.cy==='shared-reports'),f.panel);assert.match(f.panel.innerHTML,/synthetic@example.invalid/);
 const old=childEl(f.panel,'report-pdf');f.click(childEl(f.root,'workspace-account'));const requests=f.requests.length;await childInvoke(old);await settle();assert.equal(f.requests.length,requests);
 f.palette(f.data.landing)();await settle();assert.equal(f.root.children.find(c=>c.dataset.cy==='shared-reports'),f.panel);assert.match(f.panel.innerHTML,/synthetic@example.invalid/);
 __boundary.respond=async()=>new Response('%PDF-1.7');await childInvoke(childEl(f.panel,'report-pdf'));await settle();assert.equal(__boundary.downloads.length,1);f.dispatch('pagehide',{persisted:false});
});
test('report email completion after terminal presentation failure preserves uncertain delivery identity',async()=>{
 const f=await reportFixture();childEl(f.panel,'report-confirm').checked=true;await childInvoke(childEl(f.panel,'report-confirm'),'change');const pending=deferred();__boundary.respond=()=>pending.promise;await childInvoke(childEl(f.panel,'report-email-form'),'submit');await settle();
 const key='primecare-report-pending:fixture-user:registered',identity=f.storage.getItem(key);assert.ok(identity);failChild(f);pending.resolve(Response.json({state:'accepted'}));await settle();assert.equal(f.storage.getItem(key),identity);assert.equal(__boundary.downloads.length,0);f.dispatch('pagehide',{persisted:false});
});

for(const failure of ['storage','redirect'])test('current password local '+failure+' failure retains feedback and enabled control',async()=>{
 const f=await accountFixture(),form=childEl(f.root,'change-password-form'),output=form.querySelector('output'),button=form.querySelector('button');
 __boundary.respond=async()=>Response.json({status:'password_changed',reauthenticationRequired:true});
 if(failure==='storage')f.storage.removeItem=()=>{throw Error('synthetic storage failure');};else location.assign=()=>{throw Error('synthetic navigation failure');};
 await childInvoke(form,'submit');await settle();assert.ok(output.value);assert.equal(button.disabled,false);assert.equal(typeof form.onsubmit,'function');assert.equal(f.reloads(),0);f.dispatch('pagehide',{persisted:false});
});


const definitionPayload=()=>({reports:[reportDefinition],resources:{accepted:'Accepted'}});
const reportDefinitionReads=f=>f.requests.filter(r=>new URL(r.url).pathname==='/v1/governance/reports').length;
async function pendingDefinitions(stage='fetch'){
 const f=await ownedBrowser(),pending=deferred();
 __boundary.respond=async(url,_options,data)=>new URL(url).pathname==='/v1/governance/reports'?(stage==='fetch'?pending.promise:{ok:true,json:()=>pending.promise}):Response.json(data);
 await f.render();await settle();f.panel=f.root.children.find(c=>c.dataset.cy==='shared-reports');assert.ok(f.panel);assert.equal(reportDefinitionReads(f),1);
 return {f,pending,complete:()=>pending.resolve(stage==='fetch'?Response.json(definitionPayload()):definitionPayload())};
}
for(const stage of ['fetch','body'])test('discarded hidden definitions '+stage+' resumes one safe read on return',async()=>{
 const {f,complete}=await pendingDefinitions(stage);f.click(childEl(f.root,'workspace-account'));complete();await settle();
 assert.equal(reportDefinitionReads(f),1);__boundary.respond=childResponse;f.palette(f.data.landing)();await settle();
 assert.equal(reportDefinitionReads(f),2);assert.equal(f.root.children.find(c=>c.dataset.cy==='shared-reports'),f.panel);assert.match(f.panel.innerHTML,/Synthetic report/);f.dispatch('pagehide',{persisted:false});
});
for(const stage of ['fetch','body'])test('return during original definitions '+stage+' keeps the pending read coalesced',async()=>{
 const {f,complete}=await pendingDefinitions(stage);f.click(childEl(f.root,'workspace-account'));f.palette(f.data.landing)();
 for(const callback of [...__boundary.live])callback();assert.equal(reportDefinitionReads(f),1);complete();await settle();assert.equal(reportDefinitionReads(f),1);assert.match(f.panel.innerHTML,/Synthetic report/);f.dispatch('pagehide',{persisted:false});
});
test('repeated redraws during a resumed definitions read do not duplicate it',async()=>{
 const {f,complete}=await pendingDefinitions();f.click(childEl(f.root,'workspace-account'));complete();await settle();const retry=deferred();
 __boundary.respond=()=>retry.promise;f.palette(f.data.landing)();await settle();assert.equal(reportDefinitionReads(f),2);
 for(let i=0;i<3;i++){for(const callback of [...__boundary.live])callback();await settle();}assert.equal(reportDefinitionReads(f),2);
 retry.resolve(Response.json(definitionPayload()));await settle();assert.equal(reportDefinitionReads(f),2);assert.match(f.panel.innerHTML,/Synthetic report/);f.dispatch('pagehide',{persisted:false});
});
for(const failure of ['network','permission'])test('active definitions '+failure+' failure never retries merely on redraw or return',async()=>{
 const {f,pending}=await pendingDefinitions();if(failure==='network')pending.reject(Error('synthetic active network failure'));else pending.resolve(Response.json({error:'Forbidden'},{status:403}));await settle();assert.equal(reportDefinitionReads(f),1);
 for(const callback of [...__boundary.live])callback();f.click(childEl(f.root,'workspace-account'));f.palette(f.data.landing)();await settle();assert.equal(reportDefinitionReads(f),1);
 __boundary.respond=childResponse;await childInvoke(childEl(f.panel,'report-refresh'));await settle();assert.equal(reportDefinitionReads(f),2);assert.match(f.panel.innerHTML,/Synthetic report/);f.dispatch('pagehide',{persisted:false});
});
test('hidden definitions network failure resumes once and an active retry failure remains explicit',async()=>{
 const {f,pending}=await pendingDefinitions();f.click(childEl(f.root,'workspace-account'));pending.reject(Error('synthetic hidden network failure'));await settle();
 __boundary.respond=async()=>{throw Error('synthetic retry failure');};f.palette(f.data.landing)();await settle();assert.equal(reportDefinitionReads(f),2);
 for(const callback of [...__boundary.live])callback();f.click(childEl(f.root,'workspace-account'));f.palette(f.data.landing)();await settle();assert.equal(reportDefinitionReads(f),2);f.dispatch('pagehide',{persisted:false});
});
for(const interruption of ['failure','session','detach'])test('discarded definitions never restart after terminal '+interruption,async()=>{
 const {f,complete}=await pendingDefinitions();f.click(childEl(f.root,'workspace-account'));complete();await settle();const old=f.palette(f.data.landing);
 if(interruption==='failure')failChild(f);if(interruption==='session')f.storage.setItem('primecare_session','replacement-session');if(interruption==='detach')f.root.isConnected=false;
 const reads=reportDefinitionReads(f);old();for(const callback of [...__boundary.live])callback();f.dispatch('popstate',{});await settle();assert.equal(reportDefinitionReads(f),reads);f.dispatch('pagehide',{persisted:false});
});
test('definitions resumption preserves existing report drafts across interrupted refresh',async()=>{
 const f=await reportFixture();childEl(f.panel,'report-recipient').value='draft@example.invalid';await childInvoke(childEl(f.panel,'report-recipient'),'input');const pending=deferred();__boundary.respond=()=>pending.promise;
 await childInvoke(childEl(f.panel,'report-refresh'));await settle();f.click(childEl(f.root,'workspace-account'));pending.resolve(Response.json(definitionPayload()));await settle();__boundary.respond=childResponse;f.palette(f.data.landing)();await settle();
 assert.equal(reportDefinitionReads(f),3);assert.match(f.panel.innerHTML,/draft@example.invalid/);f.dispatch('pagehide',{persisted:false});
});
for(const action of ['report-pdf','report-email-form'])test('return never replays discarded '+action+' user action',async()=>{
 const f=await reportFixture(),pending=deferred();if(action==='report-email-form'){childEl(f.panel,'report-confirm').checked=true;await childInvoke(childEl(f.panel,'report-confirm'),'change');}
 __boundary.respond=()=>pending.promise;await childInvoke(childEl(f.panel,action),action==='report-email-form'?'submit':'click');await settle();f.click(childEl(f.root,'workspace-account'));pending.resolve(action==='report-pdf'?new Response('%PDF-1.7'):Response.json({state:'accepted'}));await settle();
 const before=f.requests.length;__boundary.respond=childResponse;f.palette(f.data.landing)();await settle();assert.equal(f.requests.length,before);assert.equal(__boundary.downloads.length,0);if(action==='report-email-form')assert.ok(f.storage.getItem('primecare-report-pending:fixture-user:registered'));f.dispatch('pagehide',{persisted:false});
});
