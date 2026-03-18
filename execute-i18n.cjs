const fs = require('fs');
const path = require('path');

const registryPath = 'apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts';
let content = fs.readFileSync(registryPath, 'utf8');

const match = content.match(/export const TEXT_VARS: Record<string, string> = (\{[\s\S]*?\});/);
if (match) {
    const textVarsStr = match[1];
    const textVarsObj = JSON.parse(textVarsStr);
    
    const localesDir = 'apps/web-admin/src/locales';
    if (!fs.existsSync(localesDir)) fs.mkdirSync(localesDir, { recursive: true });
    fs.writeFileSync(path.join(localesDir, 'en.ts'), `// Auto-generated English translations\nexport const en = ${JSON.stringify(textVarsObj, null, 4)};\n`);
    
    const identityMap = {};
    for (const key of Object.keys(textVarsObj)) {
        identityMap[key] = key;
    }
    const newTextVarsStr = JSON.stringify(identityMap, null, 4);
    content = content.replace(match[0], `export const TEXT_VARS: Record<string, string> = ${newTextVarsStr};`);
    fs.writeFileSync(registryPath, content);
    console.log("Successfully created en.ts and replaced TEXT_VARS with identity map.");
} else {
    console.log("Could not find TEXT_VARS.");
}
