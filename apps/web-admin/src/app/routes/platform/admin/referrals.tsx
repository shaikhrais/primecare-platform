import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L9-ReferralList.tsx ---
// PAGE IDENTITY: L9 · Referral List
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

export function ReferralList() {
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

// --- Merged from R11-ReferralAnalytics.tsx ---
// PAGE IDENTITY: R11 · Referral Analytics

export function ReferralAnalytics() {
    return (
        <PageTemplate pageId="R11" title="📊 Referral Analytics" subtitle="Referral source analysis, conversion rates & pipeline metrics"
            sectionData={{
                'R11.stats': { kpiCards: [
                    { label: 'Total Referrals MTD', value: 28, color: 'var(--pc-primary)' },
                    { label: 'Conversion Rate', value: '72%', color: 'var(--pc-success)' },
                    { label: 'Top Source', value: 'CCAC', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Time to Serve', value: '3.2 days', color: '#7C3AED' },
                ]},
                'R11.by-source': { chart: { title: 'Referrals by Source', type: 'donut', data: [
                    { label: 'CCAC', value: 40, color: '#3B82F6' }, { label: 'Hospital', value: 25, color: '#10B981' },
                    { label: 'Physician', value: 20, color: '#F59E0B' }, { label: 'Self', value: 15, color: '#8B5CF6' },
                ]}},
                'R11.trend': { chart: { title: 'Monthly Referral Volume', type: 'bar', data: [
                    { label: 'Oct', value: 22 }, { label: 'Nov', value: 25 }, { label: 'Dec', value: 18 },
                    { label: 'Jan', value: 30 }, { label: 'Feb', value: 24 }, { label: 'Mar', value: 28 },
                ]}},
            }}
        />
    );
}
