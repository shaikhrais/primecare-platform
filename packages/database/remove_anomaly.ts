// Governance - Category: service | Purpose: ========================================== TEST SCRIPT: Remove Architectural Anomaly ================================...
// ==========================================
// TEST SCRIPT: Remove Architectural Anomaly
// ==========================================

import { PrismaClient } from './generated/client';
const prisma = new PrismaClient();

async function removeTestAnomaly() {
    console.log("Removing anomaly to clear CI/CD block...");

    try {
        const deletedFunc = await prisma.screenFunctionality.deleteMany({
            where: {
                title: "Generate Q3 Financial Extrapolations"
            }
        });
        
        const deletedScreen = await prisma.platformScreen.deleteMany({
            where: {
                name: "AI Analytics Forecasting System"
            }
        });

        console.log(`Successfully removed ${deletedFunc.count} unimplemented functions.`);
        console.log(`Successfully removed ${deletedScreen.count} unimplemented screens.`);
        console.log("--> Pipeline Should Now Pass.");
    } catch (e) {
        console.error("Failed to remove anomaly:", e);
    } finally {
        await prisma.$disconnect();
    }
}

removeTestAnomaly();
