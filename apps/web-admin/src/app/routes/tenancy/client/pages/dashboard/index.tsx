import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: D8-ClientDashboard.tsx
// removed broken export: export { default } from './D8-ClientDashboard';


// --- Merged from D8-ClientDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D8 — Client Dashboard
// Type: Dashboard | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientDashboard() {
    return (
        <PageTemplate pageId="D8" title="🏡 My Care Dashboard" subtitle="Your upcoming visits, care team & health journey at a glance"
            sectionData={{
                'D8.stats': { kpiCards: [
                    { label: 'Next Visit', value: 'Today 2 PM', color: 'var(--pc-primary)' },
                    { label: 'Care Hours (MTD)', value: 42,  color: 'var(--pc-success)' },
                    { label: 'Funding Balance', value: '$3,200', color: '#8B5CF6' },
                    { label: 'Care Team', value: '4 Members', color: '#F59E0B' },
                ]},
                'D8.upcoming': { table: { columns: [
                    { key: 'date', label: 'Date' }, { key: 'caregiver', label: 'Caregiver' },
                    { key: 'service', label: 'Service' }, { key: 'time', label: 'Time' },
                ], rows: [
                    { date: 'Today', caregiver: 'Sarah P.', service: 'Personal Care', time: '2:00 PM — 4:00 PM' },
                    { date: 'Tomorrow', caregiver: 'Mike R.', service: 'Companionship', time: '10:00 AM — 12:00 PM' },
                    { date: 'Mar 19', caregiver: 'Lisa T.', service: 'ADL Support', time: '9:00 AM — 11:00 AM' },
                ]}},
                'D8.journey': { statusCards: { items: [
                    { label: 'Care Plan', value: 'Active', description: 'Reviewed Jan 2026', icon: 'Activity', color: 'green' },
                    { label: 'Assessments', value: 'Up to Date', description: 'Next due Apr 2026', icon: 'Activity', color: 'green' },
                    { label: 'Telehealth', value: 'Available', description: 'Dr. Chen — Click to join', icon: 'Activity', color: 'blue' },
                ]} },
            }}
        />
    );
}