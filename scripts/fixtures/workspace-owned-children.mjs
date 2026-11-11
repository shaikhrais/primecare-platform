import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile, mkdtemp} from 'node:fs/promises';
import {createRequire} from 'node:module';
import {tmpdir} from 'node:os';
import {join} from 'node:path';

// Extends the existing workspace route fixture with actual account, report and portal
// presentation modules. Deterministic DOM and transport are not browser acceptance.
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
  './admin-training': `export const openAdminTraining=(...args)=>{globalThis.__boundary.training.push(args);}; export const trainingText=()=>'';`,
  './media-look': `export class DashboardMediaLook {roleLabel(v){return v;} sectionIcon(){return '';} heading(v){return v;}}`,
  './screen-text': `export const liveScreenText=()=>({text:(_screen,_locale,_key,fallback)=>fallback,subscribe:callback=>{globalThis.__workspaceRouteLive.push(callback);globalThis.__boundary.live.add(callback);return ()=>{globalThis.__boundary.live.delete(callback);};}});`,

  './auth-client': `export const signOut=async(...args)=>{globalThis.__boundary.signouts.push(args);return globalThis.__boundary.signOut();};`,
  './shell': `export const renderShell=(root,options)=>root.renderShell(options); export const bindShell=(root,_title,_locale,_scope,entries)=>{root.entries=entries();};`,

  './internal-calls': `export const renderInternalCalls=async(root)=>{root.innerHTML='calls fixture';};`,
};
const client = await importCode({stdin: {contents: `export * from './websites/typescript/src/workspace';
  export * from './packages/primecare_ui/web/screen-manager'; export * from './websites/typescript/src/managed-routes'; export * from './websites/typescript/src/screen-presentation';`, resolveDir: process.cwd()},
  plugins: [{name: 'workspace-peripheral-fixtures', setup(builder) {
    builder.onResolve({filter: /^\.\//}, args => {
 if(args.importer.endsWith('/account.ts') && ['./sessions-panel','./voice-pairing-panel','./sms-verification-panel'].includes(args.path))return {path:args.path,namespace:'account-child-fixture'};
 if(args.importer.endsWith('/reports.ts')&&args.path==='./screen-text')return {path:args.path,namespace:'fixture'};
 return args.importer.endsWith('/workspace.ts')&&fixtures[args.path]?{path:args.path,namespace:'fixture'}:null;
 });
 builder.onLoad({filter: /.*/, namespace:'account-child-fixture'},()=>({contents:'export const sessionsMarkup=()=>"";export const voicePairingMarkup=()=>"";export const smsVerificationMarkup=()=>"";export const bindSessions=()=>()=>{};export const bindVoicePairing=()=>()=>{};export const bindSmsVerification=()=>()=>{};',loader:'js'}));
    builder.onLoad({filter: /.*/, namespace: 'fixture'}, args => ({contents: fixtures[args.path], loader: 'js'}));
  }}]});

