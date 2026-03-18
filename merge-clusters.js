const fs = require('fs');
const path = require('path');

const projectRoot = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';

const dirsList = [
    'apps/web-admin/src/app/routes/platform/admin/pages/ai',
    'apps/web-admin/src/app/routes/platform/admin/pages/audit-export',
    'apps/web-admin/src/app/routes/platform/admin/pages/authorizations',
    'apps/web-admin/src/app/routes/platform/admin/pages/claims',
    'apps/web-admin/src/app/routes/platform/admin/pages/consent',
    'apps/web-admin/src/app/routes/platform/admin/pages/evv',
    'apps/web-admin/src/app/routes/platform/admin/pages/knowledge-base',
    'apps/web-admin/src/app/routes/platform/admin/pages/ops',
    'apps/web-admin/src/app/routes/platform/admin/pages/referrals',
    'apps/web-admin/src/app/routes/platform/admin/pages/reseller',
    'apps/web-admin/src/app/routes/platform/admin/pages/security',
    'apps/web-admin/src/app/routes/platform/admin/pages/setup',
    'apps/web-admin/src/app/routes/platform/admin/pages/webhooks',
    'apps/web-admin/src/app/routes/platform/dam/pages/analytics',
    'apps/web-admin/src/app/routes/platform/dam/pages/content',
    'apps/web-admin/src/app/routes/platform/dam/pages/design',
    'apps/web-admin/src/app/routes/platform/dam/pages/governance',
    'apps/web-admin/src/app/routes/platform/dam/pages/media',
    'apps/web-admin/src/app/routes/platform/dam/pages/security',
    'apps/web-admin/src/app/routes/platform/dam/pages/workflows',
    'apps/web-admin/src/app/routes/platform/marketing/pages/b2b',
    'apps/web-admin/src/app/routes/platform/marketing/pages/brand',
    'apps/web-admin/src/app/routes/platform/marketing/pages/pipeline',
    'apps/web-admin/src/app/routes/platform/marketing/pages/retention',
    'apps/web-admin/src/app/routes/platform/marketing/pages/seo',
    'apps/web-admin/src/app/routes/platform/scrum-master/pages/audit',
    'apps/web-admin/src/app/routes/platform/scrum-master/pages/flows',
    'apps/web-admin/src/app/routes/shared/pages/error',
    'apps/web-admin/src/app/routes/tenancy/client/pages/support',
    'apps/web-admin/src/app/routes/tenancy/manager/pages/finance',
    'apps/web-admin/src/app/routes/tenancy/rn/pages/mar',
    'apps/web-admin/src/app/routes/tenancy/rn/pages/rai',
    'apps/web-admin/src/app/routes/tenancy/staff/pages/operations'
];

let mergeCount = 0;

dirsList.forEach(dir => {
    const fullDir = path.resolve(projectRoot, dir);
    if (!fs.existsSync(fullDir)) return;
    
    const files = fs.readdirSync(fullDir).filter(f => f.endsWith('.tsx') && !f.endsWith('index.tsx') && !f.includes('registryMeta') && !f.includes('pipelineConfig') && !f.includes('Imports.ts') && !f.endsWith('Routes.tsx') && !f.endsWith('router.tsx'));
    if (files.length === 0) return;
    
    const indexFile = path.join(fullDir, 'index.tsx');
    let indexContent = fs.existsSync(indexFile) ? fs.readFileSync(indexFile, 'utf8') : '';
    
    if (!fs.existsSync(indexFile)) {
        indexContent = `import React from 'react';\nimport { PageTemplate } from '@/shared/components/ui/PageTemplate';\n\n`;
    }

    files.forEach(file => {
        let content = fs.readFileSync(path.join(fullDir, file), 'utf8');
        
        // Strip out repetitive React / PageTemplate imports
        content = content.replace(/import React(?:.*?)from 'react';\n?/g, '');
        content = content.replace(/import \{ PageTemplate \} from '@\/shared\/components\/ui\/PageTemplate';\n?/g, '');
        
        let componentMatch = content.match(/export default function\s+([A-Za-z0-9_]+)/);
        if (componentMatch) {
            content = content.replace(/export default function/, 'export function');
        } else {
             const defaultExportMatch = content.match(/export default ([A-Za-z0-9_]+)/);
             if (defaultExportMatch) {
                 content = content.replace(new RegExp(`^export default ${defaultExportMatch[1]};?`, 'm'), '');
                 content = content.replace(new RegExp(`const ${defaultExportMatch[1]}\\s*=`), `export const ${defaultExportMatch[1]} =`);
                 content = content.replace(new RegExp(`function ${defaultExportMatch[1]}\\s*\\(`), `export function ${defaultExportMatch[1]}(`);
                 content = content.replace(new RegExp(`class ${defaultExportMatch[1]}\\s*\\{`), `export class ${defaultExportMatch[1]} {`);
             }
        }
        
        indexContent += `\n// --- Merged from ${file} ---\n${content.trim()}\n`;
    });
    
    fs.writeFileSync(indexFile, indexContent, 'utf8');
    
    files.forEach(file => {
        fs.unlinkSync(path.join(fullDir, file));
    });
    
    mergeCount++;
    console.log(`Merged ${files.length} files in ${dir}`);
});

console.log('Total directories merged:', mergeCount);
