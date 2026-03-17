import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function NoCodeBuilderMock() {
    return (
        <PageTemplate 
            pageId="PGE-NCB" 
            title="✨ No Code Builder Mock" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'NCB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'NCB.empty']: { emptyState: { title: 'No Code Builder Mock Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
