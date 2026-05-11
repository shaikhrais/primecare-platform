const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const services = [
  'auth-api',
  'api-gateway',
  'provider-api',
  'client-api',
  'scheduling-api',
  'visit-api',
  'notes-api',
  'billing-api',
  'notification-api',
  'compliance-api',
  'franchise-reporting-api'
];

services.forEach(service => {
  const servicePath = path.join(process.cwd(), 'services', service);
  if (fs.existsSync(servicePath)) {
    console.log(`\n--- Deploying ${service} ---`);
    try {
      // Use --commit-dirty=true to avoid git warnings
      execSync('npx wrangler deploy --commit-dirty=true', {
        cwd: servicePath,
        stdio: 'inherit'
      });
      console.log(`Successfully deployed ${service}`);
    } catch (err) {
      console.error(`Failed to deploy ${service}: ${err.message}`);
    }
  }
});
