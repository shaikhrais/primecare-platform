import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function TeamRoster() {
    return (
        <PageTemplate pageId="T36" title="Team Roster" subtitle="Your care team members and contact information"
            sectionData={{
                'T36.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}