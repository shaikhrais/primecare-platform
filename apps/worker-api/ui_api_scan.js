/**
 * UI-First API Alignment Scanner
 * 
 * Scans web-admin UI to find:
 * 1. All API endpoint calls (using apiClient or ApiRegistry paths)
 * 2. What response fields the UI reads from each endpoint
 * 
 * Then cross-references with the worker-api to find:
 * 3. What the API actually returns per endpoint
 * 4. Mismatches between UI expectations and API responses
 */

const fs = require('fs');
const path = require('path');

// ---- Config ----
const WEB_ADMIN_SRC = path.join(__dirname, '..', 'web-admin', 'src');
const WORKER_API_SRC = path.join(__dirname, 'src');

// ---- Helpers ----
function walkDir(dir, ext = ['.ts', '.tsx']) {
    let results = [];
    try {
        const items = fs.readdirSync(dir, { withFileTypes: true });
        for (const item of items) {
            const full = path.join(dir, item.name);
            if (item.isDirectory() && !item.name.startsWith('.') && item.name !== 'node_modules') {
                results = results.concat(walkDir(full, ext));
            } else if (item.isFile() && ext.some(e => item.name.endsWith(e))) {
                results.push(full);
            }
        }
    } catch { }
    return results;
}

// ---- Phase 1: Scan UI for API calls ----
function scanUIApiCalls() {
    const uiFiles = walkDir(WEB_ADMIN_SRC);
    const apiCalls = [];

    // Patterns to detect API endpoint usage
    const patterns = [
        // Direct apiClient calls: apiClient.get('/v1/xxx'), apiClient.post('/v1/xxx')
        /apiClient\.(get|post|put|patch|delete)\s*\(\s*['"`]([^'"` ]+)['"`]/g,
        // ApiRegistry references: ApiRegistry.TENANCY.PSW.VISITS, etc.
        /ApiRegistry\.([A-Z_]+(?:\.[A-Z_]+)*(?:\([^)]*\))?)/g,
        // useApiQuery hook
        /useApiQuery[<\w>]*\(\s*\{[^}]*path:\s*['"`]([^'"` ]+)['"`]/g,
        /useApiQuery[<\w>]*\(\s*\{[^}]*path:\s*([A-Za-z_.]+)/g,
        // Direct fetch or template literals
        /(?:fetch|apiClient\.request)\s*\(\s*[`'"]([^`'"]*\/v1\/[^`'"]*)[`'"]/g,
    ];

    for (const file of uiFiles) {
        const content = fs.readFileSync(file, 'utf-8');
        const relPath = path.relative(WEB_ADMIN_SRC, file);

        for (const pattern of patterns) {
            pattern.lastIndex = 0;
            let match;
            while ((match = pattern.exec(content)) !== null) {
                apiCalls.push({
                    file: relPath,
                    endpoint: match[2] || match[1],
                    fullMatch: match[0].substring(0, 100),
                });
            }
        }
    }

    return apiCalls;
}

// ---- Phase 2: Scan UI for response field access ----
function scanUIFieldAccess() {
    const uiFiles = walkDir(WEB_ADMIN_SRC);
    const fieldAccess = [];

    // Common patterns for accessing API response data
    // data.xxx, response.xxx, result.xxx, item.xxx
    const accessPatterns = [
        // Destructuring: const { fieldA, fieldB } = data
        /(?:const|let|var)\s*\{([^}]+)\}\s*=\s*(?:data|response|result|item|record|entry|user|client|visit|plan)/g,
        // Property access: data.fieldName, response.fieldName
        /(?:data|response|result|item|record|entry)\.(\w+)/g,
        // TypeScript interface fields
        /(?:interface|type)\s+\w+\s*\{([^}]+)\}/g,
    ];

    for (const file of uiFiles) {
        const content = fs.readFileSync(file, 'utf-8');
        const relPath = path.relative(WEB_ADMIN_SRC, file);

        // Find all property accesses following API calls
        for (const pattern of accessPatterns) {
            pattern.lastIndex = 0;
            let match;
            while ((match = pattern.exec(content)) !== null) {
                fieldAccess.push({
                    file: relPath,
                    fields: match[1],
                });
            }
        }
    }

    return fieldAccess;
}

// ---- Phase 3: Find UI data consumption patterns per endpoint ----
function findUIDataPatterns() {
    const uiFiles = walkDir(WEB_ADMIN_SRC);
    const patterns = {};

    for (const file of uiFiles) {
        const content = fs.readFileSync(file, 'utf-8');
        const relPath = path.relative(WEB_ADMIN_SRC, file);

        // Find API paths in the file
        const pathMatches = [];
        
        // apiClient.get and similar
        const clientPattern = /apiClient\.(get|post|put|patch|delete)\s*\(\s*(?:['"`]([^'"` ]+)['"`]|([A-Za-z_.]+))/g;
        let m;
        while ((m = clientPattern.exec(content)) !== null) {
            pathMatches.push({ method: m[1], path: m[2] || m[3] });
        }

        // useApiQuery
        const queryPattern = /useApiQuery[<\w>]*\(\s*\{[^}]*path:\s*(?:['"`]([^'"` ]+)['"`]|([A-Za-z_.()]+))/g;
        while ((m = queryPattern.exec(content)) !== null) {
            pathMatches.push({ method: 'GET', path: m[1] || m[2] });
        }

        if (pathMatches.length === 0) continue;

        // Now find what fields are accessed from the response in this file
        // Look for data.xxx, particularly after .then(data =>), const { xxx } = data, etc.
        const fieldPattern = /(?:\.map|\.filter|\.forEach|\.find|\.some)\s*\(\s*\(?(\w+)\)?\s*=>/g;
        const iteratorVars = new Set();
        while ((m = fieldPattern.exec(content)) !== null) {
            iteratorVars.add(m[1]);
        }

        // Also add common variable names
        iteratorVars.add('data');
        iteratorVars.add('item');
        iteratorVars.add('record');
        iteratorVars.add('entry');

        // Find all property accesses on these variables
        const fieldsUsed = new Set();
        for (const varName of iteratorVars) {
            const accessPattern = new RegExp(`${varName}\\.(\\w+)`, 'g');
            while ((m = accessPattern.exec(content)) !== null) {
                // Skip common JS methods
                if (!['map', 'filter', 'forEach', 'find', 'some', 'length', 'reduce', 'sort', 'slice',
                    'push', 'pop', 'join', 'includes', 'indexOf', 'toString', 'then', 'catch', 'json',
                    'ok', 'status', 'text', 'headers', 'body', 'error', 'message', 'trim', 'split',
                    'replace', 'toLowerCase', 'toUpperCase', 'startsWith', 'endsWith', 'keys', 'values',
                    'entries', 'stringify', 'parse', 'flat', 'flatMap', 'every', 'reverse', 'concat',
                    'toFixed', 'toISOString', 'getTime', 'getDate', 'getMonth', 'getFullYear',
                    'toLocaleDateString', 'toLocaleTimeString', 'toLocaleString', 'charAt', 'substring',
                    'padStart', 'padEnd'].includes(m[1])) {
                    fieldsUsed.add(m[1]);
                }
            }
        }

        if (pathMatches.length > 0 && fieldsUsed.size > 0) {
            patterns[relPath] = {
                endpoints: pathMatches,
                fieldsUsed: [...fieldsUsed],
            };
        }
    }

    return patterns;
}

// ---- Phase 4: Compare with API responses ----
function scanAPIResponses() {
    const apiFiles = walkDir(WORKER_API_SRC);
    const responses = {};

    for (const file of apiFiles) {
        const content = fs.readFileSync(file, 'utf-8');
        const relPath = path.relative(WORKER_API_SRC, file);

        // Find c.json() calls to see what the API returns
        const jsonPattern = /c\.json\(\s*(\{[^}]+\}|\w+)/g;
        let m;
        const jsonReturns = [];
        while ((m = jsonPattern.exec(content)) !== null) {
            jsonReturns.push(m[1].substring(0, 200));
        }

        // Find include/select Prisma patterns
        const selectPattern = /select:\s*\{([^}]+)\}/g;
        const includes = [];
        while ((m = selectPattern.exec(content)) !== null) {
            includes.push(m[1].trim());
        }

        if (jsonReturns.length > 0) {
            responses[relPath] = {
                returns: jsonReturns,
                selects: includes,
            };
        }
    }

    return responses;
}

// ---- Main ----
console.log('\n🔍 UI-FIRST API ALIGNMENT AUDIT\n');
console.log('='.repeat(80));

// Step 1: What endpoints does the UI call?
console.log('\n📱 PHASE 1: UI API Calls\n');
const uiCalls = scanUIApiCalls();
console.log(`Found ${uiCalls.length} API call sites in web-admin\n`);

// Deduplicate by endpoint path
const endpointSet = new Set();
uiCalls.forEach(c => endpointSet.add(c.endpoint));
console.log(`Unique endpoints referenced: ${endpointSet.size}\n`);

// Step 2: What does the UI read from each response?
console.log('\n📊 PHASE 2: UI Data Consumption Patterns\n');
const dataPatterns = findUIDataPatterns();
const patternEntries = Object.entries(dataPatterns);
console.log(`Found ${patternEntries.length} files with API calls + field access patterns\n`);

// Print summary of most important ones (files with both API calls and field reads)
let filesWithPatterns = 0;
for (const [file, info] of patternEntries) {
    if (info.endpoints.length > 0 && info.fieldsUsed.length > 0) {
        filesWithPatterns++;
        if (filesWithPatterns <= 50) {
            console.log(`  📁 ${file}`);
            console.log(`     Endpoints: ${info.endpoints.map(e => e.path).join(', ').substring(0, 120)}`);
            console.log(`     Fields used: ${info.fieldsUsed.sort().join(', ').substring(0, 150)}`);
            console.log();
        }
    }
}
if (filesWithPatterns > 50) {
    console.log(`  ... and ${filesWithPatterns - 50} more files\n`);
}

// Step 3: What does the API return?
console.log('\n🔧 PHASE 3: API Response Shapes\n');
const apiResponses = scanAPIResponses();
console.log(`Analyzed ${Object.keys(apiResponses).length} API route files\n`);

console.log('\nDone. Scan complete.');
