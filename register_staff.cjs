const https = require('https');

const data = JSON.stringify({
    email: 'staff@primecare.com',
    password: 'staff123',
    role: 'staff'
});

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

const req = https.request(options, (res) => {
    console.log(`Status: ${res.statusCode}`);
    res.on('data', (d) => {
        process.stdout.write(d);
    });
});

req.on('error', (error) => {
    console.error(error);
});

req.write(data);
req.end();
