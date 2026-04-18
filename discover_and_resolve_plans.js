// discover_and_resolve_plans.js
const { execSync } = require('child_process');

const EDGE_URL = "https://primecare-verification-service.itpro-mohammed.workers.dev";

async function runPlanDiscovery() {
    console.log("=== PrimeCare Missing Plan Discovery & Execution ===");
    console.log(`[1] Fetching missing plans from: ${EDGE_URL}/v1/verifications/missing-plans`);
    
    let res;
    try {
        res = await fetch(`${EDGE_URL}/v1/verifications/missing-plans`);
    } catch (e) {
        console.error("Network error reaching API:", e);
        process.exit(1);
    }
    
    const missingData = await res.json();
    if (!missingData.success) {
        console.error("API returned error:", missingData);
        process.exit(1);
    }

    const { missingScreensCount, missingFunctionsCount, missingScreens, missingFunctions } = missingData;

    console.log(`\nFound ${missingScreensCount} missing (unimplemented/pending) screens.`);
    console.log(`Found ${missingFunctionsCount} missing (unimplemented/pending) functionalities.`);

    if (missingScreensCount > 0 || missingFunctionsCount > 0) {
        console.log("\n[2] Anomalies detected! Executing Plan to generate/resolve components...");
        
        console.log("\n--- Triggering packages/database/prisma/seed_tracking.ts ---");
        try {
            const stdout = execSync('npx tsx packages/database/prisma/seed_tracking.ts', { stdio: 'inherit' });
        } catch (err) {
            console.error("Error executing seed_tracking.ts", err);
            process.exit(1);
        }

        console.log("--- Execution completed ---\n");

        console.log("[3] Verifying resolution...");
        const res2 = await fetch(`${EDGE_URL}/v1/verifications/missing-plans`);
        const verifyData = await res2.json();

        if (verifyData.missingScreensCount === 0 && verifyData.missingFunctionsCount === 0) {
            console.log("✅ SUCCESS: All missing components have been verified and resolved!");
        } else {
            console.log(`⚠️  WARNING: Still found ${verifyData.missingScreensCount} remaining screens and ${verifyData.missingFunctionsCount} remaining functionalities.`);
        }
    } else {
         console.log("\n[2] No missing plans detected! State is 100% synced.");
    }

    console.log("\n[4] Running full cluster Cross-Validation...");
    const cvRes = await fetch(`${EDGE_URL}/v1/verifications/cross-validate`);
    const cv = await cvRes.json();
    console.log("Cross-Validation Final Response:", cv);
    
    console.log("\n=== Plan Discovery Automation Complete ===");
}

runPlanDiscovery().catch(e => {
    console.error("Unhandled error:", e);
    process.exit(1);
});
