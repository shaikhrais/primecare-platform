import {test} from 'node:test';
import assert from 'node:assert/strict';
import {totpAt, matchTotp} from '../cloudflare/workers/src/security/totp.mjs';
const encode = value => new TextEncoder().encode(value);
const secret = encode('12345678901234567890');
// RFC 6238 Appendix B, with corrected per-algorithm key lengths.
const vectors = [
 [59,'94287082','46119246','90693936'],
 [1111111109,'07081804','68084774','25091201'],
 [1111111111,'14050471','67062674','99943326'],
 [1234567890,'89005924','91819424','93441116'],
 [2000000000,'69279037','90698825','38618901'],
 [20000000000,'65353130','77737706','47863826'],
];
for (const [index, algorithm, size] of [[1,'SHA-1',20],[2,'SHA-256',32],[3,'SHA-512',64]]) {
 test(`RFC 6238 ${algorithm} vectors including dates beyond 2038`, async () => {
  const key = encode('1234567890'.repeat(7).slice(0,size));
  for (const vector of vectors) assert.equal(await totpAt(key, vector[0], {digits:8,algorithm}), vector[index]);
 });
}
test('accept current and previous counter, reject future, expired and replayed codes', async () => {
 const now = 1234567890;
 const counter = Math.floor(now/30);
 const code = await totpAt(secret, now);
 assert.equal(await matchTotp(secret, code, {seconds:now}),counter);
 assert.equal(await matchTotp(secret, code, {seconds:now+30}),counter);
 assert.equal(await matchTotp(secret, code, {seconds:now+60}),null);
 assert.equal(await matchTotp(secret, code, {seconds:now-30}),null);
 assert.equal(await matchTotp(secret, code, {seconds:now,lastAcceptedCounter:counter}),null);
 assert.equal(await matchTotp(secret, code, {seconds:now,lastAcceptedCounter:counter+1}),null);
});
test('reject malformed codes and invalid cryptographic inputs', async () => {
 for(const code of [123456,' 123456','123456\n','１２３４５６','12345','1234567',null]) assert.equal(await matchTotp(secret,code,{seconds:59}),null);
 for(const seconds of [-1,NaN,Infinity,1.5,undefined]) await assert.rejects(matchTotp(secret,'123456',{seconds}));
 await assert.rejects(totpAt(new Uint8Array(19),59));
 await assert.rejects(totpAt(secret,59,{digits:7}));
 await assert.rejects(totpAt(secret,59,{algorithm:'MD5'}));
 await assert.rejects(matchTotp(secret,'123456',{seconds:59,lastAcceptedCounter:NaN}));
});
test('preserve leading zeroes and exact 30-second boundaries', async () => {
 assert.equal(await totpAt(secret,1111111109), '081804');
 const code = await totpAt(secret,29);
 assert.equal(await matchTotp(secret,code,{seconds:29}),0);
 assert.equal(await matchTotp(secret,code,{seconds:30}),0);
 assert.equal(await matchTotp(secret,code,{seconds:60}),null);
});
