const { Client } = require('pg');

const client = new Client({
  connectionString: process.env.DATABASE_URL || 'postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require',
});

async function main() {
  await client.connect();
  
  try {
      const res = await client.query('SELECT email, roles, status FROM "users" WHERE email ILIKE \'%founder%\' OR email ILIKE \'%psw%\'');
      
      console.log("----- PRODUCTION FOUNDER/PSW ROLES -----");
      console.table(res.rows);
      console.log("----------------------------------------");
  } catch (err) {
      console.error('users table failed:', err.message);
      
      const tables = await client.query("SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema'");
      console.log("Available Tables:", tables.rows);
  } finally {
      await client.end();
  }
}

main();
