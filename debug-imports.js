const { Project } = require('ts-morph');
const path = require('path');

const project = new Project({ skipAddingFilesFromTsConfig: true });
const f = project.addSourceFileAtPath(path.join(__dirname, 'apps/web-admin/src/app/routes/tenancy.tsx'));

f.getImportDeclarations().forEach(i => {
    let spec = i.getModuleSpecifierValue();
    if (!spec || spec.trim() === '') {
        console.log("EMPTY IMPORT AT LINE:", i.getStartLineNumber(), i.getText());
        i.remove();
    }
});

f.getExportDeclarations().forEach(e => {
    if (e.hasModuleSpecifier()) {
        let spec = e.getModuleSpecifierValue();
        if (!spec || spec.trim() === '') {
            console.log("EMPTY EXPORT AT LINE:", e.getStartLineNumber(), e.getText());
            e.remove();
        }
    }
});

// Also check for dynamic imports
f.getDescendantsOfKind(require('ts-morph').SyntaxKind.CallExpression).forEach(c => {
    if (c.getExpression().getText() === 'import') {
        let args = c.getArguments();
        if (args.length > 0) {
            let argText = args[0].getText().replace(/['"`]/g, '').trim();
            if (argText === '') {
                console.log("EMPTY DYNAMIC IMPORT AT LINE:", c.getStartLineNumber(), c.getText());
                // Destroy the lazy wrapper
                c.getParent().getParent().getParent().remove(); // Assumes const X = lazy(() => import(''))
            }
        }
    }
});

project.saveSync();
console.log("Done checking for empty imports.");
