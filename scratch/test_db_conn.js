const { PrismaClient } = require('@primecare/database');

const dbUrl = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function test() {
  const prisma = new PrismaClient({
    datasources: {
      db: {
        url: dbUrl
      }
    }
  });
  try {
    console.log('Connecting to DB...');
    const roles = await prisma.platformRole.findMany({ take: 1 });
    console.log('Connection successful, roles found:', roles.length);
  } catch (err) {
    console.error('Connection failed:', err.message);
  } finally {
    await prisma.$disconnect();
  }
}

test();
