const fs = require('fs');
const path = require('path');

const ROUTES_DIR = path.join(__dirname, 'apps/web-admin/src/app/routes');

// 1. Fix router.tsx (lazy imports without default exports)
const routerPath = path.join(__dirname, 'apps/web-admin/src/app/router.tsx');
let rC = fs.readFileSync(routerPath, 'utf8');

// Replace raw import('./routes/shared') with proper lazy mapping
// e.g. const Profile = React.lazy(() => import('./routes/shared')); 
// -> const Profile = React.lazy(() => import('./routes/shared').then(m => ({ default: m.Profile })));
rC = rC.replace(/const\s+([A-Za-z0-9_]+)\s*=\s*React\.lazy\(\(\)\s*=>\s*import\(\s*['"]\.\/routes\/(shared|platform|tenancy)['"]\s*\)\s*\);/g, "const $1 = React.lazy(() => import('./routes/$2').then((m: any) => ({ default: m.$1 })));");

// Also fix KnowledgeBaseIndex etc
rC = rC.replace(/const\s+KnowledgeBaseIndex\s*=\s*React\.lazy\(\(\)\s*=>\s*import\(\s*['"]\.\/routes\/platform\/admin['"]\s*\)\.then\(m\s*=>\s*\(\{\s*default:\s*m\.KnowledgeBase\s*\}\)\)\);/g, "const KnowledgeBaseIndex = React.lazy(() => import('./routes/platform').then((m: any) => ({ default: m.KnowledgeBase })));");
rC = rC.replace(/const\s+KnowledgeBaseArticle\s*=\s*React\.lazy\(\(\)\s*=>\s*import\(\s*['"]\.\/routes\/platform\/admin['"]\s*\)\.then\(m\s*=>\s*\(\{\s*default:\s*m\.KBArticle\s*\}\)\)\);/g, "const KnowledgeBaseArticle = React.lazy(() => import('./routes/platform').then((m: any) => ({ default: m.KBArticle })));");

fs.writeFileSync(routerPath, rC);

// 2. Eradicate redundant const destructuring and exact duplicate React functions
['auth', 'shared', 'tenancy', 'platform'].forEach(domain => {
    const fPath = path.join(ROUTES_DIR, `${domain}.tsx`);
    if (!fs.existsSync(fPath)) return;
    
    let content = fs.readFileSync(fPath, 'utf8');
    
    // Fix broken imports
    content = content.replace(/['"]\.\.\/\.\.\/shared\/PageSectionRegistry['"]/g, "'./shared'");
    content = content.replace(/['"]\.\/audit-logs['"]/g, "''"); // Dead imports from old concatenation logic
    content = content.replace(/['"]\.\/sla-monitoring['"]/g, "''");
    content = content.replace(/['"]\.\.\/platform\/scrum-master['"]/g, "''");
    content = content.replace(/['"]\.\/tenants['"]/g, "''");
    content = content.replace(/['"]\.\/governance-hub['"]/g, "''");
    content = content.replace(/['"]\.\/policies['"]/g, "''");
    content = content.replace(/['"]\.\/client['"]/g, "''");
    content = content.replace(/['"]\.\.\/tenancy\/staff['"]/g, "''");
    content = content.replace(/['"]\.\/rn['"]/g, "''");

    const lines = content.split('\n');
    const newLines = [];
    
    const seenFunctions = new Set();
    let skippingFunction = false;
    let funcBraces = 0;
    
    let keptAdminRegistry = false;

    // We can also find exact full lines and only print them once
    const perfectLines = new Set();
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        const trimmed = line.trim();

        // Admin Registry destructure
        if (trimmed.startsWith('const { RouteRegistry')) {
            if (keptAdminRegistry) continue;
            keptAdminRegistry = true;
        }

        // Duplicate interfaces
        if (trimmed.startsWith('export interface TableColumn')) continue;

        // Strip exact duplicated basic let/const/imports that are identical
        if (trimmed.startsWith('const API_URL = ') || trimmed.startsWith('const API_URL_1 = ') || trimmed.startsWith('const SystemPolicies =') || trimmed.startsWith('import { PageSectionRegistry }')) {
            if (perfectLines.has(trimmed)) continue;
            perfectLines.add(trimmed);
        }

        // Function parsing
        const fMatch = line.match(/^export\s+(?:async\s+)?function\s+([A-Za-z0-9_]+)\s*\(/);
        if (fMatch) {
            const funcName = fMatch[1];
            if (seenFunctions.has(funcName)) {
                skippingFunction = true;
                funcBraces = 0;
            } else {
                seenFunctions.add(funcName);
            }
        }
        
        if (skippingFunction) {
            if (line.includes('{')) funcBraces += (line.match(/\{/g) || []).length;
            if (line.includes('}')) funcBraces -= (line.match(/\}/g) || []).length;
            if (funcBraces <= 0 && line.includes('}')) {
                skippingFunction = false; // Block ends
            }
            continue;
        }
        
        // Remove individual duplicate export statements like export { AlliedHealthHome }
        const exportMatch = trimmed.match(/^import\s+\{\s*([a-zA-Z0-9_]+)\s*\}\s*from\s*['"]\.\/.*?['"]/);
        if (exportMatch) continue; // Strip relative leftover imports
        
        newLines.push(line);
    }
    
    fs.writeFileSync(fPath, newLines.join('\n'));
});

// Final sweep of shared.tsx TableColumn
const sP = path.join(ROUTES_DIR, 'shared.tsx');
if (fs.existsSync(sP)) {
    let sC = fs.readFileSync(sP, 'utf8');
    sC = sC.replace(/export\s+interface\s+TableColumn\s*\{[\s\S]*?\}/, ''); 
    fs.writeFileSync(sP, sC);
}

console.log("Nuked duplicates.");
