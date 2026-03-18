const fs = require('fs');
const path = require('path');

function walk(dir) {
    let results = [];
    if (!fs.existsSync(dir)) return results;
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

const allFiles = walk('apps/web-admin/src').filter(f => f.endsWith('.tsx') && !f.includes('__tests__'));

// Folders that are ALLOWED to have raw JSX because they build the fundamental UI
const allowedDirs = [
    'components',
    'ui',
    'layout',
    'sections', // The section registry itself uses raw JSX
    'context',
    'hooks',
    'assets'
];

const badFiles = allFiles.filter(f => {
    // If it's in an allowed dir, skip it
    if (allowedDirs.some(d => f.includes(`\\${d}\\`) || f.includes(`/${d}/`))) return false;
    
    // Skip routing and meta files
    if (f.endsWith('Routes.tsx') || f.includes('Imports.ts') || f.endsWith('registryMeta.tsx') || f.endsWith('pipelineConfig.tsx') || f.endsWith('router.tsx') || f.endsWith('App.tsx') || f.endsWith('main.tsx')) return false;
    
    const content = fs.readFileSync(f, 'utf8');
    
    // Look for generic raw JSX tags
    if (content.match(/return\s*\(/) || content.match(/return\s*</)) {
        if (content.includes('<PageTemplate')) return false; // Allowed
        if (content.includes('<Outlet') || content.includes('<Routes') || content.includes('<Navigate') || content.includes('createRoot')) return false; // Routing/Entry
        
        // If it returns a standard HTML tag or Fragment
        if (content.includes('<div') || content.includes('<main') || content.includes('<span') || content.includes('<form') || content.includes('<>')) {
             return true;
        }
    }
    return false;
});

console.log('--- GLOBAL RAW JSX FILES ---');
console.log('Count:', badFiles.length);
badFiles.forEach(f => console.log('  ' + f));


const dirs = {};
allFiles.forEach(f => {
    const d = path.dirname(f);
    if (!dirs[d]) dirs[d] = [];
    dirs[d].push(f);
});

const splitDirs = Object.entries(dirs).filter(([d, files]) => {
     // Skip allowed dirs
    if (allowedDirs.some(allowed => d.includes(`\\${allowed}`) || d.includes(`/${allowed}`))) return false;

    // Only care if it has an index.tsx
    const hasIndex = files.some(f => path.basename(f) === 'index.tsx');
    // And it has more than just index.tsx and some meta file
    const otherComponents = files.filter(f => {
        const base = path.basename(f);
        return base !== 'index.tsx' && base !== 'registryMeta.tsx' && base !== 'pipelineConfig.tsx';
    });
    return hasIndex && otherComponents.length > 0;
});

console.log('\n--- GLOBAL SPLIT DIRECTORIES ---');
console.log('Count:', splitDirs.length);
splitDirs.forEach(([d, files]) => {
    console.log(d);
    files.forEach(f => console.log('  ' + path.basename(f)));
});
