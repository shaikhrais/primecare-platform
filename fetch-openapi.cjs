const { spawn } = require('child_process');
const fs = require('fs');
const http = require('http');

console.log("Starting wrangler dev...");
const worker = spawn('npx', ['wrangler', 'dev'], {
    cwd: 'apps/worker-api',
    shell: true
});

let fetched = false;

function tryFetch() {
    if (fetched) return;
    
    http.get('http://localhost:8787/openapi.json', (res) => {
        if (res.statusCode === 200) {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => {
                fs.writeFileSync('backend-openapi.json', data);
                console.log("Successfully intercepted openapi.json - writing to disk!");
                fetched = true;
                worker.kill('SIGINT');
                setTimeout(() => process.exit(0), 1000);
            });
        } else {
            // Not ready or error
            res.resume();
            setTimeout(tryFetch, 1000);
        }
    }).on('error', (err) => {
        // Connection refused - not up yet
        setTimeout(tryFetch, 1000);
    });
}

worker.stdout.on('data', (data) => {
    const text = data.toString();
    if (text.includes('Ready on http://localhost:8787') || text.includes('Starting local server')) {
        console.log("Worker is booting. Polling...");
        setTimeout(tryFetch, 1000);
    }
});

// timeout just in case
setTimeout(() => {
    if (!fetched) {
        console.log("Timeout waiting for OpenAPI spec");
        worker.kill('SIGINT');
        process.exit(1);
    }
}, 30000);
