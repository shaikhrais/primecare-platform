import fs from 'node:fs/promises';
import { pathToFileURL } from 'node:url';
import pg from 'pg';
import bcrypt from 'bcryptjs';

const { Client } = pg;

export function validateRoles(value) {
  if (!Array.isArray(value) || value.length === 0) throw new Error('No active governed roles were provided');
  const seenCodes = new Set();
  const seenEmails = new Set();
  return value.map((role) => {
    const code = String(role.role_code || '').trim().toLowerCase();
    const email = String(role.test_email || '').trim().toLowerCase();
    if (!/^[a-z0-9_]+$/.test(code)) throw new Error(`Invalid role code for role id ${role.id}`);
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) throw new Error(`Invalid test email for role ${code}`);
    if (seenCodes.has(code) || seenEmails.has(email)) throw new Error(`Duplicate governed role or email: ${code}`);
    seenCodes.add(code); seenEmails.add(email);
    return { id: Number(role.id), code, email };
  });
}

async function requireColumns(client, table, required) {
  const result = await client.query(
    `SELECT column_name FROM information_schema.columns WHERE table_schema = 'public' AND table_name = $1`,
    [table],
  );
  const columns = new Set(result.rows.map((row) => row.column_name));
  const missing = required.filter((column) => !columns.has(column));
  if (missing.length) throw new Error(`${table} is missing required columns: ${missing.join(', ')}`);
}

async function main() {
  const databaseUrl = process.env.PRODUCTION_DATABASE_URL;
  const password = process.env.TEST_DEFAULT_PASSWORD;
  const rolesPath = process.argv[2];
  if (!databaseUrl) throw new Error('PRODUCTION_DATABASE_URL is required');
  if (!password || password.length < 12) throw new Error('TEST_DEFAULT_PASSWORD must contain at least 12 characters');
  if (!rolesPath) throw new Error('Usage: node scripts/seed-production-role-users.mjs <roles.json>');

  const roles = validateRoles(JSON.parse(await fs.readFile(rolesPath, 'utf8')));
  const passwordHash = await bcrypt.hash(password, 12);
  const client = new Client({ connectionString: databaseUrl, ssl: { rejectUnauthorized: true } });
  await client.connect();
  try {
    await requireColumns(client, 'tenants', ['id', 'name', 'slug', 'status']);
    await requireColumns(client, 'users', ['id', 'email', 'tenant_id', 'roles', 'password_hash', 'status']);
    await client.query('BEGIN');
    await client.query(`SELECT pg_advisory_xact_lock(hashtext('primecare-qa-role-user-seed'))`);
    const tenantResult = await client.query(
      `INSERT INTO tenants (name, slug, status)
       VALUES ('PrimeCare QA', 'primecare-qa', 'active')
       ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, status = 'active'
       RETURNING id`,
    );
    const tenantId = tenantResult.rows[0].id;
    for (const role of roles) {
      await client.query(
        `INSERT INTO users (email, tenant_id, roles, password_hash, status)
         VALUES ($1, $2, $3, $4, 'active')
         ON CONFLICT (email) DO UPDATE SET
           tenant_id = EXCLUDED.tenant_id,
           roles = EXCLUDED.roles,
           password_hash = EXCLUDED.password_hash,
           status = 'active',
           updated_at = NOW()`,
        [role.email, tenantId, role.code, passwordHash],
      );
    }
    const verification = await client.query(
      `SELECT roles, COUNT(*)::int AS count
       FROM users WHERE tenant_id = $1 AND email = ANY($2::text[])
       GROUP BY roles ORDER BY roles`,
      [tenantId, roles.map((role) => role.email)],
    );
    const count = verification.rows.reduce((total, row) => total + row.count, 0);
    if (count !== roles.length) throw new Error(`Expected ${roles.length} users after upsert, found ${count}`);
    await client.query('COMMIT');
    console.log(JSON.stringify({ tenant: 'primecare-qa', governedRoles: roles.length, usersVerified: count }));
  } catch (error) {
    await client.query('ROLLBACK').catch(() => undefined);
    throw error;
  } finally {
    await client.end();
  }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch((error) => { console.error(error instanceof Error ? error.message : 'Role user seed failed'); process.exit(1); });
}
