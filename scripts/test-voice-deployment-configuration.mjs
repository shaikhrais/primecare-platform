import {test} from 'node:test';
import assert from 'node:assert/strict';
import {voiceDeploymentConfiguration} from './voice-deployment-configuration.mjs';
test('missing credentials are explicit and there is no default model or deployment origin',()=>{
 const r=voiceDeploymentConfiguration({});assert.equal(r.configurationPresent,false);assert.ok(r.missing.includes('OPENAI_API_KEY'));assert.ok(r.missing.includes('VOICE_MODEL'));assert.ok(r.missing.includes('VOICE_ORIGIN'));assert.deepEqual(r.configured,[]);
});
test('even complete configuration cannot claim a mounted endpoint or live call',()=>{
 const environment=Object.fromEntries(voiceDeploymentConfiguration({}).missing.map(name=>[name,'PRIVATE secret value']));
 const r=voiceDeploymentConfiguration(environment);assert.equal(r.configurationPresent,true);assert.equal(r.missing.length,0);for(const name of ['runtimeMounted','liveCallVerified','numberRoutingChanged','providerWrites'])assert.equal(r[name],false);assert.doesNotMatch(JSON.stringify(r),/PRIVATE/);
});
test('unexpected environment variables, whitespace and malformed source identifiers are not disclosed',()=>{
 const r=voiceDeploymentConfiguration({OPENAI_API_KEY:' \n',GITHUB_SHA:'PRIVATE token',EXTRA_SECRET:'PRIVATE'});assert.ok(r.missing.includes('OPENAI_API_KEY'));assert.equal(r.sourceCommit,null);assert.doesNotMatch(JSON.stringify(r),/PRIVATE|EXTRA_SECRET/);
});
