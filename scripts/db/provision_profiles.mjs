import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function provisionProfiles() {
    const db = new Client({ connectionString });
    await db.connect();
    try {
        const email = 'manager.a@primecare.ca';
        const userRes = await db.query('SELECT id, tenant_id FROM users WHERE email = $1', [email]);
        if (userRes.rows.length === 0) {
            console.log('User not found');
            return;
        }
        const { id: userId, tenant_id: tenantId } = userRes.rows[0];

        // 1. PSW Profile
        const pswRes = await db.query('SELECT id FROM psw_profiles WHERE user_id = $1', [userId]);
        if (pswRes.rows.length === 0) {
            console.log('Creating PSW Profile...');
            await db.query(`
                INSERT INTO psw_profiles (id, user_id, full_name, is_approved, tenant_id, created_at)
                VALUES (gen_random_uuid(), $1, 'Manager Alpha (PSW)', true, $2, NOW())
            `, [userId, tenantId]);
        }

        // 2. Client Profile
        const clientRes = await db.query('SELECT id FROM client_profiles WHERE user_id = $1', [userId]);
        if (clientRes.rows.length === 0) {
            console.log('Creating Client Profile...');
            await db.query(`
                INSERT INTO client_profiles (id, user_id, full_name, tenant_id, created_at, updated_at)
                VALUES (gen_random_uuid(), $1, 'Manager Alpha (Client)', $2, NOW(), NOW())
            `, [userId, tenantId]);
        }

        console.log('PROFILES SYNCED');
    } catch (err) {
        console.error('Error:', err);
    } finally {
        await db.end();
    }
}

provisionProfiles();
