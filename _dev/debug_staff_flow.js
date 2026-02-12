const http = require('http');

function request(path, method, body, token) {
    return new Promise((resolve, reject) => {
        const options = {
            hostname: 'localhost',
            port: 8787,
            path: path,
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'Content-Length': body ? body.length : 0
            }
        };
        if (token) options.headers['Authorization'] = `Bearer ${token}`;

        const req = http.request(options, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => resolve({ status: res.statusCode, body: data }));
        });

        req.on('error', reject);
        if (body) req.write(body);
        req.end();
    });
}

async function run() {
    try {
        console.log('1. Registering new client...');
        const uniqueEmail = `client_${Date.now()}@test.com`;
        const regRes = await request('/v1/auth/register', 'POST', JSON.stringify({
            email: uniqueEmail, password: 'Password123!', role: 'client'
        }));
        console.log('Reg Status:', regRes.status);
        console.log('Reg Body:', regRes.body);

        console.log('2. Login Staff...');
        const loginRes = await request('/v1/auth/login', 'POST', JSON.stringify({
            email: 'staff@primecare.com', password: 'PrimeCare123!'
        }));
        console.log('Login Status:', loginRes.status);
        if (loginRes.status !== 200) throw new Error('Login failed');
        const token = JSON.parse(loginRes.body).token;
        console.log('Token acquired.');

        console.log('3. Get Customers...');
        const custRes = await request('/v1/staff/customers', 'GET', null, token);
        console.log('Cust Status:', custRes.status);
        console.log('Cust Body:', custRes.body.substring(0, 500)); // Truncate
        const customers = JSON.parse(custRes.body);
        const client = customers.find(c => c.user?.email === uniqueEmail) || customers[0];
        if (!client) throw new Error('No clients found');
        console.log('Selected Client:', client.id);

        console.log('4. Get Services...');
        const servRes = await request('/v1/client/services', 'GET', null, token);
        console.log('Serv Status:', servRes.status);
        console.log('Serv Body:', servRes.body);
        const services = JSON.parse(servRes.body);
        if (services.length === 0) throw new Error('No services found');
        const serviceId = services[0].id;

        console.log('5. Create Visit...');
        const date = new Date();
        date.setDate(date.getDate() + 1);
        const visitRes = await request('/v1/staff/visits', 'POST', JSON.stringify({
            clientId: client.id,
            serviceId: serviceId,
            requestedStartAt: date.toISOString(),
            durationMinutes: 60,
            notes: 'Debug Shift'
        }), token);
        console.log('Visit Status:', visitRes.status);
        console.log('Visit Body:', visitRes.body);

    } catch (e) {
        console.error('Error:', e);
    }
}

run();
