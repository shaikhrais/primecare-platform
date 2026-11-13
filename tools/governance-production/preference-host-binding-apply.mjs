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
  const connect = async () => {
    const client = new pg.Client({ connectionString: raw, ssl: { rejectUnauthorized: true }, connectionTimeoutMillis: 10000 });
    await client.connect();
    return client;
  };
  db = await connect();
  const result = await registerPreferenceHostBindings(db, { commit: true });
  await db.end();
  db = await connect();
  const readback = await registerPreferenceHostBindings(db, { readOnly: true });
  if (readback.missingScreenIds.length) throw Error('Independent readback found missing links');
  console.log(JSON.stringify({ result, readback }));
} catch (error) {
  console.error('Preference host registration or independent readback failed.');
  if (/^[0-9A-Z]{5}$/.test(error?.code ?? '')) console.error('PostgreSQL SQLSTATE: ' + error.code);
  process.exitCode = 1;
} finally {
  if (db) await db.end();
}
