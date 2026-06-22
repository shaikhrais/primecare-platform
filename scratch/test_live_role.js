const AUTH_URL = "https://primecare-worker-auth-api.itpro-mohammed.workers.dev/login";

async function testRole(email, password) {
  console.log(`Sending POST request to ${AUTH_URL} for email: ${email}...`);
  try {
    const res = await fetch(AUTH_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password })
    });
    
    console.log(`Response Status: ${res.status} ${res.statusText}`);
    const text = await res.text();
    console.log(`Response Body:\n${text}`);
  } catch (err) {
    console.error(`Fetch error:`, err);
  }
}

async function main() {
  // Test both potential email configurations
  await testRole("ceo@primecare.io", "Test@12345");
  console.log("\n------------------------------------------------\n");
  await testRole("ceo@test.primecare.local", "Test@12345");
}

main();
