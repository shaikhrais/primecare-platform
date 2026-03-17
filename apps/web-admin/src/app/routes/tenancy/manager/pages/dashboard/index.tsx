import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: D7-ManagerDashboard.tsx
// removed broken export: export { default } from './D7-ManagerDashboard';


// --- Merged from D7-ManagerDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D7 — Manager Dashboard
// Type: Dashboard | Owner: manager
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ManagerDashboard() {
    return (
        <PageTemplate pageId="D7" title="📊 Manager Dashboard" subtitle="Branch operations, staff performance & business intelligence"
            sectionData={{
                'D7.stats': { kpiCards: [
                    { label: 'Active Staff', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Visits Today', value: 47, color: 'var(--pc-success)' },
                    { label: 'Overtime Alerts', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Branch Margin', value: '18.2%', color: '#8B5CF6' },
                ]},
                'D7.timeline': { table: { columns: [
                    { key: 'time', label: 'Time' }, { key: 'event', label: 'Event' },
                    { key: 'staff', label: 'Staff' }, { key: 'status', label: 'Status' },
                ], rows: [
                    { time: '07:00', event: 'Shift Start — Morning Block', staff: '12 PSWs', status: '🟢 On Track' },
                    { time: '09:30', event: 'Late Check-In Alert', staff: 'S. Patel', status: '🟡 5 min late' },
                    { time: '11:00', event: 'Shift Swap Approved', staff: 'J. Lee ↔ M. Kim', status: '✅ Completed' },
                ]}},
            }}
        />
    );
}