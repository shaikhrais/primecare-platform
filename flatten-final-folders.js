const fs = require('fs');
const path = require('path');

const TARGETS = [
  { dir: 'apps/web-admin/src/app/routes/auth/onboarding/components', name: '../onboarding.tsx' },
  { dir: 'apps/web-admin/src/app/routes/platform/superuser', name: '../superuser.tsx' },
  { dir: 'apps/web-admin/src/app/routes/tenancy/allied-health', name: '../allied-health.tsx' },
  { dir: 'apps/web-admin/src/app/routes/tenancy/finance', name: '../finance.tsx' },
  { dir: 'apps/web-admin/src/app/routes/tenancy/hr', name: '../hr.tsx' },
  { dir: 'apps/web-admin/src/app/routes/tenancy/marketing', name: '../marketing.tsx' },
  { dir: 'apps/web-admin/src/app/routes/tenancy/qa', name: '../qa.tsx' }
];

let mergeCount = 0;
TARGETS.forEach(target => {
    if (!fs.existsSync(target.dir)) return;

    const files = fs.readdirSync(target.dir).filter(f => f.endsWith('.tsx'));
    let mergedContent = '';
    let imports = new Set();
    let body = [];

    files.forEach(file => {
        const fullPath = path.join(target.dir, file);
        const content = fs.readFileSync(fullPath, 'utf8');
        
        // Very basic merge logic just to combine imports and append bodies
        const lines = content.split('\n');
        lines.forEach(line => {
            if (line.trim().startsWith('import ') && !line.includes('./')) {
                imports.add(line);
            } else if (!line.trim().startsWith('import ')) {
                body.push(line);
            }
        });
        
        // Remove the original file
        fs.unlinkSync(fullPath);
    });

    // Write merged file up one level
    const newPath = path.join(target.dir, target.name);
    fs.writeFileSync(newPath, Array.from(imports).join('\n') + '\n\n' + body.join('\n'));
    console.log(`Merged ${files.length} files into ${newPath}`);

    // Remove the old directory
    try {
        fs.rmdirSync(target.dir);
        if (target.dir.includes('onboarding/components')) {
            fs.rmdirSync(path.join(target.dir, '..'));
        }
        console.log(`Deleted directory ${target.dir}`);
    } catch(e) {
        console.log(`Could not delete ${target.dir}`, e.message);
    }
});
