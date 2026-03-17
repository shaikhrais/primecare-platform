import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function PswUserGuide() {
    return (
        <PageTemplate pageId="G1" title="PSW User Guide" subtitle="Interactive guide to using the PrimeCare PSW platform"
            sectionData={{
                'G1.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}