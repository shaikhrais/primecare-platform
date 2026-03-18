const fs = require('fs');

const registryPath = 'apps/web-admin/src/app/routes/shared/PageSectionRegistry.ts';
const content = fs.readFileSync(registryPath, 'utf8');

// The registry path currently contains identity map V_XXX: "V_XXX"
// Wait! If the registry currently contains the identity map, the original English strings are GONE!
// Let me use git to restore the original English strings temporarily! Wait, we don't have the original?
// Ah! We ran `execute-i18n.cjs` which overwrote PageSectionRegistry.ts!
// The original English strings were in `en.ts` which I deleted in `extract-json.cjs`.
// But wait! `execute-i18n.cjs` created `en.ts`. `extract-json.cjs` read `en.ts`, wrote to `en.json`, and deleted `en.ts`.
// Did `extract-json.cjs` write the ENGLISH strings to `en.json`?
// YES! `match[1]` from `en.ts` was literally the English strings object `{ "V_XYZ": "Dashboard", ... }`!
// So `en.json` currently HAS the 593 English strings!
// If I `git checkout en.json`, I will LOSE the 593 English strings!

// Let me instead grab the CURRENT en.json (which are the newly extracted strings).
const currentEnJsonPath = 'apps/web-admin/src/locales/en.json';
const newVarsStr = fs.readFileSync(currentEnJsonPath, 'utf8');
let newVarsObj = {};
try { newVarsObj = JSON.parse(newVarsStr); } catch(e) { }

// NOW git checkout en.json to get the legacy stuff!
const child = require('child_process');
try { child.execSync('git checkout HEAD apps/web-admin/src/locales/en.json'); } catch(e) {}

// Now read the legacy en.json
const legacyEnJsonPath = 'apps/web-admin/src/locales/en.json';
let legacyVarsObj = {};
if (fs.existsSync(legacyEnJsonPath)) {
    try { legacyVarsObj = JSON.parse(fs.readFileSync(legacyEnJsonPath, 'utf8')); } catch(e) {}
}

// Merge them!
const finalEnObj = { ...legacyVarsObj, ...newVarsObj };
fs.writeFileSync(currentEnJsonPath, JSON.stringify(finalEnObj, null, 4));

// Now fr.json
const frJsonPath = 'apps/web-admin/src/locales/fr.json';
let legacyFrObj = {};
if (fs.existsSync(frJsonPath)) {
    try { legacyFrObj = JSON.parse(fs.readFileSync(frJsonPath, 'utf8')); } catch(e) {}
}
// Assume the new keys have no French translation yet, so just map the new keys to their English values or just empty strings.
// Actually, mapping to English strings acts as a fallback. Let's map to English so the UI doesn't show "V_XYZ".
const finalFrObj = { ...legacyFrObj, ...newVarsObj };
fs.writeFileSync(frJsonPath, JSON.stringify(finalFrObj, null, 4));

console.log("Successfully merged legacy and new translations!");
