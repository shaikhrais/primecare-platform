import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createRequire} from 'node:module';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';

// Real renderer/route and theme-owner code with synthetic DOM/transport peripherals.
// This is not browser layout, PostgreSQL, computed-style or permission acceptance.
if(Object.keys(process.env).some(k=>/(?:DATABASE_URL|DB_URL|CLOUDFLARE|CF_API|PGPASSWORD)/i.test(k)))throw Error('Credentials forbidden in Growth contract checks');
const root=process.cwd(),candidateRoot=resolve(process.env.GROWTH_CONTRACT_SOURCE_ROOT??root);
const require=createRequire(resolve(root,'package.json')),{build}=require('esbuild');
const read=p=>readFile(resolve(root,p),'utf8'),candidate=p=>readFile(resolve(candidateRoot,p),'utf8');
const [adminHarness,growthHarness,workflow,fixture,platformSource,growthSource,bridgeSource,shellSource]=await Promise.all([
 candidate('scripts/test-growth-admin-browser.mjs'),candidate('scripts/test-growth-browser.mjs'),candidate('.github/workflows/growth-marketing.yml'),read('scripts/fixtures/platform-admin.mjs'),read('websites/typescript/src/platform-admin.ts'),read('websites/typescript/src/growth/dashboard.ts'),read('websites/typescript/src/screen-presentation.ts'),read('packages/primecare_ui/web/shell.ts')]);
const hierarchy=JSON.parse(await read('cloudflare/workers/src/admin-hierarchy.json'));
const registry=JSON.parse(await read('packages/shared/src/growth/registry.json'));
const solidTheme=JSON.parse(await read('packages/shared/src/solid-theme.json'));
const {Element}=await import(pathToFileURL(resolve(root,'scripts/fixtures/care-dom-base.mjs')).href);
const built=await build({stdin:{contents:"export {BaseLayoutManager} from './packages/primecare_ui/web/layout-manager';export {codeAdminPage} from './websites/typescript/src/code-admin-layout';",resolveDir:root},bundle:true,write:false,platform:'node',format:'esm',metafile:true});
const api=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
for(const path of ['packages/primecare_ui/web/theme-manager.ts','packages/shared/src/solid-theme.json','websites/typescript/src/code-admin-layout.ts'])assert.ok(Object.keys(built.metafile.inputs).some(p=>p.endsWith(path)),path);
// Reuse the existing renderer fixture. Replace only its codeAdminPage presentation
// stub with the actual page composer, so headings come from production arguments.
const oldPage="export const codeAdminPage=o=>`<div data-cy=\"code-admin-page-body\">${o.content}</div>`;";
assert.equal(fixture.split(oldPage).length-1,1,'Exact existing page-composer peripheral');
globalThis.__growthContractPage=api.codeAdminPage;
const projectedFixture=fixture.replace(oldPage,'export const codeAdminPage=o=>globalThis.__growthContractPage(o);').replace("import assert from 'node:assert/strict';",'').replace("import {build} from 'esbuild';",'').replace('export {browser, deferred, settle, token, nestedControllers, installPortalPresentation};','return {browser,settle,token,installPortalPresentation,resolveManagedRoute};');
const AsyncFunction=Object.getPrototypeOf(async()=>{}).constructor;
const {browser,settle,token,installPortalPresentation,resolveManagedRoute}=await new AsyncFunction('assert','build',projectedFixture)(assert,build);
const globals=['document','window','sessionStorage','localStorage','location','history','FormData','fetch','getComputedStyle','__adminFixture'];
function preserve(){const saved=new Map(globals.map(k=>[k,Object.getOwnPropertyDescriptor(globalThis,k)]));return ()=>{for(const [k,d]of saved){if(d)Object.defineProperty(globalThis,k,d);else delete globalThis[k];}};}
function parsed(f){const dom=new Element({changed(){}},'div');dom.innerHTML=f.root.innerHTML;return dom;}
function tenantFixture(t,locale='en'){
 const restore=preserve(),policy=hierarchy.roles.tenant_admin;
 assert.equal(policy.scope,'tenant');assert.equal(policy.createTenant,false);
 const f=browser({role:'tenant_admin',locale,capabilities:{scope:policy.scope,canCreateTenant:policy.createTenant,extended:false,assignableRoles:policy.assignable,tenants:[{id:'tenant-a',name:'Activated tenant',slug:'activated-tenant'}]}});
 const renderShell=f.root.renderShell.bind(f.root);f.root.renderShell=o=>{f.shell=o;renderShell(o);};
 f.respond=async url=>url.endsWith('/v1/governance/platform')?Response.json(f.data):url.endsWith('/tenants/tenant-a/accounts')?Response.json({users:[{id:'fixture-admin',email:'tenant-admin@example.invalid',roles:'tenant_admin',status:'active',canModify:false}]}):Response.json({users:[],records:[],events:[],partners:[]});
 t.after(()=>{try{for(const fn of f.events.get('pagehide')??[])fn({persisted:false});}finally{restore();}});return f;
}
const start=adminHarness.indexOf("await local.locator(",adminHarness.indexOf('await local.goto('));
const end=adminHarness.indexOf('if(width===320)',start);
assert.ok(start>=0&&end>start,'Existing local-console admission sequence');
const admission=adminHarness.slice(start,end);
function localPage(f,{extraTenant=false,roleOverride}={}){
 return {locator(selector){return {
  async waitFor(){assert.ok(parsed(f).querySelector(selector),'Missing actual control '+selector);},
  async textContent(){if(selector==='.sidebar-role')return roleOverride??f.shell.role;return parsed(f).querySelector(selector)?.textContent??null;},
  async count(){return parsed(f).querySelectorAll(selector).length;},
  async evaluate(callback){const e=parsed(f).querySelector(selector);assert.ok(e,'Missing evaluated control');e.options=e.querySelectorAll('option');if(extraTenant)e.options.push({value:'foreign-tenant'});return callback(e);},
  async selectOption(value){const e=f.root.querySelector(selector);assert.ok(e,'Missing actual select handler');assert.equal(typeof e.onchange,'function');e.value=value;e.onchange({currentTarget:e});await settle();},
 };}};
}
async function admit(f,lang,code=admission,options){await new AsyncFunction('local','lang','registry','assert','result',code)(localPage(f,options),lang,hierarchy,assert,{tenantId:'tenant-a'});}

