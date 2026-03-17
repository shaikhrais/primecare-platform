// ================================================================
// PAGE IDENTITY: D14 — PSW Dashboard
// Type: Dashboard | Owner: psw
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function PswDashboard() {
    return (
        <PageTemplate pageId="D14" title="🏠 PSW Dashboard" subtitle="Your home base — shifts, earnings, compliance & wellness at a glance"
            sectionData={{
                'D14.stats': { kpiCards: [
                    { label: 'Upcoming Shifts', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Hours This Week', value: 28.5, suffix: 'hrs', color: 'var(--pc-success)' },
                    { label: 'Reliability Streak', value: '14 days', color: '#8B5CF6' },
                    { label: 'Projected Earnings', value: '$1,240', color: '#F59E0B' },
                ]},
                'D14.shifts': { table: { columns: [
                    { key: 'client', label: 'Client' }, { key: 'time', label: 'Time' },
                    { key: 'type', label: 'Visit Type' }, { key: 'status', label: 'Status' },
                ], rows: [
                    { client: 'Jane M.', time: 'Today 2:00 PM', type: 'Personal Care', status: '🟢 Confirmed' },
                    { client: 'Robert K.', time: 'Today 5:00 PM', type: 'Companionship', status: '🟢 Confirmed' },
                    { client: 'Maria L.', time: 'Tomorrow 9:00 AM', type: 'ADL Support', status: '🟡 Pending' },
                ]}},
                'D14.compliance': { statusCards: [
                    { label: 'CPR Certification', value: 'Valid', description: 'Expires Dec 2026', color: 'green' },
                    { label: 'TB Test', value: 'Current', description: 'Due Mar 2027', color: 'green' },
                    { label: 'First Aid', value: 'Expiring Soon', description: 'Expires Apr 2026', color: 'yellow' },
                ]},
            }}
        />
    );
}
