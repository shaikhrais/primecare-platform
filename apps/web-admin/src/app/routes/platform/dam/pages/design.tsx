import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from DynamicTokenEditor.tsx ---
export function DynamicTokenEditor() {
    return (
        <PageTemplate 
            pageId="PGE-DTE" 
            title="✨ Dynamic Token Editor" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'DTE.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DTE.empty']: { emptyState: { title: 'Dynamic Token Editor Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from FontTypographyRegistry.tsx ---
export function FontTypographyRegistry() {
    return (
        <PageTemplate 
            pageId="PGE-FTR" 
            title="✨ Font Typography Registry" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'FTR.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'FTR.empty']: { emptyState: { title: 'Font Typography Registry Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
