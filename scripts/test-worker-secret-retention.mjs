import assert from 'node:assert/strict';
import test from 'node:test';
import { assertExplicitSecretRetention, assertWorkerSecretBindingsPreserved } from './worker-secret-retention.mjs';

const binding = (name, type = 'secret_text') => ({ name, type });
const settings = (...bindings) => ({ bindings });

test('retention must be an explicit boolean in the candidate config', () => {
  for (const config of [null, {}, { keep_vars: false }, { keep_vars: 'true' }, { keep_vars: 1 }]) {
    assert.throws(() => assertExplicitSecretRetention(config), /Explicit Worker secret retention required/);
  }
  assert.equal(assertExplicitSecretRetention({ keep_vars: true }), true);
});

test('secret identity comparison ignores ordering and returns only aggregate evidence', () => {
  const before = settings(binding('database'), binding('key', 'secret_key'), binding('visible', 'plain_text'));
  const after = settings(binding('key', 'secret_key'), binding('database'), binding('visible', 'plain_text'));
  assert.deepEqual(assertWorkerSecretBindingsPreserved(before, after), {
    secretBindingCount: 2, secretBindingsPreserved: true,
  });
});

test('removed, added, renamed and retyped secrets all fail', () => {
  const before = settings(binding('database'));
  for (const after of [settings(), settings(binding('database'), binding('added')),
    settings(binding('renamed')), settings(binding('database', 'secret_key')),
    settings(binding('database', 'plain_text'))]) {
    assert.throws(() => assertWorkerSecretBindingsPreserved(before, after), /identity changed/);
  }
});

test('absent and malformed metadata fail before any preservation claim', () => {
  for (const invalid of [null, {}, { bindings: null }, settings(null), settings({}),
    settings(binding('')), settings(binding('  ')), settings(binding('x', '')),
    settings(binding('x'), binding('x', 'plain_text'))]) {
    assert.throws(() => assertWorkerSecretBindingsPreserved(invalid, settings()), /metadata/);
    assert.throws(() => assertWorkerSecretBindingsPreserved(settings(), invalid), /metadata/);
  }
});

test('secret values are never accessed, and inputs are not mutated', () => {
  const secret = Object.freeze({ name: 'database', type: 'secret_text',
    get text() { throw new Error('must not access text'); },
    get value() { throw new Error('must not access value'); } });
  const input = Object.freeze({ bindings: Object.freeze([secret]) });
  assert.equal(assertWorkerSecretBindingsPreserved(input, input).secretBindingCount, 1);
});

test('failure diagnostics expose neither binding names nor values', () => {
  const sensitive = 'private-binding-marker';
  assert.throws(() => assertWorkerSecretBindingsPreserved(settings(binding(sensitive)), settings()), error => {
    assert.equal(error.message, 'Worker secret binding identity changed');
    assert.ok(!error.message.includes(sensitive));
    return true;
  });
});

test('empty secret sets are valid without claiming non-secret preservation', () => {
  assert.deepEqual(assertWorkerSecretBindingsPreserved(settings(), settings(binding('new', 'plain_text'))), {
    secretBindingCount: 0, secretBindingsPreserved: true,
  });
});

test('inherited and hidden retention flags cannot establish explicit JSON configuration', () => {
  for (const config of [Object.create({ keep_vars: true }),
    Object.defineProperty({}, 'keep_vars', { value: true })]) {
    assert.equal(JSON.stringify(config), '{}');
    assert.throws(() => assertExplicitSecretRetention(config), /Explicit Worker secret retention required/);
  }
});

test('retention rejects accessors and non-object JSON configurations without invoking a flag getter', () => {
  let reads = 0;
  const accessor = Object.defineProperty({}, 'keep_vars', { enumerable: true,
    get() { reads++; return true; } });
  for (const config of [accessor, Object.assign([], { keep_vars: true }),
    Object.assign(() => {}, { keep_vars: true })]) {
    assert.throws(() => assertExplicitSecretRetention(config), /Explicit Worker secret retention required/);
  }
  assert.equal(reads, 0);
});

test('own enumerable boolean data flags work for parsed, frozen and null-prototype configurations', () => {
  for (const config of [JSON.parse('{"keep_vars":true}'), Object.freeze({ keep_vars: true }),
    Object.assign(Object.create(null), { keep_vars: true })]) {
    const before = JSON.stringify(config);
    assert.equal(assertExplicitSecretRetention(config), true);
    assert.equal(JSON.parse(before).keep_vars, true);
    assert.equal(JSON.stringify(config), before);
  }
});
