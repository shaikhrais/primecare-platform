import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L12-BookingRequestQueue.tsx ---
// PAGE IDENTITY: L12 · Booking Request Queue
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const cols: TableColumn[] = [
    { key: 'id', label: 'Booking' }, { key: 'client', label: 'Client' },
    { key: 'service', label: 'Service' }, { key: 'requested', label: 'Requested' },
    { key: 'preferred', label: 'Preferred Time' }, { key: 'status', label: 'Status' },
];

export function BookingRequestQueue() {
    return (
        <PageTemplate pageId="L12" title="📅 Booking Request Queue" subtitle="Incoming service requests, assignment & scheduling"
            sectionData={PageSectionRegistry['L12']}
        />
    );
}
