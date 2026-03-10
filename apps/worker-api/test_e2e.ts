import app from './src/index';

// Polyfill minimal env for local Node execution
const mockEnv = {
    DATABASE_URL: 'file:./dev.db',
    JWT_SECRET: 'test-secret'
};

async function runE2E() {
    console.log('--- NATIVE NODE DB E2E TEST: PRIMECARE PLATFORM ---');
    console.log('[1] Testing User Registration...');

    const uniqueEmail = `test.client.${Date.now()}@primecare.com`;
    let cookieStr = '';

    const registerReq = new Request('http://localhost/v1/auth/register', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({
            email: uniqueEmail,
            password: 'SecurePassword123!',
            role: 'client',
            tenantName: 'E2E Testing Tenant',
            tenantSlug: 'e2e-tenant'
        })
    });

    const registerRes = await app.request(registerReq, {}, mockEnv);

    const regData = await registerRes.json();
    console.log('Registration Response:', registerRes.status);

    if (registerRes.status !== 201) {
        console.error('Registration Failed!', regData);
        process.exit(1);
    }

    const setCookieHeader = registerRes.headers.get('set-cookie');
    if (setCookieHeader) {
        // Extract accessToken for following requests
        const tokens = setCookieHeader.split(',').map(c => c.split(';')[0].trim());
        const at = tokens.find(t => t.startsWith('accessToken='));
        if (at) cookieStr = at;
    }

    console.log('[2] Testing User Login...');
    const loginReq = new Request('http://localhost/v1/auth/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({
            email: uniqueEmail,
            password: 'SecurePassword123!'
        })
    });

    const loginRes = await app.request(loginReq, {}, mockEnv);
    const loginData = await loginRes.json();
    console.log('Login Response:', loginRes.status);

    if (loginRes.status !== 200) {
        console.error('Login Failed!', loginData);
        process.exit(1);
    }

    console.log('[3] Fetching Profile via Authenticated Route...');
    const profileReq = new Request('http://localhost/v1/client/dashboard/profile', {
        method: 'GET',
        headers: {
            'Cookie': cookieStr,
            'X-Requested-With': 'XMLHttpRequest'
        }
    });

    const profileRes = await app.request(profileReq, {}, mockEnv);
    const profileData = await profileRes.json();
    console.log('Profile Response:', profileRes.status);
    console.log('Profile Data (Mapped from DB):', profileData);

    if (profileRes.status === 200 && profileData.userId) {
        console.log('✅ End-to-End Database Lifecycle Verified Successfully!');
    } else {
        console.error('❌ Failed to fetch authenticated profile via database.', profileData);
        process.exit(1);
    }
}

runE2E().catch(console.error);
