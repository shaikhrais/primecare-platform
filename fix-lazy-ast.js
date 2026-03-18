const { Project, SyntaxKind } = require('ts-morph');
const path = require('path');

const project = new Project({ skipAddingFilesFromTsConfig: true });
const files = ['tenancy.tsx', 'platform.tsx', 'shared.tsx', 'auth.tsx'];

for (const f of files) {
    const p = path.join(__dirname, 'apps/web-admin/src/app/routes', f);
    if (!require('fs').existsSync(p)) continue;
    const source = project.addSourceFileAtPath(p);
    
    // Find all variable declarations
    source.getVariableDeclarations().forEach(vd => {
        const init = vd.getInitializer();
        if (init && init.getKind() === SyntaxKind.CallExpression) {
            const expr = init.getExpression().getText();
            // If it's a call to `lazy(...)`
            if (expr === 'lazy' || expr === 'React.lazy') {
                vd.setInitializer('() => <div />');
            }
        }
    });
}

project.saveSync();
console.log("AST transformation of lazy boundaries complete.");
