// Node 18+ has native fetch
const email = 'manager.a@primecare.ca';
const password = 'admin123';
const url = 'https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login';

console.log(`Attempting login for ${email} at ${url}...`);

async function testLogin() {
    try {
        const response = await fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });

        const status = response.status;
        const data = await response.json();

        console.log(`Status: ${status}`);
        console.log('Response Body:', JSON.stringify(data, null, 2));

        if (status === 200) {
            console.log('SUCCESS: Login works!');
        } else {
            console.log('FAILURE: Login failed.');
        }
    } catch (error) {
        console.error('ERROR during login test:', error);
    }
}

testLogin();
