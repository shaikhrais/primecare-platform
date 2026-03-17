import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function StaffDashboard() {
    return (
        <PageTemplate pageId="D19" title="Staff Dashboard" subtitle="Your daily tasks, messages and team operations"
            sectionData={{
                'D19.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}