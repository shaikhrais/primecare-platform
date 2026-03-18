const fs = require('fs');

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors-clusters.json', 'utf8'));

const fileErrors = {};
errors.forEach(err => {
    const match = err.match(/^(.+?)\((\d+),(\d+)\):\s*error TS2307:\s*Cannot find module '([^']+)'/);
    if (!match) return;
    const [_, file, line, col, missingMod] = match;
    if (!fileErrors[file]) fileErrors[file] = [];
    fileErrors[file].push({ line: parseInt(line), col: parseInt(col), missingMod });
});

for (const [file, errs] of Object.entries(fileErrors)) {
    const fullPath = 'apps/web-admin/' + file;
    if (!fs.existsSync(fullPath)) continue;
    
    let lines = fs.readFileSync(fullPath, 'utf8').split('\n');
    let changed = false;
    
    errs.sort((a, b) => b.line - a.line);
    
    for (const err of errs) {
        let lineIdx = err.line - 1;
        let lineStr = lines[lineIdx];
        
        let parts = err.missingMod.split('/');
        parts.pop();
        let newPath = parts.join('/');
        if (newPath === '') newPath = '.';
        
        // Handle lazy imports
        const lazyMatch = lineStr.match(/(?:export\s+)?const\s+([A-Za-z0-9_]+)\s*=\s*lazy\(\(\)\s*=>\s*import\(['"]([^'"]+)['"]\)\)/);
        if (lazyMatch) {
            const compName = lazyMatch[1];
            lineStr = lineStr.replace(/lazy\(\(\)\s*=>\s*import\(['"][^'"]+['"]\)\)/, 
               `lazy(() => import('${newPath}').then(m => ({ default: m.${compName} })))`);
            lines[lineIdx] = lineStr;
            changed = true;
            continue;
        }
        
        // Handle default imports
        const defImportMatch = lineStr.match(/import\s+([A-Za-z0-9_]+)\s+from\s+['"]([^'"]+)['"]/);
        if (defImportMatch) {
            const compName = defImportMatch[1];
            lines[lineIdx] = lineStr.replace(/import\s+([A-Za-z0-9_]+)\s+from\s+['"][^'"]+['"]/, `import { ${compName} } from '${newPath}'`);
            changed = true;
            continue;
        }

        // Handle await imports (in tests)
        if (lineStr.includes('await import(')) {
            lineStr = lineStr.replace(new RegExp(`'${err.missingMod}'`), `'${newPath}'`);
            lines[lineIdx] = lineStr;
            changed = true;
            continue;
        }

        console.log(`Unpatched: ${lineStr}`);
    }
    
    if (changed) {
        fs.writeFileSync(fullPath, lines.join('\n'), 'utf8');
        console.log(`Patched imports in ${fullPath}`);
    }
}
