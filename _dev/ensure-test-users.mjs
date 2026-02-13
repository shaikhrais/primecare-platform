import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client'];
const passwordHash = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'; // admin123

async function main() {
    console.log('--- ENSURING TEST USERS ---');

    // Find or create tenant
    let tenant = await prisma.tenant.findUnique({ where: { slug: 'prime-toronto' } });
    if (!tenant) {
        console.log('Creating tenant: prime-toronto');
        tenant = await prisma.tenant.create({
            data: {
                name: 'PrimeCare Toronto',
                slug: 'prime-toronto',
                status: 'active'
            }
        });
    }

    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        console.log(`Processing ${email}...`);

        try {
            const user = await prisma.user.upsert({
                where: { email },
                update: {
                    passwordHash,
                    status: 'active'
                },
                create: {
                    email,
                    passwordHash,
                    roles: [role] as any,
                    tenantId: tenant.id,
                    status: 'active'
                }
            });
            console.log(`  v SUCCESS: ${user.email} (ID: ${user.id})`);

            // Ensure profiles exist
            if (role === 'psw') {
                await prisma.pswProfile.upsert({
                    where: { userId: user.id },
                    update: {},
                    create: {
                        userId: user.id,
                        fullName: 'Walker PSW A',
                        tenantId: tenant.id,
                        isApproved: true
                    }
                });
            } else if (role === 'client') {
                await prisma.clientProfile.upsert({
                    where: { userId: user.id },
                    update: {},
                    create: {
                        userId: user.id,
                        fullName: 'John Client A',
                        tenantId: tenant.id
                    }
                });
            }
        } catch (err) {
            console.error(`  x FAILED ${email}:`, err.message);
        }
    }

    console.log('---------------------------');
}

main()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
