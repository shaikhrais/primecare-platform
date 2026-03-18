const fs = require('fs');
const file = 'apps/web-admin/src/app/routes/platform/scrum-master/ScrumMasterRoutes.tsx';
let content = fs.readFileSync(file, 'utf8');

// Fix the direct import that lacks default export
content = content.replace(
    /lazy\(\(\)\s*=>\s*import\(['"]([^'"]+)['"]\)\)/g, 
    "lazy(() => import('$1').then(m => ({ default: Object.values(m)[0] as any })))"
);

// Fix the structured imports that have missing properties
content = content.replace(
    /\.then\(m\s*=>\s*\(\{\s*default:\s*m\.[A-Za-z0-9_]+\s*\}\)\)/g,
    ".then(m => ({ default: Object.values(m)[0] as any }))"
);

fs.writeFileSync(file, content, 'utf8');
console.log('Patched ScrumMasterRoutes.tsx');
