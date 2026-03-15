/**
 * DEEP UI-First End-to-End Alignment Scanner
 * 
 * For each UI page in web-admin:
 *   1. Find all API endpoint calls (apiClient.get/post, useApiQuery, ApiRegistry refs)
 *   2. Find all response field accesses (data.xxx, item.xxx, destructuring, etc.)
 *   3. Map them to exact ApiRegistry paths where possible
 * 
 * Then for each API route in worker-api:
 *   1. Find which Prisma model/method it queries
 *   2. Find what fields it selects/includes
 *   3. Find what it returns in c.json()
 * 
 * Finally, cross-reference to find mismatches.
 */

const fs = require('fs');
const path = require('path');

const WEB_ADMIN_SRC = path.join(__dirname, '..', 'web-admin', 'src');
const WORKER_API_SRC = path.join(__dirname, 'src');
const SCHEMA_PATH = path.join(__dirname, 'prisma', 'schema.prisma');

function walkDir(dir, ext = ['.ts', '.tsx']) {
    let results = [];
    try {
        const items = fs.readdirSync(dir, { withFileTypes: true });
        for (const item of items) {
            const full = path.join(dir, item.name);
            if (item.isDirectory() && !item.name.startsWith('.') && item.name !== 'node_modules' && item.name !== 'generated') {
                results = results.concat(walkDir(full, ext));
            } else if (item.isFile() && ext.some(e => item.name.endsWith(e))) {
                results.push(full);
            }
        }
    } catch { }
    return results;
}

// ---- Parse Schema ----
function parseSchema() {
    const content = fs.readFileSync(SCHEMA_PATH, 'utf-8');
    const models = {};
    const modelRegex = /model\s+(\w+)\s*\{([^}]+)\}/g;
    let match;
    while ((match = modelRegex.exec(content)) !== null) {
        const modelName = match[1];
        const body = match[2];
        const fields = {};
        const fieldRegex = /^\s+(\w+)\s+(\w+[\[\]?]*)/gm;
        let fm;
        while ((fm = fieldRegex.exec(body)) !== null) {
            if (!['@@map', '@@index', '@@unique', '@@id'].some(d => fm[0].trim().startsWith(d))) {
                fields[fm[1]] = fm[2];
            }
        }
        models[modelName] = fields;
    }
    return models;
}

