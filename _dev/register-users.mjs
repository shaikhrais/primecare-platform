const url = 'https://primecare-api.itpro-mohammed.workers.dev/v1/auth/register';
const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client'];
const password = 'admin123';

async function registerAll() {
    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
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
}

registerAll();
