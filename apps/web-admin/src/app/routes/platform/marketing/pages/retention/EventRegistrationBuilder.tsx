import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function EventRegistrationBuilder() {
    return (
        <PageTemplate 
            pageId="PGE-ERB" 
            title="✨ Event Registration Builder" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'ERB.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ERB.empty']: { emptyState: { title: 'Event Registration Builder Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
