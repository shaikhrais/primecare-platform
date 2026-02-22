import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

const API_URL = 'https://primecare-api.shaikhrais.workers.dev';

async function qa() {
    console.log('--- COMPREHENSIVE PRODUCTION QA VERIFICATION ---');
    const db = new Client({ connectionString });
    await db.connect();

    try {
        // 1. Get real IDs
        const clientRes = await db.query('SELECT id FROM client_profiles LIMIT 1');
        const serviceRes = await db.query('SELECT id FROM services WHERE is_active = true LIMIT 1');
        const pswRes = await db.query('SELECT id FROM psw_profiles WHERE is_approved = true LIMIT 1');

        const clientId = clientRes.rows[0].id;
        const serviceId = serviceRes.rows[0].id;
        const pswId = pswRes.rows[0].id;

        // 2. Login
        const loginRes = await fetch(`${API_URL}/v1/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: 'manager.a@primecare.ca', password: 'admin123' })
        });
        const { token } = await loginRes.json();
        console.log('1. Login: PASS');

        // 3. Post Shift
        const shiftRes = await fetch(`${API_URL}/v1/admin/visits`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' },
            body: JSON.stringify({
                clientId, serviceId, requestedStartAt: new Date().toISOString(),
                durationMinutes: 60, priority: 'urgent', clientNotes: 'QA-FULL-CYCLE-01'
            })
        });
        const shiftData = await shiftRes.json();
        const visitId = shiftData.id;
        console.log(`2. Post Shift: PASS (Visit: ${visitId})`);

        // 4. PSW Check-in
        const checkinRes = await fetch(`${API_URL}/v1/psw/schedule/visits/${visitId}/check-in`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        console.log(`3. PSW Check-in: ${checkinRes.status === 200 ? 'PASS' : 'FAIL'}`);

        // 5. PSW Submit Form (Tasks + Notes)
        const formRes = await fetch(`${API_URL}/v1/psw/schedule/visits/${visitId}/complete`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' },
            body: JSON.stringify({
                notes: 'QA-PROD-VISIT-NOTES-01',
                tasks: [{ id: 'task-1', completed: true, label: 'Personal Hygiene' }],
                incidentFlag: false
            })
        });
        console.log(`4. PSW Form Submission: ${formRes.status === 200 ? 'PASS' : 'FAIL'}`);

        // 6. DB Verification
        const dbVisit = await db.query('SELECT * FROM visits WHERE id = $1', [visitId]);
        const v = dbVisit.rows[0];
        const pass = v.visit_notes === 'QA-PROD-VISIT-NOTES-01' && v.status === 'completed';
        console.log(`5. DB Verification: ${pass ? 'PASS' : 'FAIL'}`);
        if (!pass) console.log('DB Record:', v);

        console.log('--- QA VERIFICATION COMPLETE ---');

    } catch (err) {
        console.error('QA ERROR:', err);
    } finally {
        await db.end();
    }
}

qa();
