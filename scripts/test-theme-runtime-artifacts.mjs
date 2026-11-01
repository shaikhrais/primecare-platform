import {test} from 'node:test';import assert from 'node:assert/strict';
import {auditRuntimeArtifacts} from './audit-theme-runtime-artifacts.mjs';
const deployment='11111111-1111-4111-8111-111111111111',version='22222222-2222-4222-8222-222222222222';
function fixture(change=()=>{}){const calls=[];return {calls,fetcher:async(url,options)=>{calls.push({url,options});assert.equal(options.method,'GET');let result;
 if(url.endsWith('/settings'))result={bindings:[{name:'SERVICE_NAME',type:'plain_text',text:url.includes('auth-api')?'auth':'governance'},{name:'DB_URL',type:'secret_text',text:'MUST_NOT_EXPORT'},{name:'OTHER_SETTING',type:'plain_text',text:'PRIVATE_SETTING'}]};
 else if(url.includes('/deployments?'))result={deployments:[{id:deployment,created_on:'2026-11-01T12:00:00Z',versions:[{version_id:version,percentage:100}]}]};
 else result={id:version,annotations:{'workers/tag':'a'.repeat(40)},metadata:{created_on:'2026-11-01T12:00:00Z',source:'wrangler',author_email:'PRIVATE_EMAIL'}};
 change(result,url,calls.length);return Response.json({success:true,result});}};}
test('only active deployment versions are read and private values never emitted',async()=>{
 const f=fixture(),r=await auditRuntimeArtifacts({account:'a'.repeat(32),token:'fixture',fetcher:f.fetcher});
 assert.equal(r.artifacts.length,2);assert.equal(r.artifacts[0].versions[0].versionId,version);
 assert.ok(f.calls.every(c=>!c.url.endsWith('/versions')));assert.equal(r.grantsChanged,0);
 for(const secret of ['MUST_NOT_EXPORT','PRIVATE_SETTING','PRIVATE_EMAIL'])assert.ok(!JSON.stringify(r).includes(secret));
 assert.ok(r.artifacts.every(a=>a.registeredGovernanceArtifactId===null&&a.grantAssociationApproved===false));
});
test('invalid source config and mismatched service cannot identify an artifact',async()=>{
 await assert.rejects(auditRuntimeArtifacts({account:'invalid',token:'fixture',fetcher:()=>{throw Error('must not fetch');}}));
 const f=fixture((r,url)=>{if(url.endsWith('/settings'))r.bindings[0].text='wrong';});
 await assert.rejects(auditRuntimeArtifacts({account:'a'.repeat(32),token:'fixture',fetcher:f.fetcher}));
});
test('traffic split, version mismatch and deployment drift fail instead of registering a guess',async()=>{
 for(const mutate of [
  (r,url)=>{if(url.includes('/deployments?'))r.deployments[0].versions[0].percentage=50;},
  (r,url)=>{if(url.includes('/versions/'))r.id=deployment;},
  (r,url,n)=>{if(url.includes('/deployments?')&&n===4)r.deployments[0].id=version;},
 ]){const f=fixture(mutate);await assert.rejects(auditRuntimeArtifacts({account:'a'.repeat(32),token:'fixture',fetcher:f.fetcher}));}
});

test('standard CI commit annotations are retained without inferring source authority',async()=>{
 const f=fixture((r,url)=>{if(url.includes('/versions/'))r.annotations={'workers/commit_sha':'b'.repeat(40),'private':'DO_NOT_EXPORT'};});
 const r=await auditRuntimeArtifacts({account:'a'.repeat(32),token:'fixture',fetcher:f.fetcher});
 assert.equal(r.artifacts[0].versions[0].sourceCommitCandidate,'b'.repeat(40));assert.equal(r.artifacts[0].sourceCommitCandidatesPresent,true);assert.equal(r.artifacts[0].sourceCommitTagsPresent,false);assert.equal(r.artifacts[0].sourceCommitFullyEstablished,false);assert.ok(!JSON.stringify(r).includes('DO_NOT_EXPORT'));
});
test('conflicting commit identities fail and malformed annotations are not treated as a source',async()=>{
 const conflict=fixture((r,url)=>{if(url.includes('/versions/'))r.annotations['workers/commit_sha']='b'.repeat(40);});await assert.rejects(()=>auditRuntimeArtifacts({account:'a'.repeat(32),token:'fixture',fetcher:conflict.fetcher}));
 const invalid=fixture((r,url)=>{if(url.includes('/versions/'))r.annotations={'workers/commit_sha':'main'};});const r=await auditRuntimeArtifacts({account:'a'.repeat(32),token:'fixture',fetcher:invalid.fetcher});assert.equal(r.artifacts[0].versions[0].sourceCommitCandidate,null);assert.equal(r.artifacts[0].sourceCommitCandidatesPresent,false);
});
