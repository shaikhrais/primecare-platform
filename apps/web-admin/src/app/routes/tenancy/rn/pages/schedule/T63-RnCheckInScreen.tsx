import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function RnCheckInScreen() {
    return (
        <PageTemplate pageId="T63" title="RN Check-In" subtitle="Nursing visit check-in with clinical assessment triggers"
            sectionData={{
                'T63.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}