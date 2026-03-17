import fs from 'fs';
import path from 'path';

const routesDir = path.join(process.cwd(), 'apps/web-admin/src/app/routes');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        let isDirectory = fs.statSync(dirPath).isDirectory();
        isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
    });
}

const directCodePages = [];

walkDir(routesDir, (filePath) => {
    if (!filePath.endsWith('.tsx')) return;
    const content = fs.readFileSync(filePath, 'utf8');
    
    // Check if it's likely a page component
    if (!content.includes('export default function') && !content.includes('export const')) return;
    if (filePath.toLowerCase().includes('layout') || filePath.toLowerCase().includes('routes.tsx')) return;
    if (content.split('\n').length < 20) return; // Ignore small boilerplate or index exports
    
    // If it doesn't use PageTemplate but returns JSX
    if (!content.includes('PageTemplate') && (content.includes('<div') || content.includes('return ('))) {
        directCodePages.push(filePath.replace(process.cwd(), ''));
    }
});

fs.writeFileSync('direct-code-pages.json', JSON.stringify(directCodePages, null, 2));
console.log(`Found ${directCodePages.length} pages using direct code.`);
