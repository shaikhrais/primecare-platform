import test from 'node:test';
import assert from 'node:assert/strict';
import {validateFlutterMfaReceipt, requiredFlutterMfaChecks} from './validate-flutter-mfa-receipt.mjs';
const source = 'a'.repeat(40);
function fixture() {
  return {source, bundleSha256: 'b'.repeat(64), synthetic: true, ownerAccountTouched: false,
    independentApprovals: false, passed: true,
    results: [['en', 320], ['fr', 768], ['es', 1440]].map(([locale, width]) =>
      ({locale, width, checks: [...requiredFlutterMfaChecks], cleanup: true, passed: true}))};
}
test('source-bound scoped proof grants no independent approval or whole-auth credit', () => {
  assert.deepEqual(validateFlutterMfaReceipt(fixture(), source),
    {source, locales: 3, independentApprovals: false, wholePlatformAuthVerified: false});
});
for (const [name, mutate] of [
  ['different source', r => {r.source = 'c'.repeat(40);}],
  ['failed cleanup', r => {r.results[0].cleanup = false;}],
  ['missing database proof', r => {r.results[0].checks = r.results[0].checks.filter(x => x !== 'browser session matches hashed database record');}],
  ['duplicate locale', r => {r.results[1] = r.results[0];}],
  ['unverified viewport', r => {r.results[0].width = 1440;}],
  ['invented approval', r => {r.independentApprovals = true;}],
  ['real owner mutation', r => {r.ownerAccountTouched = true;}],
  ['unexpected secret field', r => {r.token = 'must-not-be-recorded';}],
  ['failed journey', r => {r.results[1].passed = false;}],
  ['missing build binding', r => {r.bundleSha256 = '';}],
]) test('rejects ' + name, () => {
  const receipt = fixture(); mutate(receipt);
  assert.throws(() => validateFlutterMfaReceipt(receipt, source));
});
