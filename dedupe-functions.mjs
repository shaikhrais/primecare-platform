import fs from 'fs';
import path from 'path';

const srcDir = path.join(process.cwd(), 'apps/web-admin/src');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        if (fs.statSync(dirPath).isDirectory()) {
            walkDir(dirPath, callback);
        } else if (f.endsWith('.ts') || f.endsWith('.tsx')) {
            callback(dirPath);
        }
    });
}

walkDir(srcDir, (filePath) => {
    let content = fs.readFileSync(filePath, 'utf8');
    
    const exportFuncRegex = /export\s+function\s+([a-zA-Z0-9_]+)\s*\(/g;
    let match;
    const funcCounts = {};
    while ((match = exportFuncRegex.exec(content)) !== null) {
        funcCounts[match[1]] = (funcCounts[match[1]] || 0) + 1;
    }
    
    let hasChanges = false;
    for (const [funcName, count] of Object.entries(funcCounts)) {
        if (count > 1) {
            console.log(`Duplicate function ${funcName} found in ${path.basename(filePath)} (${count} times)`);
            let occurrences = 0;
            content = content.replace(new RegExp(`export\\s+function\\s+${funcName}\\s*\\(`, 'g'), (m) => {
                occurrences++;
                if (occurrences < count) {
                     return `export function ${funcName}_OLD${occurrences}(`;
                }
                return m;
            });
            hasChanges = true;
        }
    }
    
    const missingImports = [];
    if (content.match(/TableColumn(\[\]| )/) && !content.includes("from '@/shared")) {
         if (!content.includes('interface TableColumn') && !content.includes('type TableColumn')) {
              missingImports.push("TableColumn");
         }
    }
    if (content.match(/useState\s*</) && !content.includes("useState")) missingImports.push("useState");
    if (content.match(/TabItem(\[\]| )/) && !content.includes("from '@/shared")) {
         if (!content.includes('interface TabItem') && !content.includes('type TabItem')) {
              missingImports.push("TabItem");
         }
    }
    
    if (missingImports.length > 0) {
        if (missingImports.includes('TableColumn') && !content.includes('import { TableColumn }')) {
            content = `import { TableColumn } from '@/shared/components/sections/SectionTable';\n` + content;
            hasChanges = true;
        }
        if (missingImports.includes('TabItem') && !content.includes('import { TabItem }')) {
            content = `import { TabItem } from '@/shared/components/sections/SectionTabs';\n` + content;
            hasChanges = true;
        }
        if (missingImports.includes('useState') && !content.includes('import { useState }')) {
            content = `import { useState } from 'react';\n` + content;
            hasChanges = true;
        }
    }
    
    // Also remove any rogue `export { IncidentList, IncidentEntry };` lines if they still exist at the top.
    const duplicateExports = content.match(/^export\s*\{[^}]+\}\s*;/gm);
    if (duplicateExports) {
        for (const line of duplicateExports) {
            // only remove if it's one of the functions we parsed
            for (const funcName of Object.keys(funcCounts)) {
                if (line.includes(funcName)) {
                    // It's re-exporting something we are already declaring!
                    content = content.replace(line, `// removed re-export: ${line}`);
                    hasChanges = true;
                    break;
                }
            }
        }
    }
    
    if (hasChanges) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Fixed missing imports / dupes in ${path.basename(filePath)}`);
    }
});
