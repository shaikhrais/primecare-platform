import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

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

let modifiedFiles: string[] = [];

targetDirs.forEach(dir => {
    walk(dir, (filePath) => {
        if (!filePath.endsWith('.tsx') && !filePath.endsWith('.ts')) return;

        let content = fs.readFileSync(filePath, 'utf-8');

        if (!content.includes('ContentRegistry.')) return;

        const regex = /(?<!t\(\s*)(ContentRegistry\.[a-zA-Z0-9_\.]+)(?!\s*\w)/g;

        let newContent = content.replace(regex, (match, p1) => {
            return `t(${p1})`;
        });

        if (newContent !== content) {
            // Also handle functions: t(ContentRegistry.ADMIN.STATUS.ONLINE)('1.0.4')
            // Actually, in the UI they are ContentRegistry.ADMIN_DASHBOARD.STATUS.ONLINE('1.0.4')
            // After our regex it became t(ContentRegistry.ADMIN_DASHBOARD.STATUS.ONLINE)('1.0.4')
            // Wait, does t() return a function if the registry value was a function?
            // i18next `t` returns a string. If the registry had a function that takes '1.0.4',
            // i18next doesn't support functions natively like that.
            // Let's fix that manualy.

            if (!newContent.includes('useTranslation')) {
                // Find last import
                const importMatch = newContent.match(/^import .*?;\r?\n/gm);
                if (importMatch && importMatch.length > 0) {
                    const lastImport = importMatch[importMatch.length - 1];
                    const lastImportIndex = newContent.lastIndexOf(lastImport) + lastImport.length;
                    newContent = newContent.slice(0, lastImportIndex) + `import { useTranslation } from 'react-i18next';\n` + newContent.slice(lastImportIndex);
                } else {
                    newContent = `import { useTranslation } from 'react-i18next';\n` + newContent;
                }
            }

            // Attempt to inject const { t } = useTranslation(); into the component body.
            // Look for `const [Name] = (...) => {` or `export default function [Name](...) {`
            newContent = newContent.replace(/(const [A-Z][a-zA-Z0-9_]* = [^=]*?=> \{|export (?:default )?function [A-Z][a-zA-Z0-9_]*\s*\([^\)]*\)\s*\{)/g, `$1\n    const { t } = useTranslation();`);

            fs.writeFileSync(filePath, newContent, 'utf-8');
            modifiedFiles.push(filePath);
        }
    });
});

console.log('Modified files:', modifiedFiles);
