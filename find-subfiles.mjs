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

const allFiles = walk('apps/web-admin/src/app/routes').filter(f => f.endsWith('.tsx') && !f.includes('__tests__'));

const dirs = {};
for (const f of allFiles) {
    const d = path.dirname(f);
    if (!dirs[d]) dirs[d] = [];
    dirs[d].push(f);
}

const unmergedDirs = [];
for (const [d, files] of Object.entries(dirs)) {
    // Only look at directories that have an index.tsx
    const hasIndex = files.some(f => path.basename(f) === 'index.tsx');
    if (hasIndex && files.length > 1) {
        // Exclude specific known exceptions if they are not pages:
        // Exclude auth routes since they are handled differently.
        if (d.includes('auth')) continue;
        // Verify if the other .tsx files are actually page subcomponents (e.g. F1-Login.tsx) or just hooks/helpers.
        const subFiles = files.filter(f => path.basename(f) !== 'index.tsx' && path.basename(f) !== 'registryMeta.tsx' && path.basename(f) !== 'pipelineConfig.tsx');
        if (subFiles.length > 0) {
            unmergedDirs.push({ dir: d, subFiles });
        }
    }
}

console.log(`Found ${unmergedDirs.length} directories with unmerged subfiles.`);
for (const {dir, subFiles} of unmergedDirs) {
    console.log(`\nDirectory: ${dir}`);
    for (const f of subFiles) {
        console.log(`  - ${path.basename(f)}`);
    }
}
