import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ErrorPayloadInspector() {
    return (
        <PageTemplate 
            pageId="PGE-EPI" 
            title="✨ Error Payload Inspector" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'EPI.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'EPI.empty']: { emptyState: { title: 'Error Payload Inspector Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
