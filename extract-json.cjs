const fs = require('fs');

const enTsPath = 'apps/web-admin/src/locales/en.ts';
const enJsonPath = 'apps/web-admin/src/locales/en.json';
const frJsonPath = 'apps/web-admin/src/locales/fr.json';

if (fs.existsSync(enTsPath)) {
    // We already parsed it out in execute-i18n.cjs, we can just require or re-parse.
    let content = fs.readFileSync(enTsPath, 'utf8');
    let match = content.match(/export const en = (\{[\s\S]*?\});/);
    if (match) {
        fs.writeFileSync(enJsonPath, match[1]);
        
        // Create an empty fr.json if it doesn't exist
        if (!fs.existsSync(frJsonPath)) {
            fs.writeFileSync(frJsonPath, "{}");
        }
        
        // Remove en.ts
        fs.unlinkSync(enTsPath);
        console.log("Converted en.ts to en.json!");
    }
}
