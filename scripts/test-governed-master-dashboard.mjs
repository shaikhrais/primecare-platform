import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {test} from 'node:test';
import {build} from 'esbuild';

const {outputFiles:[file]}=await build({
  stdin:{resolveDir:process.cwd(),contents:`
    export * from './websites/typescript/src/governed-master-dashboard';
    export {ScreenManager,installScreenManager} from './packages/primecare_ui/web/screen-manager';
    export {assertMasterDashboardShell} from './packages/primecare_ui/web/dashboard-render-policy';
    export {MasterDashboard} from './packages/primecare_ui/web/master-dashboard';
  `},bundle:true,format:'esm',platform:'node',write:false,
});
const {governedDashboardDescriptor,GovernedMasterDashboard,connectGovernedMasterDashboard,MasterDashboard,ScreenManager,
  installScreenManager,assertMasterDashboardShell}=await import('data:text/javascript;base64,'+Buffer.from(file.text).toString('base64'));
const {screens}=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const canonical=screens.filter(s=>s.renderer==='dashboard');
const dedicated=new Set(['care_delivery','founder_growth_dashboard']);
const generic=canonical.filter(s=>!dedicated.has(s.code));

test('the registered coverage derives from one adapter with no per-dashboard configuration',()=>{
  assert.equal(canonical.length,115);
  assert.equal(generic.length,113);
  assert.equal(new Set(generic.map(page=>page.route)).size,113);
  assert.deepEqual(Object.getOwnPropertyNames(GovernedMasterDashboard.prototype),['constructor']);
  for(const page of generic)assert.deepEqual(governedDashboardDescriptor(page),{screenCode:page.code,route:page.route,title:page.name,views:[{id:'overview',label:page.name}]});
  for(const page of canonical.filter(s=>dedicated.has(s.code)))assert.throws(()=>governedDashboardDescriptor(page),/dedicated route/);
});

test('the guard requires a current authorized registration and is retired on dashboard exit',()=>{
  const root={},manager=new ScreenManager({layout(){},theme(){},language(){},responsive(){}});
  installScreenManager(root,manager);
  const page=generic[0],entry={id:'governed:'+page.code,route:page.route,kind:'governed',adapter:'workspace'};
  assert.throws(()=>connectGovernedMasterDashboard(root,manager,page,()=>true),/Missing dashboard registration/);
  assert.doesNotThrow(()=>assertMasterDashboardShell(root));
  manager.registerScope('workspace',[entry]);
  const {master}=connectGovernedMasterDashboard(root,manager,page,()=>true);
  assert.ok(master instanceof MasterDashboard);
  assert.throws(()=>assertMasterDashboardShell(root),/must extend MasterDashboard/);
  manager.registerScope('workspace',[]);
  assert.doesNotThrow(()=>assertMasterDashboardShell(root));
  assert.throws(()=>master.mount({view:'overview',allowedViews:['overview'],current:()=>true}),/Inactive or unavailable dashboard/);
});
