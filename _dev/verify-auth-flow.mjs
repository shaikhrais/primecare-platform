const url = 'https://primecare-api.itpro-mohammed.workers.dev/v1/auth/register';
const email = 'manager.test@primecare.ca';
const role = 'manager';
const password = 'admin123';

async function registerTest() {
    console.log(`Registering ${email} as ${role}...`);
    try {
        const response = await fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email,
                password,
                role,
                tenantName: 'PrimeCare Toronto',
                tenantSlug: 'prime-toronto'
            })
        });
        const data = await response.json();
        console.log(`Status ${response.status}:`, JSON.stringify(data));

        if (response.status === 201 || (response.status === 400 && data.error === 'User already exists')) {
            console.log('Now testing login for the new/existing account...');
            const loginUrl = 'https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login';
            const logResp = await fetch(loginUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email, password })
            });
            console.log(`Login Status ${logResp.status}:`, await logResp.json());
        }
    } catch (err) {
        console.error(`Error:`, err);
    }
}

registerTest();
