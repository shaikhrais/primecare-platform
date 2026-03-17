import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function SignOff() {
    return (
        <PageTemplate pageId="T42" title="Clinical Sign-Off" subtitle="Review and sign off on completed clinical documentation"
            sectionData={{
                'T42.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}