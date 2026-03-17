import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function DripEmailSequenceBuilder() {
    return (
        <PageTemplate 
            pageId="PGE-DES" 
            title="✨ Drip Email Sequence Builder" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'DES.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DES.empty']: { emptyState: { title: 'Drip Email Sequence Builder Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
