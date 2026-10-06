import {accountId} from './account-read-projection';

/** Validate claims before session issuance or serialization; never coerce values. */
export function authIdentity(row: Record<string, unknown>) {
  const userId = accountId(row.id);
  if (typeof row.roles !== 'string' || !row.roles || row.roles.length > 200) throw Error('Invalid authentication role');
  return {userId, roles: row.roles};
}

/** A mutation must return its expected account, with only approved fields. */
export function mutatedAccount(row: Record<string, unknown>, expected: {id: string; email?: string; role: string; status: string; tenantId: string}) {
  const id = accountId(row.id);
  if (id.toLowerCase() !== expected.id.toLowerCase() || typeof row.email !== 'string' || !row.email ||
      expected.email !== undefined && row.email !== expected.email || row.roles !== expected.role ||
      row.status !== expected.status || row.tenant_id !== expected.tenantId) throw Error('Invalid account mutation result');
  return {id, email: row.email, roles: row.roles, status: row.status, tenant_id: row.tenant_id};
}
