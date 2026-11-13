import pg from 'pg';
import { registerPreferenceHostBindings } from './preference-host-binding-registration.mjs';

let db;
try {
  const raw = process.env.PRODUCTION_DATABASE_URL;
  const url = new URL(raw);
  if (!['postgres:', 'postgresql:'].includes(url.protocol) ||
      url.hostname !== 'pooled.db.prisma.io' || url.pathname !== '/postgres') {
    throw Error('Pinned production connection required');
  }
  db = new pg.Client({ connectionString: raw, ssl: { rejectUnauthorized: true }, connectionTimeoutMillis: 10000 });
  await db.connect();
  console.log(JSON.stringify(await registerPreferenceHostBindings(db, { readOnly: true })));
} catch (error) {
  console.error('Read-only preference host preflight failed.');
  if (/^[0-9A-Z]{5}$/.test(error?.code ?? '')) console.error('PostgreSQL SQLSTATE: ' + error.code);
  process.exitCode = 1;
} finally {
  if (db) await db.end();
}