for(const locale of ['en','fr','es'])test('tenant-admin Organizations entry and candidate browser admission in '+locale,async t=>{
 const f=tenantFixture(t,locale);await f.render();assert.equal(f.root.view,'organizations');assert.equal(parsed(f).querySelector('[data-cy=platform-tenant-select]'),null);assert.ok(parsed(f).querySelector('[data-cy=platform-topbar-tenant]'));
 const before=f.requests.length;await admit(f,locale);assert.equal(f.root.view,'organizations');assert.equal(f.requests.length,before,'Selecting the only current tenant grants no data capability');
 await f.click('accounts');assert.equal(f.root.view,'accounts');assert.ok(parsed(f).querySelector('[data-cy=platform-account-form]'));assert.equal(parsed(f).querySelector('[data-cy=platform-users] [data-save-user]').disabled,true,'Protected self-user remains disabled');
 const reads=f.requests.filter(r=>r.url.includes('/tenants/'));assert.deepEqual(reads.map(r=>r.url),['https://gateway.invalid/v1/governance/platform/tenants/tenant-a/accounts']);
 for(const request of f.requests){assert.equal(request.options.method,'GET');assert.equal(request.options.headers.authorization,'Bearer '+token);assert.equal(request.options.cache,'no-store');assert.equal(request.options.body,undefined);}
 assert.equal(f.values.get('primecare_session'),token);assert.deepEqual(f.assigned,[]);
});
for(const locale of ['en','fr','es'])test('old tenant-only selector fails before selection or any additional request in '+locale,async t=>{
 const f=tenantFixture(t,locale);await f.render();const count=f.requests.length;
 const original=admission.replaceAll('platform-topbar-tenant','platform-tenant-select');await assert.rejects(admit(f,locale,original),/Missing actual control/);assert.equal(f.requests.length,count);assert.equal(f.root.view,'organizations');
});
for(const [name,code,options]of [
 ['stale Dashboard heading',admission.replace("{en:'Organizations',fr:'Organisations',es:'Organizaciones'}[lang]","{en:'Dashboard',fr:'Tableau de bord',es:'Panel'}[lang]"),undefined],
 ['foreign tenant option',admission,{extraTenant:true}],
 ['wrong account role',admission,{roleOverride:'Wrong role'}],
])test('local-console contract rejects '+name,async t=>{const f=tenantFixture(t);await f.render();const count=f.requests.length;await assert.rejects(admit(f,'en',code,options),assert.AssertionError);assert.equal(f.requests.length,count);});

test('the existing central-admin landing and creation controls remain separate',async t=>{
 const restore=preserve();t.after(restore);const policy=hierarchy.roles.central_admin,f=browser({role:'central_admin',capabilities:{scope:policy.scope,canCreateTenant:policy.createTenant}});await f.render();assert.equal(f.root.view,'tenants');assert.ok(parsed(f).querySelector('[data-cy=platform-tenant-select]'));assert.ok(parsed(f).querySelector('[data-cy=platform-tenant-form]'));assert.ok(f.anchor('onboarding'));
});

