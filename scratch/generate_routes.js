const fs = require('fs');
const path = require('path');

const routesDir = path.join(__dirname, '../packages/worker-api/src/routes');
const premiumRoutesFile = path.join(routesDir, 'premium.ts');

if (!fs.existsSync(routesDir)) {
  fs.mkdirSync(routesDir, { recursive: true });
}

let content = `import { Hono } from 'hono';\n\nconst premiumRoutes = new Hono();\n\n`;

for (let i = 1; i <= 125; i++) {
  content += `premiumRoutes.get('/feature-${i}', (c) => {
  return c.json({
    screenId: 'SCREEN_PREMIUM_FEATURE_${i}',
    featureName: 'PremiumFeature${i}',
    status: 'active',
    data: {
      message: 'Hydrated data for Premium Feature ${i}'
    }
  });
});\n\n`;
}

content += `export default premiumRoutes;\n`;

fs.writeFileSync(premiumRoutesFile, content);

console.log('Successfully generated 125 API endpoints in premiumRoutes.ts');
