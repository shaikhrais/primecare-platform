const https = require('https');

const API_HOST = 'primecare-api.itpro-mohammed.workers.dev';
const EMAIL = 'reset_test_' + Date.now() + '@primecare.com';
const PASSWORD = 'password123';
const NEW_PASSWORD = 'newpassword123';

function request(method, path, body) {
    return new Promise((resolve, reject) => {
        const options = {
            hostname: API_HOST,
            port: 443,
            path: path,
            method: method,
            headers: {
                'Content-Type': 'application/json',
            }
        };

        const req = https.request(options, (res) => {
            let data = '';
            res.on('data', (chunk) => data += chunk);
            res.on('end', () => {
                try {
                    const json = JSON.parse(data);
                    resolve({ status: res.statusCode, body: json });
                } catch (e) {
                    resolve({ status: res.statusCode, body: data });
                }
            });
        });

        req.on('error', reject);
        if (body) req.write(JSON.stringify(body));
        req.end();
    });
}

async function runTest() {
    console.log(`Setting up test user: ${EMAIL}`);

    // 1. Register
    let res = await request('POST', '/v1/auth/register', { email: EMAIL, password: PASSWORD, role: 'client' });
    console.log('Register:', res.status, res.body.error || 'OK');
    if (res.status !== 201 && res.status !== 200) process.exit(1);

    // 2. Forgot Password
    console.log('Requesting reset token...');
    res = await request('POST', '/v1/auth/forgot-password', { email: EMAIL });
    console.log('Forgot Password:', res.status, res.body);

    const token = res.body.debug_token;
    if (!token) {
        console.error('No debug_token returned (ensure worker-api was deployed with mock email logic)');
        process.exit(1);
    }

    // 3. Reset Password
    console.log(`Resetting password with token: ${token}`);
    res = await request('POST', '/v1/auth/reset-password', { token: token, newPassword: NEW_PASSWORD });
    console.log('Reset Password:', res.status, res.body);
    if (res.status !== 200) process.exit(1);

    // 4. Login with Old Password (should fail)
    console.log('Attempting login with OLD password...');
    res = await request('POST', '/v1/auth/login', { email: EMAIL, password: PASSWORD });
    console.log('Login (Old):', res.status, res.status === 401 ? 'Failed (Correct)' : 'Unexpected Success');

    // 5. Login with New Password (should succeed)
    console.log('Attempting login with NEW password...');
    res = await request('POST', '/v1/auth/login', { email: EMAIL, password: NEW_PASSWORD });
    console.log('Login (New):', res.status, res.body.token ? 'Success' : 'Failed');
}

runTest().catch(console.error);
