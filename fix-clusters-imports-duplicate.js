const fs = require('fs');
const path = require('path');

const files = [
  'apps/web-admin/src/app/routes/platform/admin/pages/ai/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/claims/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/security/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/webhooks/index.tsx',
  'apps/web-admin/src/app/routes/shared/pages/error/index.tsx'
];

files.forEach(file => {
    const fullPath = path.resolve(process.cwd(), file);
    if (!fs.existsSync(fullPath)) return;
    
    let content = fs.readFileSync(fullPath, 'utf8');
    
    // Remove all TableColumn imports anywhere (multi-line or single line)
    content = content.replace(/import\s+(?:type\s+)?\{\s*TableColumn\s*\}\s*from\s*['"]@\/shared\/components\/sections.*?['"];?/g, '');
    
    // Add master import exactly once
    if (!content.includes("import type { TableColumn } from '@/shared/components/sections';")) {
        content = "import type { TableColumn } from '@/shared/components/sections';\n" + content;
    }
    
    // Revert TableColumn suffixes
    content = content.replace(/TableColumn_[0-9]+(?:_[0-9]+)?/g, 'TableColumn');
    
    // Remove any inline type TableColumn definitions just in case some legacy ones matched
    content = content.replace(/type TableColumn<T extends[^>]+>\s*=\s*\{[\s\S]*?\};\n?/g, '');
    
    // Fix any stray double exports
    content = content.replace(/export export /g, 'export ');
    content = content.replace(/export\nexport /g, 'export\n');
    
    fs.writeFileSync(fullPath, content, 'utf8');
    console.log(`Cleaned types in ${file}`);
});
