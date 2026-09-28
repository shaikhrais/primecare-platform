import assert from 'node:assert/strict';
import { validateRoles } from './seed-production-role-users.mjs';

const valid = validateRoles([
  { id: 1, role_code: 'rmt', test_email: 'qa.rmt@test.primecare.local' },
  { id: 2, role_code: 'client', test_email: 'qa.client@test.primecare.local' },
]);
assert.deepEqual(valid.map((role) => role.code), ['rmt', 'client']);
assert.throws(() => validateRoles([]), /No active governed roles/);
assert.throws(() => validateRoles([{ id: 1, role_code: 'Bad Role', test_email: 'valid@example.com' }]), /Invalid role code/);
assert.throws(() => validateRoles([{ id: 1, role_code: 'rmt', test_email: 'not-an-email' }]), /Invalid test email/);
assert.throws(() => validateRoles([
  { id: 1, role_code: 'rmt', test_email: 'same@example.com' },
  { id: 2, role_code: 'client', test_email: 'same@example.com' },
]), /Duplicate governed role or email/);
console.log('Role seed validation tests passed');
