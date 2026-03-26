import fetch from 'node-fetch';

async function run() {
  try {
    const res = await fetch('https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login', {
      method: 'POST',
      headers: {
        'Origin': 'https://primecare-mobile.pages.dev',
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: JSON.stringify({ email: 'founder@primecare.com', password: 'pwd' })
    });
    const text = await res.text();
    console.log("STATUS:", res.status);
    console.log("BODY:", text);
  } catch (e) {
    console.error("ERROR:", e);
  }
}

run();
