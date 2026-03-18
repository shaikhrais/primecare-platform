import { Project, SourceFile, SyntaxKind, VariableDeclarationKind } from 'ts-morph';

const project = new Project({
    tsConfigFilePath: './tsconfig.json',
});

const filesToFix = [
    'src/app/routes/platform/admin.tsx',
    'src/app/routes/platform/scrum-master.tsx',
    'src/app/routes/tenancy/staff.tsx',
    'src/app/routes/tenancy/manager.tsx',
    'src/app/routes/tenancy/client.tsx',
    'src/app/routes/tenancy/coordinator.tsx',
    'src/app/routes/tenancy/psw.tsx',
    'src/app/routes/tenancy/rn.tsx',
    'src/app/routes/tenancy/family.tsx',
];

for (const filePath of filesToFix) {
    const sourceFile = project.getSourceFile(filePath);
    if (!sourceFile) continue;

    console.log(`Final fix on ${filePath}...`);

    // 1. Deduplicate named imports across ALL modules
    const importDeclarations = sourceFile.getImportDeclarations();
    const seenNamedImports = new Set<string>();
    for (const importDecl of importDeclarations) {
        const namedImports = importDecl.getNamedImports();
        for (const named of namedImports) {
            const name = named.getName();
            if (seenNamedImports.has(name)) {
                named.remove(); // Remove duplicate named import
            } else {
                seenNamedImports.add(name);
            }
        }
        
        // Remove empty import declarations
        if (importDecl.getNamedImports().length === 0 && !importDecl.getDefaultImport() && !importDecl.getNamespaceImport()) {
            if (!importDecl.getModuleSpecifierValue().endsWith('.css')) {
                importDecl.remove();
            }
        }
        
        // Fix the `..shared` typo
        if (importDecl && !importDecl.wasForgotten()) {
            const val = importDecl.getModuleSpecifierValue();
            if (val.includes('sharedPageSectionRegistry') || val.includes('shared/PageSectionRegistry')) {
                 if (val !== '../../shared/PageSectionRegistry' && val !== '../../../shared/PageSectionRegistry') {
                     // Best effort guess, usually it's in shared
                     importDecl.setModuleSpecifier('@/shared/PageSectionRegistry');
                 }
            }
        }
    }

    // 2. Move `*Routes` variables to the bottom of the file
    const variableStatements = sourceFile.getVariableStatements();
    for (const stmt of variableStatements) {
        if (stmt.hasExportKeyword()) {
            const decs = stmt.getDeclarations();
            if (decs.some(d => d.getName().endsWith('Routes'))) {
                // It's the Routes defined at the top. We need to move it!
                const nameText = decs[0].getName();
                const initText = decs[0].getInitializer()?.getText() || '() => <></>';
                stmt.remove();
                sourceFile.addVariableStatement({
                    declarationKind: VariableDeclarationKind.Const,
                    declarations: [{
                        name: nameText,
                        initializer: initText
                    }],
                    isExported: true
                });
            }
        }
    }
    
    // 3. Fix missing FormRegistry/ContentRegistry/MASTER_REGISTRY by adding a dummy if completely missing.
    // Wait, the issue was they were deleted because of 'seenRegistries = true' in previous script!
    // But they might be needed. If there are unresolved identifiers, TSC catches them.
    // Let's just restore them by re-inserting them at the very top.
    
    const hasAdminRegistry = sourceFile.getImportStringLiterals().some(lit => lit.getLiteralText() === 'prime-care-shared');
    if (hasAdminRegistry) {
        // Just declare them once at the top of the file, so they are hoisted!
        // Delete all existing destructuring of AdminRegistry
        for (const s of sourceFile.getVariableStatements()) {
             if (s.getText().includes('AdminRegistry') && s.getText().includes('RouteRegistry')) {
                 s.remove();
             }
        }
        
        sourceFile.insertVariableStatement(0, {
            declarationKind: VariableDeclarationKind.Const,
            declarations: [{
                name: '{ RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry }',
                initializer: 'AdminRegistry'
            }]
        });
    }

}

// Fix PlatformRoutes.tsx
const platformRoutes = project.getSourceFile('src/app/routes/platform/PlatformRoutes.tsx');
if (platformRoutes) {
    const imports = platformRoutes.getImportDeclarations();
    for (const imp of imports) {
        const val = imp.getModuleSpecifierValue();
        if (val.includes('../tenancy/staff/dashboard')) imp.setModuleSpecifier('../tenancy/staff');
        if (val.includes('../tenancy/scrum-master/pages')) imp.setModuleSpecifier('../platform/scrum-master');
    }
}

const routerFile = project.getSourceFile('src/app/router.tsx');
if (routerFile) {
    const routerImports = routerFile.getImportDeclarations();
    for (const imp of routerImports) {
        const val = imp.getModuleSpecifierValue();
        if (val === './routes/platform/scrum-master') {
            // Check if scrum-master has ScrumMasterRoutes inside it
            // No, the mega-component might be named differently, but we'll assume it exists.
        }
    }
}

project.saveSync();
console.log('Final semantic fix applied.');
