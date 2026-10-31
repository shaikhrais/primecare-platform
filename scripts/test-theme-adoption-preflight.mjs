import test from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {validateContract,reconcileSnapshot,compileRead,compileDiscovery,ROOT,CONTRACT} from '../tools/governance-production/theme-adoption-preflight.mjs';
const catalog=JSON.parse(await readFile(ROOT+'/'+CONTRACT,'utf8'));
function snapshot() {
  const resources=Object.keys(catalog.resources).map((resource_key,i)=>({resource_id:i+1,resource_key,active:1}));
  const languages=['en','fr','es'].map((language_code,i)=>({language_id:i+1,language_code,enabled:1}));
  return {components:catalog.requiredExistingComponents.map((component_code,i)=>({id:i+1,component_code,active:1})),languages,resources,
    translations:resources.flatMap(r=>languages.map(l=>({resource_id:r.resource_id,language_id:l.language_id,translated_text:catalog.resources[r.resource_key][l.language_code],reviewed:1,approved:1}))),
    controls:catalog.controls.map(c=>({screen_id:101,component_type:c.componentCode,data_cy:c.testId,file_path:catalog.existingSourceHosts[0]})),
    requiredElements:catalog.controls.map(c=>({screen_id:101,test_id:c.testId})),
    screens:[{id:101,screen_code:'fixture_theme_host',route_path:'/fixture-only',actual_file_path:catalog.existingSourceHosts[0],active:1}],
    permissions:[{role_id:202,screen_id:101,can_view:1}]};
}
test('source contract covers every catalogued core family, source file and component import',async()=>{
  assert.deepEqual(await validateContract(catalog),{features:72,coreFamilies:24,referenceFiles:389,componentImports:78,proposedControls:25,resources:40,translations:120});
});
test('incomplete coverage, status inflation, invented host bindings and unreviewed approvals fail',async()=>{
  const mutations=[
    c=>c.features.splice(c.features.findIndex(f=>f.category==='core_family'),1),
    c=>delete c.referenceInventory.fileMappings[Object.keys(c.referenceInventory.fileMappings)[0]],
    c=>c.referenceInventory.muiImports.pop(),
    c=>c.features[0].runtimeStatus='verified',
    c=>c.features[0].productionStatus='registered',
    c=>c.runtimeExposure=true,
    c=>c.authority.newRoleGrants=true,
    c=>c.authority.sqliteFallback=true,
    c=>c.controls[0].hostScreenIds.push(101),
    c=>c.controls[0].testId='Workspace-Uppercase',
    c=>c.controls.push(structuredClone(c.controls[0])),
    c=>delete c.resources[Object.keys(c.resources)[0]].fr,
    c=>c.resources[Object.keys(c.resources)[0]].approved=true,
    c=>c.features.find(f=>f.sourceEvidence.length).sourceEvidence[0].sha256='0'.repeat(64)
  ];
  for(const mutate of mutations){const value=structuredClone(catalog);mutate(value);await assert.rejects(()=>validateContract(value));}
});
test('complete isolated metadata is only a registration candidate, never runtime or activation proof',()=>{
  const data=snapshot(),before=JSON.stringify(data);const report=reconcileSnapshot(catalog,data);
  assert.equal(report.registrationCandidatesSatisfied,true);assert.equal(report.productionActivationAllowed,false);assert.equal(report.runtimeVerified,false);assert.equal(report.writes,0);assert.deepEqual(report.issues,[]);assert.equal(JSON.stringify(data),before);
});
test('missing metadata cannot be reported as registered or ready',()=>{
  const data=snapshot();for(const key of Object.keys(data))data[key]=[];
  const report=reconcileSnapshot(catalog,data);assert.equal(report.registrationCandidatesSatisfied,false);assert.ok(report.issues.some(i=>i.kind==='host'));assert.equal(report.controls.every(c=>c.status==='missing'),true);assert.equal(report.resources.every(r=>r.status==='missing'),true);
});
test('reviewed translation conflicts are preserved and block adoption',()=>{
  const data=snapshot();data.translations[0].translated_text='Existing reviewed text';const before=JSON.stringify(data);
  const report=reconcileSnapshot(catalog,data);assert.equal(report.registrationCandidatesSatisfied,false);assert.ok(report.issues.some(i=>i.kind==='translation'&&i.status==='conflict'));assert.equal(JSON.stringify(data),before);
});
test('unreviewed translations, duplicate keys and disabled components remain unresolved',()=>{
  for(const mutate of [s=>s.translations[0].approved=0,s=>s.resources.push({...s.resources[0]}),s=>s.components[0].active=0,s=>s.languages.push({...s.languages[0]}),s=>s.requiredElements.push({...s.requiredElements[0]})]) {
    const data=snapshot();mutate(data);const report=reconcileSnapshot(catalog,data);assert.equal(report.registrationCandidatesSatisfied,false);assert.ok(report.issues.length);
  }
});
test('a control on an unrelated or denied host cannot satisfy the proposed binding',()=>{
  for(const mutate of [s=>{s.controls.forEach(r=>r.file_path='unrelated.ts');s.screens[0].actual_file_path='unrelated.ts';},s=>s.permissions[0].can_view=0,s=>s.screens[0].active=0,s=>s.controls[0].component_type='unapproved_widget',s=>s.controls.push({...s.controls[0]})]) {
    const data=snapshot();mutate(data);const report=reconcileSnapshot(catalog,data);assert.equal(report.registrationCandidatesSatisfied,false);assert.ok(report.issues.length);
  }
});
test('database compiler permits only parameterized reads from allowlisted metadata',()=>{
  const names=['id','component_code','active'];const ready={pin:{schema:'fixture_only'},manifest:{tables:[{name:'primecare_ui_component_registry',columns:names.map(name=>({name,storage_types:['text']}))}]}};
  const evil="x'); DROP TABLE users; --",request=compileRead(ready,'primecare_ui_component_registry','component_code',[evil]);
  assert.match(request.sql,/^SELECT /);assert.ok(!request.sql.includes(evil));assert.deepEqual(request.parameters,[evil]);assert.match(request.sql,/"fixture_only"\."govt_primecare_ui_component_registry"/);
  assert.throws(()=>compileRead(ready,'business_clients','id',['x']));assert.throws(()=>compileRead(ready,'primecare_ui_component_registry','password',['x']));assert.throws(()=>compileRead(ready,'primecare_ui_component_registry','id',[]));
  ready.manifest.tables[0].columns[0].storage_types=[];assert.match(compileRead(ready,'primecare_ui_component_registry','id',['1']).sql,/jsonb_typeof/);
  ready.manifest.tables[0].columns[0].storage_types=['integer','text'];assert.throws(()=>compileRead(ready,'primecare_ui_component_registry','id',['1']));
});
test('name discovery is bounded, allowlisted and cannot activate candidate hosts',()=>{
  const names=['id','component_code','active'];const ready={pin:{schema:'fixture_only'},manifest:{tables:[{name:'primecare_ui_component_registry',columns:names.map(name=>({name,storage_types:['text']}))}]}};
  const query=compileDiscovery(ready,'primecare_ui_component_registry');assert.match(query.sql,/^SELECT /);assert.match(query.sql,/LIMIT 100$/);assert.ok(query.parameters.includes('%dropdown%'));assert.ok(!query.sql.includes('%dropdown%'));assert.throws(()=>compileDiscovery(ready,'business_clients'));
  const data=snapshot();data.discovery={screens:[{id:999,screen_code:'fixture_theme_candidate'}],components:[],authoritativeBindings:false};const report=reconcileSnapshot(catalog,data);assert.equal(report.discovery.authoritativeBindings,false);assert.ok(!report.hosts.some(h=>h.screenId===999));assert.equal(report.productionActivationAllowed,false);
});
