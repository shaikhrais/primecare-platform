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
} catch {
  console.error('Read-only preference host preflight failed.');
  process.exitCode = 1;
} finally {
  if (db) await db.end();
}
