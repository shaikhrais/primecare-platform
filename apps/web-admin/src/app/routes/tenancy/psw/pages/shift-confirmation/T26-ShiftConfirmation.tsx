import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ShiftConfirmation() {
    return (
        <PageTemplate pageId="T26" title="Shift Confirmation" subtitle="Confirm, modify or cancel upcoming shift assignments"
            sectionData={{
                'T26.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}