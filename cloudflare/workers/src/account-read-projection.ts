/** Explicit projections for existing CEO read contracts. Never coerce adapter values. */
export function accountId(value: unknown): string {
  if (typeof value !== 'string' || !/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(value)) throw Error('Invalid account identifier');
  return value;
}
export function accountTimestamp(value: unknown, nullable = false): string | null {
  if (nullable && value === null) return null;
  if (value instanceof Date) {
    if (!Number.isFinite(value.getTime()) || value.getUTCFullYear() < 0 || value.getUTCFullYear() > 9999) throw Error('Invalid account timestamp');
    return value.toISOString();
  }
  if (typeof value !== 'string' || !/^\d{4}-\d{2}-\d{2}T(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d(?:\.\d+)?(?:Z|[+-](?:[01]\d|2[0-3]):[0-5]\d)$/.test(value) || !Number.isFinite(Date.parse(value))) throw Error('Invalid account timestamp');
  const [year, month, day] = value.slice(0, 10).split('-').map(Number);
  const calendar = new Date(0); calendar.setUTCFullYear(year, month - 1, day);
  if (calendar.getUTCFullYear() !== year || calendar.getUTCMonth() !== month - 1 || calendar.getUTCDate() !== day) throw Error('Invalid account timestamp');
  return value;
}
export function accountUser(row: Record<string, unknown>, actorId: string, nullableState = false) {
  const id = accountId(row.id);
  if (typeof row.email !== 'string' || !row.email ||
    !(typeof row.roles === 'string' || nullableState && row.roles === null) ||
    !(typeof row.status === 'string' || nullableState && row.status === null)) throw Error('Invalid account row');
  return {id, email: row.email, roles: row.roles, status: row.status,
    updated_at: accountTimestamp(row.updated_at, true), canModify: id.toLowerCase() !== actorId.toLowerCase()};
}
export function accountAuditIdentity(row: Record<string, unknown>) {
  return {id: accountId(row.id), actorUserId: accountId(row.actorUserId), targetUserId: accountId(row.targetUserId),
    created_at: accountTimestamp(row.created_at)};
}
