import pg from 'pg';
import {pathToFileURL} from 'node:url';

const identityCatalog = `
WITH required(name) AS (VALUES ('tenants'), ('users'), ('visits'))
SELECT required.name, n.nspname AS schema, c.relkind,
       format_type(a.atttypid,a.atttypmod) AS type,
       COALESCE(a.attnotnull,false) AS not_null,
       COALESCE(has_column_privilege(c.oid,a.attnum,'REFERENCES'),false) AS can_reference,
       EXISTS (SELECT 1 FROM pg_index i WHERE i.indrelid=c.oid
         AND i.indisunique AND i.indisvalid AND i.indimmediate AND i.indpred IS NULL
         AND i.indexprs IS NULL AND i.indnkeyatts=1 AND i.indkey[0]=a.attnum) AS reference_key
FROM required LEFT JOIN pg_class c ON c.oid=to_regclass(required.name)
LEFT JOIN pg_namespace n ON n.oid=c.relnamespace
LEFT JOIN pg_attribute a ON a.attrelid=c.oid AND a.attname='id'
  AND a.attnum>0 AND NOT a.attisdropped
ORDER BY required.name`;

/** Catalog-only compatibility check. Never applies migrations or reads care records. */
export async function checkCareMigrationTarget(database) {
  await database.query('BEGIN READ ONLY');
  try {
    await database.query("SET LOCAL statement_timeout='5s'");
    const {rows: [target]} = await database.query(`SELECT current_schema() AS schema,
      COALESCE(has_schema_privilege(current_schema(),'CREATE'),false) AS can_create`);
    const {rows: identities} = await database.query(identityCatalog);
    const issues = [];
    if (!target?.schema) issues.push('No writable target schema resolves through search_path');
    else if (!target.can_create) issues.push('Target schema does not grant CREATE to the migration role');
    for (const identity of identities) {
      if (!identity.schema) { issues.push(`${identity.name}: relation does not resolve through search_path`); continue; }
      if (!['r', 'p'].includes(identity.relkind)) issues.push(`${identity.name}: a table is required`);
      if (!['uuid', 'text', 'character varying'].includes(identity.type)) issues.push(`${identity.name}: id type is unsupported by the care migration`);
      if (!identity.not_null) issues.push(`${identity.name}: id must be NOT NULL`);
      if (!identity.reference_key) issues.push(`${identity.name}: id requires a valid, unconditional single-column unique key`);
      if (!identity.can_reference) issues.push(`${identity.name}: migration role requires REFERENCES`);
    }
    return {scope: 'care_base_identity_compatibility', targetSchema: target?.schema ?? null,
      identities, compatible: issues.length === 0, issues, migrationsApplied: 0,
      clinicalRecordsRead: 0, releaseApproved: false};
  } finally {
    await database.query('ROLLBACK');
  }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  const connectionString = process.env.CARE_PREFLIGHT_DATABASE_URL;
  if (!connectionString) {
    console.error('Set CARE_PREFLIGHT_DATABASE_URL to the intended migration connection. No database was accessed.');
    process.exitCode = 1;
  } else {
    let database;
    try {
      database = new pg.Client({connectionString, connectionTimeoutMillis: 5000});
      await database.connect();
      const result = await checkCareMigrationTarget(database);
      console.log(JSON.stringify(result, null, 2));
      if (!result.compatible) process.exitCode = 1;
    } catch {
      // Connection errors can contain credentials or hostnames; never print them.
      console.error('Care identity preflight failed. No migrations were applied; inspect connection and catalog access separately.');
      process.exitCode = 1;
    } finally {
      if (database) await database.end().catch(() => {});
    }
  }
}
