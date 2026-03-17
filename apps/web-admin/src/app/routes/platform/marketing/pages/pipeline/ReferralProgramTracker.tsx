import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ReferralProgramTracker() {
    return (
        <PageTemplate 
            pageId="PGE-RPT" 
            title="✨ Referral Program Tracker" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'RPT.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RPT.empty']: { emptyState: { title: 'Referral Program Tracker Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
