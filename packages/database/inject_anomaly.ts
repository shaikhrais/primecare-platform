// Governance - Category: service | Purpose: ========================================== TEST SCRIPT: Inject Architectural Anomaly ================================...
// ==========================================
// TEST SCRIPT: Inject Architectural Anomaly
// ==========================================

import { PrismaClient } from './generated/client';
const prisma = new PrismaClient();

async function injectTestAnomaly() {
    console.log("Starting anomaly injection...");

    try {
        // 1. Fetch a valid role to bind the screen to (using the CTO role for testing)
        const role = await prisma.platformRole.findFirst();

        if (!role) {
            console.error("No valid admin role found to attach the anomaly. Make sure DB is seeded.");
            return;
        }

        // 2. Create an intentionally 'unimplemented' screen
        const newScreen = await prisma.platformScreen.create({
            data: {
                roleId: role.id,
                name: "AI Analytics Forecasting System",
                route: "/clinical/ai-analytics",
                status: "unimplemented", // Puts it on the radar
                description: "TEST: This is a simulated pending feature to observe architectural flag telemetry.",
                
                // 3. Inject missing functionality (apiEndpoint missing + status unimplemented)
                functions: {
                    create: {
                        title: "Generate Q3 Financial Extrapolations",
                        status: "unimplemented", 
                        isCore: true,
                        // Deliberately skipped: apiEndpoint
                    }
                }
            },
            include: { functions: true }
        });

        console.log("Successfully injected new missing Screen:", newScreen.name);
        console.log("Successfully injected new missing Function:", newScreen.functions[0].title);
        console.log("--> This will now automatically flag in your Architectural Planning Dashboard.");

    } catch (e) {
        console.error("Failed to inject anomaly:", e);
    } finally {
        await prisma.$disconnect();
    }
}

injectTestAnomaly();
