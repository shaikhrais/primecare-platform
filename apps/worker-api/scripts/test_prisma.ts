import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from './generated/client/index.js';

const dbUrl = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function main() {
  console.log("Connecting...");
  const pool = new Pool({ connectionString: dbUrl });
  const adapter = new PrismaPg(pool);
  const prisma = new PrismaClient({ adapter });
  
  const users = await prisma.user.findMany({ take: 1 });
  console.log("Users:", users);
}

main().catch(console.error);
