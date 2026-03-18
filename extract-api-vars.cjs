const fs = require('fs');
const glob = require('glob');

function extractApiRegistry() {
    const files = glob.sync('packages/shared/src/registries/ApiRegistry/*.ts');
    let dict = {};
    
    files.forEach(f => {
        let content = fs.readFileSync(f, 'utf8');
        
        // Match string literals like '/admin/users' or '/api/v1/...'
        content = content.replace(/(?<=:\s*)(['"])(.*?)\1(?:,|\s*$)/gm, (match, quote, text) => {
            if (!text || text.trim() === '' || !text.includes('/')) return match;
            
            // Generate a clean variable name from the path optionally
            let key = 'API_' + text.replace(/[^a-zA-Z0-9]/g, '_').toUpperCase().replace(/_+/g, '_').replace(/^_|_$/g, '');
            if (!key || key === 'API_') key = 'API_VAR_' + Math.random().toString(36).substr(2, 5).toUpperCase();
            
            // Deduplicate keys
            if (dict[key] && dict[key] !== text) {
                key = key + '_' + Math.random().toString(36).substr(2, 3).toUpperCase();
            }
            
            dict[key] = text;
            return match.replace(quote + text + quote, 'API_VARS.' + key);
        });

        // Insert API_VARS import if not present
        if (!content.includes('API_VARS')) {
            content = `import { API_VARS } from './api-vars';\n` + content;
        }

        fs.writeFileSync(f, content);
    });

    // Create the variables file
    const varsFile = `// Auto-extracted API string variables\nexport const API_VARS: Record<string, string> = ${JSON.stringify(dict, null, 4)};\n`;
    fs.writeFileSync('packages/shared/src/registries/ApiRegistry/api-vars.ts', varsFile);
    
    // Update index.ts to export api-vars
    let indexContent = fs.readFileSync('packages/shared/src/registries/ApiRegistry/index.ts', 'utf8');
    if (!indexContent.includes('api-vars')) {
        fs.writeFileSync('packages/shared/src/registries/ApiRegistry/index.ts', indexContent + `\nexport * from './api-vars';\n`);
    }

    console.log("Extracted " + Object.keys(dict).length + " strings from ApiRegistry.");
}

extractApiRegistry();
