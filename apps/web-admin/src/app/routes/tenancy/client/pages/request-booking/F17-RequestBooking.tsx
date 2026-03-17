import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function RequestBooking() {
    return (
        <PageTemplate pageId="F17" title="Request Booking" subtitle="Request a new care visit or service appointment"
            sectionData={{
                'F17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}