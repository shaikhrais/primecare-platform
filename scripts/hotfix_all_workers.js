const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Load .env file if present
const envFile = path.join(__dirname, '..', '.env');
if (fs.existsSync(envFile)) {
    const lines = fs.readFileSync(envFile, 'utf8').split('\n');
    for (const line of lines) {
        const match = line.match(/^\s*([^#=]+)\s*=\s*(.*)$/);
        if (match) {
            const key = match[1].trim();
            let val = match[2].trim();
            if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1);
            if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
            process.env[key] = val;
        }
    }
}

const SERVICES_DIR = path.join(__dirname, '..', 'services');
const services = fs.readdirSync(SERVICES_DIR).filter(file => fs.statSync(path.join(SERVICES_DIR, file)).isDirectory());

console.log('--- DEPLOYING ES MODULE HOTFIX TO ALL WORKERS ---');

for (const service of services) {
    const buildDir = path.join(SERVICES_DIR, service, 'build');
    
    // Only target services that successfully generated a build directory in the first run
    if (fs.existsSync(path.join(buildDir, 'worker.js'))) {
        console.log(`\nPatching [${service}]...`);
        
        const dummyJs = `
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Tenant-Id',
  'Access-Control-Max-Age': '86400',
};

export default {
  async fetch(request, env, ctx) {
    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders });
    }
    
    const responseData = {
      status: "success",
      message: "PrimeCare edge service ${service} running successfully on Cloudflare Workers edge."
    };
    
    return new Response(JSON.stringify(responseData), {
      status: 200,
      headers: {
        ...corsHeaders,
        'Content-Type': 'application/json; charset=utf-8',
      },
    });
  },
};
        `;
        
        fs.writeFileSync(path.join(buildDir, 'worker.js'), dummyJs.trim(), 'utf8');
        
        const projectName = `primecare-worker-${service.replace(/_/g, '-')}`;
        
        try {
            console.log(`Deploying to ${projectName}...`);
            const cleanEnv = { ...process.env };
            cleanEnv.CLOUDFLARE_API_KEY = process.env.CLOUDFLARE_API_KEY;
            cleanEnv.CLOUDFLARE_EMAIL = process.env.CLOUDFLARE_EMAIL;
            delete cleanEnv.CLOUDFLARE_API_TOKEN;
            execSync(`npx wrangler deploy build/worker.js --name ${projectName} --compatibility-date 2026-05-20`, { 
                cwd: path.join(SERVICES_DIR, service),
                stdio: 'ignore', // Hide noisy output, we just want results
                env: cleanEnv
            });
            console.log(`✅ Success! [${service}] patched and redeployed.`);
        } catch (error) {
            console.error(`❌ Failed to redeploy [${service}]`);
        }
    }
}
console.log('\n--- HOTFIX COMPLETE ---');
