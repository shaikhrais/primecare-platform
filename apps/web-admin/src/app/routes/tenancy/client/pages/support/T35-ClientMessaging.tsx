import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ClientMessaging() {
    return (
        <PageTemplate pageId="T35" title="Client Messaging" subtitle="Secure messaging with your care team"
            sectionData={{
                'T35.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}