const fs = require('fs');
const path = require('path');

const files = [
  'apps/web-admin/src/app/router.tsx',
  'apps/web-admin/src/app/routes/platform/admin/AdminRoutes.tsx',
  'apps/web-admin/src/app/routes/platform/PlatformRoutes.tsx',
  'apps/web-admin/src/app/routes/platform/scrum-master/ScrumMasterRoutes.tsx',
  'apps/web-admin/src/app/routes/tenancy/staff/StaffRoutes.tsx',
  'apps/web-admin/src/app/routes/tenancy/tenancyImports.ts'
];

files.forEach(file => {
    const fullPath = path.resolve(process.cwd(), file);
    if (!fs.existsSync(fullPath)) return;
    
    let content = fs.readFileSync(fullPath, 'utf8');
    
    // Replace `m['ComponentName'] || Object.values(m)[0]` with `Object.values(m)[0] as any`
    content = content.replace(/m\['[^']+'\]\s*\|\|\s*Object\.values\(m\)\[0\]/g, 'Object.values(m)[0] as any');
    
    fs.writeFileSync(fullPath, content, 'utf8');
    console.log(`Cleaned lazy casts in ${file}`);
});
