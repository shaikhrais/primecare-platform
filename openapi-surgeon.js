const { Project, SyntaxKind } = require('ts-morph');
const fs = require('fs');
const path = require('path');

const project = new Project({ skipAddingFilesFromTsConfig: true });
const targetDir = path.join(__dirname, 'apps/worker-api/src');
project.addSourceFilesAtPaths(`${targetDir}/**/*.ts`);

project.getSourceFiles().forEach(file => {
    let modified = false;
    const createRoutes = file.getDescendantsOfKind(SyntaxKind.CallExpression).filter(c => c.getExpression().getText() === 'createRoute');
    
    if (createRoutes.length > 0) {
        let hasZImport = false;
        file.getImportDeclarations().forEach(imp => {
            if (imp.getNamedImports().some(ni => ni.getName() === 'z')) hasZImport = true;
        });
        
        if (!hasZImport) {
            file.addImportDeclaration({ namedImports: ['z'], moduleSpecifier: '@hono/zod-openapi' });
            modified = true;
        }

        createRoutes.forEach(call => {
            const arg = call.getArguments()[0];
            if (arg && arg.getKind() === SyntaxKind.ObjectLiteralExpression) {
                const responsesProp = arg.getProperty('responses');
                if (responsesProp && responsesProp.getKind() === SyntaxKind.PropertyAssignment) {
                    const resObj = responsesProp.getInitializer();
                    if (resObj && resObj.getKind() === SyntaxKind.ObjectLiteralExpression) {
                        const keys = resObj.getProperties().map(p => {
                            if (p.getKind() === SyntaxKind.PropertyAssignment) return p.getName().replace(/['"]/g, '');
                            return '';
                        });
                        
                        if (!keys.includes('400')) {
                            resObj.addPropertyAssignment({
                                name: "'400'",
                                initializer: "{ description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }"
                            });
                            modified = true;
                        }
                        if (!keys.includes('404')) {
                            resObj.addPropertyAssignment({
                                name: "'404'",
                                initializer: "{ description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }"
                            });
                            modified = true;
                        }
                    }
                }
            }
        });
    }

    if (modified) {
        file.saveSync();
    }
});

console.log("Phase 2: Native AST Property Assignment Complete.");
