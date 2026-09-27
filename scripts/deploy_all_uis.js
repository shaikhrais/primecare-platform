const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const APPS_DIR = path.join(__dirname, '..', 'apps');
const apps = fs.readdirSync(APPS_DIR).filter(file => fs.statSync(path.join(APPS_DIR, file)).isDirectory());

console.log('--- STARTING MASSIVE CLOUDFLARE DEPLOYMENT ---');

let successCount = 0;
let failCount = 0;

for (const app of apps) {
    console.log(`\nDeploying [${app}] to Cloudflare Pages...`);
    
    // We assume the web build already exists in apps/<app_name>/build/web
    const webBuildPath = path.join(APPS_DIR, app, 'build', 'web');
    
    if (fs.existsSync(webBuildPath)) {
        try {
            // Replace underscores with hyphens for Cloudflare project name rules
            const projectName = app.replace(/_/g, '-');
            
            // Execute real wrangler deployment
            const output = execSync(`wrangler pages deploy build/web --project-name ${projectName} --commit-dirty=true`, { 
                cwd: path.join(APPS_DIR, app),
                encoding: 'utf8'
            });
            
            console.log(`✅ Success! [${app}] is live at https://${projectName}.pages.dev`);
            successCount++;
        } catch (error) {
            console.error(`❌ Failed to deploy [${app}]:`, error.message);
            failCount++;
        }
    } else {
        console.log(`⚠️ Skipping [${app}]: No build/web directory found. Run flutter build web first.`);
    }
}

console.log('\n--- MASTER DEPLOYMENT COMPLETE ---');
console.log(`Successfully Deployed: ${successCount}`);
console.log(`Failed: ${failCount}`);
