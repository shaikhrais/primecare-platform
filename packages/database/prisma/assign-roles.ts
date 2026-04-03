import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
    const email = 'itpro.mohammed@gmail.com';
    const allRoles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client', 'coordinator', 'finance'];

    console.log(`Assigning all roles to ${email}...`);

    try {
        const user = await prisma.user.update({
            where: { email },
            data: {
                roles: allRoles as any
            }
        });

        console.log('Successfully updated user roles:');
        console.log(JSON.stringify(user, null, 2));
    } catch (error) {
        console.error('Error updating user roles:', error);
    } finally {
        await prisma.$disconnect();
    }
}

main();
