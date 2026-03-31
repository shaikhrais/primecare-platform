import { PrismaClient } from '@prisma/client';
import { withAccelerate } from '@prisma/extension-accelerate';
import crypto from 'crypto';

const prisma = new PrismaClient().$extends(withAccelerate());

async function main() {
    const password = 'password123';
    const hashBuffer = crypto.createHash('sha256').update(password).digest('hex');
    
    console.log(`[AUTH] Administrator Override`);
    console.log(`[AUTH] Resetting ALL user passwords to legacy SHA256 equivalent of '${password}' using Accelerate...`);
    
    const result = await prisma.user.updateMany({
        data: {
            passwordHash: hashBuffer
        }
    });
    
    console.log(`[AUTH] ✅ Emitted forced cryptographic rollback for ${result.count} users globally!`);
}

main().catch(e => {
    console.error(`[AUTH] ❌ Failed to reset passwords:`, e);
}).finally(async () => {
    await prisma.$disconnect();
});
