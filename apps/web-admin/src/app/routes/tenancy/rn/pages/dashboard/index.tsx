import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: D15-RnDashboard.tsx
// removed broken export: export { default } from './D15-RnDashboard';


// --- Merged from D15-RnDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D15 — RN Dashboard
// Type: Dashboard | Owner: rn
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function RnDashboard() {
    return (
        <PageTemplate pageId="D15" title="👩‍⚕️ RN Clinical Dashboard" subtitle="Patient assessments, delegations, care plans & medication oversight"
            sectionData={{
                'D15.stats': { kpiCards: [
                    { label: 'Active Patients', value: 18, color: 'var(--pc-primary)' },
                    { label: 'Assessments Due', value: 4, color: 'var(--pc-warning)' },
                    { label: 'Delegations Active', value: 7, color: 'var(--pc-success)' },
                    { label: 'Critical Alerts', value: 1, color: 'var(--pc-error, #EF4444)' },
                ]},
                'D15.patients': { table: { columns: [
                    { key: 'patient', label: 'Patient' }, { key: 'assessment', label: 'Next Assessment' },
                    { key: 'carePlan', label: 'Care Plan' }, { key: 'meds', label: 'MAR Status' },
                    { key: 'alert', label: 'Alert' },
                ], rows: [
                    { patient: 'E. Rodriguez', assessment: 'Today', carePlan: '✅ Current', meds: '🟢 Compliant', alert: '—' },
                    { patient: 'K. Patel', assessment: 'Tomorrow', carePlan: '✅ Current', meds: '🟡 1 Missed', alert: '⚠️ Follow-up' },
                    { patient: 'W. Johnson', assessment: 'Overdue', carePlan: '🔄 Renewal', meds: '🟢 Compliant', alert: '🔴 Urgent' },
                ]}},
                'D15.compliance': { statusCards: { items: [
                    { label: 'Documentation', value: '94%', description: '18/19 entries complete', color: 'green' },
                    { label: 'Delegation Audits', value: 'Passed', description: 'Last audit: Mar 12', color: 'green' },
                    { label: 'Wound Assessments', value: '2 Due', description: 'Next: Today 3 PM', color: 'yellow' },
                ]} },
            }}
        />
    );
}