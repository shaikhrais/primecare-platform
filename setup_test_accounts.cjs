const https = require('https');

const accounts = [
    { email: 'admin@primecare.com', password: 'PrimeCare123!', role: 'admin' },
    { email: 'staff@primecare.com', password: 'PrimeCare123!', role: 'staff' },
    { email: 'client@primecare.com', password: 'PrimeCare123!', role: 'client' },
    { email: 'psw@primecare.com', password: 'PrimeCare123!', role: 'psw' }
];

async function registerAccount(account) {
    console.log(`Registering ${account.role}: ${account.email}...`);
    const data = JSON.stringify(account);

    const options = {
        hostname: 'primecare-api.itpro-mohammed.workers.dev',
        port: 443,
        path: '/v1/auth/register',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Content-Length': data.length
        }
    };

    return new Promise((resolve, reject) => {
        const req = https.request(options, (res) => {
            let responseBody = '';
            res.on('data', (d) => { responseBody += d; });
            res.on('end', () => {
                console.log(`Status: ${res.statusCode}`);
                console.log(`Response: ${responseBody}`);
                resolve();
            });
        });

        req.on('error', (error) => {
            console.error(`Error for ${account.email}:`, error);
            reject(error);
        });

        req.write(data);
        req.end();
    });
}

async function setupAll() {
    for (const account of accounts) {
        try {
            await registerAccount(account);
        } catch (e) {
            console.error(`Failed to register ${account.email}`);
        }
    }
    console.log('\n--- Setup Complete ---');
}

setupAll();
