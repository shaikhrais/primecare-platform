import {test} from 'node:test';
import assert from 'node:assert/strict';
import {webcrypto} from 'node:crypto';
import worker from './worker.mjs';
globalThis.crypto ??= webcrypto;
function fixture(to, size = 12, raw = new TextEncoder().encode('Subject: hi\r\n\r\nhello')) {
  const writes = []; const rejects = [];
  const message = {to, from: 'sender@example.com', rawSize: size, headers: new Headers({subject:'hi'}),
    raw: new ReadableStream({start(controller) {controller.enqueue(raw);controller.close();}}), setReject: value => rejects.push(value)};
  return {message, writes, rejects, env:{INBOX_ADDRESSES:'temp@15minutes-email.com,auth-test@15minutes-email.com', INBOX:{put:async(...args)=>writes.push(args)}}};
}
test('temporary inbox preserves exact MIME and expires after seven days', async()=>{
  const f = fixture('TEMP@15minutes-email.com'); await worker.email(f.message,f.env);
  assert.equal(f.writes.length,1); assert.equal(f.writes[0][2].expirationTtl,604800);
  assert.equal(atob(JSON.parse(f.writes[0][1]).rawBase64),'Subject: hi\r\n\r\nhello');
});
test('permanent inbox does not expire',async()=>{const f=fixture('auth-test@15minutes-email.com');await worker.email(f.message,f.env);assert.deepEqual(f.writes[0][2],{});});
test('unknown recipient rejected without storing',async()=>{const f=fixture('other@15minutes-email.com');await worker.email(f.message,f.env);assert.equal(f.writes.length,0);assert.equal(f.rejects.length,1);});
test('oversized declared and actual messages rejected',async()=>{
  for (const f of [fixture('temp@15minutes-email.com',2097153),fixture('temp@15minutes-email.com',1,new Uint8Array(2097153))]) {
    await worker.email(f.message,f.env);assert.equal(f.writes.length,0);assert.equal(f.rejects.length,1);
  }
});
test('storage failure propagates instead of silently losing email',async()=>{const f=fixture('temp@15minutes-email.com');f.env.INBOX.put=async()=>{throw new Error('Unavailable');};await assert.rejects(worker.email(f.message,f.env),/Unavailable/);});
