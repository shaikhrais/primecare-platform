import * as fs from 'fs';
import * as path from 'path';

const SRC_DIR = path.join(process.cwd(), 'archive', 'services', 'client-service', 'src');

function walk(dir) {
    let results = [];
    const list = fs.readdirSync(dir);
    list.forEach(file => {
        file = path.join(dir, file);
        const stat = fs.statSync(file);
        if (stat && stat.isDirectory()) {
            results = results.concat(walk(file));
        } else if (file.endsWith('.ts')) {
            results.push(file);
        }
    });
    return results;
}

const files = walk(SRC_DIR);
let replaced = 0;

for (const file of files) {
    let content = fs.readFileSync(file, 'utf8');
    const original = content;

    // Replace shared-* imports with new packages
    content = content.replace(/@primecare\/shared-utils/g, '@primecare/infrastructure');
    content = content.replace(/@primecare\/shared-auth/g, '@primecare/security');
    content = content.replace(/@primecare\/shared-types/g, '@primecare/contracts');
    content = content.replace(/@primecare\/shared-events/g, '@primecare/infrastructure'); // verify this mapping
    
    // Bindings typically come from shared-types, but in Hono contexts it's typically just Variables/Bindings
    if (content !== original) {
        fs.writeFileSync(file, content, 'utf8');
        replaced++;
    }
}

console.log(`Replaced imports in ${replaced} files.`);
