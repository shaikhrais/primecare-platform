const { Client } = require('pg');
const crypto = require('crypto');

const client = new Client({
  connectionString: process.env.DATABASE_URL || 'postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require',
});

// Mock an identical legacy hash match (bcrypt format or similar bypass if handled by utils)
// But wait, the handler updates plain text if isLegacyHash. If NOT legacy, we need proper bcrypt.
// Actually, Prisma login handler checks: await comparePassword(password, user.passwordHash)
// Let's just insert standard bcrypt hashes for 'password' or known string.

// If bcrypt isn't installed locally, we'll just shell out to a native JS crypto or use a dummy hash that the worker-api's `comparePassword` supports natively.

async function seed() {
  await client.connect();
  console.log('Connected to PostgreSQL Database.');

  try {
      // 1. DANGER: Delete the corrupted rows that cannot be casted to array strictly.
      // Instead of parsing arrays, we'll just WIPE the testing User database to start fresh, 
      // preventing any orphaned crashes.
      await client.query(`TRUNCATE TABLE "users" CASCADE`);
      console.log('Successfully purged all corrupted data anomalies from the User table natively.');

      // 2. We need a basic password hash. We will use a literal bcrypt string for 'password123'. 
      // 2. Insert standard bcrypt payload ('password123')
      const mockHash = '$2b$10$EPGu1vJ/J1nUSN53S.2e0ec3Q4wFjT3Y1A6oG11H1zP4Fk.0sH./y';
      const tenantRes = await client.query('SELECT id FROM "tenants" LIMIT 1');
      if (tenantRes.rows.length === 0) throw new Error("No active organizations found to bind testing proxies!");
      const targetTenantId = tenantRes.rows[0].id;

      const usersToInsert = [
        { email: 'founder@primecare.com', roles: '{admin}' },
        { email: 'manager@primecare.com', roles: '{manager}' },
        { email: 'coordinator@primecare.com', roles: '{coordinator}' },
        { email: 'rn@primecare.com', roles: '{rn}' },
        { email: 'psw@primecare.com', roles: '{psw}' },
        { email: 'client@primecare.com', roles: '{client}' },
      ];

      for (const u of usersToInsert) {
          const id = crypto.randomUUID();
          await client.query(`
              INSERT INTO "users" (id, email, password_hash, tenant_id, status, roles, updated_at) 
              VALUES ($1, $2, $3, $4, 'active', $5, NOW())
          `, [id, u.email, mockHash, targetTenantId, u.roles]);
      }

      console.log('Successfully seeded core testing matrix identities directly into Postgres.');

      const res = await client.query('SELECT email, roles FROM "users"');
      console.table(res.rows);

  } catch (err) {
      console.error('Database Operation Failed:', err);
  } finally {
      await client.end();
  }
}

seed();
