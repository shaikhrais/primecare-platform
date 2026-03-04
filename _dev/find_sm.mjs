import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function findAdmins() {
    const db = new Client({ connectionString });
    await db.connect();
    try {
        const res = await db.query("SELECT email, roles FROM users WHERE 'admin' = ANY(roles) LIMIT 5");
        console.log('--- ADMIN ACCOUNTS ---');
        res.rows.forEach(r => console.log(`- ${r.email} [${r.roles}]`));
    } catch (err) {
        console.error('Error:', err);
    } finally {
        await db.end();
    }
}

findAdmins();
