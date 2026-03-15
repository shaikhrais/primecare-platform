import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from './generated/client/index.js';

const dbUrl = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function main() {
  const pool = new Pool({ connectionString: dbUrl });
  const adapter = new PrismaPg(pool);
  const prisma = new PrismaClient({ adapter });

  // Check if admin@example.com exists at all
  const exampleAdmin = await prisma.user.findUnique({ where: { email: 'admin@example.com' } });
  console.log("admin@example.com exists?", !!exampleAdmin);

  // Get the itpro admin full hash
  const itproAdmin = await prisma.user.findUnique({
    where: { email: 'itpro.mohammed@gmail.com' },
    select: { id: true, email: true, passwordHash: true, roles: true, tenantId: true, status: true }
  });
  console.log("\n=== itpro.mohammed@gmail.com ===");
  console.log(itproAdmin);

  // Check admin.a hash against "admin123" and "Password123"
  const encoder = new TextEncoder();
  for (const pw of ['admin123', 'Admin123', 'admin1234', 'welcome', 'welcome1', 'test', 'test123', 'primecare', 'Primecare1!']) {
    const hashBuffer = await crypto.subtle.digest('SHA-256', encoder.encode(pw));
    const hash = Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');
    if (hash.startsWith('240be518')) {
      console.log(`\n*** MATCH! Password for admin.a@primecare.ca is: "${pw}" ***`);
    }
  }

  // Count total users
  const totalUsers = await prisma.user.count();
  console.log(`\nTotal users in DB: ${totalUsers}`);

  // List all unique emails
  const allUsers = await prisma.user.findMany({
    select: { email: true, roles: true, status: true },
    take: 20
  });
  console.log("\n=== All users (up to 20) ===");
  allUsers.forEach(u => console.log(`  ${u.email} | ${u.roles} | ${u.status}`));

  await pool.end();
}

main().catch(console.error);
