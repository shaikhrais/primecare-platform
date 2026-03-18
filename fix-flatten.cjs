const fs = require('fs');
const path = require('path');

const ROUTES_DIR = path.join(__dirname, 'apps/web-admin/src/app/routes');
const DOMAINS = ['auth', 'shared', 'tenancy', 'platform'];

// 1. Fix router.tsx eager imports
const routerPath = path.join(__dirname, 'apps/web-admin/src/app/router.tsx');
let routerContent = fs.readFileSync(routerPath, 'utf8');
routerContent = routerContent.replace(/from\s+['"]\.\/routes\/shared\/error['"]/g, "from './routes/shared'");
routerContent = routerContent.replace(/import\s*\(\s*['"]\.\/routes\/shared\/.*?['"]\s*\)/g, "import('./routes/shared')");
routerContent = routerContent.replace(/import\s*\(\s*['"]\.\/routes\/platform\/.*?['"]\s*\)/g, "import('./routes/platform')");
fs.writeFileSync(routerPath, routerContent);

// 2. Fix RequireRole.tsx
const requireRolePath = path.join(__dirname, 'apps/web-admin/src/shared/rbac/RequireRole.tsx');
if (fs.existsSync(requireRolePath)) {
    let rrContent = fs.readFileSync(requireRolePath, 'utf8');
    rrContent = rrContent.replace(/@\/app\/routes\/shared\/error/g, "@/app/routes/shared");
    fs.writeFileSync(requireRolePath, rrContent);
}

// 3. Fix ViewsAndGeo.test.ts
const testPath = path.join(__dirname, 'apps/web-admin/src/test/ViewsAndGeo.test.ts');
if (fs.existsSync(testPath)) {
    let testContent = fs.readFileSync(testPath, 'utf8');
    testContent = testContent.replace(/['"]\.\.\/app\/routes\/auth\/.*?['"]/g, "'../app/routes/auth'");
    fs.writeFileSync(testPath, testContent);
}

// 4. Fix Duplicate declarations in the flattened files
DOMAINS.forEach(domain => {
    const filePath = path.join(ROUTES_DIR, `${domain}.tsx`);
    if (!fs.existsSync(filePath)) return;

    let lines = fs.readFileSync(filePath, 'utf8').split('\n');
    let newLines = [];
    
    // Tracking sets
    let seenConsts = new Set();
    let seenFunctions = new Set();
    let seenImports = new Set();
    
    let inTenancyImportsBlock = false;

    for (let i = 0; i < lines.length; i++) {
        let line = lines[i];
        let trimmed = line.trim();

        // Remove duplicate imports
        if (line.startsWith('import ') && line.includes('from')) {
            // Very naive import dedupe - works if they are exact
            if (seenImports.has(trimmed)) continue;
            seenImports.add(trimmed);
        }

        // Remove duplicated Registry declarations
        const constMatch = trimmed.match(/^const\s+(\{[\s\S]*?\}|[a-zA-Z0-9_]+)\s*=\s*AdminRegistry;/);
        if (constMatch) {
            if (seenConsts.has('AdminRegistry')) continue;
            seenConsts.add('AdminRegistry');
        }

        const urlMatch = trimmed.match(/^const\s+(API_URL(_1)?)\s*=/);
        if (urlMatch) {
            if (seenConsts.has(urlMatch[1])) continue;
            seenConsts.add(urlMatch[1]);
        }
        
        const sysMatch = trimmed.match(/^const\s+SystemPolicies\s*=/);
        if (sysMatch) {
            if (seenConsts.has('SystemPolicies')) continue;
            seenConsts.add('SystemPolicies');
        }

        // Deal with `export function AlliedHealthDashboard` vs `export function AlliedHealthDashboard`
        // Wait, if it's identical functions exported multiple times, we just throw away the second one.
        const funcMatch = trimmed.match(/^export\s+(?:async\s+)?function\s+([a-zA-Z0-9_]+)\s*\(/);
        if (funcMatch) {
            const funcName = funcMatch[1];
            if (seenFunctions.has(funcName)) {
                // Skip this function block
                let braceCount = 0;
                let started = false;
                while (i < lines.length) {
                    let fLine = lines[i];
                    if (fLine.includes('{')) { started = true; braceCount += (fLine.match(/\{/g) || []).length; }
                    if (fLine.includes('}')) { braceCount -= (fLine.match(/\}/g) || []).length; }
                    if (started && braceCount <= 0) break;
                    i++;
                }
                continue;
            }
            seenFunctions.add(funcName);
        }

        // Remove any remaining bad imports (like internal file types or unresolved stuff)
        if (trimmed.startsWith('import ') && trimmed.includes("from './")) {
            // These shouldn't have been left, but if they are (like import { TableColumn } from './shared')
            // we ignore for now, compiler will flag them later.
        }

        newLines.push(line);
    }

    // Now write it back
    fs.writeFileSync(filePath, newLines.join('\n'));
});

// Also manually fix shared.tsx duplicate TableColumn and PageTemplate if they exist
const sharedPath = path.join(ROUTES_DIR, 'shared.tsx');
if (fs.existsSync(sharedPath)) {
    let content = fs.readFileSync(sharedPath, 'utf8');
    content = content.replace(/export\s+interface\s+TableColumn[\s\S]*?\}\s*;/g, (match, offset, str) => {
        // Only keep the first one
        if (str.indexOf(match) === offset) return match;
        return '';
    });
    fs.writeFileSync(sharedPath, content);
}

// Let's strip React duplicate imports that somehow survived earlier (identically named but differently spaced)
DOMAINS.forEach(domain => {
    const filePath = path.join(ROUTES_DIR, `${domain}.tsx`);
    if (!fs.existsSync(filePath)) return;
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Collapse duplicate `import React from 'react';`
    content = content.replace(/(import\s+React\s+from\s+['"]react['"];\s*){2,}/g, "import React from 'react';\n");
    // Collapse duplicate `import { PageTemplate...`
    content = content.replace(/(import\s+\{\s*PageTemplate\s*\}\s+from\s+['"].*?['"];\s*){2,}/g, "import { PageTemplate } from '@/shared/components/ui/PageTemplate';\n");
    // AppLayout
    content = content.replace(/(import\s+AppLayout\s+from\s+['"].*?['"];\s*){2,}/g, "import AppLayout from '@/shared/components/layout/AppLayout';\n");

    fs.writeFileSync(filePath, content);
});

console.log("Cleanup attempted.");
