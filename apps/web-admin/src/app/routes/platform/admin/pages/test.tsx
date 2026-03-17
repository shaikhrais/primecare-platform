import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function TestPage() {
    return (
        <PageTemplate 
            pageId="PGE-TP" 
            title="✨ Test Page" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'TP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TP.empty']: { emptyState: { title: 'Test Page Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
