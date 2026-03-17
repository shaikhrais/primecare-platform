// PAGE IDENTITY: T49 · Authorization Alerts
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const alertFeed = [
    { icon: '🔴', title: 'Susan Park — Auth expires Mar 31, 92% used, NO renewal filed', time: 'Urgent', level: 'danger' as const },
    { icon: '🟠', title: 'Margaret Chen — 82% used (98/120 hrs), 6 weeks remaining', time: '2 hrs ago', level: 'warning' as const },
    { icon: '🟡', title: 'James Brown — OT auth 75% used, renewal recommended', time: '1 day ago', level: 'warning' as const },
    { icon: '🟢', title: 'Helen Taylor — Renewal approved, new auth starts Apr 1', time: '2 days ago', level: 'success' as const },
];

export default function AuthAlerts() {
    return (
        <PageTemplate pageId="T49" title="🔔 Authorization Alerts" subtitle="Exhaustion warnings, expiration alerts & renewal notifications"
            sectionData={{
                'T49.stats': { kpiCards: [
                    { label: 'Critical', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Warnings', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Resolved', value: 1, color: 'var(--pc-success)' },
                ]},
                'T49.feed': { feed: { title: '🔔 Active Alerts', items: alertFeed } },
            }}
        />
    );
}
