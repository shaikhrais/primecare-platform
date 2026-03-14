// Using native fetch

const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';
const EMAIL = 'psw.a@primecare.ca';
const PASSWORD = 'admin123';

async function verifyOffers() {
    process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
    try {
        console.log(`1. Logging in as ${EMAIL}...`);
        const loginRes = await fetch(`${API_URL}/v1/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: EMAIL, password: PASSWORD })
        });

        if (!loginRes.ok) {
            throw new Error(`Login failed: ${loginRes.status} ${await loginRes.text()}`);
        }

        const { token } = await loginRes.json();
        console.log('✅ Login Successful');

        console.log('2. Fetching Open Offers...');
        const offersRes = await fetch(`${API_URL}/v1/psw/schedule/offers`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (!offersRes.ok) {
            throw new Error(`Failed to fetch offers: ${offersRes.status} ${await offersRes.text()}`);
        }

        const offers = await offersRes.json();
        console.log(`🔍 Found ${offers.length} Open Offers:`);
        console.log(JSON.stringify(offers, null, 2));

        if (offers.length > 0) {
            console.log('✅ VERIFICATION PASSED: Open offers are visible via API.');
        } else {
            console.log('❌ VERIFICATION FAILED: No open offers found for this PSW.');
        }

    } catch (err) {
        console.error('💥 Error:', err.message);
    }
}

verifyOffers();
