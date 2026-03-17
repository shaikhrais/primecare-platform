// ================================================================
// PAGE IDENTITY: D1 · Admin Dashboard (Main Landing)
// Type: Dashboard | Owner: admin | Registry: D1
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const quickActions = [
    { icon: '📅', title: 'Schedule', subtitle: 'View & manage today\'s shifts' },
    { icon: '👥', title: 'Staff', subtitle: '82 PSWs, 4 RNs active' },
    { icon: '🏥', title: 'Clients', subtitle: '67 active clients' },
    { icon: '💰', title: 'Revenue', subtitle: '$185K MTD' },
    { icon: '📋', title: 'Compliance', subtitle: '98.2% score' },
    { icon: '🤖', title: 'AI Insights', subtitle: '8 actionable items' },
];

export default function AdminDashboard() {
    return (
        <PageTemplate pageId="D1" title="🏠 Admin Dashboard" subtitle="Platform overview — operations, finance, compliance & AI insights"
            actionPageId="admin.dashboard"
            sectionData={{
                'D1.stats': { kpiCards: [
                    { label: 'Active Visits', value: 23, color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Staff Active', value: 86, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Clients', value: 67, color: '#7C3AED' },
                    { label: 'Compliance', value: '98.2%', color: '#10B981' },
                    { label: 'Incidents', value: 2, color: 'var(--pc-warning)' },
                ]},
                'D1.quick-actions': { cardGrid: { items: quickActions, columns: 3 } },
                'D1.visit-chart': { chart: { title: 'Weekly Visit Volume', type: 'bar', data: [
                    { label: 'Mon', value: 145 }, { label: 'Tue', value: 162 },
                    { label: 'Wed', value: 138 }, { label: 'Thu', value: 155 },
                    { label: 'Fri', value: 170 }, { label: 'Sat', value: 45 },
                    { label: 'Sun', value: 32 },
                ]}},
            }}
        />
    );
}
