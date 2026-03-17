import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Barrel re-export — identity file: F6-ClientAdmission.tsx
// removed broken export: export { default } from './F6-ClientAdmission';


// --- Merged from F6-ClientAdmission.tsx ---
// PAGE IDENTITY: F6 · Client Admission



const admissionSteps = [
    { icon: '📋', title: 'Referral Information', subtitle: 'Source, date, reason for referral & urgency level' },
    { icon: '👤', title: 'Client Demographics', subtitle: 'Name, DOB, address, contacts & emergency contacts' },
    { icon: '🏥', title: 'Medical History', subtitle: 'Diagnoses, medications, allergies & physician info' },
    { icon: '📊', title: 'Care Assessment', subtitle: 'RAI-HC, functional status & cognitive assessment' },
    { icon: '📝', title: 'Service Plan', subtitle: 'Approved services, hours, frequency & goals' },
    { icon: '✅', title: 'Consent & Documents', subtitle: 'Signed consents, ID verification & insurance' },
];

export function ClientAdmission() {
    return (
        <PageTemplate pageId="F6" title="📋 Client Admission" subtitle="New client intake workflow — referral, demographics, assessment & service plan"
            sectionData={{
                'F6.stats': { kpiCards: [
                    { label: 'In Progress', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Completed Today', value: 1, color: 'var(--pc-success)' },
                    { label: 'Pending Review', value: 2, color: 'var(--pc-primary)' },
                    { label: 'Avg Intake Time', value: '2.5 days', color: 'var(--pc-info, #2563EB)' },
                ]},
                'F6.steps': { cardGrid: { items: admissionSteps, columns: 3 } },
            }}
        />
    );
}