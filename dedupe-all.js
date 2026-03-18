const { Project, SyntaxKind } = require('ts-morph');
const fs = require('fs');
const path = require('path');

const project = new Project({
    tsConfigFilePath: './apps/web-admin/tsconfig.json',
    skipAddingFilesFromTsConfig: true
});

const routesDir = path.join(__dirname, 'apps/web-admin/src/app/routes');

['auth.tsx', 'platform.tsx', 'tenancy.tsx', 'shared.tsx'].forEach(file => {
    project.addSourceFileAtPath(path.join(routesDir, file));
});

project.getSourceFiles().forEach(sf => {
    // 1. Remove ANY duplicate exported functions or arrow functions or constants
    const seenBindings = new Set();
    
    // First pass: register all things we keep
    
    // Functions (`export function X`)
    sf.getFunctions().forEach(f => {
        const name = f.getName();
        if (name) {
            if (seenBindings.has(name)) f.remove();
            else seenBindings.add(name);
        }
    });

    // Variables / Arrow Functions (`export const X = ...`)
    const varsToRemove = [];
    sf.getVariableStatements().forEach(vs => {
        let isCompleteDuplicate = true; // If all declarations in this var statement are duplicates
        
        vs.getDeclarations().forEach(d => {
            if (d.getNameNode().getKind() === SyntaxKind.ObjectBindingPattern) {
                // e.g. const { ApiRegistry, ... } = AdminRegistry;
                let hasFresh = false;
                d.getNameNode().getElements().forEach(el => {
                    const name = el.getName();
                    if (!seenBindings.has(name)) { hasFresh = true; seenBindings.add(name); }
                });
                if (hasFresh) isCompleteDuplicate = false;
            } else {
                const name = d.getName();
                if (!seenBindings.has(name)) {
                    isCompleteDuplicate = false;
                    seenBindings.add(name);
                }
            }
        });
        
        if (isCompleteDuplicate) {
            varsToRemove.push(vs);
        }
    });
    
    // Safely remove variables
    varsToRemove.forEach(vs => {
        try { vs.remove(); } catch(e){}
    });

    // Strip broken imports manually (ts-morph sometimes misses empty module specifiers if syntax is weird)
    sf.getImportDeclarations().forEach(imp => {
        if (imp.getModuleSpecifierValue() === '') imp.remove();
    });
    sf.getExportDeclarations().forEach(exp => {
        if (exp.hasModuleSpecifier() && exp.getModuleSpecifierValue() === '') exp.remove();
    });

});

// Specific string-replacements for weird edge cases caught by TSC
let platformTsx = project.getSourceFile('platform.tsx');
if (platformTsx) {
    let text = platformTsx.getText();
    // src/app/routes/platform.tsx(2557,160): error TS2345: Argument of type 'string' is not assignable to parameter of type '"CONNECTED" | "DISCONNECTED" | "EXPIRED"'.
    text = text.replace(/status:\s*d\.status/g, "status: d.status as 'CONNECTED' | 'DISCONNECTED' | 'EXPIRED'");
    // Delete any remaining import ... from ''
    text = text.replace(/import\s*\{\s*[A-Za-z0-9_,\s]*\s*\}\s*from\s*['"]['"];?/g, '');
    fs.writeFileSync(platformTsx.getFilePath(), text);
}

let tenancyTsx = project.getSourceFile('tenancy.tsx');
if (tenancyTsx) {
    let text = tenancyTsx.getText();
    // Delete any remaining import ... from ''
    text = text.replace(/import\s*\{\s*[A-Za-z0-9_,\s]*\s*\}\s*from\s*['"]['"];?/g, '');
    text = text.replace(/import\s*\*\s*as\s*[A-Za-z0-9_]+\s*from\s*['"]['"];?/g, '');
    text = text.replace(/import\s+type\s*\{\s*[A-Za-z0-9_,\s]*\s*\}\s*from\s*['"]['"];?/g, '');
    fs.writeFileSync(tenancyTsx.getFilePath(), text);
}

let sharedTsx = project.getSourceFile('shared.tsx');
if (sharedTsx) {
    let text = sharedTsx.getText();
    text = text.replace(/import\s*\{\s*[A-Za-z0-9_,\s]*\s*\}\s*from\s*['"]['"];?/g, '');
    fs.writeFileSync(sharedTsx.getFilePath(), text);
}

project.saveSync();
console.log('Final deduplication complete.');
