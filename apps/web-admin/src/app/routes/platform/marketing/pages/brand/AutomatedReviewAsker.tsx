import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function AutomatedReviewAsker() {
    return (
        <PageTemplate 
            pageId="PGE-ARA" 
            title="✨ Automated Review Asker" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'ARA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'ARA.empty']: { emptyState: { title: 'Automated Review Asker Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
