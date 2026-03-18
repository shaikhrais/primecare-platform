const { Project, SyntaxKind } = require('ts-morph');
const fs = require('fs');
const path = require('path');

const files = JSON.parse(fs.readFileSync('inline-data-files.json', 'utf8'));
const REGISTRY_FILE = 'apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts';

const project = new Project({ tsConfigFilePath: "apps/web-admin/tsconfig.json" });
const regFile = project.getSourceFileOrThrow(REGISTRY_FILE);

// Get all undefined variables from the registry
const diagnostics = project.getPreEmitDiagnostics();
const missingNames = new Set();

diagnostics.forEach(d => {
    if (d.getCode() === 2304) {
        const msg = typeof d.getMessageText() === 'string' ? d.getMessageText() : d.getMessageText().getMessageText();
        const match = msg.match(/Cannot find name '([^']+)'/);
        if (match) missingNames.add(match[1]);
    }
});

console.log(`Need to find ${missingNames.size} dangling variables...`);

let extractionBuffer = '';
let varsAdded = 0;

for (const file of files) {
    if (file.includes('router.tsx')) continue;
    const sourceFile = project.getSourceFileOrThrow(file);
    let modified = false;

    // Find all variable statements in the file
    const varStatements = sourceFile.getVariableStatements();
    
    for (const stmt of varStatements) {
        const decls = stmt.getDeclarations();
        for (const decl of decls) {
            const name = decl.getName();
            
            // If the registry needs this variable, we extract it!
            if (missingNames.has(name)) {
                // Ignore state hooks (e.g., const [activeTab, setActiveTab])
                if (decl.getInitializer() && decl.getInitializer().getText().includes('useState')) {
                    console.log(`Warning: Registry relies on state hook ${name} in ${file}. Manual fix needed.`);
                    continue;
                }
                
                // Get the full text of the variable statement
                extractionBuffer += `// Inherited from ${path.basename(file)}\n`;
                
                // Export it so other things can use it if needed, or just define it
                const isExported = stmt.isExported();
                if (!isExported) {
                    extractionBuffer += stmt.getText() + '\n\n';
                } else {
                    extractionBuffer += stmt.getText() + '\n\n';
                }
                
                // Track success
                varsAdded++;
                missingNames.delete(name);
                
                // Remove it from the original file since we are migrating it
                stmt.remove();
                modified = true;
                break; // Move to next statement
            }
        }
    }

    if (modified) {
        sourceFile.saveSync();
    }
}

console.log(`Successfully migrated ${varsAdded} variable blocks.`);

if (missingNames.size > 0) {
    console.log(`Still missing:`, Array.from(missingNames));
}

// Inject the extracted variables at the top of the registry file (after imports)
const currentRegContent = fs.readFileSync(REGISTRY_FILE, 'utf8');
const importsEnd = currentRegContent.indexOf('export const PageSectionRegistry');

const newRegContent = currentRegContent.slice(0, importsEnd) + '\n' + extractionBuffer + '\n' + currentRegContent.slice(importsEnd);
fs.writeFileSync(REGISTRY_FILE, newRegContent, 'utf8');
console.log('Registry file expanded.');
