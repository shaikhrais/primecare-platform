import fetch from 'node-fetch';

const API_URL = 'https://primecare-api.shaikhrais.workers.dev';

async function verify() {
    console.log('--- PRODUCTION QA SMOKE TEST ---');
    console.log(`Target API: ${API_URL}`);

    try {
        // 1. Health Check
        const health = await fetch(`${API_URL}/`);
        console.log(`- API Health: ${health.status} ${await health.text()}`);

        // 2. Login
        const loginRes = await fetch(`${API_URL}/v1/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: 'manager.a@primecare.ca', password: 'admin123' })
        });

        if (!loginRes.ok) {
            console.error(`- FAILED LOGIN: ${loginRes.status} ${await loginRes.text()}`);
            return;
        }

        const { token } = await loginRes.json();
        console.log('- SUCCESS: Logged in to production.');

        // 3. Test API Data Flow (Post Shift)
        const createVisitRes = await fetch(`${API_URL}/v1/admin/visits`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                clientId: 'seed-client-a-id', // Needs valid ID
                serviceId: 'seed-service-pc-id',
                requestedStartAt: new Date(Date.now() + 86400000).toISOString(),
                durationMinutes: 60,
                priority: 'urgent',
                clientNotes: 'QA-Shift-Production-Test'
            })
        });

        console.log(`- Create Visit: ${createVisitRes.status}`);
        if (!createVisitRes.ok) {
            console.log(await createVisitRes.text());
        }

    } catch (err) {
        console.error('QA ERROR:', err);
    }
}

verify();
