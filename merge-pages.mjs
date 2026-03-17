import fs from 'fs';
import path from 'path';

const routesDir = path.join(process.cwd(), 'apps/web-admin/src/app/routes');

function walkDirDir(dir, callback) {
    if (!fs.existsSync(dir)) return;
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        if (fs.statSync(dirPath).isDirectory()) {
            callback(dirPath);
            walkDirDir(dirPath, callback);
        }
    });
}

function processDirs() {
    let totalMerged = 0;
    walkDirDir(routesDir, (dirPath) => {
        const files = fs.readdirSync(dirPath);
        if (files.includes('index.tsx')) {
            const indexFilePath = path.join(dirPath, 'index.tsx');
            let indexContent = fs.readFileSync(indexFilePath, 'utf8');
            let hasChanges = false;
            
            // Find other .tsx files
            const tsxFiles = files.filter(f => f.endsWith('.tsx') && f !== 'index.tsx');
            
            let mergedComponents = [];
            
            for (const tsxFile of tsxFiles) {
                const subFilePath = path.join(dirPath, tsxFile);
                const content = fs.readFileSync(subFilePath, 'utf8');
                
                // If it's a refactored PageTemplate page (short)
                if (content.includes('PageTemplate') && content.split('\n').length < 60) {
                    console.log(`Merging ${tsxFile} into index.tsx in ${path.basename(dirPath)}`);
                    totalMerged++;
                    
                    // Extract the component code.
                    let cleanContent = content.replace(/import .*?from .*?;/g, '').trim();
                    
                    // Convert export default to regular export
                    cleanContent = cleanContent.replace(/export default function ([A-Za-z0-9_]+)/, 'export function $1');
                    // Also replace export const Name = ...
                    cleanContent = cleanContent.replace(/export (const|let) ([A-Za-z0-9_]+)/, 'export $1 $2');
                    // remove "export default Name;"
                    cleanContent = cleanContent.replace(/export default [A-Za-z0-9_]+;/g, '');
                    
                    mergedComponents.push(`// --- Merged from ${tsxFile} ---\n${cleanContent}`);
                    
                    // Delete the subfile
                    fs.unlinkSync(subFilePath);
                    hasChanges = true;
                    
                    // Remove references to this file from indexContent
                    const baseName = tsxFile.replace('.tsx', '');
                    const nameRegex = new RegExp(`import .*? from ['"./]+${baseName}['"];?`, 'g');
                    indexContent = indexContent.replace(nameRegex, '');
                    
                    // Also try to remove names that might have been imported differently
                    const noPrefix = baseName.replace(/^[A-Z0-9a-z]+-/, '');
                    if (noPrefix !== baseName) {
                        const noPrefixRegex = new RegExp(`import .*? from ['"./]+${noPrefix}['"];?`, 'g');
                        indexContent = indexContent.replace(noPrefixRegex, '');
                    }
                }
            }
            
            if (hasChanges) {
                // Ensure React and PageTemplate are imported in index.tsx
                if (!indexContent.includes("import React")) {
                    indexContent = `import React from 'react';\n` + indexContent;
                }
                if (!indexContent.includes("PageTemplate")) {
                    indexContent = `import { PageTemplate } from '@/shared/components/ui/PageTemplate';\n` + indexContent;
                }
                
                fs.writeFileSync(indexFilePath, indexContent + '\n\n' + mergedComponents.join('\n\n'), 'utf8');
            }
        }
    });
    console.log(`Total files merged: ${totalMerged}`);
}

processDirs();
