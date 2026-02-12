const fetch = require('node-fetch');

const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';

async function run() {
    try {
        console.log('1. Registering/Logging in PSW...');
        const email = `test.psw.${Date.now()}@example.com`;
        const regRes = await fetch(`${API_URL}/v1/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email,
                password: 'Password@123',
                role: 'psw',
                fullName: 'PSW Test'
            })
        });

        if (!regRes.ok) throw new Error('Reg/Login failed');
        const token = (await regRes.json()).token;

        console.log('2. Requesting Payout...');
        const res = await fetch(`${API_URL}/v1/psw/payouts/request`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (!res.ok) {
            const err = await res.text();
            throw new Error(`Request failed: ${res.status} - ${err}`);
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
