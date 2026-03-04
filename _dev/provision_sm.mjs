import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function provisionSM() {
    const db = new Client({ connectionString });
    await db.connect();
    try {
        const email = 'manager.a@primecare.ca';
        // Add scrum_master to roles array if not already there
        await db.query("UPDATE users SET roles = array_append(roles, 'scrum_master') WHERE email = $1 AND NOT ('scrum_master' = ANY(roles))", [email]);

        const res = await db.query("SELECT email, roles FROM users WHERE email = $1", [email]);
        console.log('--- PROVISIONED ACCOUNT ---');
        console.log(`Email: ${res.rows[0].email}`);
        console.log(`Roles: [${res.rows[0].roles}]`);
        console.log(`Password: admin123 (from qa_final_prod.mjs)`);
    } catch (err) {
        console.error('Error:', err);
    } finally {
        await db.end();
    }
}

provisionSM();
