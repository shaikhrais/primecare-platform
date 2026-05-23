// Governance - Category: service | Purpose: ========================================== CI/CD Architectural Governance Gate ======================================...
import https from "https";
import http from "http";

// ==========================================
// CI/CD Architectural Governance Gate
// ==========================================

const API_ENDPOINT = process.env.VERIFICATION_API_URL || "https://primecare-verification-service.itpro-mohammed.workers.dev/v1/verifications/purpose-report";

async function fetchPurposeReport(): Promise<any> {
    return new Promise((resolve, reject) => {
        const client = API_ENDPOINT.startsWith("https") ? https : http;
        
        client.get(API_ENDPOINT, (res) => {
            let data = "";
            res.on("data", chunk => data += chunk);
            res.on("end", () => {
                if (res.statusCode && res.statusCode >= 200 && res.statusCode < 300) {
                    try {
                        resolve(JSON.parse(data));
                    } catch (e) {
                        reject(new Error("Invalid JSON response from Verification Service"));
                    }
                } else {
                    reject(new Error(`Verification Service returned status ${res.statusCode}: ${data}`));
                }
            });
        }).on("error", reject);
    });
}

async function runArchitecturalGate() {
    console.log("==========================================");
    console.log("🛡️  PRIMECARE ARCHITECTURAL GATE 🛡️");
    console.log("==========================================");
    console.log(`Connecting to Verification Service Telemetry at: ${API_ENDPOINT}`);
    
    try {
        const report = await fetchPurposeReport();

        if (!report.success) {
            console.error("❌ Gate Failed: The verification service returned an error state.");
            process.exit(1);
        }

        const missingCount = report.layerStatus?.flaggedFunctionsWithoutAPIs || 0;
        const missingComponents = report.layerStatus?.missingComponents || [];

        console.log(`✅ C4 Enterprise Domains Scanned: ${report.c4Topology?.length || 0}`);
        
        if (missingCount > 0) {
            console.error(`\n❌ ARCHITECTURAL DRIFT DETECTED: The system contains ${missingCount} unimplemented or disconnected components!`);
            console.error("This violates the strict zero-latency structural governance policy.\n");
            
            missingComponents.forEach((anomaly: any, idx: number) => {
                console.error(`  [Anomaly ${idx + 1}] Entity: ${anomaly.title}`);
                console.error(`    - Route Context: ${anomaly.route}`);
                console.error(`    - Justification: ${anomaly.justification}`);
                console.log(""); // Spacing
            });

            console.error("ACTION REQUIRED: You must implement the corresponding API endpoints or remove the unresolved architectural intents before deploying.");
            console.error("Failing CI/CD Pipeline.");
            process.exit(1);
        }

        console.log("\n✅ STRUCTURAL PARITY VERIFIED: All code purposes align with their technical implementation.");
        console.log("✅ CI/CD Pipeline Approved for Deployment.");
        process.exit(0);

    } catch (e: any) {
        console.error("❌ Fatal Error connecting to Verification Governance Gateway:", e.message);
        console.error("The deployment cannot proceed without an architectural sign-off.");
        process.exit(1);
    }
}

runArchitecturalGate();
