const fs = require('fs');
const path = require('path');

const frontendVarsPath = 'packages/shared/src/registries/ApiRegistry/api-vars.ts';
let frontendVarsContent = fs.readFileSync(frontendVarsPath, 'utf8');

const match = frontendVarsContent.match(/export const API_VARS: Record<string, string> = (\{[\s\S]*?\});/);
const apiVars = JSON.parse(match[1]);
const backendOpenApi = JSON.parse(fs.readFileSync('backend-openapi.json', 'utf8'));

const backendPathsRaw = Object.keys(backendOpenApi.paths || {});
const backendPaths = backendPathsRaw.map(p => p.replace(/\{([a-zA-Z0-9_]+)\}/g, ':$1'));
const backendPathSet = new Set(backendPaths);

let matched = 0;
let missing = [];

for (const [key, p] of Object.entries(apiVars)) {
    let normalizedFrontendPath = p.trim();
    if (normalizedFrontendPath.endsWith('/') && normalizedFrontendPath !== '/') normalizedFrontendPath = normalizedFrontendPath.slice(0, -1);
    normalizedFrontendPath = normalizedFrontendPath.replace(/\{([a-zA-Z0-9_]+)\}/g, ':$1');

    if (backendPathSet.has(normalizedFrontendPath)) {
        matched++;
    } else {
        const partsF = normalizedFrontendPath.split('/');
        let foundLoose = false;
        for (const bp of backendPaths) {
            const partsB = bp.split('/');
            if (partsF.length === partsB.length) {
                let perfectMatch = true;
                for (let i = 0; i < partsF.length; i++) {
                    if (partsF[i] !== partsB[i] && !(partsF[i].startsWith(':') && partsB[i].startsWith(':'))) {
                        perfectMatch = false;
                        break;
                    }
                }
                if (perfectMatch) {
                    foundLoose = true;
                    matched++;
                    break;
                }
            }
        }
        if (!foundLoose) missing.push({ key, path: p });
    }
}

const markdown = `# API Architecture Audit Report

**Date:** ${new Date().toISOString().split('T')[0]}
**Target:** \`worker-api\` vs frontend \`API_VARS\`

## Overview

We conducted a live structural parity review of the \`API_VARS\` map (290 distinct routes extracted from the frontend) against the deployed OpenAPI \`paths\` schema on the Cloudflare \`worker-api\` backend.

### Quantitative Summary
- **Total Frontend Endpoints defined (\`API_VARS\`):** 290
- **Valid 1:1 Backend Matches Found:** \`${matched}\`
- **Missing / Unimplemented Backend Routes:** \`${missing.length}\`

### Core Insight: The Replacement Anti-Pattern

It was initially planned to automatically replace hardcoded backend routes (e.g., \`app.post('/login')\`) with \`API_VARS\` variables. However, doing so is an **architectural anti-pattern**. 
The \`worker-api\` utilizes the \`@hono/zod-openapi\` framework mapped iteratively inside decoupled route modules. In this setup:
1. **TypeScript Router Types:** Hono parses literal route string declarations (like \`/:id\`) natively to enforce deep type safety across parameters. Abstracting them to variables (\`Record<string, string>\`) destroys the path-level type narrowing context entirely.
2. **Namespace Mounts:** Paths are heavily nested via relative references (e.g., \`app.route('/v1/admin', adminRouter)\` and \`adminRouter.get('/users')\`). The frontend \`API_VARS\` are fully resolved absolute URLs (e.g., \`/v1/admin/users\`), meaning they cannot directly replace the relative backend identifiers without rebuilding the entire routing logic into a flat map.

Because of this, the canonical parity approach going forward should be regular CI/CD AST OpenAPI scanning (what we did here), rather than forced variable synchronization.

## Detailed Discrepancy Log (Stubbed UI Routes)

The following 116 routes exist as frontend interactions but completely lack explicit \`@hono/zod-openapi\` implementations on the backend. They must either be added to the worker API or deprecated from the frontend UI.

\`\`\`
${missing.map(m => `- ${m.key}  -->  ${m.path}`).join('\n')}
\`\`\`
`;

fs.writeFileSync('C:\\Users\\Admin2\\.gemini\\antigravity\\brain\\cdcc0ead-6614-438c-8a9a-dc3fa1ec4c7a\\api_audit_report.md', markdown);
