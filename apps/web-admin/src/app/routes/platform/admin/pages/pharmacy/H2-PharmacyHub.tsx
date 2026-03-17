// ================================================================
// PAGE IDENTITY: H2 · Pharmacy Hub
// Type: Hub | Owner: admin | Registry: H2
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const prescriptions = [
    { medication: '💊 Metformin 500mg', patient: 'Margaret Chen', frequency: 'BID (2x daily)', status: 'Active', nextDose: '18:00' },
    { medication: '💊 Lisinopril 10mg', patient: 'Robert Williams', frequency: 'QD (1x daily)', status: 'Active', nextDose: '08:00' },
    { medication: '💊 Warfarin 5mg', patient: 'Susan Park', frequency: 'QD (1x daily)', status: 'Renewed', nextDose: '20:00' },
    { medication: '💊 Furosemide 40mg', patient: 'James Brown', frequency: 'BID (2x daily)', status: 'Active', nextDose: '12:00' },
    { medication: '💊 Donepezil 10mg', patient: 'Helen Taylor', frequency: 'QHS (at bedtime)', status: 'Active', nextDose: '21:00' },
    { medication: '💉 Insulin Glargine 20u', patient: 'Margaret Chen', frequency: 'QD (1x daily)', status: 'Active', nextDose: '22:00' },
];

const medCols: TableColumn[] = [
    { key: 'medication', label: 'Medication' }, { key: 'patient', label: 'Patient' },
    { key: 'frequency', label: 'Frequency' }, { key: 'status', label: 'Status' },
    { key: 'nextDose', label: 'Next Dose' },
];

export default function PharmacyHub() {
    return (
        <PageTemplate
            pageId="H2"
            title="💊 Pharmacy & Medication Hub"
            subtitle="E-prescribing, MAR tracking, ADC integration, and BCMA"
            actionPageId="admin.pharmacy"
            sectionData={{
                'H2.mar-summary': { kpiCards: [
                    { label: 'Active Prescriptions', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Pending Renewals', value: 2, color: 'var(--pc-warning)' },
                    { label: 'MAR Compliance', value: '100%', color: 'var(--pc-success)' },
                    { label: 'Critical Alerts', value: 0, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H2.prescriptions': { table: { columns: medCols, rows: prescriptions } },
            }}
        />
    );
}
