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

function processFiles() {
    let filesToRefactor = [];
    walkDir(routesDir, (filePath) => {
        if (!filePath.endsWith('.tsx')) return;
        const content = fs.readFileSync(filePath, 'utf8');
        
        // Exclude Layouts, Auth, Error boundaries, and pure non-page components
        const lowerPath = filePath.toLowerCase();
        if (lowerPath.includes('layout') || lowerPath.includes('routes.tsx')) return;
        if (lowerPath.includes('_app') || lowerPath.includes('index.tsx') && filePath.includes('shared')) return;
        if (lowerPath.includes('\\auth\\') || lowerPath.includes('/auth/')) return;
        if (lowerPath.includes('\\error\\') || lowerPath.includes('/error/')) return;
        
        // Exclude index.tsx if it's just exporting things
        if (filePath.endsWith('index.tsx') && content.split('\n').length < 20) return;
        
        // If it doesn't use PageTemplate but returns JSX directly
        if (!content.includes('PageTemplate') && (content.includes('<div') || content.includes('return ('))) {
            // Further filter to likely "Pages"
            if (content.match(/export (default )?function /) || content.match(/export (const|let) [A-Z][a-zA-Z0-9_]*.*=/)) {
                filesToRefactor.push(filePath);
            }
        }
    });

    console.log(`Found ${filesToRefactor.length} files to refactor.`);

    filesToRefactor.forEach(filePath => {
        const content = fs.readFileSync(filePath, 'utf8');
        // Extract component name
        let componentName = 'UnknownPage';
        
        const funcMatch = content.match(/export (default )?function ([A-Z][a-zA-Z0-9_]*)/);
        const constMatch = content.match(/export (const|let) ([A-Z][a-zA-Z0-9_]*)/);
        
        if (funcMatch) {
            componentName = funcMatch[2];
        } else if (constMatch) {
            componentName = constMatch[2];
        }

        // Generate ID from component name
        let pageId = componentName.replace(/[a-z]/g, '').slice(0, 3).toUpperCase() || 'PGE';
        if (pageId.length < 2) pageId = pageId + 'X';

        // Extract a title from component name
        let pageTitle = componentName.replace(/([A-Z])/g, ' $1').trim();

        const newContent = `import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ${componentName}() {
    return (
        <PageTemplate 
            pageId="PGE-${pageId}" 
            title="✨ ${pageTitle}" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + '${pageId}.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + '${pageId}.empty']: { emptyState: { title: '${pageTitle} Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
`;
        fs.writeFileSync(filePath, newContent, 'utf8');
        console.log(`Refactored: ${filePath}`);
    });
}

processFiles();
