// PAGE IDENTITY: D4 · EVV Dashboard
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function EvvDashboard() {
    return (
        <PageTemplate pageId="D4" title="📍 EVV Dashboard" subtitle="Electronic Visit Verification — real-time GPS, clock-in/out & compliance"
            isLive
            sectionData={{
                'D4.stats': { kpiCards: [
                    { label: 'Active Visits', value: 23, color: 'var(--pc-primary)' },
                    { label: 'On-Time Rate', value: '94%', color: 'var(--pc-success)' },
                    { label: 'GPS Verified', value: '98%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Exceptions', value: 3, color: 'var(--pc-warning)' },
                ]},
                'D4.map': { map: {
                    title: '📍 Live Visit Locations',
                    markers: [
                        { id: 'm1', lat: 43.65, lng: -79.38, label: 'PSW Santos — Chen residence', status: 'active' },
                        { id: 'm2', lat: 43.72, lng: -79.34, label: 'PSW Williams — Park home', status: 'active' },
                        { id: 'm3', lat: 43.68, lng: -79.42, label: 'PSW Brown — Taylor facility', status: 'active' },
                        { id: 'm4', lat: 43.71, lng: -79.40, label: 'PSW Chen — Williams home', status: 'danger' },
                    ],
                }},
                'D4.recent': { feed: { title: '📡 Live EVV Feed', items: [
                    { icon: '🟢', title: 'PSW Santos clocked in — Margaret Chen — GPS ✓', time: '14:23', level: 'success' as const },
                    { icon: '🟢', title: 'PSW Williams clocked out — Robert Williams — 2h 15m', time: '14:10', level: 'success' as const },
                    { icon: '🟡', title: 'PSW Brown — GPS outside service area (50m)', time: '13:55', level: 'warning' as const },
                    { icon: '🔴', title: 'PSW Chen — No clock-in for scheduled visit', time: '13:30', level: 'danger' as const },
                ]}},
            }}
        />
    );
}
