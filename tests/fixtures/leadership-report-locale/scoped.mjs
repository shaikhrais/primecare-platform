import assert from 'node:assert/strict';
import {test} from 'node:test';
import {browser} from '../../../scripts/fixtures/workspace-owned-children.mjs';

const roleLandings = [
 ['finance_director','/offices/corporate/roles/finance_director/dashboard'],
 ['shareholder','/offices/corporate/roles/shareholder/dashboard'],
 ['legal','/offices/corporate/roles/legal/dashboard'],
 ['cto','/common/architecture-planning-dashboard'],
 ['scrum_master','/management/scrum-master-dashboard'],
];
const strings = {
 en:{report:'Page Readiness',page:'Page'},
 fr:{report:'État des pages',page:'Page vérifiée'},
 es:{report:'Estado de las páginas',page:'Página'},
};
const workspacePath = '/v1/governance/workspace';
const catalogPath = '/v1/governance/reports';
const reportPath = catalogPath + '/page_readiness';
const fakeOrigin = 'https://gateway.invalid';
const settle = async () => {for(let i=0;i<12;i++) await Promise.resolve();await new Promise(setImmediate);};
const control = (root,name) => root.querySelector('[data-cy='+name+']');
const panel = f => f.root.children.find(c=>c.dataset.cy==='shared-reports');
const select = (root,name,value) => {
 const c=control(root,name);c.value=value;assert.equal(typeof c.onchange,'function');c.onchange();
};
function transport(f) {
 const seen=[];
 globalThis.__boundary.respond = async (raw,options,data) => {
  const url = new URL(raw);
  assert.equal(url.origin,fakeOrigin);
  assert.equal(options?.method??'GET','GET','No mutation or delivery request is allowed');
  assert.equal(options?.cache,'no-store');
  assert.equal(new Headers(options?.headers).get('authorization'),'Bearer '+'a'.repeat(43));
  seen.push(url);
  if(url.pathname===workspacePath) return Response.json(data);
  const locale=url.searchParams.get('locale'),copy=strings[locale];
  assert.ok(copy,'locale must be one of the existing EN/FR/ES options');
  if(url.pathname===catalogPath) return Response.json({
   reports:[{id:'page_readiness',title:copy.report,canExport:false,canEmail:false,supportsFilters:true}],
   resources:{title:copy.report,report:copy.report},
  });
  assert.equal(url.pathname,reportPath,'Only the existing read-only Page Readiness endpoint is simulated');
  assert.equal(url.searchParams.get('readiness'),'created');
  assert.equal(url.searchParams.get('search'),'unverified');
  return Response.json({
    id:'page_readiness',title:copy.report,classification:'internal',generatedAt:'2026-09-01T00:00:00Z',
    locale,scope:'authorized_pages',columns:[{key:'title',label:copy.page}],rows:[{title:copy.report+' fixture'}],
  });
 };
 return seen;
}
const reads = (requests,path) => requests.filter(url=>url.pathname===path);
const locales = (requests,path) => reads(requests,path).map(url=>url.searchParams.get('locale'));

for(const [role,path] of roleLandings)for(const locale of ['en','fr','es']) {
 test(role+' '+locale+': current authorized report starts in workspace locale',async()=>{
  const f=await browser({role,locale});const seen=transport(f);
  try {
   assert.equal(f.data.identity.role,role);
   assert.equal(f.data.landing,path);
   const screen=f.data.screens.find(s=>s.route===path);
   assert.ok(screen&&f.data.reporting?.screens.includes(screen.code),'Actual Worker reply must authorize this existing report placement');
   assert.equal(f.data.reporting.endpoint,catalogPath);
   await f.render();await settle();
   const rendered=panel(f);
   assert.ok(rendered);
   assert.deepEqual(locales(seen,catalogPath),[locale]);
   assert.ok(rendered.innerHTML.includes(strings[locale].report));
   const search=control(rendered,'report-search');search.value='unverified';
   assert.equal(typeof search.oninput,'function');search.oninput();
   select(rendered,'report-readiness','created');
   control(rendered,'report-generate').onclick();await settle();
   assert.deepEqual(locales(seen,reportPath),[locale]);
   assert.ok(rendered.innerHTML.includes(strings[locale].page));
   assert.ok(rendered.innerHTML.includes('authorized_pages'));
   assert.equal(reads(seen,workspacePath).length,1);
   assert.equal(seen.length,3,'Only workspace and existing report reads');
  } finally {f.dispatch('pagehide',{persisted:false});}
 });
}

test('explicit report-language selection survives shell redraw and is not overwritten by workspace locale',async()=>{
 const f=await browser({role:'finance_director',locale:'fr'}),seen=transport(f);
 try {
  await f.render();await settle();const original=panel(f);assert.ok(original);
  select(original,'report-language','es');await settle();
  assert.deepEqual(locales(seen,catalogPath),['fr','es']);
  for(const redraw of [...globalThis.__boundary.live])redraw();await settle();
  assert.equal(panel(f),original);
  assert.ok(original.innerHTML.includes(strings.es.report));
  assert.deepEqual(locales(seen,catalogPath),['fr','es'],'Same-owner redraw must not fetch a new locale');
 } finally {f.dispatch('pagehide',{persisted:false});}
});

test('existing unlocalized document fallback is English',async()=>{
 const f=await browser({role:'shareholder',locale:'it'}),seen=transport(f);
 try {await f.render();await settle();assert.ok(panel(f));assert.deepEqual(locales(seen,catalogPath),['en']);}
 finally {f.dispatch('pagehide',{persisted:false});}
});

test('existing role screen without reporting placement never opens or queries reports',async()=>{
 const f=await browser({role:'finance_director',locale:'es',path:'/offices/corporate/roles/finance_director/cashflow'});
 const seen=transport(f);
 try {
  const page=f.data.screens.find(s=>s.route===location.pathname);assert.ok(page);
  assert.ok(!f.data.reporting.screens.includes(page.code));
  await f.render();await settle();assert.equal(panel(f),undefined);
  assert.deepEqual(seen.map(url=>url.pathname),[workspacePath]);
 } finally {f.dispatch('pagehide',{persisted:false});}
});