// ---- Phase 1: Deep scan each UI file ----
function deepScanUI() {
    const uiFiles = walkDir(WEB_ADMIN_SRC);
    const results = [];

    for (const file of uiFiles) {
        const content = fs.readFileSync(file, 'utf-8');
        const relPath = path.relative(WEB_ADMIN_SRC, file);
        const lines = content.split('\n');

        // Skip non-page files (hooks, utils, components without API calls)
        if (!content.includes('apiClient') && !content.includes('useApiQuery') && !content.includes('ApiRegistry')) continue;

        const pageInfo = {
            file: relPath,
            apiCalls: [],
            responseFields: [],
        };

        // 1. Find all API call sites with context
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            
            // apiClient.get/post/put/patch/delete
            const clientMatch = line.match(/apiClient\.(get|post|put|patch|delete)\s*\(\s*(?:['"`]([^'"` \)]+)['"`]|([A-Za-z_.()]+))/);
            if (clientMatch) {
                pageInfo.apiCalls.push({
                    method: clientMatch[1].toUpperCase(),
                    path: clientMatch[2] || clientMatch[3],
                    line: i + 1,
                });
            }

            // useApiQuery
            const queryMatch = line.match(/useApiQuery.*path:\s*(?:['"`]([^'"` ]+)['"`]|([A-Za-z_.()]+))/);
            if (queryMatch) {
                pageInfo.apiCalls.push({
                    method: 'GET',
                    path: queryMatch[1] || queryMatch[2],
                    line: i + 1,
                });
            }

            // Template literals with API paths
            const templateMatch = line.match(/`\$\{([^}]+)\}([^`]*)`/);
            if (templateMatch && (templateMatch[1].includes('ApiRegistry') || templateMatch[2].includes('/v1/'))) {
                pageInfo.apiCalls.push({
                    method: 'TEMPLATE',
                    path: `\${${templateMatch[1]}}${templateMatch[2]}`,
                    line: i + 1,
                });
            }
        }

        // 2. Find response field accesses
        // Look for patterns after .json() or within .then(data =>) or const data = await
        const responseContext = [];
        
        // Find response variable patterns
        const responseVarPatterns = [
            /const\s+(\w+)\s*=\s*await\s+(?:response|res)\.json\(\)/g,
            /\.then\(\s*\(?(\w+)\)?\s*=>/g,
            /const\s+\{([^}]+)\}\s*=\s*(?:await\s+)?(?:response|res)\.json\(\)/g,
            /const\s+(\w+)\s*=\s*(?:json|data|result)/g,
        ];

        for (const pattern of responseVarPatterns) {
            let m;
            while ((m = pattern.exec(content)) !== null) {
                if (m[1]) responseContext.push(m[1]);
            }
        }

        // Add common response variable names
        responseContext.push('data', 'json', 'result');

        // Now find field accesses on response variables
        const fieldsAccessed = new Set();
        const jsBuiltins = new Set([
            'map', 'filter', 'forEach', 'find', 'some', 'every', 'reduce', 'sort',
            'slice', 'splice', 'push', 'pop', 'shift', 'unshift', 'join', 'concat',
            'flat', 'flatMap', 'reverse', 'includes', 'indexOf', 'lastIndexOf',
            'length', 'toString', 'toFixed', 'toISOString', 'getTime', 'getDate',
            'getMonth', 'getFullYear', 'getHours', 'getMinutes', 'getSeconds',
            'toLocaleDateString', 'toLocaleTimeString', 'toLocaleString',
            'toLowerCase', 'toUpperCase', 'trim', 'split', 'replace', 'match',
            'charAt', 'substring', 'padStart', 'padEnd', 'startsWith', 'endsWith',
            'then', 'catch', 'finally', 'json', 'ok', 'status', 'text', 'headers',
            'body', 'error', 'message', 'keys', 'values', 'entries', 'stringify',
            'parse', 'assign', 'freeze', 'create', 'defineProperty', 'hasOwnProperty',
            'prototype', 'constructor', 'apply', 'call', 'bind',
            'VITE_API_URL', 'env', 'href', 'pathname', 'search', 'hash',
            'style', 'className', 'classList', 'dataset', 'innerHTML', 'textContent',
            'document', 'window', 'console', 'log', 'warn', 'info', 'debug',
            'target', 'value', 'checked', 'selected', 'disabled', 'type',
            'preventDefault', 'stopPropagation', 'currentTarget',
            'FC', 'Fragment', 'createElement', 'useState', 'useEffect', 'useCallback',
            'useMemo', 'useRef', 'useContext', 'useNavigate', 'useParams',
            'get', 'post', 'put', 'patch', 'delete', 'request',
            'add', 'has', 'delete', 'clear', 'size', 'set',
        ]);

        for (const varName of responseContext) {
            const accessRegex = new RegExp(`\\b${varName}\\.(\\w+)`, 'g');
            let am;
            while ((am = accessRegex.exec(content)) !== null) {
                const field = am[1];
                if (!jsBuiltins.has(field) && field.length > 1 && !/^[A-Z_]+$/.test(field)) {
                    fieldsAccessed.add(field);
                }
            }
        }

        // Also find destructuring from response
        const destructPatterns = [
            /const\s*\{([^}]+)\}\s*=\s*(?:data|json|result|response\.data|item|record|entry)/g,
            /(?:data|result|json)\s*\.\s*map\s*\(\s*\(?\s*(\w+)\s*\)?\s*=>/g,
        ];
        
        for (const pattern of destructPatterns) {
            let m;
            while ((m = pattern.exec(content)) !== null) {
                if (m[1] && !m[1].includes('=>')) {
                    // For destructuring, parse field names
                    const fieldStr = m[1];
                    const parts = fieldStr.split(',').map(s => s.trim().split(':')[0].split('=')[0].trim());
                    for (const part of parts) {
                        if (part && !jsBuiltins.has(part) && part.length > 1) {
                            fieldsAccessed.add(part);
                        }
                    }
                }
                // For iterator, find field accesses on the iterator var
                if (m[1] && /^\w+$/.test(m[1])) {
                    const iterVar = m[1];
                    const iterAccess = new RegExp(`\\b${iterVar}\\.(\\w+)`, 'g');
                    let ia;
                    while ((ia = iterAccess.exec(content)) !== null) {
                        if (!jsBuiltins.has(ia[1]) && ia[1].length > 1 && !/^[A-Z_]+$/.test(ia[1])) {
                            fieldsAccessed.add(ia[1]);
                        }
                    }
                }
            }
        }

        // Also find fields used in TypeScript interfaces near the top of the file
        const interfacePattern = /interface\s+\w+\s*\{([^}]+)\}/g;
        let ifm;
        while ((ifm = interfacePattern.exec(content)) !== null) {
            const body = ifm[1];
            const fieldLines = body.split('\n');
            for (const fl of fieldLines) {
                const fieldMatch = fl.trim().match(/^(\w+)\??:\s/);
                if (fieldMatch && !jsBuiltins.has(fieldMatch[1])) {
                    fieldsAccessed.add(fieldMatch[1]);
                }
            }
        }

        pageInfo.responseFields = [...fieldsAccessed].sort();
        
        if (pageInfo.apiCalls.length > 0) {
            results.push(pageInfo);
        }
    }

    return results;
}

// ---- Phase 2: Scan API route handlers ----
function deepScanAPI() {
    const apiFiles = walkDir(WORKER_API_SRC);
    const results = {};

    for (const file of apiFiles) {
        const content = fs.readFileSync(file, 'utf-8');
        const relPath = path.relative(WORKER_API_SRC, file);
        
        // Skip non-route files
        if (!content.includes('c.json') && !content.includes('createRoute')) continue;

        const routeInfo = {
            prismaQueries: [],
            returnedFields: [],
            routes: [],
        };

        // Find route paths
        const pathPattern = /path:\s*['"`]([^'"` ]+)['"`]/g;
        let pm;
        while ((pm = pathPattern.exec(content)) !== null) {
            routeInfo.routes.push(pm[1]);
        }

        // Find Prisma queries
        const prismaPattern = /prisma\.(\w+)\.(findMany|findFirst|findUnique|create|update|delete|count|aggregate)\s*\(\s*\{([^}]*(?:\{[^}]*\}[^}]*)*)\}/gs;
        let pq;
        while ((pq = prismaPattern.exec(content)) !== null) {
            const model = pq[1];
            const method = pq[2];
            const args = pq[3];
            
            // Extract select/include fields
            const selectMatch = args.match(/select:\s*\{([^}]+)\}/);
            const includeMatch = args.match(/include:\s*\{([^}]+)\}/);
            
            routeInfo.prismaQueries.push({
                model,
                method,
                select: selectMatch ? selectMatch[1].trim() : null,
                include: includeMatch ? includeMatch[1].trim() : null,
            });
        }

        // Find c.json() return shapes
        const jsonPattern = /c\.json\(\s*(\{[^}]+\}|\[?\w+)/g;
        let jm;
        while ((jm = jsonPattern.exec(content)) !== null) {
            routeInfo.returnedFields.push(jm[1].substring(0, 200));
        }

        if (routeInfo.routes.length > 0 || routeInfo.prismaQueries.length > 0) {
            results[relPath] = routeInfo;
        }
    }

    return results;
}

// ---- Main ----
console.log('\n' + '='.repeat(100));
console.log('🔬 DEEP UI-FIRST END-TO-END ALIGNMENT AUDIT');
console.log('='.repeat(100));

const schema = parseSchema();
console.log(`\n📋 Schema: ${Object.keys(schema).length} models parsed\n`);

// Phase 1: UI
console.log('━'.repeat(100));
console.log('📱 PHASE 1: UI Pages → API Calls → Expected Response Fields');
console.log('━'.repeat(100));
const uiPages = deepScanUI();
console.log(`\nScanned ${uiPages.length} UI pages with API calls\n`);

for (const page of uiPages) {
    if (page.responseFields.length === 0) continue;
    console.log(`\n📄 ${page.file}`);
    for (const call of page.apiCalls) {
        console.log(`   📡 ${call.method} ${call.path} (line ${call.line})`);
    }
    if (page.responseFields.length > 0) {
        console.log(`   📊 UI reads: ${page.responseFields.join(', ')}`);
    }
}

// Phase 2: API
console.log('\n\n' + '━'.repeat(100));
console.log('🔧 PHASE 2: API Route Handlers → Prisma Queries → Return Shapes');
console.log('━'.repeat(100));
const apiHandlers = deepScanAPI();
console.log(`\nScanned ${Object.keys(apiHandlers).length} API route files\n`);

for (const [file, info] of Object.entries(apiHandlers)) {
    if (info.prismaQueries.length === 0) continue;
    console.log(`\n🔗 ${file}`);
    if (info.routes.length > 0) {
        console.log(`   Routes: ${info.routes.join(', ')}`);
    }
    for (const q of info.prismaQueries) {
        let detail = `   🗄️  prisma.${q.model}.${q.method}()`;
        if (q.select) detail += ` select: {${q.select}}`;
        if (q.include) detail += ` include: {${q.include}}`;
        console.log(detail);
        
        // Cross-reference with schema
        // Capitalize first letter for model name lookup
        const modelName = q.model.charAt(0).toUpperCase() + q.model.slice(1);
        if (!schema[modelName]) {
            // Try other casings
            const found = Object.keys(schema).find(k => k.toLowerCase() === q.model.toLowerCase());
            if (!found) {
                console.log(`      ❌ MODEL NOT IN SCHEMA: ${q.model}`);
            }
        }
    }
}

// Phase 3: Cross-reference critical pages
console.log('\n\n' + '━'.repeat(100));
console.log('🎯 PHASE 3: CRITICAL MISMATCHES (UI expects but schema/API may not provide)');
console.log('━'.repeat(100));

let mismatchCount = 0;
for (const page of uiPages) {
    if (page.responseFields.length === 0) continue;
    
    // For each field the UI reads, check if any relevant schema model has it
    const mismatches = [];
    for (const field of page.responseFields) {
        // Check across all schema models
        let foundInAnyModel = false;
        for (const [modelName, fields] of Object.entries(schema)) {
            if (fields[field]) {
                foundInAnyModel = true;
                break;
            }
        }
        if (!foundInAnyModel) {
            mismatches.push(field);
        }
    }
    
    if (mismatches.length > 0) {
        mismatchCount += mismatches.length;
        console.log(`\n⚠️  ${page.file}`);
        console.log(`   Endpoints: ${page.apiCalls.map(c => c.path).join(', ').substring(0, 120)}`);
        console.log(`   ❌ Fields NOT in any schema model: ${mismatches.join(', ')}`);
    }
}

console.log(`\n\n📊 SUMMARY: ${mismatchCount} fields used in UI that don't exist in any schema model`);
console.log('(Some of these may be computed/derived fields returned by API logic, not from DB)\n');
