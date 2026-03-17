// PAGE IDENTITY: L9 · Referral List
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const referrals = [
    { id: 'REF-201', source: 'Dr. Smith (Family MD)', client: 'New — Margaret Chen', service: 'PSW Home Care', received: 'Mar 14', status: '⏳ Intake Pending' },
    { id: 'REF-200', source: 'CCAC Coordinator', client: 'New — John Doe', service: 'RN Wound Care', received: 'Mar 12', status: '✅ Accepted' },
    { id: 'REF-199', source: 'Hospital Discharge', client: 'Transfer — Jane Roe', service: 'Rehab OT', received: 'Mar 10', status: '✅ Active' },
    { id: 'REF-198', source: 'Self-Referral', client: 'New — Bob Lee', service: 'Respite Care', received: 'Mar 8', status: '❌ Waitlisted' },
];

const cols: TableColumn[] = [
    { key: 'id', label: 'Ref ID' }, { key: 'source', label: 'Source' },
    { key: 'client', label: 'Client' }, { key: 'service', label: 'Service' },
    { key: 'received', label: 'Received' }, { key: 'status', label: 'Status' },
];

export default function ReferralList() {
    return (
        <PageTemplate pageId="L9" title="🔗 Referral Pipeline" subtitle="Incoming referrals, intake tracking & source analytics"
            sectionData={{
                'L9.stats': { kpiCards: [
                    { label: 'Pending Intake', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Accepted MTD', value: 3, color: 'var(--pc-success)' },
                    { label: 'Waitlisted', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Days to Accept', value: 2.5, color: 'var(--pc-primary)' },
                ]},
                'L9.table': { table: { columns: cols, rows: referrals } },
            }}
        />
    );
}
