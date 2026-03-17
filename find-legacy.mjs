import fs from 'fs';
import path from 'path';

function walk(dir) {
    let results = [];
    const list = fs.readdirSync(dir);
    list.forEach(file => {
        const fullPath = path.join(dir, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) {
            results = results.concat(walk(fullPath));
        } else {
            results.push(fullPath);
        }
    });
    return results;
}

const allFiles = walk('apps/web-admin/src/app/routes').filter(f => f.endsWith('.tsx') && !f.includes('__tests__') && !f.includes('auth'));

const badFiles = allFiles.filter(f => {
    const content = fs.readFileSync(f, 'utf8');
    // Skip index.tsx and AdminRoutes.tsx that act as routers or re-exports mostly, unless they are the actual page
    if (f.endsWith('AdminRoutes.tsx') || f.endsWith('StaffRoutes.tsx') || f.endsWith('tenancyImports.ts')) return false;
    
    // Check if it's a react component returning raw JSX without PageTemplate
    if (content.includes('return (') && content.includes('<') && !content.includes('PageTemplate')) {
        // Exclude strictly layout / routing / wrappers
        if (content.includes('<Outlet') || content.includes('<Routes') || content.includes('<Navigate')) {
            return false;
        }
        return true;
    }
    return false;
});

console.log('Legacy JSX files remaining:', badFiles.length);
badFiles.forEach(f => console.log('  ' + f));
