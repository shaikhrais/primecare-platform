const { Project, SyntaxKind } = require('ts-morph');
const fs = require('fs');
const path = require('path');

const project = new Project({
    tsConfigFilePath: 'apps/web-admin/tsconfig.json',
    skipAddingFilesFromTsConfig: true
});

const dirsToFlatten = [
    'apps/web-admin/src/app/routes/platform/admin',
    'apps/web-admin/src/app/routes/platform/client',
    'apps/web-admin/src/app/routes/platform/dam',
    'apps/web-admin/src/app/routes/platform/family',
    'apps/web-admin/src/app/routes/platform/marketing',
    'apps/web-admin/src/app/routes/platform/scrum-master',
    'apps/web-admin/src/app/routes/tenancy/admin',
    'apps/web-admin/src/app/routes/tenancy/client',
    'apps/web-admin/src/app/routes/tenancy/coordinator',
    'apps/web-admin/src/app/routes/tenancy/family',
    'apps/web-admin/src/app/routes/tenancy/finance',
    'apps/web-admin/src/app/routes/tenancy/manager',
    'apps/web-admin/src/app/routes/tenancy/operations',
    'apps/web-admin/src/app/routes/tenancy/psw',
    'apps/web-admin/src/app/routes/tenancy/rn',
    'apps/web-admin/src/app/routes/tenancy/scrum-master',
    'apps/web-admin/src/app/routes/tenancy/staff'
];

for (const dir of dirsToFlatten) {
    if (!fs.existsSync(dir)) continue;

    const files = fs.readdirSync(dir, { recursive: true })
        .filter(f => f.endsWith('.tsx') || f.endsWith('.ts'))
        .map(f => path.join(dir, f).replace(/\\\\/g, '/'));

    if (files.length === 0) {
        fs.rmdirSync(dir, { recursive: true });
        continue;
    }

    console.log(`Flattening ${dir} (${files.length} files)...`);
    files.forEach(f => project.addSourceFileAtPath(f));

    const featureName = path.basename(dir);
    const parentDir = path.dirname(dir);
    const targetFilePath = path.join(parentDir, `${featureName}.tsx`).replace(/\\\\/g, '/');
    
    // Create new target file
    const targetFile = project.createSourceFile(targetFilePath, '', { overwrite: true });

    const allImports = new Map();
    const sourceCodes = [];

    // Collect logic and external imports
    for (const file of files) {
        const sourceFile = project.getSourceFile(file);
        
        // 1. Process imports (keep external/shared, discard internal)
        const importDeclarations = sourceFile.getImportDeclarations();
        for (const imp of importDeclarations) {
            const specifier = imp.getModuleSpecifierValue();
            // If it resolves to a file inside `dir`, we skip it
            if (specifier.startsWith('.')) {
                // Calculate absolute path of import
                const absoluteTarget = path.resolve(path.dirname(file), specifier).replace(/\\\\/g, '/');
                // Check if absoluteTarget is inside `dir`
                if (absoluteTarget.startsWith(path.resolve(dir).replace(/\\\\/g, '/'))) {
                    continue; // Skip internal import
                }
            }
            
            // Adjust relative imports that point OUTSIDE the directory
            // Since the new file is in parentDir, relative imports going up need one less `../`
            // Example: `import { X } from '../../shared/X'` -> `import { X } from '../shared/X'`
            let newSpecifier = specifier;
            let importText = imp.getText();
            if (specifier.startsWith('.')) {
                const absPath = path.resolve(path.dirname(file), specifier);
                let newRelPath = path.relative(parentDir, absPath).replace(/\\\\/g, '/');
                if (!newRelPath.startsWith('.')) newRelPath = './' + newRelPath;
                importText = importText.replace(specifier, newRelPath);
                newSpecifier = newRelPath;
            }

            if (!allImports.has(importText)) {
                allImports.set(importText, importText);
            }
        }

        // 2. Extract bodies
        const text = sourceFile.getText();
        const lastImport = importDeclarations.length > 0 ? importDeclarations[importDeclarations.length - 1] : null;
        const bodyStart = lastImport ? lastImport.getEnd() : 0;
        
        let bodyText = text.substring(bodyStart).trim();

        // 3. Fix lazy imports locally in bodyText
        // Replace `lazy(() => import('./home').then(m => ({ default: m.AdminHome })))`
        // with `lazy(() => Promise.resolve({ default: AdminHome }))`
        bodyText = bodyText.replace(/lazy\s*\\(\\s*\\(\\)\\s*=>\s*import\\s*\\(['"][^'"]+['"]\\)\\s*\\.then\\s*\\(\\s*[a-zA-Z0-9_$]+\\s*=>\s*\\(\\s*\\{\\s*default:\\s*[a-zA-Z0-9_$]+\\.([a-zA-Z0-9_$]+)\\s*\\}\\s*\\)\\s*\\)\\s*\\)/g, 
            "lazy(() => Promise.resolve({ default: $1 }))");

        // Edge case: Sometimes Object.values is used: `lazy(() => import('./services').then(m => ({ default: Object.values(m)[0] as any })))`
        // Edge case: simple lazy: `lazy(() => import('./earnings'))` -> assumes default export.
        // For simple lazy where it assumes default export: `Promise.resolve({ default: undefined /* NEED MANUAL FIX */ })`
        // But since we own the string, let's just use regex mapping carefully
        bodyText = bodyText.replace(/lazy\s*\\(\\s*\\(\\)\\s*=>\s*import\\s*\\(['"][^'"]+['"]\\)\\s*\\)/g, (match, p1) => {
            // Find component name based on filename if simple import... actually this breaks. We will leave simple lazy as is and fix manually if TS fails.
            return match; 
        });

        sourceCodes.push(`// --- Extracted from ${path.basename(file)} ---\n` + bodyText + '\n');
    }

    // Assemble file
    const finalImports = Array.from(allImports.values()).join('\n');
    const finalBody = sourceCodes.join('\n');
    
    targetFile.replaceWithText(finalImports + '\n\n' + finalBody);
    targetFile.saveSync();

    console.log(`=> Created ${targetFilePath}`);

    // Let's delete the old source files and the directory
    for (const f of files) {
        fs.unlinkSync(f);
    }
    
    // The directory might contain subdirectories (like `schedule/hooks`), so remove recursively
    fs.rmSync(dir, { recursive: true, force: true });
}

console.log('Done!');
