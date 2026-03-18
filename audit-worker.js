const { Project, SyntaxKind } = require('ts-morph');
const fs = require('fs');
const path = require('path');

const project = new Project({ skipAddingFilesFromTsConfig: true });
const targetDir = path.join(__dirname, 'apps/worker-api/src');
project.addSourceFilesAtPaths(`${targetDir}/**/*.ts`);

let totalRoutes = 0;
let missing400or404 = [];
let vulnerableTenantLookups = [];
let unsafeTenantAccess = [];

project.getSourceFiles().forEach(file => {
    // Audit 1: Check createRoute definitions for missing 4xx/5xx responses
    file.getDescendantsOfKind(SyntaxKind.CallExpression).forEach(call => {
        if (call.getExpression().getText() === 'createRoute') {
            totalRoutes++;
            const arg = call.getArguments()[0];
            if (arg && arg.getKind() === SyntaxKind.ObjectLiteralExpression) {
                const responsesProp = arg.getProperty('responses');
                if (responsesProp && responsesProp.getKind() === SyntaxKind.PropertyAssignment) {
                    const resObj = responsesProp.getInitializer();
                    if (resObj && resObj.getKind() === SyntaxKind.ObjectLiteralExpression) {
                        const keys = resObj.getProperties().map(p => p.getName());
                        if (!keys.includes('404') && !keys.includes('400')) {
                            missing400or404.push(`${file.getBaseName()} - missing 4xx handler`);
                        }
                    }
                }
            }
        }
        
        // Audit 2: Check prisma.tenant.findUnique without try-catch
        if (call.getExpression().getText().includes('prisma.tenant.findUnique')) {
            const hasTryCatch = call.getFirstAncestorByKind(SyntaxKind.TryStatement) !== undefined;
            if (!hasTryCatch) {
                vulnerableTenantLookups.push(`${file.getBaseName()} at line ${call.getStartLineNumber()}`);
            }
        }
    });

    // Audit 3: Check for unsafe tenant access
    file.getDescendantsOfKind(SyntaxKind.PropertyAccessExpression).forEach(prop => {
        if (prop.getExpression().getText() === 'tenant' && prop.getText().startsWith('tenant.')) {
            unsafeTenantAccess.push(`${file.getBaseName()} at line ${prop.getStartLineNumber()}: ${prop.getText()}`);
        }
    });
});

const report = `# Worker API Architecture Compliance Audit

## 1. OpenAPI Pattern Compliance
- **Total Registered Routes Executing \`createRoute\`**: ${totalRoutes}
- **Missing Consensus (400/404) Response Handlers**: ${missing400or404.length} endpoints
${missing400or404.map(f => `  - ${f}`).join('\n')}

## 2. Middleware Resilience Vulnerabilities
- **Vulnerable Tenant Lookups (UUID Crashes)**: ${vulnerableTenantLookups.length} invocations without \`try...catch\`
${vulnerableTenantLookups.map(l => `  - ${l}`).join('\n')}

- **Unsafe Tenant Property Access (Potential Null Pointer)**: ${unsafeTenantAccess.length} instances lacking optional chaining (e.g., \`tenant?.field\`)
${unsafeTenantAccess.map(u => `  - ${u}`).join('\n')}
`;

const rPath = path.join(__dirname, 'architecture_audit_report.md');
fs.writeFileSync(rPath, report);
console.log("Audit complete. Report generated at", rPath);
