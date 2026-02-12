import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function grantAllRoles(email: string) {
    const roles = ['admin', 'staff', 'manager', 'psw', 'client', 'coordinator', 'finance'];

    try {
        const user = await prisma.user.update({
            where: { email },
            data: {
                roles: {
                    set: roles as any
                }
            }
        });
        console.log(`Successfully granted all roles to ${email}`);
        console.log(`Roles: ${user.roles.join(', ')}`);
    } catch (error) {
        console.error(`Error granting roles to ${email}:`, error);
    } finally {
        await prisma.$disconnect();
    }
}

const email = process.argv[2];
if (!email) {
    console.error('Usage: ts-node grant-all-roles.ts <email>');
    process.exit(1);
}

grantAllRoles(email);
