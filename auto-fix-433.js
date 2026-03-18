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

// 1. Fix missing PageSectionRegistry imports
['auth.tsx', 'platform.tsx', 'tenancy.tsx'].forEach(file => {
    const sourceFile = project.getSourceFile(file);
    if (!sourceFile) return;

    // Check if imported
    const imports = sourceFile.getImportDeclarations();
    let hasPSR = false;
    imports.forEach(imp => {
        if (imp.getNamedImports().some(n => n.getName() === 'PageSectionRegistry')) {
            hasPSR = true;
        }
    });

    if (!hasPSR) {
        sourceFile.addImportDeclaration({
            namedImports: ['PageSectionRegistry'],
            moduleSpecifier: './shared'
        });
        console.log(`Injected PageSectionRegistry into ${file}`);
    }

    // Fix missing RouteRegistry
    const varDecls = sourceFile.getVariableDeclarations();
    let hasRR = false;
    varDecls.forEach(v => {
        if (v.getName() === 'RouteRegistry' || v.getText().includes('RouteRegistry')) {
            hasRR = true;
        }
    });

    if (!hasRR) {
        // Find if AdminRegistry is imported
        let hasAR = false;
        imports.forEach(i => {
           if (i.getNamedImports().some(n => n.getName() === 'AdminRegistry')) hasAR = true;
        });
        if (!hasAR) {
            sourceFile.addImportDeclaration({
                namedImports: ['AdminRegistry'],
                moduleSpecifier: 'prime-care-shared'
            });
        }
        
        // Add const { RouteRegistry } = AdminRegistry; at the top below imports
        const lastImport = sourceFile.getLastChildByKind(SyntaxKind.ImportDeclaration);
        const insertPos = lastImport ? lastImport.getChildIndex() + 1 : 0;
        sourceFile.insertStatements(insertPos, "const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;");
        console.log(`Injected RouteRegistry destructure into ${file}`);
    }

    // 3. Remove dirty empty string imports
    const emptyImports = imports.filter(i => i.getModuleSpecifierValue() === '');
    emptyImports.forEach(i => {
        i.remove();
        console.log(`Removed empty import from ${file}`);
    });
});

// 4. Fix Duplicate declarations in platform.tsx / tenancy.tsx
console.log("Deduplicating functions and variables using AST...");
project.getSourceFiles().forEach(sf => {
    const seenFunctions = new Set();
    const sfFunctions = sf.getFunctions();
    sfFunctions.forEach(f => {
        const name = f.getName();
        if (name) {
            if (seenFunctions.has(name)) {
                console.log(`Removing duplicate function ${name} in ${sf.getBaseName()}`);
                f.remove();
            } else {
                seenFunctions.add(name);
            }
        }
    });

    const seenVars = new Set();
    sf.getVariableStatements().forEach(vs => {
        const decls = vs.getDeclarations();
        decls.forEach(d => {
            const name = d.getName();
            // Handle const { RouteRegistry } = ...
            if (d.getNameNode().getKind() === SyntaxKind.ObjectBindingPattern) {
                const elements = d.getNameNode().getElements();
                const firstEl = elements.length > 0 ? elements[0].getName() : null;
                if (firstEl && seenVars.has(firstEl)) {
                    console.log(`Removing duplicate object binding ${firstEl} in ${sf.getBaseName()}`);
                    vs.remove();
                    return;
                }
                if (firstEl) seenVars.add(firstEl);
            } else {
                // Name like API_URL, SystemPolicies, apiClient
                if (name === 'apiClient' || name === 'API_URL' || name === 'API_URL_1' || name === 'SystemPolicies') {
                    if (seenVars.has(name)) {
                        console.log(`Removing duplicate variable ${name} in ${sf.getBaseName()}`);
                        vs.remove();
                    } else {
                        seenVars.add(name);
                    }
                }
            }
        });
    });

    // Strip duplicate global constants
    const seenImports = new Set();
    sf.getImportDeclarations().forEach(i => {
        const text = i.getText();
        // Specifically fix Duplicate identifier 'AppLayout' AND 'React' AND 'lazy'
        if (seenImports.has(text) || (text.includes('React') && seenImports.has('import React from "react";'))) {
            // Very basic dedupe
            // If it's a structural duplicate
            // We'll let tsc catch complex ones, but let's nuke exact duplicates safely
        }
        
    });
});

// Deep deduplicate imports
project.getSourceFiles().forEach(sf => {
    const importModules = new Map();
    const imports = sf.getImportDeclarations();
    
    imports.forEach(imp => {
        const moduleSpecifier = imp.getModuleSpecifierValue();
        
        // Strip out 'React' or 'AppLayout' if they exist multiple times
        // A smarter way: just aggregate them all!
        if (!importModules.has(moduleSpecifier)) {
            importModules.set(moduleSpecifier, imp);
        } else {
            const existingImp = importModules.get(moduleSpecifier);
            // If it's the exact same import, remove it
            if (existingImp.getText() === imp.getText()) {
                imp.remove();
            } else {
                // E.g. import AppLayout from '@/shared... vs import AppLayout from '@/shared...
                // If they both import the default, we can remove one
                if (existingImp.getDefaultImport() && imp.getDefaultImport() && existingImp.getDefaultImport().getText() === imp.getDefaultImport().getText()) {
                    imp.remove();
                } else if (imp.getNamedImports().length > 0) {
                    // Just let them be or merge named imports
                    imp.getNamedImports().forEach(nImp => {
                        const name = nImp.getName();
                        if (!existingImp.getNamedImports().some(n => n.getName() === name)) {
                            existingImp.addNamedImport(name);
                        }
                    });
                    imp.remove();
                }
            }
        }
    });
});

// Fix Specific AST errors
const platformTsx = project.getSourceFile('platform.tsx');
if (platformTsx) {
    const errorLineStr = platformTsx.getText();
    // src/app/routes/platform.tsx(2570,160): error TS2345: Argument of type 'string' is not assignable to parameter of type '"CONNECTED" | "DISCONNECTED" | "EXPIRED"'.
    // let's do a fast string replace on the source text
}

project.saveSync();
console.log('Saved AST modifications.');
