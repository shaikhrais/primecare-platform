/** Compatibility exports; shared contracts are owned by the communication core. */
export {required} from '../../../../packages/shared/src/communications/service-base.ts';
export type {Actor,RecordState,Command,Change,AtomicStore,AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import {required,type Actor,type RecordState,type Command,type Change,type AtomicStore} from '../../../../packages/shared/src/communications/service-base.ts';
export function commandValid(command: Command) {
 for (const value of [command.id, command.key, command.type, command.actor.id, command.actor.tenantId]) required(value);
 if (!Number.isSafeInteger(command.expectedVersion) || command.expectedVersion < 0) throw Error('Invalid version');
}
function canonical(value: any): string {
 if (value === null || typeof value !== 'object') return JSON.stringify(value);
 if (Array.isArray(value)) return '[' + value.map(canonical).join(',') + ']';
 return '{' + Object.keys(value).sort().map(key => JSON.stringify(key) + ':' + canonical(value[key])).join(',') + '}';
}
export async function fingerprint(command: Command) {
 const bytes = new TextEncoder().encode(canonical({type: command.type, expectedVersion: command.expectedVersion, payload: command.payload}));
 return Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256', bytes)), byte => byte.toString(16).padStart(2, '0')).join('');
}

/** Use only after registering the schema and its permissions. Pool is a native pg Pool. */
export class PostgresAtomicStore implements AtomicStore {
 readonly pool: any;
 constructor(pool: any) { this.pool = pool; }
 async run(command: Command, authorize: (state: RecordState | null) => Promise<void>, apply: (state: RecordState | null) => Promise<Change>) {
  commandValid(command);
  const db = await this.pool.connect();
  try {
   await db.query('BEGIN');
   // Serializes creation as well as mutations. Hash collisions only serialize unrelated work.
   await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))', [JSON.stringify([command.actor.tenantId,command.id])]);
   const row = (await db.query('SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND id=$2 FOR UPDATE', [command.actor.tenantId,command.id])).rows[0];
   const state = row?.state ?? null;
   await authorize(state);
   const hash = await fingerprint(command);
   const previous = (await db.query('SELECT actor_id,fingerprint,result FROM business_work_commands WHERE tenant_id=$1 AND aggregate_id=$2 AND command_key=$3', [command.actor.tenantId,command.id,command.key])).rows[0];
   if (previous) {
    if (previous.actor_id !== command.actor.id || previous.fingerprint !== hash) throw Error('Idempotency conflict');
    await db.query('COMMIT'); return previous.result;
   }
   if ((state?.version ?? 0) !== command.expectedVersion) throw Error('Version conflict');
   const change = await apply(state ? structuredClone(state) : null);
   if (change.state.id !== command.id || change.state.tenantId !== command.actor.tenantId) throw Error('Scope conflict');
   change.state.version = command.expectedVersion + 1;
   const result = change.result ?? {id: command.id, version: change.state.version};
   await db.query('INSERT INTO business_work_aggregates(tenant_id,id,state) VALUES($1,$2,$3) ON CONFLICT(tenant_id,id) DO UPDATE SET state=EXCLUDED.state', [command.actor.tenantId,command.id,JSON.stringify(change.state)]);
   await db.query('INSERT INTO business_work_events(tenant_id,aggregate_id,actor_id,event_type,version) VALUES($1,$2,$3,$4,$5)', [command.actor.tenantId,command.id,command.actor.id,change.event,change.state.version]);
   await db.query('INSERT INTO business_work_commands(tenant_id,aggregate_id,command_key,actor_id,fingerprint,result) VALUES($1,$2,$3,$4,$5,$6)', [command.actor.tenantId,command.id,command.key,command.actor.id,hash,JSON.stringify(result)]);
   await db.query('COMMIT'); return result;
  } catch (error) { await db.query('ROLLBACK'); throw error; }
  finally { db.release(); }
 }
 async read(actor: Actor, id: string, authorize: (state: RecordState) => Promise<void>) {
  required(id); required(actor.id); required(actor.tenantId);
  const row = (await this.pool.query('SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND id=$2', [actor.tenantId,id])).rows[0];
  if (!row) throw Error('Not found');
  await authorize(row.state); return row.state;
 }
 async inbox(actor: Actor, kind: 'workflow'|'conversation', authorize: (state: RecordState) => Promise<void>, limit=50) {
  required(actor.id);required(actor.tenantId);
  if(!['workflow','conversation'].includes(kind)||!Number.isSafeInteger(limit)||limit<1||limit>100)throw Error('Invalid inbox');
  const rows=(await this.pool.query(`SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND state->>'kind'=$2
   AND ((state->>'kind'='workflow' AND (state->>'ownerId'=$3 OR state->>'reviewerId'=$3 OR state->>'originatorId'=$3))
    OR (state->>'kind'='conversation' AND state->'members' ? $3)) ORDER BY id LIMIT $4`,[actor.tenantId,kind,actor.id,limit])).rows;
  for(const row of rows)await authorize(row.state);
  return rows.map((row:any)=>row.state);
 }
}
