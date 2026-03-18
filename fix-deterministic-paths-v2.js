const fs = require('fs');
const path = require('path');

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors-deep-flatten.json', 'utf8'));
const fileLocations = JSON.parse(fs.readFileSync('file_locations.json', 'utf8'));

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
        
        // Target name resolution. E.g if missing import is '../../shared/components/error'
        let targetName = path.basename(err.missingMod);
        if (targetName === 'index') {
            const parts = err.missingMod.split('/');
            targetName = parts[parts.length - 2];
        }
        
        let dest = fileLocations[targetName];
        if (!dest) {
             console.log(`Could not find a file matching component: ${targetName} for import ${err.missingMod} in ${file}`);
             continue;
        }
        
        const fromDir = path.dirname(path.resolve(process.cwd(), fullPath));
        const toPath = path.resolve(process.cwd(), dest.replace(/\.tsx$/, ''));
        
        let relative = path.relative(fromDir, toPath).replace(/\\/g, '/');
        if (!relative.startsWith('.')) relative = './' + relative;
        
        lineStr = lineStr.replace(new RegExp(`'${err.missingMod}'`), `'${relative}'`);
        lines[lineIdx] = lineStr;
        changed = true;
    }
    
    if (changed) {
        fs.writeFileSync(fullPath, lines.join('\n'), 'utf8');
        console.log(`Patched deterministic imports in ${fullPath}`);
    }
}
