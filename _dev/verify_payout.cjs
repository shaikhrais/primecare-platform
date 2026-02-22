// const fetch = require('node-fetch');

const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';

async function run() {
    try {
        console.log('1. Registering/Logging in PSW...');
        const email = `test.psw.${Date.now()} @example.com`;
        const regRes = await fetch(`${API_URL}/v1/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email: 'test.psw.' + Math.random().toString(36).substring(7) + '@primecare.ca',
                password: 'admin123',
                role: 'psw',
                fullName: 'Test PSW'
            })
        });

        if (!regRes.ok) throw new Error('Reg/Login failed');
        const token = (await regRes.json()).token;

        console.log('2. Requesting Payout...');
        const res = await fetch(`${API_URL}/v1/psw/schedule/payouts/request`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (!res.ok) {
            const bodyText = await res.text();
            console.error('Payout Request Failed Raw Response:', bodyText); // Added logging for raw response
            throw new Error(`Request failed: ${res.status} - ${bodyText}`);
        }
        const data = await res.json();
        console.log('   Response:', data);

        if (data.success) {
            console.log('   ✅ Payout requested successfully.');
        } else {
            console.error('   ❌ Payout request failed logic.');
        }

    } catch (error) {
        console.error('FAILED:', error.message);
        process.exit(1);
    }
}

run();
