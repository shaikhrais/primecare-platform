// PAGE IDENTITY: R2 · Export Page
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ExportPage() {
    return (
        <PageTemplate pageId="R2" title="📥 Data Export" subtitle="Export platform data in CSV, PDF, Excel & JSON formats"
            sectionData={{
                'R2.stats': { kpiCards: [
                    { label: 'Export Types', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Generated Today', value: 3, color: 'var(--pc-success)' },
                    { label: 'Scheduled', value: 2, color: 'var(--pc-info, #2563EB)' },
                ]},
                'R2.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw data tables — clients, visits, timesheets, billing' },
                    { icon: '📋', title: 'PDF Reports', subtitle: 'Formatted reports with charts, summaries & branding' },
                    { icon: '📊', title: 'Excel Workbook', subtitle: 'Multi-sheet workbooks with pivot data & formulas' },
                    { icon: '🔗', title: 'JSON / API', subtitle: 'Machine-readable data for system integrations' },
                ], columns: 2 } },
            }}
        />
    );
}
