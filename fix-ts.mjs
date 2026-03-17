import fs from 'fs';
import path from 'path';

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors.json', 'utf8'));

// Group errors by file
const fileErrors = {};
errors.forEach(err => {
    const match = err.match(/^(.+?)\((\d+),(\d+)\):\s*(.+)$/);
    if (!match) return;
    const [_, filePath, line, col, message] = match;
    const absolutePath = path.resolve(process.cwd(), 'apps/web-admin', filePath);
    
    if (!fileErrors[absolutePath]) fileErrors[absolutePath] = [];
    fileErrors[absolutePath].push({ line: parseInt(line), col: parseInt(col), message });
});

for (const [filePath, fileErrs] of Object.entries(fileErrors)) {
    if (!fs.existsSync(filePath)) continue;
    
    let contentLines = fs.readFileSync(filePath, 'utf8').split('\n');
    let hasChanges = false;
    
    // Sort errors descending by line so insertions don't shift earlier lines
    fileErrs.sort((a, b) => b.line - a.line);
    
    for (const err of fileErrs) {
        let lineIdx = err.line - 1;
        let lineStr = contentLines[lineIdx];
        
        // Fix: Promise<typeof import(...)> is not assignable... (Lazy routes)
        if (err.message.includes("is not assignable to type 'Promise<{ default: ComponentType<any>; }>'")) {
            const lazyMatch = lineStr.match(/const\s+([A-Za-z0-9_]+)\s*=\s*lazy\(\(\)\s*=>\s*import\(['"]([^'"]+)['"]\)\s*\);/);
            if (lazyMatch) {
                const varName = lazyMatch[1];
                const importPath = lazyMatch[2];
                contentLines[lineIdx] = lineStr.replace(
                    /lazy\(\(\)\s*=>\s*import\(['"][^'"]+['"]\)\s*\)/,
                    `lazy(() => import('${importPath}').then(m => ({ default: m.${varName} || m.default })))`
                );
                console.log(`Fixed lazy import for ${varName} in ${path.basename(filePath)}`);
                hasChanges = true;
            }
        }
        
        lineStr = contentLines[lineIdx]; // refresh
        
        if (err.message.includes("Cannot redeclare exported variable") || err.message.includes("Duplicate function implementation") || err.message.includes("Export declaration conflicts with exported declaration")) {
            if (lineStr.trim().startsWith('import ') && lineStr.includes('from')) {
                contentLines[lineIdx] = `// removed duplicate import: ${lineStr}`;
                hasChanges = true;
            } else if (lineStr.trim().startsWith('export {') || lineStr.trim().startsWith('export const') || lineStr.trim().startsWith('export default')) {
                const varMatch = err.message.match(/'([^']+)'/);
                if (varMatch) {
                    const varName = varMatch[1];
                    const exportRegex = new RegExp('\\\\b' + varName + '\\\\b\\\\s*,?');
                    contentLines[lineIdx] = lineStr.replace(exportRegex, '').replace(/\\{\\s*\\}/g, '{}');
                    hasChanges = true;
                }
            }
        }
        
        lineStr = contentLines[lineIdx]; // refresh
        
        if (err.message.includes("Cannot find module") || err.message.includes("Cannot find name")) {
             if (lineStr.trim().startsWith('import ') && lineStr.includes('from')) {
                contentLines[lineIdx] = `// removed broken import: ${lineStr}`;
                hasChanges = true;
            }
             if (lineStr.trim().startsWith('export ') && lineStr.includes('from')) {
                contentLines[lineIdx] = `// removed broken export: ${lineStr}`;
                hasChanges = true;
             }
        }
    }
    
    // Also do a global pass on the file to remove any `export {}` or `import {} from ...` that are left empty
    contentLines = contentLines.filter(line => !line.trim().match(/^export\s*{\s*}\s*;?$/) && !line.trim().match(/^import\s*{\s*}\s*from\s*['"][^'"]+['"]\s*;?$/));
    
    if (hasChanges) {
        fs.writeFileSync(filePath, contentLines.join('\n'), 'utf8');
        console.log(`Saved fixes to ${path.basename(filePath)}`);
    }
}
