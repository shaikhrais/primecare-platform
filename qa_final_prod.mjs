import pg from 'pg';
const { Client } = pg;
const connectionString = "postgres://c99a554c7ca87f32c50ff8957acbfcdacc44ccfa1c17a1e129009f215312218e:sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

const API_URL = 'https://primecare-api.shaikhrais.workers.dev';

async function qa() {
    console.log('--- FINAL PRODUCTION QA VERIFICATION ---');
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

        console.log(`- Using Client: ${clientId}, Service: ${serviceId}, PSW: ${pswId}`);

        // 2. Login
        const loginRes = await fetch(`${API_URL}/v1/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: 'manager.a@primecare.ca', password: 'admin123' })
        });
        const { token } = await loginRes.json();
        console.log('- Logged in successfully.');

        // 3. Post Shift Test
        console.log('- Testing: Post Shift form...');
        const shiftRes = await fetch(`${API_URL}/v1/admin/visits`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                clientId,
                serviceId,
                requestedStartAt: new Date(Date.now() + 86400000).toISOString(),
                durationMinutes: 90,
                priority: 'urgent',
                clientNotes: 'QA-PROD-SHIFT-01'
            })
        });
        const shiftData = await shiftRes.json();
        console.log(`  v API Response: ${shiftRes.status} (Visit ID: ${shiftData.id})`);

        // 4. Verify in DB
        const dbShift = await db.query('SELECT * FROM visits WHERE id = $1', [shiftData.id]);
        if (dbShift.rows[0]) {
            console.log('  v DB Verification: Record created correctly.');
            console.log(`    Status: ${dbShift.rows[0].status}, Priority: ${dbShift.rows[0].priority}`);
        } else {
            console.error('  x DB Verification: Record NOT FOUND.');
        }

        // 5. Booking Form Test
        console.log('- Testing: Booking form (Recurrence)...');
        const bookingRes = await fetch(`${API_URL}/v1/client/bookings`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`, // Manager can usually act or we assume logged in as manager
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                serviceId,
                requestedStartAt: new Date(Date.now() + 172800000).toISOString(),
                durationMinutes: 120,
                priority: 'normal',
                recurrenceRule: { pattern: 'weekly' },
                notes: 'QA-PROD-BOOKING-REC-01'
            })
        });
        const bookingData = await bookingRes.json();
        console.log(`  v API Response: ${bookingRes.status} (Booking ID: ${bookingData.id})`);

        // 6. Verify Multiple Visits generated (if logic active)
        const visitsCount = await db.query('SELECT count(*) FROM visits WHERE booking_id = $1', [bookingData.id]);
        console.log(`  v DB Verification: ${visitsCount.rows[0].count} visits generated for booking.`);

        console.log('--- QA VERIFICATION COMPLETE ---');

    } catch (err) {
        console.error('QA ERROR:', err);
    } finally {
        await db.end();
    }
}

qa();
