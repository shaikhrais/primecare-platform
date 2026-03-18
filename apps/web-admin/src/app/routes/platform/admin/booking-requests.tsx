import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L12-BookingRequestQueue.tsx ---
// PAGE IDENTITY: L12 · Booking Request Queue
import type { TableColumn } from '@/shared/components/sections';

const bookings = [
    { id: 'BK-1205', client: 'Margaret Chen', service: 'PSW Home Care', requested: 'Mar 16', preferred: 'Mar 18 AM', status: '⏳ Pending' },
    { id: 'BK-1204', client: 'Robert Williams', service: 'RN Wound Care', requested: 'Mar 15', preferred: 'Mar 17 PM', status: '✅ Confirmed' },
    { id: 'BK-1203', client: 'Susan Park', service: 'Respite Care', requested: 'Mar 14', preferred: 'Mar 20 All Day', status: '✅ Assigned' },
    { id: 'BK-1202', client: 'James Brown', service: 'OT Assessment', requested: 'Mar 13', preferred: 'ASAP', status: '❌ Cancelled' },
];

const cols: TableColumn[] = [
    { key: 'id', label: 'Booking' }, { key: 'client', label: 'Client' },
    { key: 'service', label: 'Service' }, { key: 'requested', label: 'Requested' },
    { key: 'preferred', label: 'Preferred Time' }, { key: 'status', label: 'Status' },
];

export function BookingRequestQueue() {
    return (
        <PageTemplate pageId="L12" title="📅 Booking Request Queue" subtitle="Incoming service requests, assignment & scheduling"
            sectionData={{
                'L12.stats': { kpiCards: [
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Confirmed', value: 1, color: 'var(--pc-success)' },
                    { label: 'Assigned', value: 1, color: 'var(--pc-primary)' },
                    { label: 'Avg Response', value: '4 hrs', color: 'var(--pc-info, #2563EB)' },
                ]},
                'L12.table': { table: { columns: cols, rows: bookings } },
            }}
        />
    );
}
