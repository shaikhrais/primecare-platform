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
  './account-mutations-panel': `export const mutationActorForScreen=()=>false; export const accountCreationMarkup=()=>''; export const bindAccountCreation=()=>()=>{};`,
  './tenant-accounts-panel': `export const tenantAccountsScreen='fixture-disabled'; export const tenantAccountsMarkup=()=>''; export const bindTenantAccounts=()=>()=>{};`,
  './admin-training': `export const openAdminTraining=()=>{}; export const trainingText=()=>'';`,
  './media-look': `export class DashboardMediaLook {roleLabel(v){return v;} sectionIcon(){return '';} heading(v){return v;}}`,
  './screen-text': `export const liveScreenText=()=>({text:(_screen,_locale,_key,fallback)=>fallback,subscribe:callback=>{globalThis.__workspaceRouteLive.push(callback);return ()=>{};}});`,
  './account': `export const accountMarkup=()=>''; export const bindAccount=()=>()=>{};`,
  './auth-client': `export const signOut=async()=>{};`,
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
  focus() {this.focusCount++;}
  addEventListener(name, callback) {this.listeners.set(name, callback);}
  removeEventListener(name, callback) {if(this.listeners.get(name)===callback)this.listeners.delete(name);}
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
    __workspaceRouteLive: [], fetch: async (url, options) => {requests.push({url, options}); return Response.json(data);},
  });
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

test('registry-backed CEO workspace exposes Look Manager as a screen and Maintenance only as an action', async () => {
  const data = await serverData();
  assert.ok(data.screens.some(page => page.code === 'look_review_manager' && page.route === '/appearance-review'));
  assert.ok(!data.screens.some(page => page.code === 'MAINTENANCE_CONFIGURATION'));
  assert.deepEqual(data.actions.map(page => [page.code, page.route]), [['MAINTENANCE_CONFIGURATION', '/maintenance/configuration']]);
  for (const page of [...data.screens, ...data.actions]) assert.ok(page.grants.some(grant => grant.role === 'ceo' && grant.view === 1));
});
test('CEO Look Manager sidebar delegates to the existing dispatcher without generic render or history push', async () => {
  const fixture = await browser(); await fixture.render();
  const renders = fixture.root.renderCount;
  fixture.click(fixture.anchor('look_review_manager'));
  assert.equal(fixture.assigned.length, 1, 'Look Manager must receive a full-document navigation');
  assertUrl(fixture.assigned[0], '/appearance-review');
  assert.deepEqual(fixture.pushes, []);
  assert.equal(fixture.root.renderCount, renders);
});
test('CEO Maintenance palette action delegates despite correctly not being a generic screen', async () => {
  const fixture = await browser(); await fixture.render();
  assert.throws(() => fixture.manager.enter('governed:MAINTENANCE_CONFIGURATION', '/maintenance/configuration'), /Missing registration/);
  fixture.palette('/maintenance/configuration')();
  assert.equal(fixture.assigned.length, 1, 'Maintenance action must reach its existing renderer');
  assertUrl(fixture.assigned[0], '/maintenance/configuration');
  assert.deepEqual(fixture.pushes, []);
  assert.doesNotMatch(fixture.root.innerHTML, /data-cy="error-state"/);
});

for (const locale of ['en', 'fr', 'es']) for (const entry of ['sidebar', 'palette']) {
  test(`${locale} ${entry} routes existing Look/Growth screens through one document handoff`, async () => {
    for (const [code, route] of [['look_review_manager', '/appearance-review'], ['founder_growth_dashboard', '/growth']]) {
      const fixture = await browser({locale}); await fixture.render();
      const renders = fixture.root.renderCount;
      const open = entry === 'sidebar' ? () => fixture.click(fixture.anchor(code)) : fixture.palette(route);
      open(); open(); window.dispatchEvent({type:'popstate'}); for (const callback of globalThis.__workspaceRouteLive) callback();
      assert.equal(fixture.assigned.length, 1, 'Repeated callback/draw must not restart the handoff');
      assertUrl(fixture.assigned[0], route, locale);
      assert.deepEqual(fixture.pushes, []); assert.deepEqual(fixture.replaced, []);
      assert.equal(fixture.root.renderCount, renders);
      assert.equal(location.pathname, fixture.data.landing, 'No synthetic history mutation before browser navigation');
    }
  });
}
test('Maintenance action keeps its ordinary href, palette locale, and no generic presentation registration', async () => {
  const fixture = await browser({locale: 'fr'}); await fixture.render();
  const action = fixture.root.anchors.find(anchor => pathOf(anchor.href) === '/maintenance/configuration');
  assert.ok(action); assert.equal(action.onclick, undefined, 'Ordinary authorized action links remain document links');
  assertUrl(action.href, '/maintenance/configuration', 'fr');
  const open = fixture.palette('/maintenance/configuration'); open(); open();
  assert.equal(fixture.assigned.length, 1); assertUrl(fixture.assigned[0], '/maintenance/configuration', 'fr');
  assert.throws(() => fixture.manager.enter('governed:MAINTENANCE_CONFIGURATION', '/maintenance/configuration'), /Missing registration/);
});

