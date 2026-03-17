import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function WaitlistManager() {
    return (
        <PageTemplate pageId="L20" title="Waitlist Manager" subtitle="Client waitlist management with priority scoring"
            sectionData={{
                'L20.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}