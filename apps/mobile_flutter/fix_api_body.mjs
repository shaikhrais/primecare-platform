import fs from 'fs';
import path from 'path';

const directory = 'c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/mobile_flutter/lib';

function walkDir(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            walkDir(fullPath);
        } else if (fullPath.endsWith('.dart')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            let modified = false;

            // Replace apiClient.post(..., body: { with apiClient.post(..., {
            const regexPost = /apiClient\.post\(([^,]+),\s*body:\s*\{/g;
            if (regexPost.test(content)) {
                content = content.replace(regexPost, 'apiClient.post($1, {');
                modified = true;
            }

            const regexPut = /apiClient\.put\(([^,]+),\s*body:\s*\{/g;
            if (regexPut.test(content)) {
                content = content.replace(regexPut, 'apiClient.put($1, {');
                modified = true;
            }

            const regexPatch = /apiClient\.patch\(([^,]+),\s*body:\s*\{/g;
            if (regexPatch.test(content)) {
                content = content.replace(regexPatch, 'apiClient.patch($1, {');
                modified = true;
            }

            if (modified) {
                fs.writeFileSync(fullPath, content);
                console.log('Fixed API call in: ' + fullPath);
            }
        }
    }
}

walkDir(directory);
console.log('Global API Client named parameter bypass complete!');
