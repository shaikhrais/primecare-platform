import test from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {ROOT,CONTRACT,reconcileSnapshot} from '../tools/governance-production/theme-adoption-preflight.mjs';
import {buildRegistrationExport} from './export-theme-workspace-registration.mjs';
const bytes=await readFile(ROOT+'/'+CONTRACT),catalog=JSON.parse(bytes),hash=createHash('sha256').update(bytes).digest('hex'),manifest='1'.repeat(64);
function fixtures() {
  const resources=Object.keys(catalog.resources).map((resource_key,i)=>({resource_id:i+1,resource_key,active:1})),languages=['en','fr','es'].map((language_code,i)=>({language_code,language_id:i+1,enabled:1}));
  const snapshot={components:catalog.requiredExistingComponents.map((component_code,i)=>({id:i+1,component_code,active:1})),resources,languages,translations:resources.flatMap(r=>languages.map(l=>({resource_id:r.resource_id,language_id:l.language_id,translated_text:catalog.resources[r.resource_key][l.language_code],reviewed:0,approved:0}))),screens:[{id:91,screen_code:catalog.registrationTarget.screenCode,actual_file_path:catalog.existingSourceHosts[0],active:1}],permissions:[{screen_id:91,role_id:7,can_view:1}],controls:catalog.controls.map(c=>({screen_id:91,data_cy:c.testId,component_type:c.componentCode,file_path:catalog.existingSourceHosts[0]})),requiredElements:catalog.controls.map(c=>({screen_id:91,test_id:c.testId}))};
  const report={...reconcileSnapshot(catalog,snapshot),contractSha256:hash,expectedManifestSha256:manifest};
  const receipt={committed:true,independentReadback:true,runtimeActivated:false,roleGrants:0,schemaChanges:false,screenId:91,screenCode:catalog.registrationTarget.screenCode,execution:{commit:'a'.repeat(40),runId:1},controls:Object.fromEntries(catalog.controls.map((c,i)=>[c.testId,i+1])),resourceIds:Object.fromEntries(resources.map(r=>[r.resource_key,r.resource_id]))};
  return {receipt,report};
}
test('verified metadata exports all governed controls and labels while keeping runtime disabled',()=>{
  const {receipt,report}=fixtures(),out=buildRegistrationExport(catalog,receipt,report,hash,manifest);
  assert.equal(out.controls.length,25);assert.equal(Object.keys(out.resources).length,40);assert.equal(out.runtimeEnabled,false);assert.equal(out.allAppsAdopted,false);assert.equal(out.translationReviewPending,true);
});
test('dry runs, incomplete readback, stale hashes, denied hosts and conflicted labels cannot export',()=>{
  for(const mutate of [(r,p)=>r.committed=false,(r,p)=>r.independentReadback=false,(r,p)=>r.roleGrants=1,(r,p)=>r.runtimeActivated=true,(r,p)=>p.contractSha256='old',(r,p)=>p.expectedManifestSha256='old',(r,p)=>p.hosts[0].grantCount=0,(r,p)=>p.controls.pop(),(r,p)=>p.resources[0].translations.pop(),(r,p)=>p.issues.push({kind:'translation',status:'conflict'}),(r,p)=>delete r.controls[catalog.controls[0].testId],(r,p)=>r.controls[catalog.controls[1].testId]=r.controls[catalog.controls[0].testId]]) {
    const {receipt,report}=fixtures();mutate(receipt,report);assert.throws(()=>buildRegistrationExport(catalog,receipt,report,hash,manifest));
  }
});
test('committed shared export matches the actual retained production receipts',async()=>{
  const receipt=JSON.parse(await readFile(ROOT+'/docs/appearance/theme-adoption-registration-receipt.json','utf8'));
  const report=JSON.parse(await readFile(ROOT+'/docs/appearance/theme-adoption-production-preflight.json','utf8'));
  const pin=JSON.parse(await readFile(ROOT+'/tools/governance-production/production-pin.json','utf8'));
  const actual=JSON.parse(await readFile(ROOT+'/packages/primecare_ui/catalogs/theme-workspace.registration.json','utf8'));
  assert.deepEqual(actual,buildRegistrationExport(catalog,receipt,report,hash,pin.manifestSha256));
});
