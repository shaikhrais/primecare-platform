import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function CostOfCareCalculator() {
    return (
        <PageTemplate 
            pageId="PGE-COC" 
            title="✨ Cost Of Care Calculator" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'COC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'COC.empty']: { emptyState: { title: 'Cost Of Care Calculator Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
