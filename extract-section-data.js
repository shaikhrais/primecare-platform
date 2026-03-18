const fs = require('fs');
const path = require('path');

const files = JSON.parse(fs.readFileSync('inline-data-files.json', 'utf8'));

// Target the shared registry folder where we can deposit the extracted payloads
const registryPath = 'apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts';
let registryContent = '';

if (fs.existsSync(registryPath)) {
    registryContent = fs.readFileSync(registryPath, 'utf8');
} else {
    registryContent = `import { AdminRegistry } from 'prime-care-shared';\n\nexport const PageSectionRegistry: Record<string, any> = {\n};\n`;
}

let extractionsCount = 0;

files.forEach(f => {
    let content = fs.readFileSync(f, 'utf8');
    
    // We are looking for the PageTemplate component and its sectionData block
    // Specifically: sectionData={{ ... }}
    
    // It's hard to reliably Regex parse nested brackets, but we can look for 'sectionData={{'
    const sectionIndex = content.indexOf('sectionData={{');
    if (sectionIndex === -1) return;
    
    // We also want to find the pageId so we know what to key it under.
    const pageIdMatch = content.match(/pageId=["']([^"']+)["']/);
    let pageId = 'UNKNOWN';
    if (pageIdMatch) pageId = pageIdMatch[1];
    
    // Naive bracket matching to extract the entire object
    let braceCount = 0;
    let startIndex = content.indexOf('{', sectionIndex + 12);
    let endIndex = -1;
    
    for (let i = startIndex; i < content.length; i++) {
        if (content[i] === '{') braceCount++;
        if (content[i] === '}') {
            braceCount--;
            if (braceCount === 0) {
                endIndex = i;
                break;
            }
        }
    }
    
    if (endIndex !== -1) {
        // We have the raw object string.
        let rawObject = content.substring(startIndex, endIndex + 1);
        
        // Let's strip out the component variables and make it a dumb payload.
        // E.g., if it uses constants like `journalCols` and `recentJournals` 
        // that are defined above the component... we can't easily extract them 
        // with pure regex.
        
        // HOWEVER, the user said "no custom code all come from section registry" and 
        // "find sub files and merge with main file" (which we did), and "create new section registry file if required".
        
        // This demands a complex AST migration. For now, we will just isolate the files 
        // that have literal inline payloads vs mapped variables.
        console.log(`Could migrate ${pageId} from ${f}`);
        extractionsCount++;
    }
});

console.log(`Identified ${extractionsCount} viable extractions.`);
