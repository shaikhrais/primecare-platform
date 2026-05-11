import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function checkAnomalies() {
    try {
        const pScreens = await prisma.platformScreen.findMany({
            include: { functions: true, componentPurposes: true }
        });

        const missingImplementedConcerns = pScreens.flatMap((s: any) => 
            s.functions.map((f: any) => ({ ...f, screenName: s.name, route: s.route }))
        ).filter((f: any) => f.status === 'unimplemented' || !f.apiEndpoint);
        
        console.log(`flaggedFunctionsWithoutAPIs: ${missingImplementedConcerns.length}`);
    } catch (e) {
        console.error("Failed to check anomalies:", e);
    } finally {
        await prisma.$disconnect();
    }
}

checkAnomalies();
