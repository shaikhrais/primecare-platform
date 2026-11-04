import {test} from 'node:test';import assert from 'node:assert/strict';import {uploadedWorkerVersion,verifyWorkerDeployment,verifyWorkerDeploymentEventually} from './worker-deployment-receipt.mjs';
const source='a'.repeat(40),old='11111111-1111-4111-8111-111111111111',deployment='22222222-2222-4222-8222-222222222222',version='33333333-3333-4333-8333-333333333333';
function fixture(mutate=()=>{}){let calls=0;return {worker:'primecare-governance-api',service:'governance',source,versionId:version,previousDeploymentId:old,api:async path=>{calls++;const value=path.includes('/versions/')?{id:version,metadata:{author_email:'PRIVATE'}}:{deployments:[{id:deployment,created_on:'2026-11-01T12:00:00Z',versions:[{version_id:version,percentage:100}]}]};mutate(value,path,calls);return value;}};}
test('only one exact Wrangler uploaded version is accepted',()=>{assert.equal(uploadedWorkerVersion('Uploaded worker\nCurrent Version ID: '+version),version);for(const output of ['',version,'Current Version ID: bad','Current Version ID: '+version+'\nCurrent Version ID: '+old])assert.throws(()=>uploadedWorkerVersion(output));});
test('receipt joins immutable source to independent deployment and emits no private metadata or grant authority',async()=>{const r=await verifyWorkerDeployment(fixture());assert.equal(r.source,source);assert.equal(r.versionId,version);assert.equal(r.deploymentId,deployment);assert.equal(r.grantAssociationApproved,false);assert.equal(r.registeredGovernanceArtifactId,null);assert.ok(!JSON.stringify(r).includes('PRIVATE'));});
test('old deployment, wrong version, split traffic and concurrent replacement cannot establish provenance',async()=>{for(const change of [(v,p)=>{if(v.deployments)v.deployments[0].id=old;},(v,p)=>{if(v.deployments)v.deployments[0].versions[0].version_id=old;},(v,p)=>{if(v.deployments)v.deployments[0].versions[0].percentage=50;},(v,p)=>{if(v.deployments)v.deployments[0].versions.push({version_id:old,percentage:0});},(v,p)=>{if(p.includes('/versions/'))v.id=old;},(v,p,n)=>{if(n===3)v.deployments[0].id=version;}])await assert.rejects(()=>verifyWorkerDeployment(fixture(change)));});
test('unverified source or unrelated Worker is rejected before provider reads',async()=>{for(const extra of [{source:'main'},{worker:'other'},{service:'payments'},{previousDeploymentId:null},{versionId:'bad'}])await assert.rejects(()=>verifyWorkerDeployment({...fixture(),...extra,api:()=>{throw Error('must not read');}}));});

test('delayed provider propagation accepts only the exact version and fails closed',async()=>{
 let reads=0,waits=0;
 const input=fixture((value,path)=>{if(path.includes('/deployments')&&reads++<2)value.deployments[0].id=old;});
 const receipt=await verifyWorkerDeploymentEventually(input,{wait:async()=>{waits++;}});
 assert.equal(receipt.versionId,version);assert.equal(waits,2);
 const wrong=fixture((value,path)=>{if(value.deployments)value.deployments[0].versions[0].version_id=old;});
 await assert.rejects(()=>verifyWorkerDeploymentEventually(wrong,{attempts:3,wait:async()=>{}}));
});
