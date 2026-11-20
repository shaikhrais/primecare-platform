import {test} from 'node:test';import assert from 'node:assert/strict';import {verifyPublishedWorker} from './worker-content-receipt.mjs';
const old='11111111-1111-4111-8111-111111111111',version='22222222-2222-4222-8222-222222222222',deployment='33333333-3333-4333-8333-333333333333';
const contents='export default {fetch(){return new Response("ok")}}';
function fixture(change=()=>{}){
 let reads=0;
 const input={source:'a'.repeat(40),worker:'primecare-governance-api',service:'governance',versionId:old,previousDeploymentId:old,api:async path=>{reads++;const raw=path.includes('/versions?')?{items:[{id:version}]}:{deployments:[{id:deployment,created_on:'2026-11-20T13:00:00Z',versions:[{version_id:version,percentage:100}]}]};change(raw,path,reads);return raw;}};
 const options={strictVerifier:async()=>{throw Error('Uploaded ID differs');},expectedFiles:{'service.js':Buffer.from(contents)},readContent:async()=>{const form=new FormData();form.set('service.js',new Blob([contents],{type:'application/javascript'}),'service.js');return new Response(form);}};
 return {input,options};
}
test('different reported version requires exact active module hashes and stable active/latest lineage',async()=>{
 const {input,options}=fixture();const r=await verifyPublishedWorker(input,options);assert.equal(r.versionId,version);assert.equal(r.wranglerReportedVersionId,old);assert.equal(r.independentlyVerifiedCode,true);assert.equal(r.grantAssociationApproved,false);assert.equal(r.moduleSha256[0].name,'service.js');assert.ok(!JSON.stringify(r).includes(contents));
});
test('modified code or extra executable modules cannot establish source identity',async()=>{
 for(const extra of [false,true]){const {input,options}=fixture();options.readContent=async()=>{const f=new FormData();f.set('service.js',new Blob([extra?contents:'tampered']),'service.js');if(extra)f.set('other.js',new Blob(['bad']),'other.js');return new Response(f);};await assert.rejects(()=>verifyPublishedWorker(input,options),/differs/);}
});
test('split traffic, non-active latest upload and lineage changes are rejected',async()=>{
 for(const change of [(v,p)=>{if(v.deployments)v.deployments[0].versions[0].percentage=50;},(v,p)=>{if(v.items)v.items[0].id=old;},(v,p,n)=>{if(v.deployments&&n>2)v.deployments[0].id=old;}]){const {input,options}=fixture(change);await assert.rejects(()=>verifyPublishedWorker(input,options));}
});
test('successful strict receipt does not read code; untrusted target or source cannot use fallback',async()=>{
 const {input,options}=fixture();const receipt={verified:true};assert.equal(await verifyPublishedWorker(input,{...options,strictVerifier:async()=>receipt,readContent:()=>assert.fail('Code read')}),receipt);
 for(const change of [{source:'main'},{worker:'other'},{versionId:'bad'}])await assert.rejects(()=>verifyPublishedWorker({...input,...change},options));
});
test('single JavaScript response is still checked byte-for-byte without exposing source',async()=>{const {input,options}=fixture();options.readContent=async()=>new Response(contents,{headers:{'content-type':'application/javascript'}});assert.equal((await verifyPublishedWorker(input,options)).independentlyVerifiedCode,true);});