const colorAssertion=growthHarness.match(/(?:assert\.equal\(await page\.evaluate\(\(\)=>document\.documentElement\.dataset\.surfaceStyle\),'solid'\);)?assert\.equal\(await page\.evaluate\(\(\)=>document\.documentElement\.style\.getPropertyValue\('--color-sidebar'\)\),(?:solidTheme|registry\.visual\.theme)\['--color-sidebar'\]\);/)?.[0];
assert.ok(colorAssertion,'Existing exact sidebar assertion is required');
const checkTheme=code=>new AsyncFunction('page','registry','solidTheme','assert',code)({evaluate:async callback=>callback()},registry,solidTheme,assert);
function themeFixture(t,locale='en'){
 const restore=preserve(),f=browser({installManager:false,locale,path:'/growth'}),doc=f.root.ownerDocument;
 const style=()=>{const values=new Map();return {scrollbarColor:'',getPropertyValue:k=>values.get(k)??'',setProperty:(k,v)=>values.set(k,v),removeProperty:k=>values.delete(k)};};
 f.root.style=style();doc.documentElement.style=style();doc.body=doc.createElement('body');doc.body.style=style();f.root.classList.add=()=>{};doc.documentElement.classList.add=()=>{};
 doc.defaultView=window;window.getComputedStyle=()=>({getPropertyValue:k=>k==='--primecare-responsive-styles'?'1':doc.documentElement.style.getPropertyValue(k)});globalThis.getComputedStyle=window.getComputedStyle;
 f.manager=installPortalPresentation(f.root,registry.visual.theme,'https://gateway.invalid');
 f.layout=new api.BaseLayoutManager(f.root,null,()=>f.root);f.layout.setDefaultTheme(registry.visual.theme);
 t.after(()=>{try{f.layout.dispose();}finally{restore();}});return f;
}
for(const locale of ['en','fr','es'])test('real bridge and default Theme Center preserve approved solid sidebar in '+locale,async t=>{
 const f=themeFixture(t,locale),host=document.documentElement;assert.equal(host.dataset.surfaceStyle,'solid');assert.notEqual(solidTheme['--color-sidebar'],registry.visual.theme['--color-sidebar']);
 for(const language of [locale,locale==='fr'?'es':'fr',locale]){host.lang=language;const entry=resolveManagedRoute('/growth','');f.manager.registerScope('entry',[entry]);f.manager.enter(entry.id,entry.route);f.layout.setDefaultTheme(registry.visual.theme);await checkTheme(colorAssertion);assert.equal(host.lang,language);}
 assert.deepEqual(f.requests,[]);assert.equal(f.values.get('primecare_session'),token);
});
test('the original raw-registry comparison fails against the actual solid theme owner',async t=>{
 const f=themeFixture(t);await assert.rejects(checkTheme("assert.equal(await page.evaluate(()=>document.documentElement.style.getPropertyValue('--color-sidebar')),registry.visual.theme['--color-sidebar']);"),assert.AssertionError);assert.deepEqual(f.requests,[]);
});
for(const mutation of ['marker','token'])test('candidate theme assertion rejects wrong '+mutation,async t=>{
 const f=themeFixture(t);if(mutation==='marker')delete document.documentElement.dataset.surfaceStyle;else document.documentElement.style.setProperty('--color-sidebar',registry.visual.theme['--color-sidebar']);await assert.rejects(checkTheme(colorAssertion),assert.AssertionError);assert.deepEqual(f.requests,[]);
});
test('non-solid theme defaults remain valid outside the portal bridge',async t=>{
 const f=themeFixture(t);delete document.documentElement.dataset.surfaceStyle;f.layout.setDefaultTheme(registry.visual.theme);assert.equal(document.documentElement.style.getPropertyValue('--color-sidebar'),registry.visual.theme['--color-sidebar']);
});
test('contracts bind existing production entry, solid merge and required CI without bypasses',()=>{
 assert.match(platformSource,/const defaultView=\(\)=>canCreateTenant\?'tenants':'organizations'/);
 assert.match(platformSource,/data-cy="platform-topbar-tenant"/);assert.match(platformSource,/platform-tenant-select\],\[data-cy=platform-topbar-tenant/);
 assert.match(bridgeSource,/Object\.entries\(\{\.\.\.theme, \.\.\.solidTheme\}\)/);assert.match(bridgeSource,/host\.dataset\.surfaceStyle = 'solid'/);
 assert.match(growthSource,/registry\.visual\.theme,undefined,owner\.current/);assert.match(shellSource,/mountLayoutCustomizer\(root,profileScope,locale,defaultTheme/);
 assert.match(growthHarness,/solidTheme=JSON\.parse\(await readFile\('packages\/shared\/src\/solid-theme\.json','utf8'\)\)/);
 assert.match(colorAssertion,/dataset\.surfaceStyle/);assert.match(colorAssertion,/solidTheme\['--color-sidebar'\]/);
 assert.match(workflow,/env -i[^\n]+node --test scripts\/test-platform-browser-fixture\.mjs scripts\/test-growth-browser-contracts\.mjs/);
 assert.ok(workflow.split('permissions:')[0].includes("'scripts/*growth*'"),'Existing Growth path coverage selects the new contract file');
 for(const required of ['node scripts/qa-fast.mjs e2e-smoke','node --test scripts/test-growth-browser.mjs scripts/test-growth-admin-browser.mjs scripts/test-look-manager.mjs','contents: read'])assert.ok(workflow.includes(required));
 assert.doesNotMatch(admission,/force:|evaluate\([^)]*=>.*(?:\.hidden=|\.style\.)/);
});
