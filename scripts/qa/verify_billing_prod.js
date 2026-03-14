const https = require('https');

const API_URL = 'primecare-api.itpro-mohammed.workers.dev';

function post(path, data) {
    return new Promise((resolve, reject) => {
        const body = JSON.stringify(data);
        const options = {
            hostname: API_URL,
            port: 443,
            path: path,
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Content-Length': body.length
            }
        };

        const req = https.request(options, (res) => {
            let resData = '';
            res.on('data', (chunk) => resData += chunk);
            res.on('end', () => resolve({ status: res.statusCode, body: resData }));
        });

        req.on('error', (e) => {
            console.error('Inner https error:', e.message);
            reject(e);
        });
        req.write(body);
        req.end();
    });
}

async function run() {
    console.log('Testing Production API connectivity via https module (CommonJS)...');
    try {
        const res = await post('/v1/auth/login', {
            email: 'manager.a@primecare.ca',
            password: 'admin123'
        });
        console.log('Status:', res.status);
        console.log('Response:', res.body);
    } catch (err) {
        console.error('HTTPS ERROR OUTSIDE:', err.message);
    }
}

run();
