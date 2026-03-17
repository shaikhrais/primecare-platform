import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function IncidentPortal() {
    return (
        <PageTemplate pageId="T45" title="Incident Portal" subtitle="Report, track and resolve workplace incidents"
            sectionData={{
                'T45.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}