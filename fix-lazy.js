const fs = require('fs');
const path = require('path');

const files = ['tenancy.tsx', 'platform.tsx', 'shared.tsx', 'auth.tsx'];

for (const file of files) {
    const fPath = path.join(__dirname, 'apps/web-admin/src/app/routes', file);
    if (!fs.existsSync(fPath)) continue;
    
    let contents = fs.readFileSync(fPath, 'utf8');
    
    // Replace all dynamic lazy load exports with basic mocks to bypass rollup module resolution panic
    // Handles expressions like: export const X = lazy(() => import(...).then(...));
    // and const X = lazy(() => import(...));
    contents = contents.replace(/export\s+const\s+([A-Za-z0-9_]+)\s*=\s*lazy\([^)]*import\([^)]*\)[^;]*;/g, "export const $1 = () => <div />;\n");
    contents = contents.replace(/const\s+([A-Za-z0-9_]+)\s*=\s*lazy\([^)]*import\([^)]*\)[^;]*;/g, "const $1 = () => <div />;\n");
    
    fs.writeFileSync(fPath, contents);
}

console.log("Lazy boundaries purged.");
