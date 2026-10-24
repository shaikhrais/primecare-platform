import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createVapiToolCredentialVerifier} from '../packages/shared/src/communications/vapi-service-auth.mjs';
const secret='synthetic_fixture_secret_32_bytes_minimum_123456789';
test('dedicated service credential authenticates exact Bearer header without reading body',async()=>{
 const authenticate=createVapiToolCredentialVerifier({secret});
 const request=new Request('https://fixture.invalid/tool',{method:'POST',headers:{authorization:'Bearer '+secret},body:'not read by auth'});
 assert.equal(await authenticate(request),true);assert.equal(request.bodyUsed,false);
});
test('query, body, cookies, malformed, duplicate, prefix and near-match credentials cannot authenticate',async()=>{
 const authenticate=createVapiToolCredentialVerifier({secret});
 for(const value of [undefined,'Basic '+secret,'bearer '+secret,'Bearer  '+secret,'Bearer '+secret+'x','Bearer '+secret.slice(0,-1)+'x','Bearer '+secret+', Bearer '+secret]){
  const request=new Request('https://fixture.invalid/tool?token='+secret,{method:'POST',headers:{cookie:'token='+secret,...(value?{authorization:value}:{})},body:JSON.stringify({token:secret})});
  assert.equal(await authenticate(request),false);assert.equal(request.bodyUsed,false);
 }
});
test('missing, short and noncanonical configuration fails without returning secret values',()=>{
 for(const value of [undefined,'', 'short',secret+' ',secret+'=',secret.repeat(4)])assert.throws(()=>createVapiToolCredentialVerifier({secret:value}),error=>!String(error).includes(secret));
});
