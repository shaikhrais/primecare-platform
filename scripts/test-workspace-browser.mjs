import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createRequire} from 'node:module';
const require=createRequire(import.meta.url);
const {JSDOM}=require(process.env.WORKSPACE_DOM_MODULE||'jsdom');
const output=await build({entryPoints:['websites/typescript/src/workspace.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {renderWorkspace,inventoryCsv,loadWorkspace}=await import('data:text/javascript;base64,'+Buffer.from(output.outputFiles[0].text).toString('base64'));
const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
function browser(role='ceo') {
 const dom=new JSDOM('<div id="app"></div>',{url:'https://primecare-corporate.pages.dev/?enable-semantics=true'});
 for(const key of ['window','document','location','history','sessionStorage','HTMLInputElement'])globalThis[key]=dom.window[key];
 globalThis.sessionStorage.setItem('primecare_session','fixture-token');
 const screens=registry.screens.filter(s=>s.renderer!=='account'&&s.grants.some(g=>g.role===role&&g.view));
 const data={identity:{userId:'fixture',role},landing:registry.landings[role],screens,inventory:role==='ceo'?registry.screens:screens,resources:registry.resources,
 overview:{activeAccounts:3,activeSessions:2,accountRoles:[{role:'ceo',count:1},{role:'rmt',count:2}],activity:[],metrics:[],scope:role==='ceo'?'organization':'personal'}};
 globalThis.fetch=async(url,options)=>{assert.equal(options.headers.authorization,'Bearer fixture-token');assert.ok(url.endsWith('/v1/governance/workspace'));return Response.json(data);};
 return {dom,root:document.querySelector('#app'),screens,data};
}
test('CEO login landing renders real dashboard, every CEO route, governed sections and navigation',async()=>{
 const {dom,root,screens}=browser();await renderWorkspace(root,'https://gateway.test');
 assert.equal(location.pathname,registry.landings.ceo);
 assert.ok(root.querySelector('[data-cy="screen-ceo_dashboard"]'));
 assert.ok(!root.textContent.includes('under construction'));
 assert.equal(root.querySelectorAll('[data-cy="workspace-overview"] .metric').length,4);
 for(const page of screens){
  history.pushState({},'',page.route+'?enable-semantics=true');window.onpopstate();
  assert.ok(root.querySelector(`[data-cy="screen-${page.code}"]`),page.code);
  for(const section of page.sections)assert.ok([...root.querySelectorAll('[data-cy]')].some(e=>e.dataset.cy===(section.testId||section.code)),page.code+':'+section.code);
 }
 dom.window.close();
});
test('sidebar actions, search, pagination and unfinished filter work',async()=>{
 const {dom,root}=browser();await renderWorkspace(root,'https://gateway.test');
 const nav=root.querySelector('[data-cy="sidebar-item-ceo_reports"]');nav.click();assert.ok(root.querySelector('[data-cy="screen-ceo_reports"]'));
 const search=root.querySelector('[data-cy="workspace-search"]');search.value='ceo';search.dispatchEvent(new window.Event('input'));
 assert.ok(Number(root.querySelector('[data-cy="inventory-count"]').textContent.split(' · ')[0])<948);
 const filter=root.querySelector('[data-cy="workspace-pending"]');filter.checked=true;filter.dispatchEvent(new window.Event('change'));
 assert.ok(root.querySelector('[data-cy="workspace-inventory"]'));
 dom.window.close();
});
test('staff navigation contains no unauthorized CEO page and denied routes display no data',async()=>{
 const {dom,root}=browser('rmt');await renderWorkspace(root,'https://gateway.test');
 assert.equal(root.querySelector('[data-cy="sidebar-item-ceo_dashboard"]'),null);
 history.pushState({},'','/offices/corporate/roles/ceo/dashboard?enable-semantics=true');window.onpopstate();
 assert.ok(root.querySelector('[data-cy="error-state"]'));assert.equal(root.querySelector('[data-cy="workspace-overview"]'),null);
 dom.window.close();
});
test('network failures and malformed responses cannot become successful pages',async()=>{
 await assert.rejects(loadWorkspace('https://test','t',async()=>Response.json({error:'Forbidden'},{status:403})),/Forbidden/);
 await assert.rejects(loadWorkspace('https://test','t',async()=>Response.json({status:'success'})),/Invalid/);
 const {dom,root}=browser();globalThis.fetch=async()=>{throw new Error('Offline');};
 await renderWorkspace(root,'https://test');assert.ok(root.querySelector('[data-cy="error-state"]'));assert.equal(root.querySelector('[data-cy="workspace-overview"]'),null);
 dom.window.close();
});
test('inventory exports exact statuses and safely escapes spreadsheet formulas and quotes',()=>{
 const s={...registry.screens[0],name:'=SUM(1,2)',blockers:['Needs "review"']};
 const csv=inventoryCsv([s]);assert.ok(csv.includes('"\t=SUM(1,2)"'));assert.ok(csv.includes('Needs ""review""'));assert.ok(csv.includes('"No"'));
});

test('delivery details show the actual page contracts and pending actions without executing markup',async()=>{
 const {dom,root,data}=browser();
 const page=data.screens.find(p=>p.code==='ceo_dashboard');
 page.requirements={business_purpose:'<img src=x onerror=alert(1)>',acceptance_criteria:'Tenant scoped data'};
 page.pendingActions=[{key:'approve',label:'Approve request',status:'action_pending'}];
 await renderWorkspace(root,'https://gateway.test');
 const details=root.querySelector('[data-cy="workspace-delivery"]');
 assert.ok(details.textContent.includes('Tenant scoped data'));
 assert.ok(details.textContent.includes('Approve request'));
 assert.ok(details.textContent.includes('/v1/governance/workspace'));
 assert.equal(details.querySelector('img'),null);
 assert.equal(root.textContent.includes('GUEST Role Badge'),false);
 assert.ok(root.querySelector('[data-cy="inventory-next"]').getAttribute('aria-label'));
 dom.window.close();
});
test('all active role landings resolve to their own authorized governed page',async()=>{
 for(const role of Object.keys(registry.landings)) {
  const {dom,root}=browser(role);
  await renderWorkspace(root,'https://gateway.test');
  assert.equal(location.pathname,registry.landings[role],role);
  assert.ok(root.querySelector('[data-cy="workspace-title"]'),role);
  assert.equal(root.querySelector('[data-cy="error-state"]'),null,role);
  dom.window.close();
 }
});
