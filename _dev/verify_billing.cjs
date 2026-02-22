// const fetch = require('node-fetch');

const API_URL = 'http://127.0.0.1:8787';

async function run() {
    try {
        console.log('1. Registering/Logging in Client...');
        const email = `test.client.billing.${Date.now()}@example.com`;
        const regRes = await fetch(`${API_URL}/v1/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email,
                password: 'Password@123',
                role: 'client',
                fullName: 'Billing Test'
            })
        });

        if (!regRes.ok) {
            const err = await regRes.text();
            throw new Error(`Reg/Login failed: ${regRes.status} - ${err}`);
        }
        const token = (await regRes.json()).token;

        console.log('2. Fetching Invoices...');
        const res = await fetch(`${API_URL}/v1/client/invoices`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (!res.ok) throw new Error(`Fetch failed: ${res.status}`);
        const data = await res.json();

        if (Array.isArray(data)) {
            console.log(`   ✅ Success! Retrieved ${data.length} invoices.`);
        } else {
            throw new Error('Response is not an array');
        }

    } catch (error) {
        console.error('FAILED:', error.message);
        process.exit(1);
    }
}

run();
