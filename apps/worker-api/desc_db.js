const { Client } = require('pg');

const client = new Client({
  connectionString: process.env.DATABASE_URL || 'postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require',
});

async function main() {
  await client.connect();
  
  try {
      const res = await client.query(`SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'users'`);
      console.table(res.rows);
  } catch (err) {
      console.error(err.message);
  } finally {
      await client.end();
  }
}

main();
