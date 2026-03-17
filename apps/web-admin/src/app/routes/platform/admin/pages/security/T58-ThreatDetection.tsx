// ================================================================
// PAGE IDENTITY: T58 · Threat Detection
// Type: Tool | Owner: admin | Registry: T58
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const threats = [
    { icon: '🔴', title: 'Brute Force Attack — 185.220.101.42 — 47 attempts in 60s', time: '2 min ago', level: 'danger' as const },
    { icon: '🟠', title: 'Suspicious Login — admin@primecare.ca from new location (Kyiv, UA)', time: '15 min ago', level: 'warning' as const },
    { icon: '🟡', title: 'Rate Limit Exceeded — API endpoint /v1/admin/users — 250 req/min', time: '1 hr ago', level: 'warning' as const },
    { icon: '🟢', title: 'Vulnerability Scan Completed — 0 critical findings', time: '3 hrs ago', level: 'success' as const },
    { icon: '🟢', title: 'SSL Certificate Valid — expires Dec 2027', time: '6 hrs ago', level: 'success' as const },
    { icon: 'ℹ️', title: 'WAF rule update applied — 12 new signatures', time: '12 hrs ago', level: 'info' as const },
];

export default function ThreatDetection() {
    return (
        <PageTemplate
            pageId="T58"
            title="🚨 Threat Detection"
            subtitle="Real-time threat monitoring, intrusion detection & automated response"
            actionPageId="admin.threat-detection"
            isLive
            sectionData={{
                'T58.stats': { kpiCards: [
                    { label: 'Active Threats', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Blocked Today', value: 47, color: 'var(--pc-warning)' },
                    { label: 'WAF Rules', value: 234, color: 'var(--pc-primary)' },
                    { label: 'Uptime', value: '99.98%', color: 'var(--pc-success)' },
                ]},
                'T58.threat-feed': { feed: { title: '📡 Live Threat Feed', items: threats } },
                'T58.history': { chart: { title: 'Blocked Attacks (7 Days)', type: 'bar', data: [
                    { label: 'Mon', value: 23, color: '#EF4444' }, { label: 'Tue', value: 15, color: '#EF4444' },
                    { label: 'Wed', value: 8, color: '#F59E0B' }, { label: 'Thu', value: 31, color: '#EF4444' },
                    { label: 'Fri', value: 47, color: '#EF4444' }, { label: 'Sat', value: 12, color: '#F59E0B' },
                    { label: 'Sun', value: 5, color: '#10B981' },
                ]}},
            }}
        />
    );
}
