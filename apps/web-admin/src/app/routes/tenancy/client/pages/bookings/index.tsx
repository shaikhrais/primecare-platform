import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: L14-ClientBookings.tsx
// removed broken export: export { default } from './L14-ClientBookings';


// --- Merged from L14-ClientBookings.tsx ---
// ================================================================
// PAGE IDENTITY: L14 — Client Bookings
// Type: List | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientBookings() {
    return (
        <PageTemplate pageId="L14" title="📅 My Bookings" subtitle="View, request & manage your upcoming care appointments"
            sectionData={{
                'L14.stats': { kpiCards: [
                    { label: 'Upcoming', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Completed (MTD)', value: 12, color: 'var(--pc-success)' },
                    { label: 'Cancelled', value: 1, color: 'var(--pc-error, #EF4444)' },
                    { label: 'Pending Requests', value: 1, color: 'var(--pc-warning)' },
                ]},
                'L14.bookings': { table: { columns: [
                    { key: 'date', label: 'Date' }, { key: 'time', label: 'Time' },
                    { key: 'caregiver', label: 'Caregiver' }, { key: 'service', label: 'Service' },
                    { key: 'status', label: 'Status' },
                ], rows: [
                    { date: 'Mar 17', time: '2:00 PM', caregiver: 'Sarah P.', service: 'Personal Care', status: '🟢 Confirmed' },
                    { date: 'Mar 18', time: '10:00 AM', caregiver: 'Mike R.', service: 'Companionship', status: '🟢 Confirmed' },
                    { date: 'Mar 20', time: '9:00 AM', caregiver: 'TBD', service: 'ADL Support', status: '🟡 Pending' },
                ]}},
            }}
        />
    );
}