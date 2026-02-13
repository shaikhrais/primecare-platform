const url = 'https://primecare-api.itpro-mohammed.workers.dev/v1/auth/register';
const email = 'rn.a@primecare.ca';
const role = 'rn';
const password = 'admin123';

async function registerRN() {
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
    } catch (err) {
        console.error(`Error registering ${email}:`, err);
    }
}

registerRN();
