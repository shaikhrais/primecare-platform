const fetch = require('node-fetch');

const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';

async function run() {
    try {
        // 0. Setup: Register Admin and Create Service
        const adminEmail = `admin.${Date.now()}@example.com`;
        console.log(`0. Setting up: Registering Admin (${adminEmail})...`);
        const adminReg = await fetch(`${API_URL}/v1/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: adminEmail, password: 'Password@123', role: 'admin' })
        });
        if (!adminReg.ok) throw new Error('Admin reg failed');
        const adminToken = (await adminReg.json()).token;

        console.log('   Creating Test Service...');
        const svcRes = await fetch(`${API_URL}/v1/admin/services`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${adminToken}`
            },
            body: JSON.stringify({
                name: 'Test Service ' + Date.now(),
                hourlyRate: 50,
                description: 'Verification Service',
                isActive: true
            })
        });
        if (!svcRes.ok) {
            const err = await svcRes.text();
            console.error('Service creation failed:', err);
            // Continue anyway, maybe service exists?
        } else {
            console.log('   Service created.');
        }

        // 1. Client Flow
        const email = `test.client.${Date.now()}@example.com`;
        const password = 'Password@123';
        console.log(`1. Registering new Client (${email})...`);

        const regRes = await fetch(`${API_URL}/v1/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email,
                password,
                role: 'client',
                fullName: 'Test Client',
                phone: '555-0100'
            })
        });

        if (!regRes.ok) {
            const err = await regRes.text();
            throw new Error(`Registration failed: ${regRes.status} - ${err}`);
        }

        const regData = await regRes.json();
        const token = regData.token;
        console.log('   Registration successful.');

        console.log('2. Fetching Services...');
        const servicesRes = await fetch(`${API_URL}/v1/public/services`);


        if (!servicesRes.ok) throw new Error(`Services fetch failed: ${servicesRes.status}`);
        const services = await servicesRes.json();
        console.log(`   Found ${services.length} services.`);

        if (services.length === 0) throw new Error('No services available to book.');
        const serviceId = services[0].id;
        console.log(`   Selected Service: ${services[0].name} (${serviceId})`);

        console.log('3. Creating Booking Request...');
        const bookingPayload = {
            serviceId: serviceId,
            requestedStartAt: new Date(Date.now() + 86400000).toISOString(), // Tomorrow
            durationMinutes: 60,
            notes: 'Verification Script Test Booking'
        };

        const bookRes = await fetch(`${API_URL}/v1/client/bookings`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(bookingPayload)
        });

        if (!bookRes.ok) {
            const err = await bookRes.text();
            throw new Error(`Booking failed: ${bookRes.status} - ${err}`);
        }
        const booking = await bookRes.json();
        console.log('   Booking successful:', booking.id);

        console.log('4. Verifying Booking in List...');
        const listRes = await fetch(`${API_URL}/v1/client/bookings`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        const list = await listRes.json();
        const found = list.find(b => b.id === booking.id);

        if (found) {
            console.log('   ✅ Booking verified in list.');
        } else {
            console.error('   ❌ Booking NOT found in list.');
        }

    } catch (error) {
        console.error('FAILED:', error.message);
        process.exit(1);
    }
}

run();
