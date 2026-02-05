const fetch = require('node-fetch');

const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';

async function run() {
    try {
        console.log('1. Registering/Logging in Client...');
        const email = `test.client.${Date.now()}@example.com`;
        const regRes = await fetch(`${API_URL}/v1/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email,
                password: 'Password@123',
                role: 'client',
                fullName: 'Client Test'
            })
        });

        if (!regRes.ok) {
            const err = await regRes.text();
            throw new Error(`Reg failed: ${regRes.status} - ${err}`);
        }
        const token = (await regRes.json()).token;

        console.log('2. Testing GET /v1/client/services...');
        const res = await fetch(`${API_URL}/v1/client/services`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (!res.ok) {
            const err = await res.text();
            throw new Error(`Request failed: ${res.status} - ${err}`);
        }
        const data = await res.json();
        console.log('   ✅ Success! Found services:', data.length);

    } catch (error) {
        console.error('FAILED:', error.message);
        process.exit(1);
    }
}

run();
