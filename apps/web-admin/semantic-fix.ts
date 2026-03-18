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

    console.log(`Fixing ${filePath}...`);

    // Remove `lazy` variables which cause duplicate identifiers
    const varDecls = sourceFile.getVariableDeclarations();
    for (const decl of varDecls) {
        const init = decl.getInitializer();
        if (init && init.getText().startsWith('lazy(')) {
            // Remove the whole VariableStatement if it's the only declaration, else just the declaration
            const stmt = decl.getVariableStatement();
            if (stmt && stmt.getDeclarations().length === 1) {
                stmt.remove();
            } else {
                decl.remove();
            }
        }
    }

    // Remove duplicate `const { RouteRegistry, ApiRegistry ... } = AdminRegistry`
    const variableStatements = sourceFile.getVariableStatements();
    let seenRegistries = false;
    let seenApiClient = false;
    let counter = 1;
    for (const stmt of variableStatements) {
        const text = stmt.getText();
        if (text.includes('AdminRegistry') || text.includes('RouteRegistry')) {
            if (seenRegistries) {
                stmt.remove();
            } else {
                seenRegistries = true;
            }
        } else if (text.includes('apiClient =') || (stmt.getDeclarations().some(d => d.getName() === 'apiClient'))) {
            if (seenApiClient) {
                stmt.remove();
            } else {
                seenApiClient = true;
            }
        } else if (stmt.getDeclarations().some(d => ['cols', 'API_URL'].includes(d.getName()))) {
            // Keep the renames for simple variables like `cols`
            for (const decl of stmt.getDeclarations()) {
                const name = decl.getName();
                if (['cols', 'API_URL'].includes(name)) {
                   decl.rename(`${name}_${counter++}`);
                }
            }
        }
    }
}

// Fix `lazy` import paths in router and tenancyImports
const fixImportsInFile = (filePath: string) => {
    const file = project.getSourceFile(filePath);
    if (!file) return;

    // Both static imports and dynamic imports
    const staticImports = file.getImportDeclarations();
    for (const imp of staticImports) {
        let val = imp.getModuleSpecifierValue();
        val = resolveNewPath(val);
        imp.setModuleSpecifier(val);
    }

    const calls = file.getDescendantsOfKind(SyntaxKind.CallExpression);
    for (const call of calls) {
        if (call.getExpression().getText() === 'import') {
            const args = call.getArguments();
            if (args.length > 0 && args[0].getKind() === SyntaxKind.StringLiteral) {
                const strLiteral = args[0] as any;
                const oldPath = strLiteral.getLiteralValue();
                const newPath = resolveNewPath(oldPath);
                strLiteral.replaceWithText(`'${newPath}'`);
            }
        }
    }
};

const resolveNewPath = (val: string) => {
    // Basic mapping logic
    let out = val.replace('/manager/', '/manager')
                 .replace('/staff/', '/staff')
                 .replace('/client/', '/client')
                 .replace('/coordinator/', '/coordinator')
                 .replace('/psw/', '/psw')
                 .replace('/rn/', '/rn')
                 .replace('/scrum-master/', '/scrum-master')
                 .replace('/platform/admin/', '/platform/admin');
                 
    // cleanup trailing if it matched everything, e.g. './manager/dashboard' -> './managerdashboard' which is wrong.
    // Let's use regex instead:
    out = val.replace(/\/manager\/.*/, '/manager')
             .replace(/\/staff\/.*/, '/staff')
             .replace(/\/client\/.*/, '/client')
             .replace(/\/coordinator\/.*/, '/coordinator')
             .replace(/\/psw\/.*/, '/psw')
             .replace(/\/rn\/.*/, '/rn')
             .replace(/\/scrum-master\/.*/, '/scrum-master')
             .replace(/\/platform\/admin\/.*/, '/platform/admin');
             
    // specific cases
    if (out === '@/app/routes/platform/admin') return '../platform/admin';
    if (val.includes('sharedPageSectionRegistry') || val.includes('shared/PageSectionRegistry')) return '../../shared/PageSectionRegistry'; // fix properly
    
    return out;
};

fixImportsInFile('src/app/router.tsx');
fixImportsInFile('src/app/routes/tenancy/tenancyImports.ts');

project.saveSync();
console.log('Semantic fix applied.');
