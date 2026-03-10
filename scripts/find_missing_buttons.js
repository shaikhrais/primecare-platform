const fs = require('fs');
const { execSync } = require('child_process');

const registry = fs.readFileSync('./packages/shared/src/registries/ButtonRegistry.ts', 'utf8');
const regex = /id:\s*'([^']+)'/g;
const matches = [...registry.matchAll(regex)];
const buttons = matches.map(m => m[1]);

let missing = [];
for (let b of buttons) {
    try {
        execSync(`findstr /S /C:"${b}" apps\\web-admin\\src\\*.*`, { stdio: 'ignore' });
    } catch (e) {
        missing.push(b);
    }
}
console.log("MISSING_BUTTONS_START");
console.log(missing.join('\n'));
console.log("MISSING_BUTTONS_END");
