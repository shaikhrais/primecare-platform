// PAGE IDENTITY: R8 · EVV Export
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function EvvExport() {
    return (
        <PageTemplate pageId="R8" title="📥 EVV Export" subtitle="Export EVV data for billing, compliance & payer submissions"
            sectionData={{
                'R8.stats': { kpiCards: [
                    { label: 'Exportable Records', value: '2.4K', color: 'var(--pc-primary)' },
                    { label: 'Last Export', value: 'Today', color: 'var(--pc-success)' },
                    { label: 'Format', value: 'CSV/XML', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R8.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw EVV data — all fields, date-filterable' },
                    { icon: '📋', title: 'XML (Payer Format)', subtitle: 'OHIP/CCAC-compliant structured format' },
                    { icon: '📊', title: 'Summary PDF', subtitle: 'Aggregated EVV compliance report' },
                ], columns: 3 } },
            }}
        />
    );
}
