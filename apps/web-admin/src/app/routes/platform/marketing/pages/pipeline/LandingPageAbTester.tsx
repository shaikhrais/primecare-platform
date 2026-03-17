import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function LandingPageAbTester() {
    return (
        <PageTemplate 
            pageId="PGE-LPA" 
            title="✨ Landing Page Ab Tester" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'LPA.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'LPA.empty']: { emptyState: { title: 'Landing Page Ab Tester Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
