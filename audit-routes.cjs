const fs = require('fs');

const frontendVarsPath = 'packages/shared/src/registries/ApiRegistry/api-vars.ts';
let frontendVarsContent = fs.readFileSync(frontendVarsPath, 'utf8');

const match = frontendVarsContent.match(/export const API_VARS: Record<string, string> = (\{[\s\S]*?\});/);
if (!match) {
    console.error("Could not find API_VARS");
    process.exit(1);
}

const apiVars = JSON.parse(match[1]);
const backendOpenApi = JSON.parse(fs.readFileSync('backend-openapi.json', 'utf8'));

const backendPathsRaw = Object.keys(backendOpenApi.paths || {});
// Normalize backend paths for regex conversion: {id} -> :id
// Oh wait! API_VARS values are just strings. Are they "/users/:id" or "/users/{id}"?
const backendPaths = backendPathsRaw.map(p => p.replace(/\{([a-zA-Z0-9_]+)\}/g, ':$1'));

// Also build an exact reverse lookup for fast checking
const backendPathSet = new Set(backendPaths);
const originalBackendPathMap = new Map();
backendPaths.forEach((p, i) => originalBackendPathMap.set(p, backendPathsRaw[i]));

let matched = 0;
let missing = [];

for (const [key, path] of Object.entries(apiVars)) {
    // Normalization logic: sometimes API_VARS might have trailing slashes
    let normalizedFrontendPath = path.trim();
    if (normalizedFrontendPath.endsWith('/') && normalizedFrontendPath !== '/') normalizedFrontendPath = normalizedFrontendPath.slice(0, -1);
    
    // Convert {param} to :param if present in frontend string just in case
    normalizedFrontendPath = normalizedFrontendPath.replace(/\{([a-zA-Z0-9_]+)\}/g, ':$1');

    if (backendPathSet.has(normalizedFrontendPath)) {
        matched++;
    } else {
        // Try loose matching inside the list
        // e.g. /v1/admin/users/:userId vs /v1/admin/users/:id
        // We can just rely on exact path part matching:
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
        
        if (!foundLoose) {
            missing.push({ key, path: normalizedFrontendPath });
        }
    }
}

console.log(`\n=== API AUDIT RESULTS ===`);
console.log(`Total API_VARS defined: ${Object.keys(apiVars).length}`);
console.log(`Matched perfectly or contextually: ${matched}`);
console.log(`Missing from Backend: ${missing.length}`);
if (missing.length > 0) {
    console.log("\nThe following frontend definitions have NO corresponding backend route:");
    missing.forEach(m => console.log(` - ${m.key} -> ${m.path}`));
}
