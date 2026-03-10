const fs = require('fs');
const path = require('path');

const schemaPath = path.join(__dirname, 'prisma', 'schema.prisma');
let schema = fs.readFileSync(schemaPath, 'utf8');

// 1. Enums -> String fields
const enumRegex = /enum\s+(\w+)\s*{([^}]+)}/g;
const enums = {};
let match;
while ((match = enumRegex.exec(schema)) !== null) {
    const enumName = match[1];
    enums[enumName] = true;
}

// Strip enum definitions
schema = schema.replace(enumRegex, '');

// Replace enum usages with String
for (const enumName of Object.keys(enums)) {
    const usageRegex = new RegExp(`(\\s+\\w+\\s+)${enumName}(\\s|\\?)`, 'g');
    schema = schema.replace(usageRegex, `$1String$2`);

    // Also handle default values that were enum references
    const defaultRegex = new RegExp(`(@default\\()([a-zA-Z_]+)(\\))`, 'g');
    schema = schema.replace(defaultRegex, (match, prefix, val, suffix) => {
        // Basic heuristic: if it looks like an enum constant, quote it
        if (val === 'now' || val === 'uuid' || val === 'cuid' || val === 'autoincrement' || val === 'true' || val === 'false') return match;
        return `${prefix}"${val}"${suffix}`;
    });
}

// 2. String[] -> String
schema = schema.replace(/String\[\]/g, 'String');

// 3. Json -> String
schema = schema.replace(/Json/g, 'String');

schema = schema.replace(/@db\.Decimal\(\d+,\s?\d+\)/g, '');

fs.writeFileSync(schemaPath, schema);
console.log('Schema modernized for SQLite');
