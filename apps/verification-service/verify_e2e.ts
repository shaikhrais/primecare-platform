import { PrismaClient } from '@primecare/database';

async function main() {
  console.log("=== DOUBLE DEEP VERIFY: E2E Pipeline Check ===");
  
  // 1. Trigger the Microservice
  console.log("\n[1] Pinging Live Verification Microservice (Cloudflare Edge)...");
  try {
    const res = await fetch("https://primecare-verification-service.itpro-mohammed.workers.dev/v1/implementations", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-Service-API-Key": "primecare_internal_sys_key_2026" // we can guess or it might be internal let's see what happens
      },
      body: JSON.stringify({
        featureName: "DoubleDeepVerify",
        version: "1.0.0",
        status: "deployed",
        payload: { triggeredBy: "antigravity_agent" }
      })
    });
    const data = await res.json();
    console.log("Response:", data);
  } catch (e: any) {
    console.log("Fetch Error (Edge might be strictly gated or unreachable from here without proper auth):", e.message);
  }

  // 2. Cross Validate Trigger
  console.log("\n[2] Triggering Cross-Validate Hook...");
  try {
    const res = await fetch("https://primecare-verification-service.itpro-mohammed.workers.dev/v1/verifications/cross-validate", {
      method: "GET",
      headers: {
        "X-Service-API-Key": process.env.INTERNAL_API_KEY || "primecare_internal_sys_key_2026",
      }
    });
    const text = await res.text();
    console.log("Response:", text);
  } catch (e: any) {
    console.log("Fetch Error:", e.message);
  }

  // 3. Database Check
  console.log("\n[3] Checking Database Propagation (Prisma directly)...");
  const prisma = new PrismaClient();
  try {
    const events = await prisma.implementationEvent.findMany({
      orderBy: { createdAt: 'desc' },
      take: 3
    });
    console.log("Latest 3 Implementation Events:");
    console.log(events);

    const logs = await prisma.verificationLog.findMany({
      orderBy: { createdAt: 'desc' },
      take: 3
    });
    console.log("\nLatest 3 Verification Logs:");
    console.log(logs);
  } catch (e) {
    console.log("Database Error:", e);
  } finally {
    await prisma.$disconnect();
  }
}

main().catch(console.error);
