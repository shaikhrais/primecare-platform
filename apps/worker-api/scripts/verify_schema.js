/**
 * Deep Verification Script: Cross-references all prisma.MODEL.METHOD({ ... field ... })
 * calls in worker-api route files against the actual Prisma schema.
 * 
 * Reports:
 * 1. Fields referenced in code but missing from schema
 * 2. Models referenced in code but missing from schema
 * 3. Summary of all models used vs defined
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// ========== STEP 1: Parse schema.prisma ==========
const schemaPath = path.join(__dirname, 'prisma', 'schema.prisma');
const schema = fs.readFileSync(schemaPath, 'utf-8');

const models = {};
let currentModel = null;

for (const line of schema.split('\n')) {
    const modelMatch = line.match(/^model\s+(\w+)\s*\{/);
    if (modelMatch) {
        currentModel = modelMatch[1];
        models[currentModel] = { fields: new Set(), relations: new Set() };
        continue;
    }
    if (line.trim() === '}') {
        currentModel = null;
        continue;
    }
    if (currentModel) {
        // Parse field: "  fieldName  Type  ..."
        const fieldMatch = line.trim().match(/^(\w+)\s+(\w+[\[\]?]*)/);
        if (fieldMatch && !fieldMatch[1].startsWith('@@') && !fieldMatch[1].startsWith('//')) {
            const fieldName = fieldMatch[1];
            const fieldType = fieldMatch[2];
            models[currentModel].fields.add(fieldName);
            // Check if it's a relation (type matches another model name)
            if (fieldType.replace('[]', '').replace('?', '') in models || 
                /^[A-Z]/.test(fieldType.replace('[]', '').replace('?', ''))) {
                models[currentModel].relations.add(fieldName);
            }
        }
    }
}

// Build lowercase model name map for Prisma client access (prisma.user => User)
const modelNameMap = {};
for (const modelName of Object.keys(models)) {
    const prismaAccessor = modelName.charAt(0).toLowerCase() + modelName.slice(1);
    modelNameMap[prismaAccessor] = modelName;
}

console.log(`\n========== SCHEMA SUMMARY ==========`);
console.log(`Total models: ${Object.keys(models).length}`);
console.log(`Models: ${Object.keys(models).join(', ')}\n`);

// ========== STEP 2: Find all .ts route files in worker-api/src ==========
const srcDir = path.join(__dirname, 'src');

function findTsFiles(dir) {
    let results = [];
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
        const fullPath = path.join(dir, entry.name);
        if (entry.isDirectory() && !entry.name.startsWith('.') && entry.name !== 'node_modules') {
            results = results.concat(findTsFiles(fullPath));
        } else if (entry.isFile() && (entry.name.endsWith('.ts') || entry.name.endsWith('.tsx'))) {
            results.push(fullPath);
        }
    }
    return results;
}

const tsFiles = findTsFiles(srcDir);
console.log(`Total TypeScript files to scan: ${tsFiles.length}\n`);

// ========== STEP 3: Scan for prisma.model.method() calls and field references ==========
const mismatches = [];
const usedModels = new Set();
const fieldUsageByFile = {};

// Pattern: prisma.modelName.method({ where: { field }, data: { field }, select: { field }, include: { field }, orderBy: { field } })
// We look for prisma.XXXX references and field names inside { }
const prismaCallRegex = /(?:prisma|reqPrisma|c\.get\(['"]prisma['"]\))\.(\w+)\.(findMany|findFirst|findUnique|create|update|upsert|delete|deleteMany|updateMany|count|aggregate|groupBy)\s*\(/g;

// Simpler: find all prisma.MODEL references
const prismaModelRegex = /(?:prisma|reqPrisma)\.(\w+)\./g;

// Find field references in where/data/select/include/orderBy blocks
const fieldRefRegex = /(\w+)\s*:/g;

for (const filePath of tsFiles) {
    const content = fs.readFileSync(filePath, 'utf-8');
    const relativePath = path.relative(__dirname, filePath);
    
    // Find all model accesses
    let match;
    const fileModels = new Set();
    
    while ((match = prismaModelRegex.exec(content)) !== null) {
        const accessor = match[1];
        // Skip non-model methods
        if (['$extends', '$transaction', '$queryRaw', '$executeRaw', '$connect', '$disconnect'].includes(accessor)) continue;
        if (accessor.startsWith('$')) continue;
        
        fileModels.add(accessor);
        usedModels.add(accessor);
        
        // Check if this model exists in schema
        if (!modelNameMap[accessor]) {
            mismatches.push({
                type: 'MISSING_MODEL',
                file: relativePath,
                model: accessor,
                message: `Model "${accessor}" is referenced in code but NOT found in schema.prisma`
            });
        }
    }
    
    // Now find specific field references in prisma operations
    // Look for patterns like: { fieldName: value } inside prisma calls
    const prismaOpRegex = /(?:prisma|reqPrisma)\.(\w+)\.\w+\(\s*\{([\s\S]*?)\}\s*\)/g;
    
    while ((match = prismaOpRegex.exec(content)) !== null) {
        const accessor = match[1];
        const modelName = modelNameMap[accessor];
        if (!modelName || !models[modelName]) continue;
        
        const operationBody = match[2];
        
        // Extract field names from where, data, select, orderBy blocks
        // Look for top-level keys and nested field references
        const blockRegex = /(?:where|data|select|include|orderBy)\s*:\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/g;
        let blockMatch;
        
        while ((blockMatch = blockRegex.exec(operationBody)) !== null) {
            const blockContent = blockMatch[1];
            let fieldMatch;
            const fieldRegex = /\b(\w+)\s*:/g;
            
            while ((fieldMatch = fieldRegex.exec(blockContent)) !== null) {
                const fieldName = fieldMatch[1];
                // Skip JS keywords and Prisma operators
                const skipWords = ['where', 'data', 'select', 'include', 'orderBy', 'skip', 'take', 
                    'cursor', 'distinct', 'AND', 'OR', 'NOT', 'in', 'notIn', 'lt', 'lte', 'gt', 'gte',
                    'contains', 'startsWith', 'endsWith', 'equals', 'not', 'some', 'every', 'none',
                    'is', 'isNot', 'mode', 'set', 'increment', 'decrement', 'multiply', 'divide',
                    'push', 'connect', 'disconnect', 'create', 'update', 'upsert', 'delete',
                    'connectOrCreate', 'createMany', 'updateMany', 'deleteMany',
                    'true', 'false', 'null', 'undefined', 'const', 'let', 'var', 'return',
                    'async', 'await', 'function', 'if', 'else', 'try', 'catch', 'throw',
                    '_count', '_sum', '_avg', '_min', '_max', 'having', 'by'];
                
                if (skipWords.includes(fieldName)) continue;
                if (fieldName.startsWith('_')) continue;
                
                // Check if field exists in the model
                if (!models[modelName].fields.has(fieldName)) {
                    mismatches.push({
                        type: 'MISSING_FIELD',
                        file: relativePath,
                        model: modelName,
                        field: fieldName,
                        message: `Field "${fieldName}" used on model "${modelName}" but NOT in schema`
                    });
                }
            }
        }
    }
}

// ========== STEP 4: Report ==========
console.log(`\n========== MODELS USED IN CODE ==========`);
for (const accessor of [...usedModels].sort()) {
    const modelName = modelNameMap[accessor] || `??? (${accessor})`;
    console.log(`  prisma.${accessor} => ${modelName}`);
}

console.log(`\n========== MODELS IN SCHEMA BUT NEVER USED IN CODE ==========`);
const usedModelNames = new Set([...usedModels].map(a => modelNameMap[a]).filter(Boolean));
for (const modelName of Object.keys(models).sort()) {
    if (!usedModelNames.has(modelName)) {
        console.log(`  ⚠️  ${modelName} — defined in schema but no prisma.${modelName.charAt(0).toLowerCase() + modelName.slice(1)} usage found`);
    }
}

console.log(`\n========== MISMATCHES FOUND ==========`);
if (mismatches.length === 0) {
    console.log('  ✅ No mismatches found!');
} else {
    // Deduplicate
    const seen = new Set();
    const unique = mismatches.filter(m => {
        const key = `${m.type}:${m.model}:${m.field || ''}:${m.file}`;
        if (seen.has(key)) return false;
        seen.add(key);
        return true;
    });
    
    console.log(`  Total unique mismatches: ${unique.length}\n`);
    
    // Group by type
    const byType = {};
    for (const m of unique) {
        if (!byType[m.type]) byType[m.type] = [];
        byType[m.type].push(m);
    }
    
    for (const [type, items] of Object.entries(byType)) {
        console.log(`  --- ${type} (${items.length}) ---`);
        for (const item of items) {
            console.log(`  📁 ${item.file}`);
            console.log(`     ${item.message}`);
        }
        console.log();
    }
}

console.log(`\nDone. Scanned ${tsFiles.length} files against ${Object.keys(models).length} schema models.`);
