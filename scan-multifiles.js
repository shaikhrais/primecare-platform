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

const dirs = {};
allFiles.forEach(f => {
    const d = path.dirname(f);
    if (!dirs[d]) dirs[d] = [];
    dirs[d].push(f);
});

const multiFilesDirs = Object.entries(dirs).filter(([d, files]) => {
    const tsxFiles = files.filter(f => {
        const base = path.basename(f);
        return !base.endsWith('registryMeta.tsx') && 
               !base.endsWith('pipelineConfig.tsx') && 
               !base.includes('Imports.ts') && 
               !base.endsWith('Routes.tsx') && 
               !base.endsWith('router.tsx');
    });
    return tsxFiles.length > 1;
});

console.log('Directories with multiple .tsx files:', multiFilesDirs.length);
multiFilesDirs.forEach(([d, files]) => {
    console.log(d);
    files.forEach(f => console.log('  ' + path.basename(f)));
});
