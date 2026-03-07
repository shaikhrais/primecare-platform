import { PrismaClient } from '../generated/client';
import readline from 'readline';

const prisma = new PrismaClient();

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const question = (query: string) => new Promise<string>((resolve) => rl.question(query, resolve));

async function main() {
    console.log('\n--- PrimeCare OSM CLI ---');
    console.log('1. Link User to OSM ID (Create if missing)');
    console.log('2. List Users with OSM IDs');
    console.log('3. List ALL Project Users (Emails)');
    console.log('4. Unlink OSM ID from User');
    console.log('5. Exit');

    const choice = await question('\nSelect an option: ');

    switch (choice) {
        case '1':
            const email = await question('Enter user email: ');
            const osmId = await question('Enter OSM ID to link: ');

            try {
                // Check if user exists first
                let user = await prisma.user.findUnique({ where: { email } });

                if (!user) {
                    console.log(`User ${email} not found. Creating new user...`);
                    const tenant = await prisma.tenant.findFirst();
                    if (!tenant) throw new Error('No tenant found to associate user with. Please seed the DB first.');

                    user = await prisma.user.create({
                        data: {
                            email,
                            osmId,
                            tenantId: tenant.id,
                            roles: ['client'],
                            status: 'active'
                        }
                    });
                    console.log(`Success! Created and linked new user: ${email}`);
                } else {
                    await prisma.user.update({
                        where: { email },
                        data: { osmId }
                    });
                    console.log(`Success! Linked existing user ${email} to OSM ID ${osmId}`);
                }
            } catch (error: any) {
                console.error('Error:', error.message);
            }
            break;

        case '2':
            const linkedUsers = await prisma.user.findMany({
                where: { osmId: { not: null } },
                select: { email: true, osmId: true, roles: true }
            });
            console.log('\n--- Linked OSM Users ---');
            console.table(linkedUsers);
            break;

        case '3':
            const allUsers = await prisma.user.findMany({
                select: { email: true, roles: true, createdAt: true }
            });
            console.log('\n--- All System Users ---');
            console.table(allUsers);
            break;

        case '4':
            const unlinkEmail = await question('Enter user email to unlink: ');
            try {
                await prisma.user.update({
                    where: { email: unlinkEmail },
                    data: { osmId: null }
                });
                console.log(`Success! Unlinked ${unlinkEmail} from OSM.`);
            } catch (error: any) {
                console.error('Error:', error.message);
            }
            break;

        case '5':
            rl.close();
            process.exit(0);

        default:
            console.log('Invalid choice.');
    }

    rl.close();
    await prisma.$disconnect();
}

main().catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
});
