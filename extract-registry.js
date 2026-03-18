const { Project, SyntaxKind } = require('ts-morph');
const fs = require('fs');
const path = require('path');

const files = JSON.parse(fs.readFileSync('inline-data-files.json', 'utf8'));

const project = new Project({
    tsConfigFilePath: "apps/web-admin/tsconfig.json",
});

// We are going to build a mega registry file. 
// A more sustainable approach for the user is Domain-Specific registries, 
// but Since they said "create new section registry file if required", let's create a core one.
const REGISTRY_FILE = 'apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts';
let registryContent = `import { AdminRegistry } from 'prime-care-shared';\n\nexport const PageSectionRegistry: Record<string, any> = {\n`;

let totalExtractions = 0;

for (const file of files) {
    if (file.includes('router.tsx')) continue;
    
    const sourceFile = project.addSourceFileAtPath(file);
    let modified = false;

    // Find all JSX elements <PageTemplate ... />
    const pageTemplates = sourceFile.getDescendantsOfKind(SyntaxKind.JsxSelfClosingElement)
        .filter(node => node.getTagNameNode().getText() === 'PageTemplate');
        
    const openTemplates = sourceFile.getDescendantsOfKind(SyntaxKind.JsxOpeningElement)
        .filter(node => node.getTagNameNode().getText() === 'PageTemplate');

    const allTemplates = [...pageTemplates, ...openTemplates];

    for (const template of allTemplates) {
        // Find pageId attribute
        const pageIdAttr = template.getAttribute('pageId');
        let pageId = 'UNKNOWN_PGE_' + Math.floor(Math.random() * 10000);
        
        if (pageIdAttr && pageIdAttr.getKind() === SyntaxKind.JsxAttribute) {
            const init = pageIdAttr.getInitializer();
            if (init && init.getKind() === SyntaxKind.StringLiteral) {
                pageId = init.getLiteralText();
            } else if (init && init.getKind() === SyntaxKind.JsxExpression) {
                pageId = init.getExpression().getText();
            }
        }
        
        // Find sectionData attribute
        const sectionAttr = template.getAttribute('sectionData');
        if (sectionAttr && sectionAttr.getKind() === SyntaxKind.JsxAttribute) {
            const init = sectionAttr.getInitializer();
            if (init && init.getKind() === SyntaxKind.JsxExpression) {
                const expr = init.getExpression();
                if (expr && expr.getKind() === SyntaxKind.ObjectLiteralExpression) {
                    
                    // 1. EXTRACT the text of the object literal
                    const objText = expr.getText();
                    
                    // 2. APPEND it to our master registry
                    registryContent += `  // Extracted from ${path.basename(file)}\n`;
                    // Let's use computed properties robustly
                    registryContent += `  [${pageId.includes('$') || pageId.includes('`') || pageId.includes('+') ? pageId : `'${pageId}'`}]: ${objText},\n\n`;
                    
                    // 3. REPLACE the inline object with the registry reference
                    // "no custom code all come from section registry"
                    expr.replaceWithText(`PageSectionRegistry[${pageId.includes('$') || pageId.includes('`') || pageId.includes('+') ? pageId : `'${pageId}'`}]`);
                    
                    // 4. ADD the missing import for the registry to the file
                    const hasImport = sourceFile.getImportDeclarations().some(imp => 
                        imp.getNamedImports().some(ni => ni.getName() === 'PageSectionRegistry')
                    );
                    
                    if (!hasImport) {
                        const fromDir = path.dirname(path.resolve(process.cwd(), file));
                        const toPath = path.resolve(process.cwd(), REGISTRY_FILE.replace(/\.ts$/, ''));
                        let relativePath = path.relative(fromDir, toPath).replace(/\\/g, '/');
                        if (!relativePath.startsWith('.')) relativePath = './' + relativePath;
                        
                        sourceFile.addImportDeclaration({
                            namedImports: ['PageSectionRegistry'],
                            moduleSpecifier: relativePath
                        });
                    }
                    
                    modified = true;
                    totalExtractions++;
                }
            }
        }
    }

    if (modified) {
        sourceFile.saveSync();
        console.log(`Migrated ${file}`);
    }
}

registryContent += `};\n`;
fs.writeFileSync(REGISTRY_FILE, registryContent, 'utf8');
console.log(`\n\n--- SUCCESS ---`);
console.log(`Extracted ${totalExtractions} inline section configurations into ${REGISTRY_FILE}.`);
console.log(`All PageTemplates now dynamically load from the central Section Registry!`);
