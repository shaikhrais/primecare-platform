import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function CaregiverSpotlightCreator() {
    return (
        <PageTemplate 
            pageId="PGE-CSC" 
            title="✨ Caregiver Spotlight Creator" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'CSC.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'CSC.empty']: { emptyState: { title: 'Caregiver Spotlight Creator Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
