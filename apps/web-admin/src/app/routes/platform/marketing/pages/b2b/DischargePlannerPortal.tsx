import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function DischargePlannerPortal() {
    return (
        <PageTemplate 
            pageId="PGE-DPP" 
            title="✨ Discharge Planner Portal" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'DPP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DPP.empty']: { emptyState: { title: 'Discharge Planner Portal Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
