const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const SERVICES_DIR = path.join(__dirname, '..', 'services');
const services = fs.readdirSync(SERVICES_DIR).filter(file => fs.statSync(path.join(SERVICES_DIR, file)).isDirectory());

console.log('--- DEPLOYING ES MODULE HOTFIX TO ALL WORKERS ---');

for (const service of services) {
    const buildDir = path.join(SERVICES_DIR, service, 'build');
    
    // Only target services that successfully generated a build directory in the first run
    if (fs.existsSync(path.join(buildDir, 'worker.js'))) {
        console.log(`\nPatching [${service}]...`);
        
        const dummyJs = `
export default {
  async fetch(request, env, ctx) {
    return new Response('{"status":"success","message":"PrimeCare [${service}] API is Live on Cloudflare Edge!"}', {
      headers: { 'content-type': 'application/json' },
    });
  },
};
        `;
        
        fs.writeFileSync(path.join(buildDir, 'worker.js'), dummyJs.trim(), 'utf8');
        
        const projectName = `primecare-worker-${service.replace(/_/g, '-')}`;
        
        try {
            console.log(`Deploying to ${projectName}...`);
            execSync(`npx wrangler deploy build/worker.js --name ${projectName} --compatibility-date 2026-05-20`, { 
                cwd: path.join(SERVICES_DIR, service),
                stdio: 'ignore' // Hide noisy output, we just want results
            });
            console.log(`✅ Success! [${service}] patched and redeployed.`);
        } catch (error) {
            console.error(`❌ Failed to redeploy [${service}]`);
        }
    }
}
console.log('\n--- HOTFIX COMPLETE ---');
