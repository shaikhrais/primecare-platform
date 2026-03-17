import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function HandoverPage() {
    return (
        <PageTemplate pageId="F13" title="Shift Handover" subtitle="Complete shift handover documentation and notes"
            sectionData={{
                'F13.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}