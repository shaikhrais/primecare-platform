import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {stripTypeScriptTypes} from 'node:module';

// This pure projection module needs no HTTP/database fixture or installed bundler.
const source=readFileSync('cloudflare/workers/src/account-read-projection.ts','utf8');
const code=stripTypeScriptTypes(source);
const {accountTimestamp,accountUtcTimestamp}=await import('data:text/javascript;base64,'+Buffer.from(code).toString('base64'));

test('UTC contracts normalize zero to three fraction digits and valid leap days',()=>{
  for(const value of ['0000-02-29T00:00:00Z','2024-02-29T23:59:59Z','2026-10-08T12:00:00Z','2026-10-08T12:00:00.1Z','2026-10-08T12:00:00.12Z','2026-10-08T12:00:00.123Z','9999-12-31T23:59:59.999Z']) {
    assert.equal(accountUtcTimestamp(value),new Date(value).toISOString());
  }
});

test('UTC contracts reject malformed dates and broader read-only syntax',()=>{
  for(const value of [null,undefined,0,{},[],true,'','2026-02-29T12:00:00Z','2026-02-30T12:00:00Z','2026-13-01T12:00:00Z','2026-10-08T24:00:00Z','2026-10-08T12:60:00Z','2026-10-08T12:00:60Z','2026-10-08t12:00:00z','2026-10-08T12:00:00+00:00','2026-10-08T12:00:00.1234Z','2026-10-08T12:00:00Z\n']) {
    assert.throws(()=>accountUtcTimestamp(value),String(value));
  }
});

test('adapter Date overrides cannot leak data or execute serialization hooks',()=>{
  const value=new Date('2026-10-08T12:00:00Z');let called=0;
  for(const method of ['getTime','getUTCFullYear','toISOString','toJSON']) {
    value[method]=()=>{called++;return {private:'adapter-secret'};};
  }
  assert.equal(accountUtcTimestamp(value),'2026-10-08T12:00:00.000Z');
  assert.equal(called,0);
  const invalid=new Date(NaN);invalid.getTime=()=>0;invalid.getUTCFullYear=()=>2026;invalid.toISOString=()=> '2026-10-08T12:00:00Z';
  assert.throws(()=>accountUtcTimestamp(invalid));
});

test('Date bounds reject expanded years',()=>{
  for(const value of [new Date(NaN),new Date('-000001-01-01T00:00:00Z'),new Date('+010000-01-01T00:00:00Z')]) assert.throws(()=>accountUtcTimestamp(value));
});

test('general account read contracts retain offsets fractions and nullable values',()=>{
  for(const value of ['2026-10-08T12:00:00+05:30','2026-10-08T12:00:00.123456Z']) {
    assert.equal(accountTimestamp(value),value);
    assert.throws(()=>accountUtcTimestamp(value));
  }
  assert.equal(accountTimestamp(null,true),null);
});
