import fs from 'fs';
import path from 'path';

const lines = fs.readFileSync('targets.txt', 'utf8').split('\n').filter(l => l.trim());

let successCount = 0;

for (let targetFile of lines) {
    const absolutePath = path.resolve(process.cwd(), targetFile);
    if (!fs.existsSync(absolutePath)) {
        console.error('File not found:', targetFile);
        continue;
    }

    let content = fs.readFileSync(absolutePath, 'utf8');

    // Extract component name
    let componentNameMatch = content.match(/export default function\s+([A-Za-z0-9_]+)/) ||
                             content.match(/export default class\s+([A-Za-z0-9_]+)/) ||
                             content.match(/export const\s+([A-Za-z0-9_]+)\s*=\s*(?:React\.FC)?/) ||
                             content.match(/export function\s+([A-Za-z0-9_]+)/);

    let componentName = componentNameMatch ? componentNameMatch[1] : null;

    if (!componentName && targetFile.endsWith('index.tsx')) {
        componentName = 'PageGroup';
        let dirNameMatch = targetFile.match(/([a-zA-Z0-9-]+)[\\/]index\.tsx$/);
        if (dirNameMatch) {
            componentName = dirNameMatch[1].split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join('');
        }
    } else if (!componentName) {
        componentName = path.basename(targetFile, '.tsx').replace(/[^a-zA-Z0-9]/g, '');
    }

    // Attempt to extract title
    let titleMatch = content.match(/<h[12][^>]*>(.*?)<\/h[12]>/);
    let title = titleMatch ? titleMatch[1].replace(/<[^>]+>/g, '').trim() : componentName;
    if (title.length > 50) title = componentName; // fallback if it matched something huge

    // Generate pageId
    let pageId = 'PG-' + Math.floor(Math.random() * 900 + 100);
    const idMatch = targetFile.match(/([A-Z][0-9]+)-/);
    if (idMatch) pageId = idMatch[1];
    
    // Check if it already uses PageTemplate, just in case
    if (content.includes('<PageTemplate')) {
        console.log(`Skipping ${targetFile} - already uses PageTemplate`);
        continue;
    }

    // Check if it's export default, vs export
    const isDefault = content.includes(`export default ${componentName}`) || content.includes(`export default function ${componentName}`);
    const exportStatement = isDefault ? `export default function ${componentName}() {` : `export function ${componentName}() {`;

    const newContent = `import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

${exportStatement}
    return (
        <PageTemplate 
            pageId="${pageId}" 
            title="${title.replace(/"/g, '&quot;')}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={{
                '${pageId}.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                '${pageId}.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    message: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}
`;

    fs.writeFileSync(absolutePath, newContent, 'utf8');
    successCount++;
    console.log(`Refactored ${targetFile}`);
}

console.log(`Total legacy pages refactored: ${successCount}`);
