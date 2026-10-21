export const requiredFlutterMfaChecks = [
  'password exchange issues challenge only', 'no browser authority before factor',
  'no database session before factor', 'cancel removes displayed setup key',
  'fresh password replaces abandoned setup key', 'abandoned challenge rejected after fresh exchange',
  'setup key is rendered in Flutter semantics', 'wrong factor denied without authority',
  'wrong factor creates no database session', 'valid factor accepted',
  'activation and encrypted credential persisted', 'gateway identity matches synthetic account',
  'browser session matches hashed database record', 'enrollment audit committed',
  'challenge and setup key are not persisted', 'reload retains session without displaying seed',
  'logout revokes server session', 'enrolled login never returns setup key',
  'enrolled prompt never renders setup key', 'consumed factor replay denied',
  'fresh enrolled factor accepted', 'signed-out reload has no local or server authority',
  'cleanup identity guard', 'cleanup tenant guard',
];

export function validateFlutterMfaReceipt(receipt, source) {
  const exactKeys = (o, keys) => o && typeof o === 'object' && !Array.isArray(o) &&
    Object.keys(o).sort().join(',') === [...keys].sort().join(',');
  if (!/^[a-f0-9]{40}$/.test(source ?? '') ||
      !exactKeys(receipt, ['source', 'bundleSha256', 'synthetic', 'ownerAccountTouched', 'independentApprovals', 'results', 'passed']) ||
      receipt.source !== source || !/^[a-f0-9]{64}$/.test(receipt.bundleSha256 ?? '') ||
      receipt.passed !== true || receipt.synthetic !== true || receipt.ownerAccountTouched !== false ||
      receipt.independentApprovals !== false || !Array.isArray(receipt.results) || receipt.results.length !== 3) {
    throw Error('Complete source-bound synthetic Flutter MFA receipt required');
  }
  const widths = new Map([['en', 320], ['fr', 768], ['es', 1440]]);
  for (const result of receipt.results) {
    if (!exactKeys(result, ['locale', 'width', 'checks', 'cleanup', 'passed']) ||
        widths.get(result.locale) !== result.width || result.cleanup !== true || result.passed !== true ||
        !Array.isArray(result.checks) || !result.checks.every(c => typeof c === 'string') ||
        !requiredFlutterMfaChecks.every(c => result.checks.includes(c))) {
      throw Error('All locale browser/database checks and cleanup required');
    }
    widths.delete(result.locale);
  }
  if (widths.size) throw Error('Unique complete locale coverage required');
  return {source, locales: 3, independentApprovals: false, wholePlatformAuthVerified: false};
}