// Minimal DOM adapter: captures the actual workspace HTML, bound anchor handlers,
// and command-palette entries. This is not browser/Cypress or layout acceptance.
class Element {
  attrs = new Map(); dataset = {}; children = []; controls = new Map(); anchors = []; entries = []; listeners = new Map();
  _html=''; get innerHTML(){return this._html;} set innerHTML(value){this._html=value;this.controls.clear();this.children=[];this.anchors=[];} renderCount = 0; focusCount = 0; open = false; isConnected = true; style = {getPropertyValue: () => '', setProperty() {}, removeProperty() {}};
  constructor(doc) {this.ownerDocument = doc;}
  setAttribute(key, value) {this.attrs.set(key, value);}
  getAttribute(key) {return this.attrs.get(key) ?? null;}
  removeAttribute(key) {this.attrs.delete(key);}
  replaceChildren(...children) {this.innerHTML = ''; this.children = children; this.anchors = []; this.controls.clear();}
  insertBefore(node) {this.children.push(node);node.parentElement=this;node.isConnected=true;} insertAdjacentHTML() {} setSelectionRange() {}
  focus() {this.focusCount++;}
  addEventListener(name, callback) {if(!this.listeners.has(name))this.listeners.set(name,new Set());this.listeners.get(name).add(callback);}
  removeEventListener(name,callback){this.listeners.get(name)?.delete(callback);}
  closest(){return null;} remove(){this.isConnected=false;}
  click(){globalThis.__boundary.downloads.push(this.download);}
  querySelectorAll(selector) {return selector === 'a[data-route]' ? this.anchors.filter(anchor => anchor.dataset.route !== undefined) : [];}
  querySelector(selector) {
    if (selector === 'main') return this; if(selector==='input:focus,textarea:focus,select:focus')return null; if(selector==='[data-cy=change-password-form]'&&!this.innerHTML.includes('change-password-form'))return null;
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
async function browser({role = 'ceo', path, locale = 'en', data, entry=true} = {}) {
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
  globalThis.__boundary={training:[],signouts:[],downloads:[],live:new Set(),signOut:async()=>{}};
  Object.assign(globalThis, {document: doc, window: view, sessionStorage: storage, localStorage: storage,
    location: {assign: url => assigned.push(url), replace: url => replaced.push(url), reload: () => reloads++},
    history: {pushState: (_a, _b, url) => {pushes.push(url); setUrl(url);}, replaceState: (_a, _b, url) => {historyReplacements.push(url); setUrl(url);}},
    __workspaceRouteLive: [], fetch: async (url, options) => {requests.push({url, options}); return globalThis.__boundary.respond?globalThis.__boundary.respond(url,options,data):Response.json(data);},
  });
  setUrl(path + '?enable-semantics=true');
  const services = Object.fromEntries(['layout', 'theme', 'language', 'responsive'].map(key => [key, () => {}]));
  const documentReview=adaptWorkspaceDocument(root,doc,view);
  const manager = client.installPortalPresentation(root, {'--color-primary':'#006b68'}, 'https://gateway.invalid');
  const entryRoute=client.resolveManagedRoute(path,'');if(entry){manager.registerScope('entry',[entryRoute]);manager.enter(entryRoute.id,entryRoute.route); }
  const palette = route => {const entry = root.entries.find(entry => entry.detail.endsWith(' · ' + route)); assert.ok(entry, 'Missing palette entry: ' + route); return entry.open;};
  const anchor = code => {const link = root.querySelector('[data-cy="sidebar-item-' + code + '"]'); assert.equal(typeof link.onclick, 'function', 'Missing sidebar binding: ' + code); return link;};
  const click = link => {let prevented = 0; link.onclick({preventDefault: () => prevented++}); assert.equal(prevented, 1);};
  const render = () => client.renderWorkspace(root, 'https://gateway.invalid');
  return {entryRoute, documentReview, root, data, manager, services, storage, assigned, replaced, pushes, historyReplacements, requests, setUrl, palette, anchor, click, render, events,
    dispatch: (name, event) => {for (const callback of [...events.get(name) ?? []]) callback(event);}, reloads: () => reloads};
}

export {browser,serverData,client,Element};

const adaptWorkspaceDocument=(root,doc,view)=>{
 const style=()=>{const values=new Map();return {scrollbarColor:'',getPropertyValue:k=>values.get(k)??'',setProperty:(k,v)=>values.set(k,v),removeProperty:k=>values.delete(k)};};
 root.style=style();doc.documentElement.style=style();doc.body=doc.createElement('body');doc.body.style=style();root.id='app';root.parentElement=doc.body;root.parentNode=doc.body;
 root.contains=node=>node===root||[...root.controls.values()].includes(node);root.scrollTo=()=>{};
 doc.querySelector=selector=>selector==='#app'?root:null;doc.defaultView=view;view.location=globalThis.location;view.history=globalThis.history;view.history.scrollRestoration='auto';
 const failures={responsive:false};view.getComputedStyle=()=>({getPropertyValue:k=>k==='--primecare-responsive-styles'?(failures.responsive?'0':'1'):doc.documentElement.style.getPropertyValue(k)});globalThis.getComputedStyle=view.getComputedStyle;
 const scrolls=[];view.scrollTo=options=>scrolls.push(options);return {scrolls,failures};
};
