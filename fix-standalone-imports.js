const fs = require('fs');
const path = require('path');

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors-standalone.json', 'utf8'));

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
    
    // Sort descending to not mess up line numbers if we were inserting lines, 
    // though here we are just editing in place.
    errs.sort((a, b) => b.line - a.line);
    
    for (const err of errs) {
        let lineIdx = err.line - 1;
        let lineStr = lines[lineIdx];
        
        let parts = err.missingMod.split('/');
        const compFile = parts.pop();
        let newPath = parts.join('/');
        if (newPath === '') newPath = '.';
        
        let compNameMatch = compFile.match(/^[A-Z0-9]+-(.*)$/);
        let compName = compNameMatch ? compNameMatch[1] : compFile;
        // The script that merged them named them based on export default <Name> or export default function <Name>
        // If it was T7-AutoPilot, it might have been exported as AutoPilot. Let's just use regex.
        
        // Handle lazy imports: `const AutoPilotHome = lazy(() => import('./pages/automation/T7-AutoPilot'));`
        const lazyMatch1 = lineStr.match(/(?:export\s+)?const\s+([A-Za-z0-9_]+)\s*=\s*(?:React\.)?lazy\(\(\)\s*=>\s*import\(['"]([^'"]+)['"]\)\)/);
        if (lazyMatch1) {
            lineStr = lineStr.replace(/(lazy\(\(\)\s*=>\s*import\(['"][^'"]+['"]\))/g, 
               `$1.then(m => ({ default: m['${compName}'] || Object.values(m)[0] }))`);
            lineStr = lineStr.replace(new RegExp(`'${err.missingMod}'`), `'${newPath}'`);
            lines[lineIdx] = lineStr;
            changed = true;
            continue;
        }

        // Handle lazy imports already with .then(): `... import('...').then(m => ({ default: m.XYZ }))`
        const lazyMatch2 = lineStr.match(/(?:export\s+)?const\s+([A-Za-z0-9_]+)\s*=\s*(?:React\.)?lazy\(\(\)\s*=>\s*import\(['"]([^'"]+)['"]\)\.then/);
        if (lazyMatch2) {
            lineStr = lineStr.replace(new RegExp(`'${err.missingMod}'`), `'${newPath}'`);
            // we should also make sure it uses Object.values(m)[0] as a fallback just in case the name evolved
            lineStr = lineStr.replace(/\{ default:\s*m\.([A-Za-z0-9_]+)\s*\}/, `{ default: m.$1 || Object.values(m)[0] }`);
            lines[lineIdx] = lineStr;
            changed = true;
            continue;
        }
        
        // Tests await import
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
