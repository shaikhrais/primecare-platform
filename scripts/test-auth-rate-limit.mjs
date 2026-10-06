import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readFileSync} from 'node:fs';

const bundle=await build({entryPoints:['cloudflare/workers/src/auth-rate-limit.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {authRateLimit,loginRateLimit}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const policy=JSON.parse(readFileSync('cloudflare/workers/src/auth-security-policy.json','utf8'));
for(const [operation,{maxAttempts,windowSeconds}] of Object.entries(policy)) {
 const run=(result)=>authRateLimit({query:async()=>result},'fixture-hashed-subject',operation);
 test(operation+' rejects nonnumeric, nonpositive and out-of-policy counters',async()=>{
  const invalid=[undefined,null,false,true,'1','',{},[],NaN,Infinity,-Infinity,-1,0,1.5,Number.MAX_SAFE_INTEGER+1];
  for(const attempts of [...invalid,maxAttempts+2])
   await assert.rejects(run({rows:[{attempts,retry_after:windowSeconds}]}),/Invalid authentication rate result/);
  for(const retry_after of [...invalid,windowSeconds+1]) {
   // Retry metadata must be valid for both allowed and throttled responses.
   for(const attempts of [1,maxAttempts+1])
    await assert.rejects(run({rows:[{attempts,retry_after}]}),/Invalid authentication rate result/);
  }
 });
 test(operation+' requires exactly one result row',async()=>{
  const row={attempts:1,retry_after:windowSeconds};
  for(const rows of [undefined,null,{},[],[null],[row,row]])
   await assert.rejects(run({rows}),/Invalid authentication rate result/);
 });
 test(operation+' retains inclusive budget and bounded retry values',async()=>{
  for(const attempts of [1,maxAttempts])
   assert.equal(await run({rows:[{attempts,retry_after:windowSeconds}]}),null);
  for(const retry_after of [1,windowSeconds])
   assert.equal(await run({rows:[{attempts:maxAttempts+1,retry_after}]}),retry_after);
  let query;
  const db={query:async(sql,values)=>{query={sql,values};return {rows:[{attempts:1,retry_after:windowSeconds}]}}};
  assert.equal(await authRateLimit(db,'fixture-hashed-subject',operation),null);
  assert.deepEqual(query.values,['fixture-hashed-subject',windowSeconds,maxAttempts]);
  assert.match(query.sql,/LEAST\(auth_rate_limits.attempts\+1,\$3\+1\)/);
 });
}
test('login wrapper enforces the same validated database result',async()=>{
 await assert.rejects(loginRateLimit({query:async()=>({rows:[{attempts:null,retry_after:60}]})},'fixture-hashed-subject'),/Invalid authentication rate result/);
});