for (const path of ['/', '/dashboard']) test(`${path} landing and fallback reuse document dispatch with replacement only`, async () => {
  for (const role of ['rn', 'owner']) {
    const fixture = await browser({role, path, locale: 'es'}); await fixture.render();
    assert.equal(fixture.replaced.length, 1); assertUrl(fixture.replaced[0], fixture.data.landing, 'es');
    assert.equal(fixture.root.renderCount, 0); assert.deepEqual(fixture.assigned, []);
    assert.deepEqual(fixture.pushes, []); assert.deepEqual(fixture.historyReplacements, []);
  }
  // Vary the response's selected landing, not the registry/grants. Both alternatives
  // below are existing authorized CEO screen records, not new production records.
  for (const fallback of [false, true]) {
    const data = await serverData();
    const look = data.screens.find(page => page.code === 'look_review_manager');
    data.landing = fallback ? '/not-registered' : look.route;
    if (fallback) data.screens = [look];
    const fixture = await browser({data, path}); await fixture.render();
    assert.deepEqual(fixture.replaced.map(pathOf), ['/appearance-review']);
    assert.equal(fixture.root.renderCount, 0); assert.deepEqual(fixture.pushes, []);
    assert.deepEqual(fixture.historyReplacements, []);
  }
});
test('generic landing fallback, account route, repeated clicks and Back/Forward stay in workspace', async () => {
  const fixture = await browser({path: '/dashboard', locale: 'fr'}); await fixture.render();
  assert.equal(location.pathname, fixture.data.landing);
  assert.equal(fixture.historyReplacements.length, 1); assertUrl(fixture.historyReplacements[0], fixture.data.landing, 'fr');
  const page = fixture.data.screens.find(page => page.code === 'ceo_reports');
  const link = fixture.anchor(page.code), open = fixture.palette(page.route);
  fixture.click(link); open(); fixture.click(link);
  assert.equal(fixture.pushes.length, 1); assertUrl(fixture.pushes[0], page.route, 'fr');
  assert.match(fixture.root.innerHTML, /data-cy="screen-ceo_reports"/);
  fixture.click(fixture.root.querySelector('[data-cy="workspace-account"]'));
  assert.equal(fixture.pushes.length, 2); assert.equal(location.pathname, '/success');
  assert.match(fixture.root.innerHTML, /data-cy="screen-account"/);
  assert.equal(fixture.manager.enter('typescript:account', '/success').adapter, 'workspace-account');
  for (const route of [page.route, fixture.data.landing, '/success']) {
    fixture.setUrl(route + '?locale=fr&enable-semantics=true'); window.dispatchEvent({type:'popstate'});
    assert.doesNotMatch(fixture.root.innerHTML, /data-cy="error-state"/);
  }
  assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.replaced, []);
  const data = await serverData('rmt'); data.landing = '/not-registered';
  const fallback = await browser({data, path: '/'}); await fallback.render();
  assert.equal(location.pathname, data.screens[0].route); assert.equal(fallback.historyReplacements.length, 1);
});
test('Back/Forward hands off only server-authorized document screens or actions, without another history entry', async () => {
  for (const route of ['/appearance-review', '/maintenance/configuration']) {
    const fixture = await browser({locale: 'es'}); await fixture.render();
    const renders = fixture.root.renderCount;
    fixture.setUrl(route + '?locale=es&enable-semantics=true'); window.dispatchEvent({type:'popstate'}); window.dispatchEvent({type:'popstate'});
    assert.equal(fixture.replaced.length, 1); assertUrl(fixture.replaced[0], route, 'es');
    assert.deepEqual(fixture.pushes, []); assert.deepEqual(fixture.assigned, []);
    assert.equal(fixture.root.renderCount, renders);
  }
});
test('known but unauthorized routes, inventory-only routes, unknowns and aliases remain denied', async () => {
  const fixture = await browser({role: 'rmt'}); await fixture.render();
  for (const route of ['/appearance-review', '/maintenance/configuration', '/business-plans', '/not-registered', '/growth/', '/APPEARANCE-REVIEW']) {
    fixture.setUrl(route + '?enable-semantics=true'); window.dispatchEvent({type:'popstate'});
    assert.match(fixture.root.innerHTML, /data-cy="error-state"/);
    assert.doesNotMatch(fixture.root.innerHTML, /workspace-overview/);
  }
  assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.replaced, []); assert.deepEqual(fixture.pushes, []);
  const ceo = await browser(); await ceo.render();
  const forbidden = ceo.data.inventory.find(page => !ceo.data.screens.some(screen => screen.route === page.route) && !ceo.data.actions.some(action => action.route === page.route) && page.route !== '/success');
  assert.ok(forbidden); ceo.setUrl(forbidden.route + '?enable-semantics=true'); window.dispatchEvent({type:'popstate'});
  assert.match(ceo.root.innerHTML, /data-cy="error-state"/);
  assert.throws(() => ceo.manager.enter('governed:' + forbidden.code, forbidden.route), /Missing registration/);
  assert.deepEqual(ceo.assigned, []); assert.deepEqual(ceo.replaced, []);
});

