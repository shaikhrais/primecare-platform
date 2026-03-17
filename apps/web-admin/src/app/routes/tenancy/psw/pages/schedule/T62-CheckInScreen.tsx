import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function CheckInScreen() {
    return (
        <PageTemplate pageId="T62" title="Check-In" subtitle="GPS-verified check-in and check-out for client visits"
            sectionData={{
                'T62.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}