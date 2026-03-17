// ================================================================
// PAGE IDENTITY: H9 · Reference Data Hub
// Type: Hub | Owner: admin | Registry: H9
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const refDataModules = [
    { icon: '🗂️', title: 'Service Codes', subtitle: 'OHIP billing codes, service types & rates' },
    { icon: '📋', title: 'Diagnosis Codes', subtitle: 'ICD-10 code management & lookup' },
    { icon: '🏥', title: 'Facility Registry', subtitle: 'Care homes, clinics & satellite offices' },
    { icon: '💊', title: 'Drug Formulary', subtitle: 'Approved medications, NDC codes & interactions' },
    { icon: '📍', title: 'Service Areas', subtitle: 'Geographic zones, postal code mapping' },
    { icon: '📊', title: 'Fee Schedules', subtitle: 'Payer-specific rates, modifiers & contracts' },
];

export default function ReferenceDataHub() {
    return (
        <PageTemplate
            pageId="H9"
            title="🗂️ Reference Data Hub"
            subtitle="Master data management — service codes, diagnosis codes, facilities & fee schedules"
            actionPageId="admin.reference-data"
            sectionData={{
                'H9.stats': { kpiCards: [
                    { label: 'Service Codes', value: 342, color: 'var(--pc-primary)' },
                    { label: 'Facilities', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Drug Records', value: 1240, color: '#7C3AED' },
                    { label: 'Last Sync', value: 'Today', color: 'var(--pc-success)' },
                ]},
                'H9.modules': { cardGrid: { items: refDataModules, columns: 3 } },
            }}
        />
    );
}
