import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function AvailabilityPage() {
    return (
        <PageTemplate pageId="F15" title="Set Availability" subtitle="Manage your weekly availability and time-off preferences"
            sectionData={{
                'F15.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}