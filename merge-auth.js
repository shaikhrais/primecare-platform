const fs = require('fs');
const path = require('path');

const authDirs = [
    'apps/web-admin/src/app/routes/auth/pages/forgot-password',
    'apps/web-admin/src/app/routes/auth/pages/login',
    'apps/web-admin/src/app/routes/auth/pages/onboard-business',
    'apps/web-admin/src/app/routes/auth/pages/register',
    'apps/web-admin/src/app/routes/auth/pages/reset-password'
];

let mergeCount = 0;

authDirs.forEach(dir => {
    const fullDir = path.resolve(process.cwd(), dir);
    if (!fs.existsSync(fullDir)) return;
    
    const files = fs.readdirSync(fullDir);
    const subfile = files.find(f => f.match(/^[A-Z][0-9]+-.*\.tsx$/));
    const indexFile = path.join(fullDir, 'index.tsx');
    
    if (subfile && fs.existsSync(indexFile)) {
        const subContent = fs.readFileSync(path.join(fullDir, subfile), 'utf8');
        
        // Rewrite export default to export function
        let componentMatch = subContent.match(/export default function ([A-Za-z0-9_]+)/);
        let mergedContent = subContent;
        if (componentMatch) {
            mergedContent = subContent.replace(/export default function/, 'export function');
        } else {
             const defaultExportMatch = subContent.match(/export default ([A-Za-z0-9_]+)/);
             if (defaultExportMatch) {
                 mergedContent = subContent.replace(new RegExp(`export default ${defaultExportMatch[1]}.*`), '');
                 mergedContent = mergedContent.replace(`const ${defaultExportMatch[1]}`, `export function ${defaultExportMatch[1]}`);
             }
        }
        
        const finalContent = `// --- Merged from ${subfile} ---\n${mergedContent.trim()}\n`;
        fs.writeFileSync(indexFile, finalContent, 'utf8');
        fs.unlinkSync(path.join(fullDir, subfile));
        mergeCount++;
        console.log(`Merged ${subfile} into ${dir}/index.tsx`);
    }
});

console.log(`Merged ${mergeCount} auth directories.`);
