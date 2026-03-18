const fs = require('fs');
const path = require('path');

const projectRoot = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';
const targetFiles = JSON.parse(fs.readFileSync(path.join(projectRoot, 'standalone-files.json'), 'utf8'));

let mergeCount = 0;

targetFiles.forEach(file => {
    const fullPath = path.resolve(projectRoot, file);
    if (!fs.existsSync(fullPath)) return;
    
    const dir = path.dirname(fullPath);
    const indexFile = path.join(dir, 'index.tsx');
    
    let indexContent = fs.existsSync(indexFile) ? fs.readFileSync(indexFile, 'utf8') : '';
    
    if (!fs.existsSync(indexFile)) {
        indexContent = `import React from 'react';\nimport { PageTemplate } from '@/shared/components/ui/PageTemplate';\n\n`;
    }

    let content = fs.readFileSync(fullPath, 'utf8');
    
    // Strip out repetitive React / PageTemplate imports
    content = content.replace(/import React(?:.*?)from 'react';\n?/g, '');
    content = content.replace(/import \{ PageTemplate \} from '@\/shared\/components\/ui\/PageTemplate';\n?/g, '');
    
    let componentMatch = content.match(/export default function\s+([A-Za-z0-9_]+)/);
    if (componentMatch) {
        content = content.replace(/export default function/, 'export function');
    } else {
         const defaultExportMatch = content.match(/export default ([A-Za-z0-9_]+)/);
         if (defaultExportMatch) {
             content = content.replace(new RegExp(`^export default ${defaultExportMatch[1]};?`, 'm'), '');
             content = content.replace(new RegExp(`const ${defaultExportMatch[1]}\\s*=`), `export const ${defaultExportMatch[1]} =`);
             content = content.replace(new RegExp(`function ${defaultExportMatch[1]}\\s*\\(`), `export function ${defaultExportMatch[1]}(`);
             content = content.replace(new RegExp(`class ${defaultExportMatch[1]}\\s*\\{`), `export class ${defaultExportMatch[1]} {`);
         }
    }
    
    // Avoid dropping the exact same block multiple times if rerunning
    if (!indexContent.includes(`// --- Merged from ${path.basename(file)} ---`)) {
        indexContent += `\n// --- Merged from ${path.basename(file)} ---\n${content.trim()}\n`;
        fs.writeFileSync(indexFile, indexContent, 'utf8');
    }
    
    try { fs.unlinkSync(fullPath); } catch(e) {}
    mergeCount++;
    console.log(`Merged ${path.basename(file)} into ${path.basename(dir)}/index.tsx`);
});

console.log('Total files merged:', mergeCount);
