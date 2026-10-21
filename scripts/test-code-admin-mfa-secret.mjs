import {test} from 'node:test';
import assert from 'node:assert/strict';
import {generateMfaSeed,sealMfaSeed,openMfaSeed} from '../cloudflare/workers/src/security/mfa-secret.mjs';
const identity={tenantId:'tenant-a',userId:'user-a',keyId:'key-v1'};
const key = crypto.getRandomValues(new Uint8Array(32));
test('random seeds and per-write nonces, authenticated encryption roundtrip',async()=>{
 const seed=generateMfaSeed();
 assert.equal(seed.length,20);
 assert.notDeepEqual(seed,generateMfaSeed());
 const a=await sealMfaSeed(seed,key,identity), b=await sealMfaSeed(seed,key,identity);
 assert.notEqual(a.iv,b.iv);assert.notEqual(a.ciphertext,b.ciphertext);
 assert.deepEqual(await openMfaSeed(a,key,identity),seed);
 assert.deepEqual(await openMfaSeed(b,key,identity),seed);
 assert.equal(JSON.stringify(a).includes(Buffer.from(seed).toString('hex')),false);
});
test('reject copied records across users, tenants and key versions',async()=>{
 const envelope=await sealMfaSeed(generateMfaSeed(),key,identity);
 for(const override of [{tenantId:'tenant-b'},{userId:'user-b'},{keyId:'key-v2'}]) await assert.rejects(openMfaSeed(envelope,key,{...identity,...override}),{message:'MFA secret unavailable'});
 await assert.rejects(openMfaSeed(envelope,crypto.getRandomValues(new Uint8Array(32)),identity),{message:'MFA secret unavailable'});
});
test('reject tampering, missing/extra fields, invalid versions and lengths with generic error',async()=>{
 const envelope=await sealMfaSeed(generateMfaSeed(),key,identity);
 const flip = s => (s[0]==='0'?'1':'0')+s.slice(1);
 const {iv,...missing}=envelope;
 for(const changed of [null,missing,{...envelope,extra:true},{...envelope,version:2},{...envelope,iv:flip(envelope.iv)},{...envelope,ciphertext:flip(envelope.ciphertext)},{...envelope,ciphertext:envelope.ciphertext.slice(2)},{...envelope,iv:'x'.repeat(24)}]) await assert.rejects(openMfaSeed(changed,key,identity),{message:'MFA secret unavailable'});
});
test('fail closed on invalid storage keys, seed lengths and identity',async()=>{
 const seed=generateMfaSeed();
 for(const invalid of [undefined,'key',new Uint8Array(16)]) await assert.rejects(sealMfaSeed(seed,invalid,identity));
 await assert.rejects(sealMfaSeed(new Uint8Array(19),key,identity));
 for(const invalid of [undefined,{...identity,userId:''},{...identity,tenantId:1}]) await assert.rejects(sealMfaSeed(seed,key,invalid));
});
