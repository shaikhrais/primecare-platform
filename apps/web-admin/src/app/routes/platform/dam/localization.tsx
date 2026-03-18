import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from GlobalI18nDictionary.tsx ---
export function GlobalI18nDictionary() {
    return (
        <PageTemplate 
            pageId="PGE-GI1" 
            title="✨ Global I18n Dictionary" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'GI1.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'GI1.empty']: { emptyState: { title: 'Global I18n Dictionary Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
