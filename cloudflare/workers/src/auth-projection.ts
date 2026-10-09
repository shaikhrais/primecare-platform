import {optionalRow,scopedActor} from './database-results';
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

/** Privileged routes validate database authority before consulting role policy. */
export function privilegedActor(value:unknown): (Record<string,unknown> & {id:string;roles:string;tenant_id:string|null}) | null {
 const row=optionalRow(value);if(!row)return null;
 const scope=scopedActor([row])!,claims=authIdentity(row);
 return {...row,id:scope.id,roles:claims.roles,tenant_id:scope.tenant_id};
}
