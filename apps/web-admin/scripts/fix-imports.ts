import fs from 'fs';
import path from 'path';

function walk(dir: string, callback: (path: string) => void) {
    fs.readdirSync(dir).forEach(f => {
        const dirPath = path.join(dir, f);
        if (fs.statSync(dirPath).isDirectory()) walk(dirPath, callback);
        else callback(dirPath);
    });
}

const targetDirs = [
    path.join(__dirname, '../src/app/routes')
];

targetDirs.forEach(dir => {
    walk(dir, (filePath) => {
        if (!filePath.endsWith('.tsx') && !filePath.endsWith('.ts')) return;

        let content = fs.readFileSync(filePath, 'utf-8');
        let modified = false;

        // Missing AdminRegistry import
        if (content.includes('AdminRegistry') && !content.includes(`import { AdminRegistry }`)) {
            // Check if there is already an import from prime-care-shared
            if (content.match(/import\s+\{[^}]*\}\s+from\s+['"]prime-care-shared['"]/)) {
                content = content.replace(/(import\s+\{[^}]*)(\}\s+from\s+['"]prime-care-shared['"])/, `$1, AdminRegistry$2`);
                modified = true;
            } else {
                content = `import { AdminRegistry } from 'prime-care-shared';\n` + content;
                modified = true;
            }
        }

        // Destruct AdminRegistry if needed
        if (content.includes('ContentRegistry') && !content.includes('const { ContentRegistry') && content.includes('AdminRegistry')) {
            const destructureMatch = content.match(/const\s+\{([^}]*)\}\s*=\s*AdminRegistry;/);
            if (destructureMatch) {
                if (!destructureMatch[1].includes('ContentRegistry')) {
                    content = content.replace(/const\s+\{([^}]*)\}\s*=\s*AdminRegistry;/, `const { $1, ContentRegistry } = AdminRegistry;`);
                    modified = true;
                }
            } else {
                content = content.replace(/(import\s+.*?\n\n|import\s+.*?\n)(?=(?:export|const|function|class))/, `$1const { ContentRegistry } = AdminRegistry;\n\n`);
                modified = true;
            }
        }

        // Subcomponents missing `const { t } = useTranslation();`
        // We look for function definitions that have `t(` directly inside them but don't declare it.
        const fnRegex = /(?:export\s+(?:default\s+)?)?(?:const\s+(\w+)\s*=\s*(?:<[^>]*>\s*)?(?:\([^)]*\)|\w+)\s*=>\s*\{(?:\s*return)?|function\s+(\w+)\s*\([^)]*\)\s*\{)/g;
        let match;
        const matches = [];
        while ((match = fnRegex.exec(content)) !== null) {
            matches.push({ index: match.index, length: match[0].length, full: match[0] });
        }

        // iterate backwards to not break indices
        for (let i = matches.length - 1; i >= 0; i--) {
            const m = matches[i];
            const nextFnIndex = i + 1 < matches.length ? matches[i + 1].index : content.length;
            const body = content.substring(m.index + m.length, nextFnIndex);

            if (body.includes('t(') && !body.includes('const { t } = useTranslation();')) {
                // inject it
                content = content.slice(0, m.index + m.length) + `\n    const { t } = useTranslation();` + content.slice(m.index + m.length);
                modified = true;
            }
        }

        // Missing useTranslation import when t() is used
        if (content.includes('useTranslation()') && !content.includes(`import { useTranslation } from 'react-i18next'`)) {
            const importMatch = content.match(/^import .*?;\r?\n/gm);
            if (importMatch && importMatch.length > 0) {
                const lastImport = importMatch[importMatch.length - 1];
                const lastImportIndex = content.lastIndexOf(lastImport) + lastImport.length;
                content = content.slice(0, lastImportIndex) + `import { useTranslation } from 'react-i18next';\n` + content.slice(lastImportIndex);
            } else {
                content = `import { useTranslation } from 'react-i18next';\n` + content;
            }
            modified = true;
        }

        if (modified) {
            fs.writeFileSync(filePath, content, 'utf-8');
            console.log('Fixed imports in', filePath);
        }
    });
});
