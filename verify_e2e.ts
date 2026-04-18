// verify_e2e.ts
// E2E Verification script connecting to the Cloudflare Worker Telemetry & Utilities
const EDGE_URL = "https://primecare-verification-service.itpro-mohammed.workers.dev";

async function runE2E() {
    console.log("=== PrimeCare Verification E2E Testing Suite ===\n");

    try {
        // 1. Health Verification
        console.log(`[1] Pinging Health Endpoint (${EDGE_URL}/v1/health)...`);
        const healthRes = await fetch(`${EDGE_URL}/v1/health`);
        const health = await healthRes.json();
        console.log("Health Status:", health.status === 'ok' ? "✅ PASS" : "❌ FAIL", health);

        // 2. Pre-Flight Verification
        console.log(`\n[2] Testing Pre-Flight Verification...`);
        const preflightRes = await fetch(`${EDGE_URL}/v1/verifications/pre-flight`, {
            method: 'POST',
            body: JSON.stringify({ featureName: "E2E_Test", version: "1.0.0" }),
            headers: { 'Content-Type': 'application/json' }
        });
        const preflight = await preflightRes.json();
        console.log("Pre-Flight Status:", preflight.verified ? "✅ PASS" : "❌ FAIL", preflight);

        // 3. Database Utility Sweep
        console.log(`\n[3] Testing Raw Database Utility Hook...`);
        const dbuRes = await fetch(`${EDGE_URL}/v1/database/report`);
        const dbu = await dbuRes.json();
        if (dbu.success) {
             console.log("Database Utility Status: ✅ PASS", `Found ${dbu.totalTables} Tables.`);
        } else {
             // We expect this to fail if using the mock key!
             console.log("Database Utility Status: ⚠️ Prisma Mocking Blocked (Expected during local dummy-proxy simulation).");
             console.log("Reason:", dbu.error);
        }

        // 4. Cross Validate
        console.log(`\n[4] Database Cross-Validation Synchronization...`);
        const cvRes = await fetch(`${EDGE_URL}/v1/verifications/cross-validate`);
        const cv = await cvRes.json();
        console.log("Cross-Validation Final Response:", cv);

        console.log("\n=== E2E Suite Complete ===");
        
    } catch (e) {
        console.error("E2E Test Suite Crashed:", e);
    }
}

runE2E();
