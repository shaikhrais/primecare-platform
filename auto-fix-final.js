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
    // 1. Remove empty module imports/exports
    sf.getImportDeclarations().forEach(imp => {
        if (imp.getModuleSpecifierValue() === '') imp.remove();
    });
    sf.getExportDeclarations().forEach(exp => {
        if (exp.hasModuleSpecifier() && exp.getModuleSpecifierValue() === '') exp.remove();
    });

    // 2. Fix duplicate `ApiRegistry` or `RouteRegistry` across variables & imports
    const seenTopVars = new Set();
    const sfVars = sf.getVariableStatements();
    sfVars.forEach(v => {
        v.getDeclarations().forEach(d => {
            const name = d.getName();
            if (d.getNameNode().getKind() === SyntaxKind.ObjectBindingPattern) {
                // We've already deduplicated AdminRegistry destructures, but check again
                d.getNameNode().getElements().forEach(el => {
                    const elName = el.getName();
                    if (seenTopVars.has(elName)) {
                        // It's a duplicate destructure, we should really just kill the entire block
                        // but it's safe to just leave it if previous passed.
                    }
                    seenTopVars.add(elName);
                });
            } else {
                if (['ApiRegistry', 'RouteRegistry', 'apiClient'].includes(name)) {
                    if (seenTopVars.has(name)) {
                        v.remove();
                    } else seenTopVars.add(name);
                }
            }
        });
    });

    // Strip ApiRegistry from raw imports if it's already destructured!
    // Or vice/versa
    sf.getImportDeclarations().forEach(imp => {
        imp.getNamedImports().forEach(n => {
            if (['ApiRegistry', 'ContentRegistry', 'ThemeRegistry', 'PageRegistry', 'FormRegistry'].includes(n.getName())) {
                n.remove();
            }
        });
        if (imp.getNamedImports().length === 0 && !imp.getDefaultImport()) {
            imp.remove();
        }
    });

    // 3. Fix Re-export conflicts like `export { AlliedHealthHome }` colliding with `export function AlliedHealthHome`
    const localFunctions = new Set(sf.getFunctions().map(f => f.getName()));
    
    sf.getExportDeclarations().forEach(exp => {
        if (!exp.hasModuleSpecifier()) {
            exp.getNamedExports().forEach(nExp => {
                const name = nExp.getName();
                if (localFunctions.has(name)) {
                    nExp.remove();
                }
            });
            if (exp.getNamedExports().length === 0) {
                exp.remove();
            }
        }
    });

    // 4. Import conflicts with local declaration (e.g. TableColumn)
    const localInterfaces = new Set(sf.getInterfaces().map(i => i.getName()));
    sf.getImportDeclarations().forEach(imp => {
        imp.getNamedImports().forEach(n => {
            if (localInterfaces.has(n.getName())) {
                n.remove();
            }
        });
        if (imp.getNamedImports().length === 0 && !imp.getDefaultImport()) {
            imp.remove();
        }
    });

    // 5. Fix `useState`, `useEffect` missing
    let hasUseState = false;
    let hasUseEffect = false;
    sf.getImportDeclarations().forEach(imp => {
        if (imp.getModuleSpecifierValue() === 'react') {
            imp.getNamedImports().forEach(n => {
                if (n.getName() === 'useState') hasUseState = true;
                if (n.getName() === 'useEffect') hasUseEffect = true;
            });
        }
    });
    
    // Check if body actually contains useState
    if (sf.getText().includes('useState(') && !hasUseState) {
        sf.addImportDeclaration({
            namedImports: ['useState'],
            moduleSpecifier: 'react'
        });
    }
    if (sf.getText().includes('useEffect(') && !hasUseEffect) {
        sf.addImportDeclaration({
            namedImports: ['useEffect'],
            moduleSpecifier: 'react'
        });
    }

    // 6. Fix `getStatusColor` must be all exported or all local
    let getStatusColorDecls = [];
    sf.getFunctions().forEach(f => {
        if (f.getName() === 'getStatusColor') getStatusColorDecls.push(f);
    });
    sf.getVariableStatements().forEach(vs => {
        vs.getDeclarations().forEach(d => {
            if (d.getName() === 'getStatusColor') getStatusColorDecls.push(vs);
        });
    });

    if (getStatusColorDecls.length > 1) {
        // Keep the first one, remove the rest!
        for (let i = 1; i < getStatusColorDecls.length; i++) {
            getStatusColorDecls[i].remove();
        }
    }
});

project.saveSync();
console.log('Saved AST final fixes.');
