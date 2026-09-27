const fs = require('fs');
const path = require('path');

const projectRoot = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';
const searchDirs = [
  path.join(projectRoot, 'packages', 'primecare_ui', 'lib', 'src', 'screens'),
  path.join(projectRoot, 'apps')
];

let checkedFiles = 0;
let violations = 0;

console.log("==================================================");
console.log("RUNNING AUTOMATED ACCESSIBILITY & DATA-CY SELECTOR LINT");
console.log("==================================================");

function getDartFiles(srcPath) {
    if (!fs.existsSync(srcPath)) return [];
    let results = [];
    const list = fs.readdirSync(srcPath);
    list.forEach(file => {
        const fullPath = path.join(srcPath, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) {
            if (!file.includes('backup') && file !== '.dart_tool') {
                results = results.concat(getDartFiles(fullPath));
            }
        } else if (file.endsWith('.dart') && !file.endsWith('.g.dart')) {
            results.push(fullPath);
        }
    });
    return results;
}

const widgetsToAudit = [
  'ElevatedButton',
  'TextButton',
  'OutlinedButton',
  'IconButton',
  'TextFormField',
  'TextField',
  'Checkbox',
  'Radio',
  'DropdownButton'
];

searchDirs.forEach(searchDir => {
    if (!fs.existsSync(searchDir)) return;
    const dartFiles = getDartFiles(searchDir);
    
    dartFiles.forEach(file => {
        checkedFiles++;
        const content = fs.readFileSync(file, 'utf8');
        const lines = content.split('\n');
        
        lines.forEach((line, idx) => {
            // Check if line contains target widgets
            const matchedWidget = widgetsToAudit.find(w => line.includes(w));
            if (matchedWidget) {
                // Look for Semantics label or key or data-cy in the nearby lines (5 lines above/below)
                const startRange = Math.max(0, idx - 5);
                const endRange = Math.min(lines.length - 1, idx + 5);
                const contextLines = lines.slice(startRange, endRange).join('\n');
                
                const hasSemantics = contextLines.includes('Semantics(') || contextLines.includes('label:') || contextLines.includes('key:');
                
                if (!hasSemantics) {
                    const relPath = path.relative(projectRoot, file);
                    console.log(`[VIOLATION] ${relPath}:${idx+1} - Widget '${matchedWidget}' is missing a testing selector / Semantics wrapper.`);
                    console.log(`  Line: ${line.trim()}`);
                    violations++;
                }
            }
        });
    });
});

console.log("==================================================");
console.log("ACCESSIBILITY SELECTORS LINT RESULTS:");
console.log(`  Total Files Audited: ${checkedFiles}`);
console.log(`  Selector Violations: {violations}`);
if (violations === 0) {
    console.log("  Status: COMPLIANT (All input elements have test selectors)");
} else {
    console.log("  Status: NON-COMPLIANT (Wrap inputs/buttons in Semantics or add key attributes)");
}
console.log("==================================================");
