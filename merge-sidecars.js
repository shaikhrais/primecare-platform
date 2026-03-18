const fs = require('fs');
const path = require('path');

function getLeafDirs(dir) {
    let results = [];
    if (!fs.existsSync(dir)) return [];
    const list = fs.readdirSync(dir);
    
    let hasDirs = false;
    let onlyFiles = [];

    list.forEach(f => {
        const full = path.join(dir, f);
        if (fs.statSync(full).isDirectory()) {
            hasDirs = true;
            results = results.concat(getLeafDirs(full));
        } else {
            onlyFiles.push(full);
        }
    });

    if (!hasDirs && onlyFiles.length > 0) {
        results.push({ dir, files: onlyFiles });
    }
    return results;
}

const leafDirs = getLeafDirs('apps/web-admin/src/app/routes');

let processCount = 0;

leafDirs.forEach(leaf => {
    const dirName = path.basename(leaf.dir);
    const parentDir = path.dirname(leaf.dir);
    const targetFile = path.join(parentDir, dirName + '.tsx');
    
    // Ignore meta paths that aren't routing endpoints
    if (['components', 'hooks', 'layouts', 'utils', 'styles', 'assets', 'api'].includes(dirName)) return;

    if (fs.existsSync(targetFile)) {
        let parentContent = fs.readFileSync(targetFile, 'utf8');
        let appendedCode = '\n// --- Merged sidecars ---\n';
        
        leaf.files.forEach(f => {
            const ext = path.extname(f);
            const base = path.basename(f);
            
            if (ext === '.ts' || ext === '.tsx') {
                let code = fs.readFileSync(f, 'utf8');
                
                // Strip absolute and relative imports to prevent duplicate API client bugs
                // We'll trust the main file has most of them, or they are duplicate hooks
                code = code.replace(/^import\s+.*$/gm, '');
                
                appendedCode += `\n/* Merged from ${base} */\n${code}\n`;
                
                // Remove the import from the parent file!
                // e.g. import { useLedgerData } from './security/useLedgerData'
                const relImportRegex = new RegExp(`import\\s+{[^}]+}\\s+from\\s+['"]\\.\\/${dirName}\\/${base.replace(/\.tsx?$/, '')}['"];?`, 'g');
                parentContent = parentContent.replace(relImportRegex, '');
            }
            
            // Just delete the sidecar
            fs.unlinkSync(f);
        });
        
        fs.writeFileSync(targetFile, parentContent + appendedCode, 'utf8');
        fs.rmdirSync(leaf.dir);
        processCount++;
        console.log(`Merged and destroyed folder: ${leaf.dir}`);
    } else {
        // If there's no matching parent file, maybe they belong to a different structure
        // But let's log it
        console.log(`Skipped ${leaf.dir} - No matching ${targetFile} found`);
    }
});

console.log(`Successfully merged ${processCount} deep folders directly into their parent feature components.`);
