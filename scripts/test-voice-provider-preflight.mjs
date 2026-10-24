import {test} from 'node:test';
import assert from 'node:assert/strict';
import {voiceProviderPreflight} from './voice-provider-preflight.mjs';
const env={TWILIO_ACCOUNT_SID:'AC'+'a'.repeat(32),TWILIO_AUTH_TOKEN:'private-token-123456',TWILIO_API_KEY_SID:'SK'+'b'.repeat(32),TWILIO_API_KEY_SECRET:'private-secret-123456',TWILIO_VERIFY_SERVICE_SID:'VA'+'c'.repeat(32),OPENAI_API_KEY:'private-openai-123456'};
const number={account_sid:env.TWILIO_ACCOUNT_SID,sid:'PN14d5f063ed5b5412c444922d3a4b4fd1',phone_number:'+16479302223',capabilities:{voice:true}};
test('validates each credential separately, only with fixed read-only provider requests',async()=>{
 const calls=[];const report=await voiceProviderPreflight(env,{async fetch(url,options){calls.push({url,options});assert.equal(options.method,'GET');assert.equal(options.redirect,'error');assert.ok(options.signal);return Response.json(url.includes('/models')?{object:'list',data:[{id:'model'}]}:url.includes('verify.twilio')?{account_sid:env.TWILIO_ACCOUNT_SID,sid:env.TWILIO_VERIFY_SERVICE_SID}:number);}});
 assert.equal(report.providersValidated,true);assert.equal(report.runtimeMounted,false);assert.equal(calls.length,4);assert.notEqual(calls[0].options.headers.authorization,calls[1].options.headers.authorization);for(const value of Object.values(env))assert.ok(!JSON.stringify(report).includes(value));
});
test('missing or malformed credentials never contact a provider',async()=>{
 const report=await voiceProviderPreflight({...env,TWILIO_ACCOUNT_SID:'../../bad',OPENAI_API_KEY:''},{async fetch(){assert.fail('network');}});assert.equal(report.providersValidated,false);assert.ok(report.checks.every(row=>row.status==='missing_or_invalid_configuration'));
});
test('cross-account and wrong-number responses cannot pass',async()=>{
 const report=await voiceProviderPreflight(env,{async fetch(){return Response.json({...number,account_sid:'AC'+'d'.repeat(32)});}});assert.equal(report.providersValidated,false);assert.ok(report.checks.every(row=>row.status==='resource_mismatch'));
});
test('provider failures and exceptions never disclose body, credential or error text',async()=>{
 for(const mode of ['denied','throw','oversize']){const report=await voiceProviderPreflight(env,{async fetch(){if(mode==='throw')throw Error(env.TWILIO_API_KEY_SECRET);return new Response(mode==='oversize'?'x'.repeat(524289):env.TWILIO_AUTH_TOKEN,{status:mode==='denied'?401:200});}});assert.equal(report.providersValidated,false);for(const value of Object.values(env))assert.ok(!JSON.stringify(report).includes(value));}
});