function retainedCallbacks(fixture) {
  const link = fixture.anchor('look_review_manager'), generic = fixture.anchor('ceo_reports');
  return [() => fixture.click(link), fixture.palette('/maintenance/configuration'), fixture.palette('/growth'),
    () => fixture.click(generic), fixture.palette(generic.dataset.route)];
}
test('account replacement or removal blocks retained sidebar/palette callbacks before URL or history mutation', async () => {
  for (const replacement of [null, 'replacement-account']) {
    for (let index = 0; index < 5; index++) {
      const fixture = await browser(); await fixture.render(); const callback = retainedCallbacks(fixture)[index];
      if (replacement === null) fixture.storage.removeItem('primecare_session');
      else fixture.storage.setItem('primecare_session', replacement);
      callback(); callback();
      assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.replaced, []); assert.deepEqual(fixture.pushes, []);
      assert.equal(fixture.reloads(), 1); assert.equal(fixture.root.innerHTML, '');
      assert.equal(fixture.storage.getItem('primecare_session'), replacement);
      assert.throws(() => fixture.manager.enter('governed:ceo_dashboard', fixture.data.landing), /Missing registration/);
    }
  }
});
test('refresh invalidates old callbacks immediately and never lets them clear a new account/screen snapshot', async () => {
  for (const newAccount of [false, true]) {
    const fixture = await browser(); await fixture.render(); const old = retainedCallbacks(fixture);
    let finish;
    globalThis.fetch = () => new Promise(resolve => {finish = resolve;});
    if (newAccount) fixture.storage.setItem('primecare_session', 'replacement-account');
    const pending = fixture.render();
    for (const callback of old) callback();
    assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.pushes, []); assert.equal(fixture.reloads(), 0);
    const data = {...fixture.data, identity: {...fixture.data.identity, userId: newAccount ? 'replacement-user' : 'fixture-user'},
      screens: fixture.data.screens.filter(page => !['/appearance-review', '/growth'].includes(page.route)), actions: []};
    finish(Response.json(data)); await pending;
    const html = fixture.root.innerHTML;
    for (const callback of old) callback();
    assert.equal(fixture.root.innerHTML, html);
    assert.equal(fixture.manager.enter('governed:ceo_dashboard', data.landing).route, data.landing);
    assert.throws(() => fixture.manager.enter('governed:look_review_manager', '/appearance-review'), /Missing registration/);
    assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.pushes, []); assert.equal(fixture.reloads(), 0);
  }
});
test('failed refresh and reversed responses cannot revive old navigation callbacks', async () => {
  const fixture = await browser(); await fixture.render(); const old = retainedCallbacks(fixture);
  const pending = []; globalThis.fetch = () => new Promise(resolve => pending.push(resolve));
  const first = fixture.render(), second = fixture.render();
  pending[1](Response.json({error: 'Forbidden'}, {status: 403})); await second;
  pending[0](Response.json(fixture.data)); await first;
  const html = fixture.root.innerHTML;
  for (const callback of old) callback();
  assert.equal(fixture.root.innerHTML, html); assert.match(html, /Forbidden/);
  assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.pushes, []);
  assert.throws(() => fixture.manager.enter('governed:ceo_dashboard', fixture.data.landing), /Missing registration/);
});
test('a fresh render can recover after an interrupted document handoff while old callbacks remain inert', async () => {
  const fixture = await browser(); await fixture.render(); const old = fixture.palette('/appearance-review');
  old(); assert.equal(fixture.assigned.length, 1);
  await fixture.render(); old(); assert.equal(fixture.assigned.length, 1);
  fixture.palette('/maintenance/configuration')(); assert.equal(fixture.assigned.length, 2);
  assert.deepEqual(fixture.assigned.map(pathOf), ['/appearance-review', '/maintenance/configuration']);
  assert.deepEqual(fixture.pushes, []);
});
test('BFCache return fetches a fresh authorization snapshot and resumes same-session navigation', async () => {
  const fixture = await browser(); await fixture.render();
  const old = fixture.palette('/appearance-review'); old();
  fixture.dispatch('pageshow', {persisted: false}); assert.equal(fixture.requests.length, 1);
  fixture.dispatch('pageshow', {persisted: true});
  assert.equal(fixture.requests.length, 2);
  old(); assert.equal(fixture.assigned.length, 1, 'Old callbacks are invalid during resumed loading');
  await new Promise(resolve => setImmediate(resolve));
  assert.equal(fixture.events.get('pageshow').size, 1, 'Refresh replaces the previous lifecycle listener');
  fixture.palette('/maintenance/configuration')();
  assert.deepEqual(fixture.assigned.map(pathOf), ['/appearance-review', '/maintenance/configuration']);
  assert.deepEqual(fixture.pushes, []);
});
test('BFCache return denies changed/blocked sessions and obsolete generations cannot disturb the current screen', async () => {
  for (const blocked of [false, true]) {
    const fixture = await browser(); await fixture.render();
    fixture.palette('/appearance-review')();
    if (blocked) fixture.storage.getItem = () => {throw new DOMException('Blocked storage', 'SecurityError');};
    else fixture.storage.setItem('primecare_session', 'replacement-account');
    fixture.dispatch('pageshow', {persisted: true});
    assert.equal(fixture.requests.length, 1); assert.equal(fixture.root.innerHTML, '');
    assert.equal(fixture.assigned.length, 1); assert.equal(fixture.reloads(), blocked ? 0 : 1);
    assert.throws(() => fixture.manager.enter('governed:ceo_dashboard', fixture.data.landing), /Missing registration/);
  }
  const fixture = await browser(); await fixture.render();
  const obsolete = [...fixture.events.get('pageshow')][0];
  await fixture.render(); const html = fixture.root.innerHTML;
  obsolete({persisted: true});
  assert.equal(fixture.requests.length, 2); assert.equal(fixture.root.innerHTML, html);
  assert.equal(fixture.events.get('pageshow').size, 1);
  fixture.palette('/appearance-review')(); assert.equal(fixture.assigned.length, 1);
  fixture.root.isConnected = false; fixture.dispatch('pageshow', {persisted: true});
  assert.equal(fixture.requests.length, 2, 'A detached root must not refresh or take over the new page');
});
test('BFCache revalidation drops same-token revoked grants and keeps old callbacks inert on server denial', async () => {
  for (const denied of [false, true]) {
    const fixture = await browser(); await fixture.render(); const old = retainedCallbacks(fixture);
    old[0]();
    const data = {...fixture.data, screens: fixture.data.screens.filter(page => !['/appearance-review', '/growth'].includes(page.route)), actions: []};
    globalThis.fetch = async () => denied ? Response.json({error: 'Forbidden'}, {status: 403}) : Response.json(data);
    fixture.dispatch('pageshow', {persisted: true});
    assert.throws(() => fixture.manager.enter('governed:look_review_manager', '/appearance-review'), /Missing registration/);
    await new Promise(resolve => setImmediate(resolve));
    const html = fixture.root.innerHTML;
    for (const callback of old) callback();
    assert.equal(fixture.root.innerHTML, html); assert.equal(fixture.assigned.length, 1); assert.deepEqual(fixture.pushes, []);
    assert.throws(() => fixture.manager.enter('governed:look_review_manager', '/appearance-review'), /Missing registration/);
    if (denied) assert.match(html, /Forbidden/);
    else {
      assert.ok(!fixture.root.entries.some(entry => entry.detail.endsWith(' · /maintenance/configuration')));
      fixture.setUrl('/appearance-review?enable-semantics=true'); window.dispatchEvent({type:'popstate'});
      assert.match(fixture.root.innerHTML, /data-cy="error-state"/); assert.deepEqual(fixture.replaced, []);
    }
  }
});
test('blocked session storage clears protected HTML and registrations before any retained navigation', async () => {
  for (let index = 0; index < 5; index++) {
    const fixture = await browser(); await fixture.render(); const callback = retainedCallbacks(fixture)[index];
    fixture.storage.getItem = () => {throw new DOMException('Blocked storage', 'SecurityError');};
    assert.doesNotThrow(callback);
    assert.equal(fixture.root.innerHTML, ''); assert.match(fixture.root.children[0].textContent, /Session storage is unavailable/);
    assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.replaced, []); assert.deepEqual(fixture.pushes, []);
    assert.throws(() => fixture.manager.enter('governed:ceo_dashboard', fixture.data.landing), /Missing registration/);
  }
});
test('screen/action URLs reject traversal, normalization, foreign origins and query/fragment/control characters', async () => {
  // Malformed transport negatives, not new registry records or grants.
  const malformed = ['/enquire/..//external.invalid', '/enquire/%2e%2e//external.invalid', '/enquire/.%2E//external.invalid',
    '/enquire/../appearance-review', '//external.invalid', 'https://external.invalid/growth', '/growth\\extra',
    '/growth?locale=es', '/growth#tab', '/enquire/\tunsafe', '/enquire/\nunsafe', '/enquire/\u0000unsafe', '/enquire/\u007funsafe'];
  const original = await serverData();
  for (const route of malformed) for (const field of ['screens', 'actions']) {
    const data = structuredClone(original);
    data[field][0].route = route;
    const fixture = await browser({data, path: original.landing}); await fixture.render();
    assert.equal(fixture.root.innerHTML, '', field + ': ' + JSON.stringify(route));
    assert.match(fixture.root.children[0].textContent, /Invalid workspace route/);
    assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.replaced, []); assert.deepEqual(fixture.pushes, []);
    assert.throws(() => fixture.manager.enter('governed:ceo_dashboard', original.landing), /Missing registration/);
  }
});
test('no-session/401/403 and missing presentation services still fail closed', async () => {
  let fixture = await browser(); fixture.storage.removeItem('primecare_session'); await fixture.render();
  assert.equal(fixture.requests.length, 0); assertUrl(fixture.assigned[0], '/login');
  for (const status of [401, 403]) {
    fixture = await browser(); globalThis.fetch = async () => Response.json({error: 'Forbidden'}, {status}); await fixture.render();
    if (status === 401) {assertUrl(fixture.assigned[0], '/login'); assert.equal(fixture.storage.getItem('primecare_session'), null);}
    else {assert.deepEqual(fixture.assigned, []); assert.match(fixture.root.innerHTML, /Forbidden/);}
    assert.throws(() => fixture.manager.enter('governed:look_review_manager', '/appearance-review'), /Missing registration/);
  }
  fixture = await browser(); await fixture.render(); fixture.services.language = undefined;
  fixture.palette(fixture.data.screens.find(page => page.code === 'ceo_reports').route)();
  assert.equal(fixture.root.innerHTML, ''); assert.match(fixture.root.children[0].textContent, /Missing language/);
  assert.deepEqual(fixture.assigned, []); assert.deepEqual(fixture.replaced, []);
});
test('shared classifier preserves all existing exact dispatcher paths without adding screen grants or aliases', () => {
  const exact = {'/forgot-password': 'forgot', '/generated/forgot-password': 'forgot', '/reset-password': 'reset',
    '/generated/reset-password': 'reset', '/enquire/example': 'enquiry', '/appearance-review': 'look', '/tenant-dashboard': 'tenant',
    '/coordinator-charge': 'coordinator', '/psw-requests': 'requests', '/psw': 'psw', '/care': 'psw', '/business-plans': 'plans',
    '/growth': 'growth', '/platform/administration': 'platform', '/maintenance/configuration': 'maintenance', '/login': 'login'};
  for (const [path, adapter] of Object.entries(exact)) assert.equal(client.resolveManagedRoute(path, '').adapter, adapter);
  for (const path of ['/', '/dashboard', '/success', '/not-registered', '/growth/', '/GROWTH', '/growth?locale=fr', '//growth']) {
    assert.equal(client.resolveManagedRoute(path, '').adapter, 'workspace');
  }
  assert.equal(client.resolveManagedRoute('/not-registered', 'au').adapter, 'login');
  assert.ok(registry.screens.some(page => page.route === '/appearance-review'));
});
