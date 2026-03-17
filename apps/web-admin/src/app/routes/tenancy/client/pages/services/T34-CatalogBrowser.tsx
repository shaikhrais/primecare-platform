import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function CatalogBrowser() {
    return (
        <PageTemplate pageId="T34" title="Service Catalog" subtitle="Browse available care services and request bookings"
            sectionData={{
                'T34.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}