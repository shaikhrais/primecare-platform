import {test} from 'node:test';
import assert from 'node:assert/strict';
import {inspectEmsSecretCapabilities} from './inspect-ems-secret-capabilities.mjs';
const env={CLOUDFLARE_ACCOUNT_ID:'a'.repeat(32),CLOUDFLARE_API_TOKEN:'deployment-private',ENDPOINT_ANALYTICS_READ_TOKEN:'reader-private'};
test('checks both existing secrets with aggregate-only SQL and metadata reads; redacts all values',async()=>{
 const calls=[];const result=await inspectEmsSecretCapabilities(env,async(url,init)=>{
  calls.push({url,...init});
  if(url.endsWith('/analytics_engine/sql'))return Response.json({data:[{requests:987654}],rows:1});
  return Response.json({success:true,result:{bindings:[{name:'EMAIL',type:'send_email'},{name:'INBOX',type:'kv_namespace',namespace_id:'private-storage'},{name:'ENDPOINT_ANALYTICS_READ_TOKEN',type:'secret_text',text:'hidden'}]}});
 });
 assert.equal(calls.length,6);assert.equal(calls.filter(c=>c.method==='POST').length,2);
 assert.ok(calls.filter(c=>c.method==='POST').every(c=>c.body.startsWith('SELECT SUM(_sample_interval)')));
 assert.equal(result.providerWrites,0);assert.equal(result.emailMessagesSent,0);assert.equal(result.mailContentRead,false);
 assert.ok(result.analytics.every(a=>a.querySucceeded));assert.equal(result.workers.auth.sendEmailBinding,true);
 for(const secret of [...Object.values(env),'987654','private-storage','hidden'])assert.ok(!JSON.stringify(result).includes(secret));
});
test('missing dedicated secret is not replaced or copied from deployment credentials',async()=>{
 let calls=0;const result=await inspectEmsSecretCapabilities({...env,ENDPOINT_ANALYTICS_READ_TOKEN:''},async()=>{calls++;return Response.json({errors:[{code:10000,message:'private provider message'}]},{status:403});});
 assert.equal(calls,5);assert.equal(result.analytics[0].status,'missing_secret');assert.equal(result.analytics[1].querySucceeded,false);assert.deepEqual(result.analytics[1].errorCodes,[10000]);assert.ok(!JSON.stringify(result).includes('private provider message'));
});
test('missing account never makes network calls',async()=>{const result=await inspectEmsSecretCapabilities({},()=>assert.fail('Network touched'));assert.equal(result.providerWrites,0);assert.ok(result.blocker);});
test('invalid, oversized and provider error responses do not expose raw data',async()=>{
 const result=await inspectEmsSecretCapabilities(env,async()=>new Response('private'.repeat(150000),{status:403}));assert.ok(result.analytics.every(a=>!a.querySucceeded));assert.ok(!JSON.stringify(result).includes('private'));
});
