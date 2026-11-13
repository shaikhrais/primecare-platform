/** Pure deployment checks. Never fetch, return, serialize or rewrite secret values. */
const secretTypes = new Set(['secret_text', 'secret_key']);

function identities(settings) {
  if (!settings || !Array.isArray(settings.bindings)) {
    throw new Error('Secret binding metadata unavailable');
  }
  const names = new Set();
  const result = [];
  for (const binding of settings.bindings) {
    if (!binding || typeof binding !== 'object' ||
        typeof binding.name !== 'string' || !binding.name.trim() ||
        typeof binding.type !== 'string' || !binding.type || names.has(binding.name)) {
      throw new Error('Secret binding metadata invalid');
    }
    names.add(binding.name);
    if (secretTypes.has(binding.type)) result.push(JSON.stringify([binding.name, binding.type]));
  }
  return result.sort();
}

/** Pinned Wrangler 4.68.1 keep_vars also sets keepSecrets in its upload metadata.
 * This checks a candidate config, not whether any deployment used that config.
 * Non-secret bindings and deployed/latest-upload lineage need separate guards.
 */
export function assertExplicitSecretRetention(config) {
  // Inherited/hidden flags are omitted from JSON, and accessors can change
  // between this check and serialization. Accept only the explicit data flag.
  const flag = config && typeof config === 'object' && !Array.isArray(config)
    ? Object.getOwnPropertyDescriptor(config, 'keep_vars') : undefined;
  if (!flag || flag.enumerable !== true || flag.value !== true) {
    throw new Error('Explicit Worker secret retention required');
  }
  return true;
}

/** Compare freshly fetched pre/post metadata; callers retain their other guards. */
export function assertWorkerSecretBindingsPreserved(before, after) {
  const expected = identities(before);
  const actual = identities(after);
  if (expected.length !== actual.length || expected.some((value, i) => value !== actual[i])) {
    throw new Error('Worker secret binding identity changed');
  }
  return { secretBindingCount: actual.length, secretBindingsPreserved: true };
}
