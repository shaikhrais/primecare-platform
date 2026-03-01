import fs from 'fs';
import path from 'path';

const log = fs.readFileSync('tsc_utf8.log', 'utf-8');
const lines = log.split('\n');

const missingAdminRegistry = new Set<string>();
const missingT = new Set<string>();
const functionCalls = new Set<string>();

for (const line of lines) {
    if (line.includes("error TS2304: Cannot find name 'AdminRegistry'")) {
        const file = line.split('(')[0].trim();
        if (file) missingAdminRegistry.add(file);
    }
    if (line.includes("error TS2304: Cannot find name 't'")) {
        const file = line.split('(')[0].trim();
        if (file) missingT.add(file);
    }
    // "error TS2349: This expression is not callable"
    if (line.includes("error TS2349:") || line.includes("error TS2345:")) {
        const file = line.split('(')[0].trim();
        if (file) functionCalls.add(file);
    }
}

missingAdminRegistry.forEach(f => {
    try {
        let text = fs.readFileSync(f, 'utf-8');
        if (!text.includes("import { AdminRegistry")) {
            text = `import { AdminRegistry } from 'prime-care-shared';\n` + text;
            fs.writeFileSync(f, text);
            console.log("Fixed AdminRegistry in", f);
        }
    } catch (e) { }
});

missingT.forEach(f => {
    try {
        let text = fs.readFileSync(f, 'utf-8');
        let modified = false;
        if (!text.includes("import { useTranslation")) {
            text = `import { useTranslation } from 'react-i18next';\n` + text;
            modified = true;
        }

        // Very basic injection for functional components missing the hook
        if (!text.includes("const { t } = useTranslation();")) {
            const regexes = [
                /(export\s+default\s+function\s+[a-zA-Z0-9_]+\s*\([^)]*\)\s*\{)/,
                /(export\s+function\s+[a-zA-Z0-9_]+\s*\([^)]*\)\s*\{)/,
                /(const\s+[a-zA-Z0-9_]+\s*:\s*React\.FC(?:<[^>]*>)?\s*=\s*(?:\([^)]*\)|[a-zA-Z0-9_]+)\s*=>\s*\{)/,
                /(const\s+[a-zA-Z0-9_]+\s*=\s*(?:\([^)]*\)|[a-zA-Z0-9_]+)\s*=>\s*\{)/,
                /(export\s+const\s+[a-zA-Z0-9_]+\s*=\s*(?:\([^)]*\)|[a-zA-Z0-9_]+)\s*=>\s*\{)/
            ];

            for (const r of regexes) {
                if (r.test(text)) {
                    text = text.replace(r, `$1\n    const { t } = useTranslation();`);
                    modified = true;
                    // Fix only first match per file usually, or global? Wait, one file might have multiple components.
                    // Doing a global replace might be safer.
                    break;
                }
            }

            // if we didn't break out properly with a direct match, let's just do global replace:
            if (modified) {
                // already done
            } else {
                // global replace
                text = text.replace(/(export\s+(?:default\s+)?function\s+[a-zA-Z0-9_]+\s*\([^)]*\)\s*\{)/g, `$1\n    const { t } = useTranslation();`);
                text = text.replace(/(const\s+[a-zA-Z0-9_]+\s*(?::\s*React\.FC(?:<[^>]*>)?)?\s*=\s*(?:\([^)]*\)|[a-zA-Z0-9_]+)\s*=>\s*\{)/g, `$1\n    const { t } = useTranslation();`);
                text = text.replace(/(export\s+const\s+[a-zA-Z0-9_]+\s*(?::\s*React\.FC(?:<[^>]*>)?)?\s*=\s*(?:\([^)]*\)|[a-zA-Z0-9_]+)\s*=>\s*\{)/g, `$1\n    const { t } = useTranslation();`);
                modified = true;
            }
        }

        if (modified) {
            fs.writeFileSync(f, text);
            console.log("Fixed t in", f);
        }
    } catch (e) { }
});

functionCalls.forEach(f => {
    try {
        let text = fs.readFileSync(f, 'utf-8');
        let newText = text.replace(/t\((ContentRegistry\.[a-zA-Z0-9_.]+)\)\s*\(/g, '$1(');
        newText = newText.replace(/t\((ContentRegistry\.[a-zA-Z0-9_.]+)\)\.map/g, '$1.map');

        if (newText !== text) {
            fs.writeFileSync(f, newText);
            console.log("Fixed function call / map in", f);
        }
    } catch (e) { }
});
