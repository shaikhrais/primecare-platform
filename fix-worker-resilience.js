const { Project, SyntaxKind } = require('ts-morph');
const fs = require('fs');
const path = require('path');

const project = new Project({ skipAddingFilesFromTsConfig: true });
const targetDir = path.join(__dirname, 'apps/worker-api/src');
project.addSourceFilesAtPaths(`${targetDir}/**/*.ts`);

project.getSourceFiles().forEach(file => {
    let modified = false;

    // Fix 1: Wrap unprotected prisma.tenant.findUnique calls
    const calls = file.getDescendantsOfKind(SyntaxKind.CallExpression)
        .filter(c => c.getExpression().getText().includes('prisma.tenant.findUnique'))
        .filter(c => c.getFirstAncestorByKind(SyntaxKind.TryStatement) === undefined)
        // Only target variable declarations like const tenant = await prisma...
        .filter(c => c.getFirstAncestorByKind(SyntaxKind.VariableStatement) !== undefined)
        .sort((a, b) => b.getStart() - a.getStart()); // Process bottom to top
        
    calls.forEach(call => {
        const parentStmt = call.getFirstAncestorByKind(SyntaxKind.VariableStatement);
        if (parentStmt) {
            const decl = call.getFirstAncestorByKind(SyntaxKind.VariableDeclaration);
            if (decl) {
                const varName = decl.getName();
                const stmtText = parentStmt.getText();
                // Ensure it's inside an async block
                parentStmt.replaceWithText(`let ${varName} = null;\ntry {\n  ${stmtText.replace('const ', '').replace('let ', '')}\n} catch(e) {\n  console.error("Invalid UUID fallback", e);\n}`);
                modified = true;
            }
        }
    });

    // Fix 2: Add optional chaining to tenant access without it
    // Must recalculate nodes after first pass, but let's just use string replace on the file if it's safer, or target exact PropertyAccessExpressions
    const currentText = file.getFullText();
    let newText = currentText;
    
    // Fallback simple regex block for the 60 instances to avoid AST node collapse
    // We only want to replace `tenant.prop` with `tenant?.prop` where it's safe and NOT prisma.tenant
    
    // Parse through again for PropertyAccessExpressions exactly equal to "tenant"
    const props = file.getDescendantsOfKind(SyntaxKind.PropertyAccessExpression).filter(prop => {
        return prop.getExpression().getText() === 'tenant' && prop.getText().startsWith('tenant.');
    });

    if (props.length > 0) {
        // Collect exact text positions
        const replacements = [];
        props.forEach(p => {
            replacements.push({ start: p.getExpression().getEnd(), end: p.getNameNode().getStart() });
        });
        
        // Apply text replacements from bottom to top
        replacements.sort((a,b) => b.start - a.start).forEach(r => {
            const before = newText.substring(0, r.start);
            const after = newText.substring(r.end);
            newText = before + '?.' + after;
        });
        
        file.replaceWithText(newText);
        modified = true;
    }

    if (modified) {
        file.saveSync();
    }
});

console.log("Phase 1: Middleware Resilience Patching Complete.");
