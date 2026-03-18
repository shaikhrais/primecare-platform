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

const allFiles = walk('apps/web-admin/src/app/routes').filter(f => f.endsWith('.tsx') && !f.includes('__tests__'));

const badFiles = allFiles.filter(f => {
    const content = fs.readFileSync(f, 'utf8');
    // Skip routing and meta files
    if (f.endsWith('Routes.tsx') || f.includes('Imports.ts') || f.endsWith('registryMeta.tsx') || f.endsWith('pipelineConfig.tsx')) return false;
    
    // Look for raw JSX return
    if (content.match(/return\s*\(/) || content.match(/return\s*</)) {
        if (content.includes('<PageTemplate')) return false;
        if (content.includes('<Outlet') || content.includes('<Routes') || content.includes('<Navigate') || content.includes('createRoot')) return false;
        return true;
    }
    return false;
});

console.log('--- RAW JSX FILES ---');
console.log('Count:', badFiles.length);
badFiles.forEach(f => console.log('  ' + f));


const dirs = {};
allFiles.forEach(f => {
    const d = path.dirname(f);
    if (!dirs[d]) dirs[d] = [];
    dirs[d].push(f);
});

const splitDirs = Object.entries(dirs).filter(([d, files]) => {
    // Only care if it has an index.tsx
    const hasIndex = files.some(f => path.basename(f) === 'index.tsx');
    // And it has more than just index.tsx and some meta file
    const otherComponents = files.filter(f => {
        const base = path.basename(f);
        return base !== 'index.tsx' && base !== 'registryMeta.tsx' && base !== 'pipelineConfig.tsx';
    });
    return hasIndex && otherComponents.length > 0;
});


console.log('\n--- SPLIT DIRECTORIES ---');
console.log('Count:', splitDirs.length);
splitDirs.forEach(([d, files]) => {
    console.log(d);
    files.forEach(f => console.log('  ' + path.basename(f)));
});
