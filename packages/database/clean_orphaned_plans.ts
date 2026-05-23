// Governance - Category: service | Purpose: Delete all ScreenFunctionality that are unimplemented or pending Delete all PlatformScreen that are unimplemented or ...
import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function cleanOrphaned() {
    console.log("Cleaning orphaned screens and functions...");
    
    // Delete all ScreenFunctionality that are unimplemented or pending
    const deletedFuncs = await prisma.screenFunctionality.deleteMany({
        where: {
            status: { in: ['unimplemented', 'pending'] }
        }
    });
    console.log(`Deleted ${deletedFuncs.count} orphaned functionalities.`);
    
    // Delete all PlatformScreen that are unimplemented or pending
    const deletedScreens = await prisma.platformScreen.deleteMany({
        where: {
            status: { in: ['unimplemented', 'pending'] }
        }
    });
    console.log(`Deleted ${deletedScreens.count} orphaned screens.`);
}

cleanOrphaned()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
