const http = require('http');

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
        hostname: 'localhost',
        port: 8787,
        path: '/v1/auth/register',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Content-Length': data.length
        }
    };

    return new Promise((resolve, reject) => {
        const req = http.request(options, (res) => { // Use http
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
    // Seed a Service (Admin required)
    const adminLogin = await new Promise((resolve, reject) => {
        const req = http.request({
            hostname: 'localhost', port: 8787, path: '/v1/auth/login', method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        }, (res) => {
            let body = ''; res.on('data', d => body += d); res.on('end', () => resolve(JSON.parse(body)));
        });
        req.write(JSON.stringify({ email: 'admin@primecare.com', password: 'PrimeCare123!' }));
        req.end();
    });

    if (adminLogin.token) {
        console.log('Seeding Service: Senior Care...');
        const serviceData = JSON.stringify({ name: 'Senior Care', hourlyRate: 35.0, category: 'care' });
        const req = http.request({
            hostname: 'localhost', port: 8787, path: '/v1/admin/services', method: 'POST',
            headers: { 'Content-Type': 'application/json', 'Content-Length': serviceData.length, 'Authorization': `Bearer ${adminLogin.token}` }
        }, (res) => {
            let body = ''; res.on('data', d => body += d); res.on('end', () => console.log('Service Seeded:', body));
        });
        req.write(serviceData);
        req.end();
    }

    console.log('\n--- Setup Complete ---');
}

setupAll();
