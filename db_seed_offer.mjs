import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function run() {
    const client = new Client({ connectionString });
    try {
        await client.connect();
        console.log('🔗 Connected to DB');

        // 1. Get IDs
        const vRes = await client.query("SELECT id, tenant_id FROM visits WHERE status = 'posted' LIMIT 1");
        const pRes = await client.query("SELECT p.id, p.tenant_id FROM psw_profiles p JOIN users u ON p.user_id = u.id WHERE u.email = 'psw.a@primecare.ca' LIMIT 1");

        if (vRes.rows.length === 0 || pRes.rows.length === 0) {
            console.log('❌ Could not find requisite data.');
            return;
        }

        const visit = vRes.rows[0];
        const psw = pRes.rows[0];

        console.log(`Visit ID: ${visit.id} (Tenant: ${visit.tenant_id})`);
        console.log(`PSW ID: ${psw.id} (Tenant: ${psw.tenant_id})`);

        // 2. Ensure Tenants match (important for RLS/Logic)
        if (visit.tenant_id !== psw.tenant_id) {
            console.log('⚠️ Tenant mismatch. Updating PSW tenant to match visit...');
            await client.query("UPDATE psw_profiles SET tenant_id = $1 WHERE id = $2", [visit.tenant_id, psw.id]);
            await client.query("UPDATE users SET tenant_id = $1 WHERE email = 'psw.a@primecare.ca'", [visit.tenant_id]);
        }

        // 3. Clear old assignments for this PSW to be sure
        await client.query("DELETE FROM shift_assignments WHERE psw_id = $1", [psw.id]);

        // 4. Insert
        const q = "INSERT INTO shift_assignments (id, visit_id, psw_id, status, tenant_id) VALUES (gen_random_uuid(), $1, $2, 'offered', $3)";
        await client.query(q, [visit.id, psw.id, visit.tenant_id]);
        console.log('✅ Shift Assignment Inserted');

        // 5. Verify
        const check = await client.query("SELECT * FROM shift_assignments WHERE psw_id = $1 AND status = 'offered'", [psw.id]);
        console.log(`🔍 Verification: Found ${check.rows.length} offered shifts for this PSW.`);

    } catch (err) {
        console.error('💥 DB Error:', err);
    } finally {
        await client.end();
    }
}

run();
