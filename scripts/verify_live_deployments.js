const http = require('https'); // Use https since cloudflare pages/workers use SSL

console.log('--- STARTING LIVE NETWORK VERIFICATION ---');

const apiWorkers = [
    'primecare-worker-api-gateway',
    'primecare-worker-auth-api',
    'primecare-worker-billing-api',
    'primecare-worker-client-api',
    'primecare-worker-compliance-api',
    'primecare-worker-franchise-reporting-api',
    'primecare-worker-governance-api',
    'primecare-worker-notes-api',
    'primecare-worker-notification-api',
    'primecare-worker-provider-api',
    'primecare-worker-scheduling-api',
    'primecare-worker-verification-api',
    'primecare-worker-visit-api'
];

const uiPages = [
    'primecare-auth',
    'primecare-business-development',
    'primecare-client',
    'primecare-clinic',
    'primecare-corporate',
    'primecare-enterprise-blueprint',
    'primecare-franchise',
    'primecare-governance',
    'primecare-marketing',
    'primecare-support'
];

let passCount = 0;
let failCount = 0;

function checkUrl(url, name, type) {
    return new Promise((resolve) => {
        http.get(url, (res) => {
            const status = res.statusCode;
            if (status === 200) {
                console.log(`✅ [${type}] ${name} -> HTTP 200 OK (${url})`);
                passCount++;
            } else {
                console.log(`❌ [${type}] ${name} -> FAILED HTTP ${status} (${url})`);
                failCount++;
            }
            res.resume(); // consume response data to free up memory
            resolve();
        }).on('error', (e) => {
            console.log(`❌ [${type}] ${name} -> NETWORK ERROR: ${e.message} (${url})`);
            failCount++;
            resolve();
        });
    });
}

async function runTests() {
    console.log('\nTesting 13 Backend APIs (Cloudflare Workers)...');
    for (const api of apiWorkers) {
        // We use the correct subdomain based on our previous deploy
        const url = `https://${api}.itpro-mohammed.workers.dev`;
        await checkUrl(url, api, 'API');
    }

    console.log('\nTesting 10 Frontend UIs (Cloudflare Pages)...');
    for (const ui of uiPages) {
        const url = `https://${ui}.pages.dev`;
        await checkUrl(url, ui, ' UI');
    }

    console.log('\n--- VERIFICATION COMPLETE ---');
    console.log(`Total Passed: ${passCount}`);
    console.log(`Total Failed: ${failCount}`);
    
    if (failCount === 0) {
        console.log('\n🏆 MATHEMATICAL PROOF: 100% of the PrimeCare ecosystem is successfully responding on the live internet!');
    }
}

runTests();
